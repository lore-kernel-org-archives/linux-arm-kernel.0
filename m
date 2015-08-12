From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 14:20:11 +0200
Subject: [PATCH 09/20] regmap: _regmap_raw_write fix for busses without
 write()
In-Reply-To: <20150812112035.GX10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-10-git-send-email-mpa@pengutronix.de>
 <20150812112035.GX10748@sirena.org.uk>
Message-ID: <20150812122011.GE19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:20:35PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:34PM +0200, Markus Pargmann wrote:
> 
> > @@ -1229,6 +1229,11 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
> >  		}
> >  	}
> >  
> > +	if (!map->bus->write && val_len == map->format.val_bytes) {
> > +		ret = _regmap_bus_reg_write(map, reg, *(unsigned int *)val);
> > +		return ret;
> > +	}
> 
> This is broken - you can't use a raw value as a register value.  The

I am not sure what you mean here?

The register value given to _regmap_raw_write is the real register
value, not formatted differenty. This is given directly towards
bus->reg_write() which should handle the rest.

At least that's how I understood the code. For example regmap_read()
directly calls _regmap_read() which in turn calls directly
bus->reg_read() without any formating.

> endianness of the device may not be the same as the endianness of the
> system and you can't cast a value to unsigned int, the value may be of
> any size.

Yes right. On the other hand if bus->read() and bus->write() was not set
in the init method (before this patch series) no formatting functions at
all were assigned. So it was always ignored for bus->reg_read() and
bus->reg_write()?!

> 
> > @@ -1340,7 +1345,7 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
> >  	 * send the work_buf directly, otherwise try to do a gather
> >  	 * write.
> >  	 */
> > -	if (val == work_val) {
> > +	if (val == work_val && map->bus->write) {
> >  		ret = map->bus->write(map->bus_context, map->work_buf,
> >  				      map->format.reg_bytes +
> >  				      map->format.pad_bytes +
> 
> This appears to be another case of merging an unrelated change :(

Yes, will fix.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/ac1570c7/attachment-0001.sig>
