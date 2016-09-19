From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 Sep 2016 09:11:08 +0100
Subject: [PATCH soc/next] ARM: BCM53573: Add custom init_time with arch
 timer workaroud
In-Reply-To: <20160918193238.21339-1-zajec5@gmail.com>
References: <20160918193238.21339-1-zajec5@gmail.com>
Message-ID: <57DF9D9C.9020206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rafa?,

On 18/09/16 20:32, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> BCM53573 uses ARM architected timer but CFE (bootloader) is bugged and
> doesn't setup hardware properly. As the architecture requirement clock
> should be enabled and CNTFRQ should be set before starting Linux.
> 
> Unfortunately it's impossible to have CFE fixed and updated on all
> released devices. There are plenty of them on the market and updating
> bootloader isn't a standard procedure. We also don't have CFE sources
> for BCM53573 devices and no replacement bootloader.
> 
> We can't modify arch timer to simply accept specifying clock. Quoting
> Mark: "The clock-frequency property is at best a dodgy workaround, and
> this is even worse.". Marc also noted that other subsystems may rely on
> CNTFRQ as well.
> 
> The only sane workaround seems to be fixing this CFE bug in BCM53573
> arch code. It doesn't require modifying other drivers and should allow
> all subsystems to work correctly.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  MAINTAINERS                   |  1 +
>  arch/arm/mach-bcm/Makefile    |  3 +++
>  arch/arm/mach-bcm/bcm_53573.c | 62 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+)
>  create mode 100644 arch/arm/mach-bcm/bcm_53573.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a91bca7..0bb0c4b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2568,6 +2568,7 @@ BROADCOM BCM53573 ARM ARCHITECTURE
>  M:	Rafa? Mi?ecki <rafal@milecki.pl>
>  L:	linux-arm-kernel at lists.infradead.org
>  S:	Maintained
> +F:	arch/arm/mach-bcm/bcm_53573.c
>  F:	arch/arm/boot/dts/bcm53573*
>  F:	arch/arm/boot/dts/bcm47189*
>  
> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> index 980f585..0d64778 100644
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -50,6 +50,9 @@ ifeq ($(CONFIG_ARCH_BCM_5301X),y)
>  obj-$(CONFIG_SMP)		+= platsmp.o
>  endif
>  
> +# BCM53573
> +obj-$(CONFIG_ARCH_BCM_53573)	+= bcm_53573.o
> +
>  # BCM63XXx
>  ifeq ($(CONFIG_ARCH_BCM_63XX),y)
>  obj-y				+= bcm63xx.o
> diff --git a/arch/arm/mach-bcm/bcm_53573.c b/arch/arm/mach-bcm/bcm_53573.c
> new file mode 100644
> index 0000000..540a247
> --- /dev/null
> +++ b/arch/arm/mach-bcm/bcm_53573.c
> @@ -0,0 +1,62 @@
> +/*
> + * Copyright (C) 2016 Rafa? Mi?ecki <rafal@milecki.pl>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <asm/mach/arch.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clocksource.h>
> +#include <linux/clk.h>
> +
> +static inline void arch_timer_set_cntfrq(u32 cntfrq)
> +{
> +	asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (cntfrq));
> +}

This is wrong for a number of reasons: This register only writeable from
the secure side. Boot this kernel in non-secure mode, and the kernel
will explode. Also, you're only setting it from the boot CPU, while it
should be set on all of them.

So in effect, this is not any better than advertising the timer
frequency in the device tree.

> +
> +/*
> + * CFE bootloader doesn't meet arch requirements. It doesn't enable ILP clock
> + * which is required for arch timer and doesn't set CNTFRQ.
> + * Fix is up here.
> + */
> +static void __init bcm_53573_setup_arch_timer(void)
> +{
> +	struct of_phandle_args out_args = { };
> +	struct clk *clk;
> +
> +	out_args.np = of_find_compatible_node(NULL, NULL, "brcm,bcm53573-ilp");
> +	if (!out_args.np) {
> +		pr_warn("Failed to find ILP node\n");
> +		return;
> +	}
> +
> +	clk = of_clk_get_from_provider(&out_args);
> +	if (!IS_ERR(clk)) {
> +		if (!clk_prepare_enable(clk))
> +			arch_timer_set_cntfrq(clk_get_rate(clk));
> +	}
> +
> +	of_node_put(out_args.np);
> +}
> +
> +/* A copy of ARM's time_init with workaround inserted */
> +static void __init bcm_53573_init_time(void)
> +{
> +#ifdef CONFIG_COMMON_CLK
> +	of_clk_init(NULL);
> +#endif
> +	bcm_53573_setup_arch_timer();
> +	clocksource_probe();
> +}
> +
> +static const char *const bcm_53573_dt_compat[] __initconst = {
> +	"brcm,bcm53573",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(BCM5301X, "BCM53573")
> +	.init_time	= bcm_53573_init_time,
> +	.dt_compat	= bcm_53573_dt_compat,
> +MACHINE_END
> 

My advise would be to move this to a shim outside of the kernel, which
could configure the clocks and set CNTFRQ on all CPUs. As it stands,
this patch doesn't really improve the situation.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
