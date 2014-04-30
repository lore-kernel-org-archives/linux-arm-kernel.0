From: 5172643@gmail.com (=?UTF-8?Q?=D0=9E=D0=9E=D0=9E_?= =?UTF-8?Q?=22=D0=AD=D0=BB=D0=B5=D0=BA=D1=82=D1=80=D0=BE=D0=9F=D0=BB?= =?UTF-8?Q?=D1=8E=D1=81=22?=)
Date: Wed, 30 Apr 2014 21:35:17 +0400
Subject: [PATCH v4 10/21] mtd: support BB SRAM on ICP DAS LP-8x4x
In-Reply-To: <20140430172114.GA2497@norris-Latitude-E6410>
References: <1397668411-27162-7-git-send-email-ynvich@gmail.com>
 <1397668667-27328-1-git-send-email-ynvich@gmail.com>
 <1397668667-27328-4-git-send-email-ynvich@gmail.com>
 <20140430172114.GA2497@norris-Latitude-E6410>
Message-ID: <1398879317.15199.15.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Wed, 2014-04-30 at 10:21 -0700, Brian Norris wrote:
> A few more small comments.
> 
> On Wed, Apr 16, 2014 at 09:17:15PM +0400, Sergei Ianovich wrote:
> > +++ b/Documentation/devicetree/bindings/mtd/sram-lp8x4x.txt
> > @@ -0,0 +1,22 @@
> > +512kB battery backed up SRAM on LP-8x4x industrial computers
> > +
> > +Required properties:
> > +- compatible : should be "icpdas,sram-lp8x4x"
> > +
> > +- reg: physical base addresses and region lengths of
> > +       * IO memory range
> > +       * SRAM page selector
> 
> Are these region types pretty static for this type of hardware? If not,
> it helps to have a reg-names property in the DT, when there are 2 or
> more register resources.

The regions are fixed. The addresses are hard-wired.

> > +- eeprom-gpios : should point to active-low write enable GPIO
> 
> I'm curious: your driver doesn't actually utilize this binding. Is this
> intentional? Is it actually optional? (I note that the example DT below
> doesn't have this property...)

Thanks for noticing. It's an artifact of copy-paste. I'll drop this.

> > +++ b/arch/arm/configs/lp8x4x_defconfig
> > @@ -57,6 +57,7 @@ CONFIG_MTD_CFI_ADV_OPTIONS=y
> >  CONFIG_MTD_CFI_GEOMETRY=y
> >  CONFIG_MTD_CFI_INTELEXT=y
> >  CONFIG_MTD_PHYSMAP_OF=y
> > +CONFIG_MTD_SRAM_LP8X4X=y
> >  CONFIG_PROC_DEVICETREE=y
> >  CONFIG_BLK_DEV_LOOP=y
> >  CONFIG_BLK_DEV_LOOP_MIN_COUNT=2
> 
> I can't take the defconfig update via MTD; it will need to go via the
> appropriate ARM tree (arm-soc?). So this hunk needs to move to another
> patch.

Sure. I'll remove this chunk and put it into main device patch.

> > +	match = of_match_device(of_flash_match, &pdev->dev);
> > +	if (!match)
> > +		return -EINVAL;
> 
> Does this of_match_device() serve any particular purpose? Your driver
> already matches against these IDs, and you're not actually retrieving
> any of-data from the match, so this looks redundant.

Point taken, I'll drop this.

> > +
> > +	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> > +	if (!info)
> > +		return -ENOMEM;
> > +
> > +	res_virt = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	info->virt =  devm_ioremap_resource(&pdev->dev, res_virt);
> > +	if (IS_ERR(info->virt))
> > +		return PTR_ERR(info->virt);
> > +
> > +	res_bank = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +	info->bank = devm_ioremap_resource(&pdev->dev, res_bank);
> > +	if (IS_ERR(info->bank))
> > +		return PTR_ERR(info->bank);
> > +
> > +	info->mtd.priv = info;
> > +	info->mtd.name = "SRAM";
> 
> Are you absolutely sure there is only ever a single SRAM device on a
> given system? Because otherwise, you will get redundantly-named MTD's.
> If the answer is no, you might consider a unique naming scheme.

Like .999999 sure. This one is hard-wired. There is no extension slots
to plug in any memory device.

I'll post a new version with the rest of the series. Thanks for
reviewing.
