From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Sep 2013 22:45:25 +0200
Subject: [PATCH v2] ARM: new platform for Energy Micro's EFM32 Cortex-M3
 SoCs
In-Reply-To: <1379447884-14025-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1379447884-14025-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <201309172245.25367.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 September 2013, Uwe Kleine-K?nig wrote:
>  arch/arm/Kconfig                               |  16 +++-
>  arch/arm/Kconfig.debug                         |  16 ++++
>  arch/arm/Makefile                              |   1 +
>  arch/arm/configs/efm32_defconfig               | 104 +++++++++++++++++++++++++
>  arch/arm/mach-efm32/Makefile                   |   1 +
>  arch/arm/mach-efm32/Makefile.boot              |   2 +
>  arch/arm/mach-efm32/cmu.h                      |  15 ++++
>  arch/arm/mach-efm32/common.c                   |  19 +++++
>  arch/arm/mach-efm32/common.h                   |   1 +
>  arch/arm/mach-efm32/dtmachine.c                |  31 ++++++++
>  arch/arm/mach-efm32/include/mach/debug-macro.S |  48 ++++++++++++
>  arch/arm/mach-efm32/include/mach/entry-macro.S |   5 ++
>  arch/arm/mach-efm32/include/mach/io.h          |   6 ++
>  arch/arm/mach-efm32/include/mach/irqs.h        |   6 ++
>  arch/arm/mach-efm32/include/mach/timex.h       |   7 ++

You should be able to add NOMMU platforms in combination with CONFIG_MULTIPLATFORM
now, which gets rid of most of these files.


> diff --git a/arch/arm/mach-efm32/Makefile b/arch/arm/mach-efm32/Makefile
> new file mode 100644
> index 0000000..081f45a
> --- /dev/null
> +++ b/arch/arm/mach-efm32/Makefile
> @@ -0,0 +1 @@
> +obj-y += common.o dtmachine.o

Just merge the two files into one.

> +
> +void __init efm32_init_time(void)
> +{
> +	of_clk_init(NULL);
> +	clocksource_of_init();
> +}

When Sebastian Hesselbarth's patches for of_clk_init() are merged, this function can go away.
> +static void __init efm32_init(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}
> +

And this one is already unnecessary.

> +static const char *const efm32gg_compat[] __initconst = {
> +	"efm32,dk3750",
> +	NULL
> +};
> +
> +DT_MACHINE_START(EFM32DT, "EFM32 (Device Tree Support)")
> +	.init_irq = irqchip_init,

Same for irqchip_init, which is the default when omitted.

> diff --git a/arch/arm/mach-efm32/include/mach/debug-macro.S b/arch/arm/mach-efm32/include/mach/debug-macro.S
> new file mode 100644
> index 0000000..c58915c
> --- /dev/null
> +++ b/arch/arm/mach-efm32/include/mach/debug-macro.S

Please move this to arch/arm/include/debug/ like the other such implementations.

> diff --git a/arch/arm/mach-efm32/include/mach/entry-macro.S b/arch/arm/mach-efm32/include/mach/entry-macro.S
> new file mode 100644
> index 0000000..f0c0f7d
> --- /dev/null
> +++ b/arch/arm/mach-efm32/include/mach/entry-macro.S
> @@ -0,0 +1,5 @@
> +		.macro	get_irqnr_preamble, base, tmp
> +		.endm
> +
> +		.macro	arch_ret_to_user, tmp1, tmp2
> +		.endm

And use set_handle_irq() to register a handler from your irqchip driver
to get rid of this one.

> --- /dev/null
> +++ b/arch/arm/mach-efm32/include/mach/irqs.h
> @@ -0,0 +1,6 @@
> +#ifndef __MACH_IRQS_H__
> +#define __MACH_IRQS_H__
> +
> +#define NR_IRQS			82
> +
> +#endif /* __MACH_IRQS_H__ */

This should not be needed if you have the proper IRQ domain support, which I think you do.

	Arnd
