From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Sep 2015 09:24:33 -0700
Subject: [PATCH 1/2] ASoC: rockchip: i2s: add 8 channels capture and
 lrck-mode support
In-Reply-To: <1442979683-9441-2-git-send-email-sugar.zhang@rock-chips.com>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
 <1442979683-9441-2-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <20150923162433.GQ30445@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 11:41:22AM +0800, Sugar Zhang wrote:

> +	/* configure tx/rx lrck use mode */
> +	if (!of_property_read_u32(node, "rockchip,lrck-mode", &val)) {
> +		if (val >= LRCK_TXRX && val <= LRCK_RX_SHARE)
> +			regmap_update_bits(i2s->regmap, I2S_CKR,
> +					   I2S_CKR_TRCM_MASK,
> +					   I2S_CKR_TRCM(val));
> +	}

This looks like it's for a board configuration thing so I'd not really
expect this to be handled in a device specific property - it's fairly
common to have this situation and we already have the symmetric_rates
flag for the DAI to handle it (and if we do end up adding this property
we'd need the driver to set that flag so that the core can handle things
properly and make sure that userspace doesn't try to set different rates
in different directions).

My initial thought here is that the machine driver should be responsible
for setting this and then the DAI driver should check to see if
symmetric_rates are in use and configure itself appropriately.  Is there
a reason why this won't work here?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150923/89d8d32d/attachment.sig>
