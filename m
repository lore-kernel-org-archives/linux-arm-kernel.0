From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 18 Sep 2014 15:10:43 +0530
Subject: [PATCH v3] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <1c762cb71a5245f19fdcec8266fd45b6@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1410935510-1567-1-git-send-email-pankaj.dubey@samsung.com>
 <20140917085818.GA10285@shlinux1.ap.freescale.net>
 <000401cfd269$922dfc40$b689f4c0$@samsung.com>
 <20140918030552.GA26661@shlinux1.ap.freescale.net>
 <000701cfd306$4d3e8080$e7bb8180$@samsung.com>
 <20140918075516.GB15363@shlinux1.ap.freescale.net>
 <1c762cb71a5245f19fdcec8266fd45b6@BY2PR0301MB0613.namprd03.prod.outlook.com>
Message-ID: <000d01cfd324$a2db05e0$e89111a0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On September 18, 2014, Li.Xiubo wrote,
> Subject: RE: [PATCH v3] mfd: syscon: Decouple syscon interface from
platform
> devices
> 
> [...]
> > > I think there should have been a check for NULL on "dev" in
> > > "regmap_get_val_endian", so that if dev pointer exist then only it
> > > makes sense to get endianness property from DT.
> > >
> > > I will suggest following fix in regmap.c for this. With following
> > > fix I tested it and it works well on linux-next also. So if you can
> > > confirm following fix is working for you then I can post this patch.
> > >
> >
> > I tested the patch work.
> > But as Xiubo pointed in another mail, it may still cause other issues.
> > Looking at regmap.c, there're still some other places using the device
> > pointer, e.g. dev_xxx debug information and some tracepoints also take
> > device pointer as parameter(not sure if it will break if dev is NULL).
> > Another thing is that if dev is NULL, we may not be able to use regmap
> > debugfs feature which seems also not as our expected.
> >
> > Maybe we could consider create device structure for each syscon
> > compatible device in syscon driver in of_syscon_register in first time
> > which seems to be reasonable.
> >
> > Regards
> > Dong Aisheng
> >
> > > --------------------------------------------
> > > Subject: [PATCH] regmap: fix NULL pointer dereference in
> > > regmap_get_val_endian
> > >
> > > Recent commits for getting reg endianess causing NULL pointer
> > > dereference if dev is passed NULL in regmap_init_mmio. This patch
> > > fixes this issue, and allows to parse reg endianess only if dev and
> > > dev->of_node exist.
> > >
> > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > ---
> > >  drivers/base/regmap/regmap.c |   23 ++++++++++++++---------
> > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/base/regmap/regmap.c
> > > b/drivers/base/regmap/regmap.c index f2281af..455a877 100644
> > > --- a/drivers/base/regmap/regmap.c
> > > +++ b/drivers/base/regmap/regmap.c
> > > @@ -477,7 +477,7 @@ static enum regmap_endian
> > > regmap_get_val_endian(struct device *dev,
> > >  					const struct regmap_bus *bus,
> > >  					const struct regmap_config *config)
{
> > > -	struct device_node *np = dev->of_node;
> > > +	struct device_node *np;
> 
> And the 'np' must be NULL as default.
> 
> Isn't it ?
> 


Yes. 

Thanks,
Pankaj Dubey

> Thanks,
> 
> BRs
> Xiubo
> 
> > >  	enum regmap_endian endian;
> > >
> > >  	/* Retrieve the endianness specification from the regmap config */
> > > @@ -487,15 +487,20 @@ static enum regmap_endian
> > > regmap_get_val_endian(struct device *dev,
> > >  	if (endian != REGMAP_ENDIAN_DEFAULT)
> > >  		return endian;
> > >
> > > -	/* Parse the device's DT node for an endianness specification */
> > > -	if (of_property_read_bool(np, "big-endian"))
> > > -		endian = REGMAP_ENDIAN_BIG;
> > > -	else if (of_property_read_bool(np, "little-endian"))
> > > -		endian = REGMAP_ENDIAN_LITTLE;
> > > +	/* If the dev and dev->of_node exist try to get endianness from DT
> > > */
> > > +	if (dev && dev->of_node) {
> > > +		np = dev->of_node;
> > >
> > > -	/* If the endianness was specified in DT, use that */
> > > -	if (endian != REGMAP_ENDIAN_DEFAULT)
> > > -		return endian;
> > > +		/* Parse the device's DT node for an endianness
> > > specification */
> > > +		if (of_property_read_bool(np, "big-endian"))
> > > +			endian = REGMAP_ENDIAN_BIG;
> > > +		else if (of_property_read_bool(np, "little-endian"))
> > > +			endian = REGMAP_ENDIAN_LITTLE;
> > > +
> > > +		/* If the endianness was specified in DT, use that */
> > > +		if (endian != REGMAP_ENDIAN_DEFAULT)
> > > +			return endian;
> > > +	}
> > >
> > >  	/* Retrieve the endianness specification from the bus config */
> > >  	if (bus && bus->val_format_endian_default)
> > > --
> > >
> > > Thanks,
> > > Pankaj Dubey
> > >
> > > > Regards
> > > > Dong Aisheng
> > > >
> > > > >
> > > > > Thanks,
> > > > > Pankaj Dubey
> > > > >
> > > > > > Regards
> > > > > > Dong Aisheng
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > _______________________________________________
> > > > > > > linux-arm-kernel mailing list
> > > > > > > linux-arm-kernel at lists.infradead.org
> > > > > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > > >
> > >
