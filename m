From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 12:57:59 +0100
Subject: [PATCH 14/20] regmap: Add raw_write/read checks for
 max_raw_write/read sizes
In-Reply-To: <1439374365-20623-15-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-15-git-send-email-mpa@pengutronix.de>
Message-ID: <20150812115759.GB10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:39PM +0200, Markus Pargmann wrote:

> Check in regmap_raw_read() and regmap_raw_write() for correct maximum
> sizes of the operations. Return -E2BIG if this size is not supported
> because it is too big.

Why not just split the transaction up like your other changes did?

> Also this patch causes an uninitialized variable warning so it
> initializes ret (although not necessary).

That's just shutting the warning up without understanding where it came
from or why this is a good way of handling it :(

> @@ -2273,8 +2276,14 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
>  
>  	map->lock(map->lock_arg);
>  
> -	if (regmap_volatile_range(map, reg, val_count) || map->cache_bypass ||
> -	    map->cache_type == REGCACHE_NONE) {
> +	if (map->bus->read &&

This change doesn't match your commit log...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/7c830a6d/attachment.sig>
