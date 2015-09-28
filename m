From: sugar.zhang@rock-chips.com (sugar)
Date: Mon, 28 Sep 2015 16:16:12 +0800
Subject: [PATCH 1/2] ASoC: rockchip: i2s: add 8 channels capture and
 lrck-mode support
In-Reply-To: <20150923162433.GQ30445@sirena.org.uk>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
 <1442979683-9441-2-git-send-email-sugar.zhang@rock-chips.com>
 <20150923162433.GQ30445@sirena.org.uk>
Message-ID: <5608F74C.3000104@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark Brown,

? 9/24/2015 00:24, Mark Brown ??:
> On Wed, Sep 23, 2015 at 11:41:22AM +0800, Sugar Zhang wrote:
>
>> +	/* configure tx/rx lrck use mode */
>> +	if (!of_property_read_u32(node, "rockchip,lrck-mode", &val)) {
>> +		if (val >= LRCK_TXRX && val <= LRCK_RX_SHARE)
>> +			regmap_update_bits(i2s->regmap, I2S_CKR,
>> +					   I2S_CKR_TRCM_MASK,
>> +					   I2S_CKR_TRCM(val));
>> +	}
>
> This looks like it's for a board configuration thing so I'd not really
> expect this to be handled in a device specific property - it's fairly
> common to have this situation and we already have the symmetric_rates
> flag for the DAI to handle it (and if we do end up adding this property
> we'd need the driver to set that flag so that the core can handle things
> properly and make sure that userspace doesn't try to set different rates
> in different directions).
>
> My initial thought here is that the machine driver should be responsible
> for setting this and then the DAI driver should check to see if
> symmetric_rates are in use and configure itself appropriately.  Is there
> a reason why this won't work here?
>

It's for i2s ip configuration, in the most situation, there is no need
to use this property, except one case:

In order to save gpio pins for other function use, we may use single
lrck(tx or rx) pin. of course, it depends on product design. when in i2s
slave mode, we need to configure this to share lrck with tx/rx inside 
i2s logic.

symmetric_rates flag works fine on rockchip platform, but it can't cover 
the above case.

Do you have any suggestion about this or maybe there is no need to 
upstream this special part?

Best Regards
Sugar
