From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 May 2013 12:29:28 +0200
Subject: [PATCH v3 2/4] ARM: imx: add initial support for MVF600
In-Reply-To: <1368684648-20826-3-git-send-email-b35083@freescale.com>
References: <1368684648-20826-1-git-send-email-b35083@freescale.com>
 <1368684648-20826-3-git-send-email-b35083@freescale.com>
Message-ID: <5396520.ZTuSn9S4Vd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 May 2013 14:10:46 Jingchang Lu wrote:

> index a402248..b9c01a1 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -835,6 +835,21 @@ config SOC_IMX6SL
>  	help
>  	  This enables support for Freescale i.MX6 SoloLite processor.
>  
> +config SOC_MVF600
> +	bool "Vybrid Family MVF600 support"
> +	select CPU_V7
> +	select ARM_GIC
> +	select CLKSRC_OF
> +	select PINCTRL
> +	select PINCTRL_MVF600
> +	select MVF600_PIT_TIMER
> +	select PL310_ERRATA_588369 if CACHE_PL310
> +	select PL310_ERRATA_727915 if CACHE_PL310
> +	select PL310_ERRATA_769419 if CACHE_PL310
> +
> +	help
> +	  This enable support for Freescale Vybrid MVF600 processor.
> +
>  endif

Shouldn't that 'depends on ARCH_MULTI_V7'?

Can you describe how much Vybrid is actually like MXC? Do you actually
use most of the mach-imx code?

> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index 208e76f..55cdba0 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -70,6 +70,7 @@ extern int mx51_clocks_init_dt(void);
>  extern int mx53_clocks_init_dt(void);
>  extern int mx6q_clocks_init(void);
>  extern int imx6sl_clocks_init(void);
> +extern int mvf600_clocks_init(void);
>  extern struct platform_device *mxc_register_gpio(char *name, int id,
>  	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
>  extern void mxc_set_cpu_type(unsigned int type);

This hunk belongs into the first patch, right?

Actually I think you should move that driver to drivers/clk and use
of_clk_init(NULL) to initialize it.

> +static void __init mvf600_init_machine(void)
> +{
> +	mxc_arch_reset_init_dt();

I don't see the mxc_arch_reset_init_dt function in 3.10-rc1. Where does it
get introduced?

It would be nice if we could integrate that into the watchdog driver,
so that driver just registers a pm_restart function when it gets loaded.
It is a rather small driver, so it would not hurt to always load it.

> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}

It would be nicer if you could just use the default init_machine.

> +static void __init mvf600_init_irq(void)
> +{
> +	struct device_node *np;
> +	void __iomem *mscm_base;
> +	int i;
> +
> +	l2x0_of_init(0, ~0UL);
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,mvf600-mscm");
> +	mscm_base = of_iomap(np, 0);
> +	if (!mscm_base)
> +		return;
> +
> +	/* route all shared peripheral interrupts to CP0 */
> +	for (i = 0; i < 111; i++)
> +		__raw_writew(1, mscm_base + 0x880 + 2 * i);
> +
> +	iounmap(mscm_base);
> +
> +	irqchip_init();
> +}

What is the mscm? Shouldn't the boot loader have set this up correctly?
If you can remove that code from the kernel, you can use the default
irqchip_init call.

> +static void __init mvf600_init_time(void)
> +{
> +	mvf600_clocks_init();
> +	clocksource_of_init();
> +}

I would like to call of_clk_init(NULL) unconditionally on all machines
in 3.11, so this function could also go away.

> +static const char *mvf600_dt_compat[] __initdata = {
> +	"fsl,mvf600",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(VYBRID_VF6XX, "Freescale Vybrid MVF600 (Device Tree)")
> +	.init_irq	= mvf600_init_irq,
> +	.init_time	= mvf600_init_time,
> +	.init_machine   = mvf600_init_machine,
> +	.dt_compat	= mvf600_dt_compat,
> +	.restart	= mxc_restart,
> +MACHINE_END

If we can do all of the above, we can actually remove the entire machine
descriptor here, since all its members are NULL.

	Arnd
