From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 12:27:07 +0100
Subject: [PATCH 11/20] regmap: _regmap_raw_read: Add handling of busses
 without bus->read()
In-Reply-To: <1439374365-20623-12-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-12-git-send-email-mpa@pengutronix.de>
Message-ID: <20150812112707.GY10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:36PM +0200, Markus Pargmann wrote:

> +	/*
> +	 * There are busses that do not have a read function as it is optional.
> +	 * Use their reg_read function instead if the requested number of bytes
> +	 * is correct.
> +	 */
> +	if (!map->bus->read) {
> +		/*
> +		 * bus_reg_read() does not support reading values that are not
> +		 * exactly the size of format.val_bytes
> +		 */
> +		if (val_len != map->format.val_bytes)
> +			return -EINVAL;
> +		return _regmap_bus_reg_read(map, reg, val);
> +	}

No, this makes no sense - if the device doesn't have a read operation
then it doesn't support a raw data stream and hence can't support raw
access sensibly.  Callers that want to access a lot of registers at once
without knowing what the wire format for the device is should be using
the bulk or multi interfaces.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/10f82529/attachment.sig>
