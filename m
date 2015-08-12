From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 13:34:06 +0100
Subject: [PATCH 09/20] regmap: _regmap_raw_write fix for busses without
 write()
In-Reply-To: <20150812122011.GE19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-10-git-send-email-mpa@pengutronix.de>
 <20150812112035.GX10748@sirena.org.uk>
 <20150812122011.GE19600@pengutronix.de>
Message-ID: <20150812123406.GG10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 02:20:11PM +0200, Markus Pargmann wrote:
> On Wed, Aug 12, 2015 at 12:20:35PM +0100, Mark Brown wrote:
> > On Wed, Aug 12, 2015 at 12:12:34PM +0200, Markus Pargmann wrote:
> > 
> > > @@ -1229,6 +1229,11 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
> > >  		}
> > >  	}
> > >  
> > > +	if (!map->bus->write && val_len == map->format.val_bytes) {
> > > +		ret = _regmap_bus_reg_write(map, reg, *(unsigned int *)val);
> > > +		return ret;
> > > +	}

> > This is broken - you can't use a raw value as a register value.  The

> I am not sure what you mean here?

> The register value given to _regmap_raw_write is the real register
> value, not formatted differenty. This is given directly towards
> bus->reg_write() which should handle the rest.

I mean the value for the register, not the register address.

> At least that's how I understood the code. For example regmap_read()
> directly calls _regmap_read() which in turn calls directly
> bus->reg_read() without any formating.

You're adding this code to regmap_raw_write() which takes raw register
values for the device, not unsigned integers.

> > endianness of the device may not be the same as the endianness of the
> > system and you can't cast a value to unsigned int, the value may be of
> > any size.

> Yes right. On the other hand if bus->read() and bus->write() was not set
> in the init method (before this patch series) no formatting functions at
> all were assigned. So it was always ignored for bus->reg_read() and
> bus->reg_write()?!

I'm not sure what the "it" you're talking about here is, sorry.  There
are unsupported features in the API especially for cases that don't make
a huge amount of sense, the error handling isn't always complete.  It
sounds like you might be trying to support one of these nonsensical
cases - it's not obvious what raw I/O on a device where we don't know
the raw format of the device should mean or how anything could sensibly
use that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/e2d08482/attachment.sig>
