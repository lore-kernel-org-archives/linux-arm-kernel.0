From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 12:20:35 +0100
Subject: [PATCH 09/20] regmap: _regmap_raw_write fix for busses without
 write()
In-Reply-To: <1439374365-20623-10-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-10-git-send-email-mpa@pengutronix.de>
Message-ID: <20150812112035.GX10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:34PM +0200, Markus Pargmann wrote:

> @@ -1229,6 +1229,11 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
>  		}
>  	}
>  
> +	if (!map->bus->write && val_len == map->format.val_bytes) {
> +		ret = _regmap_bus_reg_write(map, reg, *(unsigned int *)val);
> +		return ret;
> +	}

This is broken - you can't use a raw value as a register value.  The
endianness of the device may not be the same as the endianness of the
system and you can't cast a value to unsigned int, the value may be of
any size.

> @@ -1340,7 +1345,7 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
>  	 * send the work_buf directly, otherwise try to do a gather
>  	 * write.
>  	 */
> -	if (val == work_val) {
> +	if (val == work_val && map->bus->write) {
>  		ret = map->bus->write(map->bus_context, map->work_buf,
>  				      map->format.reg_bytes +
>  				      map->format.pad_bytes +

This appears to be another case of merging an unrelated change :(
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/42cd50dd/attachment.sig>
