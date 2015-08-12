From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 14:47:06 +0200
Subject: [PATCH 14/20] regmap: Add raw_write/read checks for
 max_raw_write/read sizes
In-Reply-To: <20150812115759.GB10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-15-git-send-email-mpa@pengutronix.de>
 <20150812115759.GB10748@sirena.org.uk>
Message-ID: <20150812124706.GI19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:57:59PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:39PM +0200, Markus Pargmann wrote:
> 
> > Check in regmap_raw_read() and regmap_raw_write() for correct maximum
> > sizes of the operations. Return -E2BIG if this size is not supported
> > because it is too big.
> 
> Why not just split the transaction up like your other changes did?

My intention was to keep these raw functions as close to the actual
hardware as possible also reporting proper error values. For
transactions that are split up you could still use the bulk functions.

The actual use case is the bmc150 driver. This chip has a FIFO behind
one of its registers. At exactly that register there is no autoincrement
of the address or anything, it is just a much larger register. But you
have to read from it in bigger chunks than normal. If you read in
chunks that do not have the correct size samples from the sensor get
discarded.

> 
> > Also this patch causes an uninitialized variable warning so it
> > initializes ret (although not necessary).
> 
> That's just shutting the warning up without understanding where it came
> from or why this is a good way of handling it :(

Yes, will have a look if I can find the issue.

> 
> > @@ -2273,8 +2276,14 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
> >  
> >  	map->lock(map->lock_arg);
> >  
> > -	if (regmap_volatile_range(map, reg, val_count) || map->cache_bypass ||
> > -	    map->cache_type == REGCACHE_NONE) {
> > +	if (map->bus->read &&
> 
> This change doesn't match your commit log...

Sorry.

Thanks,

Markus



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/a186bb60/attachment-0001.sig>
