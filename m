From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Apr 2014 22:04:29 +0100
Subject: [RFC PATCH v2] regmap: smbus: add support for regmap over SMBus
In-Reply-To: <1397480885-11962-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1397292335-5516-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397480885-11962-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140414210429.GJ25182@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 03:08:05PM +0200, Boris BREZILLON wrote:
> SMBus is a subset of the I2C protocol, oftenly used to access registers on
> external devices.

This is basically fine.  However...

> +	switch (ctx->transfer_type) {
> +	case REGMAP_SMBUS_BYTE_TRANSFER:
> +		while (count > 0 && !ret) {
> +			ret = i2c_smbus_write_byte_data(ctx->i2c, reg++,
> +							*(u8 *)data++);
> +
> +			count--;
> +		}
> +		break;

The transfer type gets set once per device at init time so why not just
parameterise based on val_bytes?

> +	case REGMAP_SMBUS_I2C_BLOCK_TRANSFER:
> +		while (count > 0 && !ret) {
> +			ret = i2c_smbus_write_i2c_block_data(ctx->i2c,
> +							     reg,
> +							     ctx->val_bytes,
> +							     (const u8 *)data);

Fix the const correctness of the API rather than casting.

> +			reg += ctx->val_bytes;
> +			count -= ctx->val_bytes;
> +			data += ctx->val_bytes;
> +		}

I'm assuming this will only be used if val_bytes isn't 1 or 2?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140414/69c7a190/attachment.sig>
