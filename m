From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Sep 2015 16:51:48 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56016780.5080104@free.fr>
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
 <56016780.5080104@free.fr>
Message-ID: <144297172.JfjI0hNJ9J@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 September 2015 16:36:48 Mason wrote:
> On 21/09/2015 17:49, Arnd Bergmann wrote:
> > 
> > - As you are probably aware, please split the series into multiple patches,
> >   doing one thing at a time. A lot of the patches don't have dependencies
> >   on one another and can just get merged as soon as they are ready
> 
> I'm supposed to use git-format-patch, right?

Yes, and follow Documentation/SubmittingPatches

> > [snip advice for drivers]
> > - no mach-types changes please
> 
> The new way is DT_MACHINE_START?

Right.

> > - whatever you need in smp_twd.c will have to get merged by Russell,
> >   the other patches go through the arm-soc tree.
> 
> One change is a temp wart for getting twd_clk until I have proper DT.
> 
> The other change is to remove CLOCK_EVT_FEAT_C3STOP for my board.
> (We discussed this in May.)
> 
> Thanks for your guidance. Just to get the ball rolling, here's
> the full platform patch minus drivers.
> 
> Open question:
> 
> 1) arch/arm/Kconfig vs arch/arm/mach-tangox/Kconfig
> What goes in the first? What goes in the second?

The first only gets a single line to include the second.

 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1c5021002fe4..06002e552afd 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -758,6 +758,21 @@ config ARCH_OMAP1
>  	help
>  	  Support for older TI OMAP1 (omap7xx, omap15xx or omap16xx)
>  
> +config ARCH_TANGOX
> +	bool "Sigma Designs Tango"
> +	select CLKDEV_LOOKUP
> +	select HAVE_CLK
> +	select HAVE_SMP
> +	select ARCH_REQUIRE_GPIOLIB
> +	select ARCH_HAS_CPUFREQ
> +	select CLKSRC_MMIO
> +	select GENERIC_CLOCKEVENTS
> +	select GENERIC_IRQ_CHIP
> +	select ARCH_HAS_HOLES_MEMORYMODEL
> +	select SPARSE_IRQ
> +	help
> +	  Support for Sigma Designs Tango platform.
> +
>  endchoice

Move this to the platform Kconfig file. Also, drop all the
'select' statements that are implied by ARCH_MULTIPLATFORM
and ARCH_MULTI_V7

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 246473a244f6..0ac4ed7c267e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1,5 +1,6 @@
>  ifeq ($(CONFIG_OF),y)
>  
> +dtb-$(CONFIG_ARCH_TANGOX) += tango.dtb
>  dtb-$(CONFIG_ARCH_ALPINE) += \
>  	alpine-db.dtb

Keep this sorted alphabetically.

> diff --git a/arch/arm/boot/dts/tango.dts b/arch/arm/boot/dts/tango.dts
> new file mode 100644
> index 000000000000..de3bf7ccc760
> --- /dev/null
> +++ b/arch/arm/boot/dts/tango.dts

name this after the actual board you use, put everything that is not
specific to the board into a tango4.dtsi file.

> +	cpublock: cpublock {
> +		compatible = "simple-bus";
> +		reg = <0x60000 0x10000>;

A "simple-bus" does not have a 'reg' property normally. If you
have to program some of the registers, give it a different
compatible string that the driver for this bus can match.

> +		ranges = <0x0 0x60000 0x10000>;
> +		interrupt-parent = <&irqintc>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		intc: intc at e000 {
> +			compatible = "sigma,tango-intc";
> +			reg = <0xe000 0x1000>;
> +			ranges = <0x0 0xe000 0x1000>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			irqintc: irq at 000 {
> +				reg = <0x000 0x100>;
> +				interrupt-parent = <&gic>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <0 2 4>;
> +				label = "IRQ";
> +			};

You can probably drop the label.

> +			fiqintc: fiq at 100 {
> +				reg = <0x100 0x100>;
> +				interrupt-parent = <&gic>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <0 3 4>;
> +				label = "FIQ";
> +			};
> +
> +			iiqintc: iiq at 300 {
> +				reg = <0x300 0x100>;
> +				interrupt-parent = <&gic>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <0 4 4>;
> +				label = "IIQ";
> +			};
> +		};
> +	};
> +
> +};


> diff --git a/arch/arm/mach-tangox/Kconfig b/arch/arm/mach-tangox/Kconfig
> new file mode 100644
> index 000000000000..aba4eef9227c
> --- /dev/null
> +++ b/arch/arm/mach-tangox/Kconfig
> @@ -0,0 +1,48 @@
> +if ARCH_TANGOX
> +
> +config UNCOMPRESS_INCLUDE
> +	string
> +	default "debug/uncompress.h"

Better do this like everyone else.

> +config ARM_L1_CACHE_SHIFT
> +	int
> +	default 5

This conflicts with the other definition of the same symbol.

> +config MACH_TANGOX_87XX
> +	bool "Sigma Designs TANGOX 87XX Board"
> +	default y
> +	depends on ARCH_TANGOX
> +	select MIGHT_HAVE_CACHE_L2X0
> +	select CPU_V7
> +	select ARM_GIC
> +	select VFP
> +	select SMP
> +	select LOCAL_TIMERS if SMP
> +	select HAVE_ARM_TWD if SMP
> +	select HAVE_ARM_SCU if SMP
> +	select PL310_ERRATA_588369
> +	select PL310_ERRATA_727915
> +	select ARM_ERRATA_754322
> +	select ARM_ERRATA_775420
> +	select ARCH_HAS_OPP
> +	select PM_OPP if PM
> +	select USB_ARCH_HAS_EHCI if USB_SUPPORT
> +	select ARM_CPU_SUSPEND if PM
> +	select CPU_USE_DOMAINS if MMU
> +	select COMMON_CLK
> +	select TANGOX

Most of these are already implied by teh generic options.

> +void __init tangox_timer_init(void)
> +{
> +	int err;
> +
> +	clkgen_base = ioremap(CLKGEN_BASE, 0x100);

Remove all hardcoded physical memory addresses.

> +	if (clkgen_base == NULL) return;
> +
> +	register_current_timer_delay(&delay_timer);
> +	sched_clock_register(read_sched_clock, 32, XTAL_FREQ);
> +
> +	err = clocksource_register_hz(&tangox_xtal, XTAL_FREQ);
> +	if (err) pi_alert("Failed to register tangox_xtal clocksource!\n");
> +
> +	tangox_clock_tree_register();
> +
> +	of_clk_init(NULL);
> +	clocksource_of_init();
> +}

CLK_OF_DECLARE() for the clk

CLOCKSOURCE_OF_DECLARE() for the clocksource/clockevent

Make these two drivers.

> +static struct map_desc tango_map_desc[] __initdata = {
> +	{
> +		.virtual	= TANGO_IO_START,
> +		.pfn		=__phys_to_pfn(0),
> +		.length		= TANGO_IO_SIZE,
> +		.type 		= MT_DEVICE,
> +	},
> +};
> +
> +static void __init tango_map_io(void)
> +{
> +	iotable_init(tango_map_desc, ARRAY_SIZE(tango_map_desc));
> +}

What is this for? Most platforms don't need this.

> +extern void __init tangox_timer_init(void);
> +//extern struct smp_operations tangox_smp_ops;

Never put 'extern' declarations into a .c file.

> +static const char *tango_dt_compat[] = { "sigma,tango4-soc", NULL };
> +
> +MACHINE_START(TANGOX_87XX, "TANGOX_87XX")
> +	.atag_offset	= 0x100,
> +	.init_time	= tangox_timer_init,
> +	.map_io		= tango_map_io,
> +	//.smp		= &tangox_smp_ops,
> +	//.restart	= tango_restart, /*** REQUIRED FOR CLEAN REBOOT ***/
> +	.dt_compat	= tango_dt_compat,
> +MACHINE_END

All except the dt_compat can be removed here.

	Arnd
