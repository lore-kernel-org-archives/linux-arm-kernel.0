From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 19 Sep 2014 05:20:18 +0000
Subject: [PATCH v3] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <20140919041933.GB19346@shlinux1.ap.freescale.net>
References: <1410935510-1567-1-git-send-email-pankaj.dubey@samsung.com>
 <20140917085818.GA10285@shlinux1.ap.freescale.net>
 <000401cfd269$922dfc40$b689f4c0$@samsung.com>
 <20140918030552.GA26661@shlinux1.ap.freescale.net>
 <000701cfd306$4d3e8080$e7bb8180$@samsung.com>
 <20140918075516.GB15363@shlinux1.ap.freescale.net>
 <000c01cfd324$1f2cd930$5d868b90$@samsung.com>
 <20140918100505.GA19346@shlinux1.ap.freescale.net>
 <48f9f4067cc44ad49297bb4b62c56c88@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <20140919041933.GB19346@shlinux1.ap.freescale.net>
Message-ID: <8e0ba684d5fe4663a8842336385ed7ad@BY2PR0301MB0613.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
> >    create child: /dcsr at 20000000/dcsr-atbrepl at 3a8000
> >    create child: /dcsr at 20000000/dcsr-tsgen-ctrl at 3a9000
> >    create child: /dcsr at 20000000/dcsr-tsgen-read at 3aa000
> >    create child: /regulators/regulator at 0
> >    ...
> >
> > As default the Linux will create all the platform device for each DT node,
> which
> > Can be found from "drivers/of/platform.c".
> >
> > So we can get the pdev node using the specified DT node, and feel safe to
> use
> > it as Pankaj's patch does.
> >
> 
> I mean before the devices are populated from device tree.
> For example, we usually call of_platform_populate in .init_machine.
> Before it, we may not be able to get it's device, isn't it?
> 

Yes, right.

For this case, we'd better create the pdev or dev manually for the first time
We use it, right ?

Thanks,

BRs
Xiubo


> Regards
> Dong Aisheng
> 
> > And also we must make sure that the 'syscon' DT nodes has the compatible
> prop.
> >
> > Thanks,
> >
> > BRs
> > Xiubo
> >
> >
> > > Regards
> > > Dong Aisheng
> > >
> > > > ----
> > > > static struct syscon *of_syscon_register(struct device_node *np)
> > > >  {
> > > > +	struct platform_device *pdev;
> > > >  	struct syscon *syscon;
> > > >  	struct regmap *regmap;
> > > >  	void __iomem *base;
> > > > @@ -142,7 +144,11 @@ static struct syscon *of_syscon_register(struct
> > > > device_node *np)
> > > >  	if (!base)
> > > >  		return ERR_PTR(-ENOMEM);
> > > >
> > > > -	regmap = regmap_init_mmio(NULL, base, &syscon_regmap_config);
> > > > +	pdev = of_find_device_by_node(np);
> > > > +	if (!(&pdev->dev))
> > > > +		return ERR_PTR(-ENODEV);
> > > > +
> > > > +	regmap = regmap_init_mmio(&pdev->dev, base,
> &syscon_regmap_config);
> > > >  	if (IS_ERR(regmap)) {
> > > >  		pr_err("regmap init failed\n");
> > > >  		return ERR_CAST(regmap);
> > > > -------
> > > >
> > > > I have tested this in linux-next and it works well. In this way there
> won't
> > > > be any issues of
> > > > dereferencing NULL pointer in regmap.c and at the same time, if DT has
> > > > {big,little}-endian
> > > > optional property in syscon device node, it will be taken care.
> > > >
> > > > So I would wait for Arnd's opinion about above mentioned changes and
> then
> > > > post a new
> > > > change after addressing Arnd's minor comment along with this fix in next
> > > > revision.
> > > >
> > > >
> > > > Thanks,
> > > > Pankaj Dubey
> > > > > Maybe we could consider create device structure for each syscon
> compatible
> > > > device in
> > > > > syscon driver in of_syscon_register in first time which seems to be
> > > > reasonable.
> > > > >
> > > > > Regards
> > > > > Dong Aisheng
> > > > >
> > > > > > --------------------------------------------
> > > > > > Subject: [PATCH] regmap: fix NULL pointer dereference in
> > > > > > regmap_get_val_endian
> > > > > >
> > > > > > Recent commits for getting reg endianess causing NULL pointer
> > > > > > dereference if dev is passed NULL in regmap_init_mmio. This patch
> > > > > > fixes this issue, and allows to parse reg endianess only if dev and
> > > > > > dev->of_node exist.
> > > > > >
> > > > > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > > > > ---
> > > > > >  drivers/base/regmap/regmap.c |   23 ++++++++++++++---------
> > > > > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/base/regmap/regmap.c
> > > > > > b/drivers/base/regmap/regmap.c index f2281af..455a877 100644
> > > > > > --- a/drivers/base/regmap/regmap.c
> > > > > > +++ b/drivers/base/regmap/regmap.c
> > > > > > @@ -477,7 +477,7 @@ static enum regmap_endian
> > > > > > regmap_get_val_endian(struct device *dev,
> > > > > >  					const struct regmap_bus *bus,
> > > > > >  					const struct regmap_config *config)
> > > > {
> > > > > > -	struct device_node *np = dev->of_node;
> > > > > > +	struct device_node *np;
> > > > > >  	enum regmap_endian endian;
> > > > > >
> > > > > >  	/* Retrieve the endianness specification from the regmap config
> > > */
> > > > > > @@ -487,15 +487,20 @@ static enum regmap_endian
> > > > > > regmap_get_val_endian(struct device *dev,
> > > > > >  	if (endian != REGMAP_ENDIAN_DEFAULT)
> > > > > >  		return endian;
> > > > > >
> > > > > > -	/* Parse the device's DT node for an endianness specification */
> > > > > > -	if (of_property_read_bool(np, "big-endian"))
> > > > > > -		endian = REGMAP_ENDIAN_BIG;
> > > > > > -	else if (of_property_read_bool(np, "little-endian"))
> > > > > > -		endian = REGMAP_ENDIAN_LITTLE;
> > > > > > +	/* If the dev and dev->of_node exist try to get endianness from
> > > DT
> > > > > > */
> > > > > > +	if (dev && dev->of_node) {
> > > > > > +		np = dev->of_node;
> > > > > >
> > > > > > -	/* If the endianness was specified in DT, use that */
> > > > > > -	if (endian != REGMAP_ENDIAN_DEFAULT)
> > > > > > -		return endian;
> > > > > > +		/* Parse the device's DT node for an endianness
> > > > > > specification */
> > > > > > +		if (of_property_read_bool(np, "big-endian"))
> > > > > > +			endian = REGMAP_ENDIAN_BIG;
> > > > > > +		else if (of_property_read_bool(np, "little-endian"))
> > > > > > +			endian = REGMAP_ENDIAN_LITTLE;
> > > > > > +
> > > > > > +		/* If the endianness was specified in DT, use that */
> > > > > > +		if (endian != REGMAP_ENDIAN_DEFAULT)
> > > > > > +			return endian;
> > > > > > +	}
> > > > > >
> > > > > >  	/* Retrieve the endianness specification from the bus config */
> > > > > >  	if (bus && bus->val_format_endian_default)
> > > > > > --
> > > > > >
> > > > > > Thanks,
> > > > > > Pankaj Dubey
> > > > > >
> > > > > > > Regards
> > > > > > > Dong Aisheng
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Pankaj Dubey
> > > > > > > >
> > > > > > > > > Regards
> > > > > > > > > Dong Aisheng
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > _______________________________________________
> > > > > > > > > > linux-arm-kernel mailing list
> > > > > > > > > > linux-arm-kernel at lists.infradead.org
> > > > > > > > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > > > > > >
> > > > > >
> > > >
