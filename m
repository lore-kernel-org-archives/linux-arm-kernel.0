From: horms@verge.net.au (Simon Horman)
Date: Sun, 16 Dec 2012 09:33:32 +0900
Subject: [PATCH 6/7] ARM: mackerel: support booting with or without DT
In-Reply-To: <Pine.LNX.4.64.1212151950360.7280@axis700.grange>
References: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
 <1355503531-7276-7-git-send-email-g.liakhovetski@gmx.de>
 <20121215082955.GA17390@verge.net.au>
 <Pine.LNX.4.64.1212151950360.7280@axis700.grange>
Message-ID: <20121216003331.GA27881@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 15, 2012 at 08:02:39PM +0100, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> Thanks for your comments. I'll reply to other your reviews later, I think, 
> let me just briefly clarify this one.
> 
> On Sat, 15 Dec 2012, Simon Horman wrote:
> 
> > On Fri, Dec 14, 2012 at 05:45:30PM +0100, Guennadi Liakhovetski wrote:
> > > This patch adds dynamic switching to booting either with or without DT.
> > > So far only a part of the board initialisation can be done via DT. Devices,
> > > that still need platform data are kept that way. Devices, that can be
> > > initialised from DT will not be supplied from the platform data, if a DT
> > > image is detected.
> > 
> > Hi Guennadi,
> > 
> > I'm not sure that I'm entirely comfortable with the implications
> > for users here.
> > 
> > In the beginning there was no DT for Mackerel, all boots were non-DT,
> > and in general the board and its devices have been well supported.
> > 
> > At the present time Mackerel only boots using DT, though almost all
> > the initialisation is done in C. Thus currently a DT boot fairly full
> > support for the board and its devices.
> > 
> > If I understand things correctly, with this change, a DT boot becomes a
> > limited boot that basically only supports devices that can be initialised
> > using DT. And users are expected to go back to a non-DT boot if they want
> > fuller support.  This seems undesirable.
> 
> No, it's in a way the contrary. As you correctly point out after a recent 
> change mackerel _must_ only be booted with DT, and, I think, this way an 
> undesirable change. After this series of patches both becomes possible: 
> booting with and without DT. And in both cases all devices are supported. 
> If booting without DT, all devices are supported in the "legacy" way from 
> the board file. If booting with DT _some_ devices, for which sufficient DT 
> support already exist are initialised from the .dts file, others are still 
> initialised from the .c. This way all devices are still supported. Note, 
> however, that some devices don't have a complete DT support yet, e.g., you 
> cannot specify card-detect GPIOs in .dts because of the lacking pincontrol 
> / GPIO DT support. As soon as that is added, .dts will have to be 
> extended respectively. Similarly, as more devices get DT support they can 
> be added to the .dts and excluded from the DT boot by putting them under 
> 
> +	if (!of_have_populated_dt()) {
> 
> clauses. If we ever come to a point, that no-DT booting will not have to 
> be supported any more, these clauses and respective devices can be easily 
> removed from board-mackerel.c. (Continued below)

Thanks, sorry for misunderstanding things. In that case I think I am
comfortable with the direction of these changes.

> > The approach that I took with the kzm9g was to provide an alternate dts and
> > board file, and compatibility string. Clearly that is not an entirely
> > elegant solution. But it does avoid the problem that I describe above.
> > 
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > ---
> > >  arch/arm/mach-shmobile/board-mackerel.c |   84 ++++++++++++++++++++++++-------
> > >  1 files changed, 66 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
> > > index 39b8f2e..a6358c9 100644
> > > --- a/arch/arm/mach-shmobile/board-mackerel.c
> > > +++ b/arch/arm/mach-shmobile/board-mackerel.c
> > > @@ -1326,7 +1326,6 @@ static struct platform_device mackerel_camera = {
> > >  
> > >  static struct platform_device *mackerel_devices[] __initdata = {
> > >  	&nor_flash_device,
> > > -	&smc911x_device,
> > >  	&lcdc_device,
> > >  	&usbhs0_device,
> > >  	&usbhs1_device,
> > > @@ -1335,17 +1334,21 @@ static struct platform_device *mackerel_devices[] __initdata = {
> > >  	&fsi_ak4643_device,
> > >  	&fsi_hdmi_device,
> > >  	&nand_flash_device,
> > > +	&ceu_device,
> > > +	&mackerel_camera,
> > > +	&hdmi_device,
> > > +	&hdmi_lcdc_device,
> > > +	&meram_device,
> > > +};
> > > +
> > > +static struct platform_device *mackerel_devices_dt[] __initdata = {
> > > +	&smc911x_device,
> > >  	&sdhi0_device,
> > >  #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
> > >  	&sdhi1_device,
> > >  #endif
> > >  	&sdhi2_device,
> > >  	&sh_mmcif_device,
> > > -	&ceu_device,
> > > -	&mackerel_camera,
> > > -	&hdmi_device,
> > > -	&hdmi_lcdc_device,
> > > -	&meram_device,
> > >  };
> > >  
> > >  /* Keypad Initialization */
> > > @@ -1404,6 +1407,24 @@ static struct i2c_board_info i2c1_devices[] = {
> > >  	},
> > >  };
> > >  
> > > +static int mackerel_i2c_bus_notify(struct notifier_block *nb,
> > > +				   unsigned long action, void *data)
> > > +{
> > > +	struct device *dev = data;
> > > +
> > > +	if (action != BUS_NOTIFY_ADD_DEVICE ||
> > > +	    strcmp(dev_name(dev->parent), "fff20000.i2c"))
> > > +		return NOTIFY_DONE;
> > > +
> > > +	i2c_new_device(to_i2c_adapter(dev), &i2c0_devices[1]);
> > > +
> > > +	return NOTIFY_OK;
> > > +}
> > > +
> > > +static struct notifier_block mackerel_i2c_notifier = {
> > > +	.notifier_call = mackerel_i2c_bus_notify,
> > > +};
> > > +
> > >  #define GPIO_PORT9CR	IOMEM(0xE6051009)
> > >  #define GPIO_PORT10CR	IOMEM(0xE605100A)
> > >  #define GPIO_PORT167CR	IOMEM(0xE60520A7)
> > > @@ -1420,22 +1441,26 @@ static void __init mackerel_init(void)
> > 
> > I wonder if it would be cleaner to achieve this by providing
> > mackerel_init_dt().
> 
> I thought about this, but initialisation is interleaved and in some cases 
> order is important, so, you would need something like "early_dt()," 
> "mid_early_common()," "late_dt()" etc., which doesn't seem an improvement 
> to me:-)

Understood. I guess it is case by case, and in this case the approach
you have taken does seem to make sense. Magnus, do you have any
thoughts on this?

> > >  		{ "A3SP", &usbhs0_device, },
> > >  		{ "A3SP", &usbhs1_device, },
> > >  		{ "A3SP", &nand_flash_device, },
> > > +		{ "A4R", &ceu_device, },
> > > +	};
> > > +	struct pm_domain_device domain_devices_dt[] = {
> > >  		{ "A3SP", &sh_mmcif_device, },
> > >  		{ "A3SP", &sdhi0_device, },
> > >  #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
> > >  		{ "A3SP", &sdhi1_device, },
> > >  #endif
> > >  		{ "A3SP", &sdhi2_device, },
> > > -		{ "A4R", &ceu_device, },
> > >  	};
> > >  	u32 srcr4;
> > >  	struct clk *clk;
> > >  
> > > -	regulator_register_always_on(0, "fixed-1.8V", fixed1v8_power_consumers,
> > > -				     ARRAY_SIZE(fixed1v8_power_consumers), 1800000);
> > > -	regulator_register_always_on(1, "fixed-3.3V", fixed3v3_power_consumers,
> > > -				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
> > > -	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
> > > +	if (!of_have_populated_dt()) {
> > > +		regulator_register_always_on(0, "fixed-1.8V", fixed1v8_power_consumers,
> > > +					     ARRAY_SIZE(fixed1v8_power_consumers), 1800000);
> > > +		regulator_register_always_on(1, "fixed-3.3V", fixed3v3_power_consumers,
> > > +					     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
> > > +		regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
> > > +	}
> > >  
> > >  	/* External clock source */
> > >  	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
> > > @@ -1633,22 +1658,35 @@ static void __init mackerel_init(void)
> > >  	udelay(50);
> > >  	__raw_writel(srcr4 & ~(1 << 13), SRCR4);
> > >  
> > > -	i2c_register_board_info(0, i2c0_devices,
> > > -				ARRAY_SIZE(i2c0_devices));
> > > -	i2c_register_board_info(1, i2c1_devices,
> > > -				ARRAY_SIZE(i2c1_devices));
> > > +	if (!of_have_populated_dt()) {
> > > +		i2c_register_board_info(0, i2c0_devices,
> > > +					ARRAY_SIZE(i2c0_devices));
> > > +		i2c_register_board_info(1, i2c1_devices,
> > > +					ARRAY_SIZE(i2c1_devices));
> > > +	} else {
> > > +		bus_register_notifier(&i2c_bus_type,
> > > +				      &mackerel_i2c_notifier);
> > > +	}
> > >  
> > >  	sh7372_add_standard_devices();
> > >  
> > >  	platform_add_devices(mackerel_devices, ARRAY_SIZE(mackerel_devices));
> > > +	if (!of_have_populated_dt())
> > > +		platform_add_devices(mackerel_devices_dt,
> > > +				     ARRAY_SIZE(mackerel_devices_dt));
> > >  
> > >  	rmobile_add_devices_to_domains(domain_devices,
> > >  				       ARRAY_SIZE(domain_devices));
> > > +	if (!of_have_populated_dt())
> > > +		rmobile_add_devices_to_domains(domain_devices_dt,
> > > +					       ARRAY_SIZE(domain_devices_dt));
> > >  
> > >  	hdmi_init_pm_clock();
> > >  	sh7372_pm_init();
> > >  	pm_clk_add(&fsi_device.dev, "spu2");
> > >  	pm_clk_add(&hdmi_lcdc_device.dev, "hdmi");
> > > +
> > > +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > >  }
> > >  
> > >  static const char *mackerel_boards_compat_dt[] __initdata = {
> > > @@ -1659,10 +1697,20 @@ static const char *mackerel_boards_compat_dt[] __initdata = {
> > >  DT_MACHINE_START(MACKEREL_DT, "mackerel")
> > >  	.map_io		= sh7372_map_io,
> > >  	.init_early	= sh7372_add_early_devices,
> > > -	.init_irq	= sh7372_init_irq,
> > > +	.init_irq	= sh7372_init_irq_of,
> > > +	.handle_irq	= shmobile_handle_irq_intc,
> > > +	.init_machine	= mackerel_init,
> > > +	.init_late	= sh7372_pm_init_late,
> > > +	.timer		= &shmobile_timer,
> > > +	.dt_compat	= mackerel_boards_compat_dt,
> > > +MACHINE_END
> > > +
> > > +MACHINE_START(MACKEREL, "mackerel")
> > > +	.map_io		= sh7372_map_io,
> > > +	.init_early	= sh7372_add_early_devices,
> > > +	.init_irq	= sh7372_init_irq_of,
> > 
> > Could sh7372_init_irq be used here ?
> 
> Yes, it could. I'll reply to your other review separately, briefly, by 
> using the conditional, that I proposed in my patch 3/7 we could make the 
> non-dt version static and let everyone just use sh7372_init_irq_of. But 
> this is just an idea, we can keep sh7372_init_irq() too if this is 
> prefered.

That is my preference at this point.

> Thanks
> Guennadi
> 
> > >  	.handle_irq	= shmobile_handle_irq_intc,
> > >  	.init_machine	= mackerel_init,
> > >  	.init_late	= sh7372_pm_init_late,
> > >  	.timer		= &shmobile_timer,
> > > -	.dt_compat  = mackerel_boards_compat_dt,
> > >  MACHINE_END
> > > -- 
> > > 1.7.2.5
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 
