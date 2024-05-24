module zcdc_coin::ZCDCCOIN {
    use std::option;
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct ZCDCCOIN has drop {}

    /// Module initializer is called once on module publish. A treasury
    /// cap is sent to the publisher, who then controls minting and burning
    fun init(witness: ZCDCCOIN, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(witness, 6, b"ZCDCCoin", b"ZCDCCoin", b"ZCDCCoin is NO.1", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx));
    }

    public entry fun mint (
        treasury_cap: &mut TreasuryCap<ZCDCCOIN>, amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx)
    }

    public entry fun burn (
        treasury_cap: &mut TreasuryCap<ZCDCCOIN>, coin: Coin<ZCDCCOIN>
    ) {
        coin::burn(treasury_cap, coin);
    }
}