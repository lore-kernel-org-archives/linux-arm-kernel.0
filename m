From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 6 Jun 2013 18:26:19 +0200
Subject: [PATCH v2] ARM: mmp: bring up pxa988 with device tree support
In-Reply-To: <175CCF5F49938B4D99B2E3EF7F558EBE3B3BA09137@SC-VEXCH4.marvell.com>
References: <1369969115-4279-1-git-send-email-zhangwm@marvell.com>
 <1726105.oKcjXShr89@wuerfel>
 <175CCF5F49938B4D99B2E3EF7F558EBE3B3BA09137@SC-VEXCH4.marvell.com>
Message-ID: <201306061826.19551.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 June 2013, Neil Zhang wrote:
> > > diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
> > > index ebdda83..0955191 100644
> > > --- a/arch/arm/mach-mmp/Kconfig
> > > +++ b/arch/arm/mach-mmp/Kconfig
> > > @@ -107,6 +107,16 @@ config MACH_MMP2_DT
> > >  	  Include support for Marvell MMP2 based platforms using
> > >  	  the device tree.
> > >
> > > +config MACH_MMPX_DT
> > > +	bool "Support no-PJ/PJ4(ARMv7) platforms from device tree"
> > > +	depends on !CPU_MOHAWK && !CPU_PJ4
> > > +	select CPU_PXA988
> > > +	select USE_OF
> > > +	select PINCTRL
> > > +	select PINCTRL_SINGLE
> > 
> > Why would this be mutually exclusive with PJ4? Cortex-A9 and PJ4 are both
> > ARMv7 based, so we should be able to have them in the same kernel.
> 
> The MACH_MMPX_DT here is for standard ARM core based SoC.
> But PJ4 is modified by Marvell, which includes IWMMXT.

That should not stop us from supporting them with the same kernel.
We can already build a kernel that will work with IWMMXT on
ArmadaXP (PJ4B) and Calxeda Highbank (Cortex-A9) for instance.

> > __initdata = {
> > >  		.virtual	= (unsigned long)AXI_VIRT_BASE,
> > >  		.length		= AXI_PHYS_SIZE,
> > >  		.type		= MT_DEVICE,
> > > -	},
> > > +	}, {
> > > +		.pfn		= __phys_to_pfn(MMP_CORE_PERIPH_PHYS_BASE),
> > > +		.virtual	= (unsigned long)MMP_CORE_PERIPH_VIRT_BASE,
> > > +		.length		= MMP_CORE_PERIPH_PHYS_SIZE,
> > > +		.type		= MT_DEVICE,
> > > +	}
> > >  };
> > >
> > >  void __init mmp_map_io(void)
> > 
> > What is this needed for?
> 
> This function is used to static map the device registers.

I understand what map_io does. Why do you need a static mapping?

> > > +/* PXA988 */
> > > +static const struct of_dev_auxdata pxa988_auxdata_lookup[] __initconst
> > = {
> > > +	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4017000, "pxa2xx-uart.0",
> > NULL),
> > > +	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4018000, "pxa2xx-uart.1",
> > NULL),
> > > +	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4036000, "pxa2xx-uart.2",
> > NULL),
> > > +	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4011000, "pxa2xx-i2c.0",
> > NULL),
> > > +	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4037000, "pxa2xx-i2c.1",
> > NULL),
> > > +	OF_DEV_AUXDATA("mrvl,mmp-gpio", 0xd4019000, "pxa-gpio", NULL),
> > > +	OF_DEV_AUXDATA("mrvl,mmp-rtc", 0xd4010000, "sa1100-rtc", NULL),
> > > +	{}
> > > +};
> > 
> > Why do you need auxdata?
> 
> Two reasons:
> 1. some of the device still need platform data at this time.

None of the ones above do apparently.

> 2. we use device name as clk name.
> Will change it later, but need some time.

If you have no platform_data, I think you should modify the clkdev
lookup table to refer to the DT based names so you no longer have
to pass auxdata.

The long term solution of course is to describe the clocks in the
device tree as well.

> > > +void __init pxa988_dt_init_timer(void) {
> > > +	extern void __init mmp_dt_init_timer(void);
> > 
> > You should never put 'extern' declarations into a .c file.
> > 
> > > +	/*
> > > +	 * Is is a SOC timer, and will be used for broadcasting
> > > +	 * when local timers are disabled.
> > > +	 */
> > > +	mmp_dt_init_timer();
> > > +
> > > +	clocksource_of_init();
> > > +}
> > 
> > Please just change the mmp_dt_init_timer function to use
> > CLOCKSOURCE_OF_DECLARE(), and if possible move the file to
> > drivers/clocksource.
> 
> Yes, we will change to use CLOCKSOURCE_OF_DECLARE later.
> But it need time, so let's keep it at this time.

It should be a trivial change, I'm not asking you to put the clocks
in the DT right away, just change the way that this function gets
called.

	Arnd
