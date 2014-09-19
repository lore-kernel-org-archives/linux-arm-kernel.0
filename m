From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 19 Sep 2014 12:19:35 +0800
Subject: [PATCH v3] mfd: syscon: Decouple syscon interface from
 platform devices
In-Reply-To: <48f9f4067cc44ad49297bb4b62c56c88@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1410935510-1567-1-git-send-email-pankaj.dubey@samsung.com>
 <20140917085818.GA10285@shlinux1.ap.freescale.net>
 <000401cfd269$922dfc40$b689f4c0$@samsung.com>
 <20140918030552.GA26661@shlinux1.ap.freescale.net>
 <000701cfd306$4d3e8080$e7bb8180$@samsung.com>
 <20140918075516.GB15363@shlinux1.ap.freescale.net>
 <000c01cfd324$1f2cd930$5d868b90$@samsung.com>
 <20140918100505.GA19346@shlinux1.ap.freescale.net>
 <48f9f4067cc44ad49297bb4b62c56c88@BY2PR0301MB0613.namprd03.prod.outlook.com>
Message-ID: <20140919041933.GB19346@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 11:38:03AM +0800, Xiubo Li-B47053 wrote:
> > > Thanks for testing. In that case I will post this change, as I feel this
> > > should be
> > > fixed irrespective of my syscon patch.
> > >
> > > > But as Xiubo pointed in another mail, it may still cause other issues.
> > > > Looking at regmap.c, there're still some other places using the device
> > > pointer, e.g.
> > > > dev_xxx debug information and some tracepoints also take device pointer as
> > > > parameter(not sure if it will break if dev is NULL).
> > > > Another thing is that if dev is NULL, we may not be able to use regmap
> > > debugfs
> > > > feature which seems also not as our expected.
> > > >
> > >
> > > I would have preferred to check dev for NULL, as it's only at two places and
> > > we could
> > > still have debug prints for NULL dev, as normal pr_info instead of dev_info.
> > >
> > > But Xiubo also pointed out that his patch [1] which updates syscon binding
> > > information
> > > will be useless if we pass NULL dev in regmap_init_mmio, which he posted
> > > today,
> > > and it requires dev pointer in "regmap_get_val_endian" function to read DT
> > > property.
> > >
> > > [1]: [PATCH] mfd: syscon: binding: Add syscon endianness support
> > >       https://lkml.org/lkml/2014/9/18/67
> > >
> > > So instead of adding dummy device or creating device structure, I would
> > > prefer to get actual
> > > device pointer corresponding to "np" passed in of_syscon_register function
> > > as shown below:
> > >
> > 
> > I wonder this may not work at early stage before the devices are populated
> > from device tree.
> > My initial understanding that one important thing for your patch is
> > to address this issue, isn't it?
> > Many people have asked for this feature before.
> > 
> 
> My boot log:
> 
>    ...
> of_platform_bus_create() - skipping /chosen, no compatible prop
> of_platform_bus_create() - skipping /aliases, no compatible prop
> of_platform_bus_create() - skipping /memory, no compatible prop
> of_platform_bus_create() - skipping /cpus, no compatible prop
>    create child: /soc/smmu at 1200000
>    create child: /soc/smmu at 1280000
>    create child: /soc/smmu at 1300000
>    create child: /soc/smmu at 1380000
>    create child: /soc/interrupt-controller at 1400000
>    create child: /soc/tzasc at 1500000
> of_platform_bus_create() - skipping /soc/tzasc at 1500000, no compatible prop
>    create child: /soc/ifc at 1530000
>    create child: /soc/ifc at 1530000/nor at 0,0
>    create child: /soc/ifc at 1530000/board-control at 2,0
>    create child: /soc/dcfg at 1ee0000
> syscon 1ee0000.dcfg: regmap [mem 0x01ee0000-0x01eeffff] registered
>    create child: /soc/quadspi at 1550000
>    create child: /soc/esdhc at 1560000
>    create child: /soc/scfg at 1570000
>    create child: /soc/crypto at 1700000
>    create child: /soc/sfp at 1e80000
> of_platform_bus_create() - skipping /soc/sfp at 1e80000, no compatible prop
>    create child: /soc/snvs at 1e90000
> of_platform_bus_create() - skipping /soc/snvs at 1e90000, no compatible prop
>    create child: /soc/serdes1 at 1ea0000
> of_platform_bus_create() - skipping /soc/serdes1 at 1ea0000, no compatible prop
>    create child: /soc/clocking at 1ee1000
>    create child: /soc/rcpm at 1ee2000
>    create child: /soc/dspi at 2100000
>    create child: /soc/dspi at 2110000
>    create child: /soc/i2c at 2180000
>    create child: /soc/i2c at 2190000
>    create child: /soc/i2c at 21a0000
>    create child: /soc/serial at 21c0500
>    create child: /soc/serial at 21c0600
>    create child: /soc/serial at 21d0500
>    create child: /soc/serial at 21d0600
>    create child: /soc/gpio at 2300000
>    create child: /soc/gpio at 2310000
>    create child: /soc/gpio at 2320000
>    create child: /soc/gpio at 2330000
>    create child: /soc/uqe at 2400000
>    create child: /soc/uqe at 2400000/qeic at 80
>    create child: /soc/uqe at 2400000/ucc at 2000
> irq: no irq domain found for /soc/uqe at 2400000/qeic at 80 !
>    create child: /soc/uqe at 2400000/ucc at 2200
> irq: no irq domain found for /soc/uqe at 2400000/qeic at 80 !
>    create child: /soc/uqe at 2400000/muram at 10000
>    create child: /soc/uqe at 2400000/si at 700
>    create child: /soc/uqe at 2400000/siram at 1000
>    create child: /soc/serial at 2950000
>    create child: /soc/serial at 2960000
>    create child: /soc/serial at 2970000
>    create child: /soc/serial at 2980000
>    create child: /soc/serial at 2990000
>    create child: /soc/serial at 29a0000
>    create child: /soc/ftm0_1 at 29d0000
>    create child: /soc/ftm at 29f0000
> of_platform_bus_create() - skipping /soc/ftm at 29f0000, no compatible prop
>    create child: /soc/ftm at 2a00000
>    create child: /soc/ftm at 2a10000
> of_platform_bus_create() - skipping /soc/ftm at 2a10000, no compatible prop
>    create child: /soc/ftm at 2a20000
> of_platform_bus_create() - skipping /soc/ftm at 2a20000, no compatible prop
>    create child: /soc/ftm at 2a30000
>    create child: /soc/ftm at 2a40000
>    create child: /soc/wdog at 2ad0000
>    create child: /soc/sai at 2b60000
>    create child: /soc/edma at 2c00000
>    create child: /soc/dcu at 2ce0000
>    create child: /soc/mdio at 2d24000
>    create child: /soc/ptp_clock at 2d10e00
>    create child: /soc/ethernet at 2d10000
>    create child: /soc/ethernet at 2d50000
>    create child: /soc/ethernet at 2d90000
>    create child: /soc/usb at 8600000
>    create child: /soc/usb3 at 3100000
>    create child: /soc/can at 2a70000
>    create child: /soc/can at 2a80000
>    create child: /soc/can at 2a90000
>    create child: /soc/can at 2aa0000
>    create child: /soc/pcie at 3400000
>    create child: /soc/pcie at 3500000
>    create child: /dcsr at 20000000/dcsr-epu at 0
>    create child: /dcsr at 20000000/dcsr-gdi at 100000
>    create child: /dcsr at 20000000/dcsr-dddi at 120000
>    create child: /dcsr at 20000000/dcsr-dcfg at 220000
>    create child: /dcsr at 20000000/dcsr-clock at 221000
>    create child: /dcsr at 20000000/dcsr-rcpm at 222000
>    create child: /dcsr at 20000000/dcsr-ccp at 225000
>    create child: /dcsr at 20000000/dcsr-fusectrl at 226000
>    create child: /dcsr at 20000000/dcsr-dap at 300000
>    create child: /dcsr at 20000000/dcsr-cstf at 350000
>    create child: /dcsr at 20000000/dcsr-a7rom at 360000
>    create child: /dcsr at 20000000/dcsr-a7cpu at 370000
>    create child: /dcsr at 20000000/dcsr-a7cti at 378000
>    create child: /dcsr at 20000000/dcsr-etm at 37c000
>    create child: /dcsr at 20000000/dcsr-hugorom at 3a0000
>    create child: /dcsr at 20000000/dcsr-etf at 3a1000
>    create child: /dcsr at 20000000/dcsr-etr at 3a3000
>    create child: /dcsr at 20000000/dcsr-cti at 3a4000
>    create child: /dcsr at 20000000/dcsr-atbrepl at 3a8000
>    create child: /dcsr at 20000000/dcsr-tsgen-ctrl at 3a9000
>    create child: /dcsr at 20000000/dcsr-tsgen-read at 3aa000
>    create child: /regulators/regulator at 0
>    ...
> 
> As default the Linux will create all the platform device for each DT node, which
> Can be found from "drivers/of/platform.c".
> 
> So we can get the pdev node using the specified DT node, and feel safe to use
> it as Pankaj's patch does.
> 

I mean before the devices are populated from device tree.
For example, we usually call of_platform_populate in .init_machine.
Before it, we may not be able to get it's device, isn't it?

Regards
Dong Aisheng

> And also we must make sure that the 'syscon' DT nodes has the compatible prop.
> 
> Thanks,
> 
> BRs
> Xiubo
> 
> 
> > Regards
> > Dong Aisheng
> > 
> > > ----
> > > static struct syscon *of_syscon_register(struct device_node *np)
> > >  {
> > > +	struct platform_device *pdev;
> > >  	struct syscon *syscon;
> > >  	struct regmap *regmap;
> > >  	void __iomem *base;
> > > @@ -142,7 +144,11 @@ static struct syscon *of_syscon_register(struct
> > > device_node *np)
> > >  	if (!base)
> > >  		return ERR_PTR(-ENOMEM);
> > >
> > > -	regmap = regmap_init_mmio(NULL, base, &syscon_regmap_config);
> > > +	pdev = of_find_device_by_node(np);
> > > +	if (!(&pdev->dev))
> > > +		return ERR_PTR(-ENODEV);
> > > +
> > > +	regmap = regmap_init_mmio(&pdev->dev, base, &syscon_regmap_config);
> > >  	if (IS_ERR(regmap)) {
> > >  		pr_err("regmap init failed\n");
> > >  		return ERR_CAST(regmap);
> > > -------
> > >
> > > I have tested this in linux-next and it works well. In this way there won't
> > > be any issues of
> > > dereferencing NULL pointer in regmap.c and at the same time, if DT has
> > > {big,little}-endian
> > > optional property in syscon device node, it will be taken care.
> > >
> > > So I would wait for Arnd's opinion about above mentioned changes and then
> > > post a new
> > > change after addressing Arnd's minor comment along with this fix in next
> > > revision.
> > >
> > >
> > > Thanks,
> > > Pankaj Dubey
> > > > Maybe we could consider create device structure for each syscon compatible
> > > device in
> > > > syscon driver in of_syscon_register in first time which seems to be
> > > reasonable.
> > > >
> > > > Regards
> > > > Dong Aisheng
> > > >
> > > > > --------------------------------------------
> > > > > Subject: [PATCH] regmap: fix NULL pointer dereference in
> > > > > regmap_get_val_endian
> > > > >
> > > > > Recent commits for getting reg endianess causing NULL pointer
> > > > > dereference if dev is passed NULL in regmap_init_mmio. This patch
> > > > > fixes this issue, and allows to parse reg endianess only if dev and
> > > > > dev->of_node exist.
> > > > >
> > > > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > > > ---
> > > > >  drivers/base/regmap/regmap.c |   23 ++++++++++++++---------
> > > > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/drivers/base/regmap/regmap.c
> > > > > b/drivers/base/regmap/regmap.c index f2281af..455a877 100644
> > > > > --- a/drivers/base/regmap/regmap.c
> > > > > +++ b/drivers/base/regmap/regmap.c
> > > > > @@ -477,7 +477,7 @@ static enum regmap_endian
> > > > > regmap_get_val_endian(struct device *dev,
> > > > >  					const struct regmap_bus *bus,
> > > > >  					const struct regmap_config *config)
> > > {
> > > > > -	struct device_node *np = dev->of_node;
> > > > > +	struct device_node *np;
> > > > >  	enum regmap_endian endian;
> > > > >
> > > > >  	/* Retrieve the endianness specification from the regmap config
> > */
> > > > > @@ -487,15 +487,20 @@ static enum regmap_endian
> > > > > regmap_get_val_endian(struct device *dev,
> > > > >  	if (endian != REGMAP_ENDIAN_DEFAULT)
> > > > >  		return endian;
> > > > >
> > > > > -	/* Parse the device's DT node for an endianness specification */
> > > > > -	if (of_property_read_bool(np, "big-endian"))
> > > > > -		endian = REGMAP_ENDIAN_BIG;
> > > > > -	else if (of_property_read_bool(np, "little-endian"))
> > > > > -		endian = REGMAP_ENDIAN_LITTLE;
> > > > > +	/* If the dev and dev->of_node exist try to get endianness from
> > DT
> > > > > */
> > > > > +	if (dev && dev->of_node) {
> > > > > +		np = dev->of_node;
> > > > >
> > > > > -	/* If the endianness was specified in DT, use that */
> > > > > -	if (endian != REGMAP_ENDIAN_DEFAULT)
> > > > > -		return endian;
> > > > > +		/* Parse the device's DT node for an endianness
> > > > > specification */
> > > > > +		if (of_property_read_bool(np, "big-endian"))
> > > > > +			endian = REGMAP_ENDIAN_BIG;
> > > > > +		else if (of_property_read_bool(np, "little-endian"))
> > > > > +			endian = REGMAP_ENDIAN_LITTLE;
> > > > > +
> > > > > +		/* If the endianness was specified in DT, use that */
> > > > > +		if (endian != REGMAP_ENDIAN_DEFAULT)
> > > > > +			return endian;
> > > > > +	}
> > > > >
> > > > >  	/* Retrieve the endianness specification from the bus config */
> > > > >  	if (bus && bus->val_format_endian_default)
> > > > > --
> > > > >
> > > > > Thanks,
> > > > > Pankaj Dubey
> > > > >
> > > > > > Regards
> > > > > > Dong Aisheng
> > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Pankaj Dubey
> > > > > > >
> > > > > > > > Regards
> > > > > > > > Dong Aisheng
> > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > _______________________________________________
> > > > > > > > > linux-arm-kernel mailing list
> > > > > > > > > linux-arm-kernel at lists.infradead.org
> > > > > > > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > > > > >
> > > > >
> > >
