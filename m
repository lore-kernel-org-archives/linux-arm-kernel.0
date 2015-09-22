From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Sep 2015 21:15:21 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <5601799C.20701@free.fr>
References: <56001B78.2090001@free.fr> <144297172.JfjI0hNJ9J@wuerfel>
 <5601799C.20701@free.fr>
Message-ID: <3168184.5li5Yj9y1C@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 September 2015 17:54:04 Mason wrote:
> On 22/09/2015 16:51, Arnd Bergmann wrote:
> > On Tuesday 22 September 2015 16:36:48 Mason wrote:
> >> On 21/09/2015 17:49, Arnd Bergmann wrote:
> >>>
> >>> - As you are probably aware, please split the series into multiple patches,
> >>>   doing one thing at a time. A lot of the patches don't have dependencies
> >>>   on one another and can just get merged as soon as they are ready
> >>
> >> I'm supposed to use git-format-patch, right?
> > 
> > Yes, and follow Documentation/SubmittingPatches
> > 
> >>> [snip advice for drivers]
> >>> - no mach-types changes please
> >>
> >> The new way is DT_MACHINE_START?
> > 
> > Right.
> > 
> >>> - whatever you need in smp_twd.c will have to get merged by Russell,
> >>>   the other patches go through the arm-soc tree.
> >>
> >> One change is a temp wart for getting twd_clk until I have proper DT.
> >>
> >> The other change is to remove CLOCK_EVT_FEAT_C3STOP for my board.
> >> (We discussed this in May.)
> >>
> >> Thanks for your guidance. Just to get the ball rolling, here's
> >> the full platform patch minus drivers.
> >>
> >> Open question:
> >>
> >> 1) arch/arm/Kconfig vs arch/arm/mach-tangox/Kconfig
> >> What goes in the first? What goes in the second?
> > 
> > The first only gets a single line to include the second.
> 
> Oh... So all the platforms that define stuff in arch/arm/Kconfig
> are just legacy at this point?

To a certain degree yes. I have patches for all ARMv6/ARMv7 platforms
that are not converted yet, and we are not accepting new platforms
outside of ARCH_MULTIPLATFORM.

> > 
> > name this after the actual board you use, put everything that is not
> > specific to the board into a tango4.dtsi file.
> 
> Nothing in tango.dts is specific to the board. It's all in the SoC,
> as far as I can tell.

You can probably just rename the file then, and have a board specific
dts file with just the /chosen and /aliases nodes.

> > [snip comments on DT description]
> >> arch/arm/mach-tangox/Kconfig
> >> +if ARCH_TANGOX
> >> +
> >> +config UNCOMPRESS_INCLUDE
> >> +	string
> >> +	default "debug/uncompress.h"
> > 
> > Better do this like everyone else.
> 
> Do you mean I should provide an empty mach/uncompress.h ?

No, add a debug/*.S file for your uart and do the configuration in
arch/arm/Kconfig.debug.

The UNCOMPRESS_INCLUDE symbol is defined in arch/arm/Kconfig.debug,
and you should not duplicate that.

> >> +config MACH_TANGOX_87XX
> >> +	bool "Sigma Designs TANGOX 87XX Board"
> >> +	default y
> >> +	depends on ARCH_TANGOX
> >> +	select MIGHT_HAVE_CACHE_L2X0
> >> +	select CPU_V7
> >> +	select ARM_GIC
> >> +	select VFP
> >> +	select SMP
> >> +	select LOCAL_TIMERS if SMP
> >> +	select HAVE_ARM_TWD if SMP
> >> +	select HAVE_ARM_SCU if SMP
> >> +	select PL310_ERRATA_588369
> >> +	select PL310_ERRATA_727915
> >> +	select ARM_ERRATA_754322
> >> +	select ARM_ERRATA_775420
> >> +	select ARCH_HAS_OPP
> >> +	select PM_OPP if PM
> >> +	select USB_ARCH_HAS_EHCI if USB_SUPPORT
> >> +	select ARM_CPU_SUSPEND if PM
> >> +	select CPU_USE_DOMAINS if MMU
> >> +	select COMMON_CLK
> >> +	select TANGOX
> > 
> > Most of these are already implied by teh generic options.
> 
> Is there a simple way to remove what is unnecessary and not more?

Look at ARCH_MULTIPLATFORM and ARCH_MULTI_V7 as a start.

> >> +void __init tangox_timer_init(void)
> >> +{
> >> +	int err;
> >> +
> >> +	clkgen_base = ioremap(CLKGEN_BASE, 0x100);
> > 
> > Remove all hardcoded physical memory addresses.
> 
> You mean I should read CLKGEN_BASE through DT?
> (Converting the clock code to DT is a TODO.)

Yes, until that is done, we are not merging this file.

> > 
> >> +static struct map_desc tango_map_desc[] __initdata = {
> >> +	{
> >> +		.virtual	= TANGO_IO_START,
> >> +		.pfn		=__phys_to_pfn(0),
> >> +		.length		= TANGO_IO_SIZE,
> >> +		.type 		= MT_DEVICE,
> >> +	},
> >> +};
> >> +
> >> +static void __init tango_map_io(void)
> >> +{
> >> +	iotable_init(tango_map_desc, ARRAY_SIZE(tango_map_desc));
> >> +}
> > 
> > What is this for? Most platforms don't need this.
> 
> IIUC, the idea was to optimize TLB entries by having a single
> 16MB super-section mapping. If every driver maps his little
> 500-byte area, the MMU code has to create lots of second
> level mappings.
> 
> We might as well create one large mapping at init, no?

Right, but if you do that, please add a comment for it, ideally
showing how much you gained from doing this in terms of vmalloc
space or real-life performance.

It's not wrong to have a mapping like this, just annoying enough
that we don't want to do it without a good reason.

> >> +static const char *tango_dt_compat[] = { "sigma,tango4-soc", NULL };
> >> +
> >> +MACHINE_START(TANGOX_87XX, "TANGOX_87XX")
> >> +	.atag_offset	= 0x100,
> >> +	.init_time	= tangox_timer_init,
> >> +	.map_io		= tango_map_io,
> >> +	//.smp		= &tangox_smp_ops,
> >> +	//.restart	= tango_restart, /*** REQUIRED FOR CLEAN REBOOT ***/
> >> +	.dt_compat	= tango_dt_compat,
> >> +MACHINE_END
> > 
> > All except the dt_compat can be removed here.
> 
> I left .smp and .restart in comments because I need those, AFAIU?

There are other ways to do those too, see CPU_METHOD_OF_DECLARE()
and register_restart_handler().

> Also I'm using the APPEND_DT_TO_UIMAGE option. I don't need the
> atag_offset info?

No, the atag_offset is only use for native booting without a DT
(old-style board files), which you don't do.

	Arnd
