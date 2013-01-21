From: horms@verge.net.au (Simon Horman)
Date: Mon, 21 Jan 2013 09:54:39 +0900
Subject: [PATCH v2 1/2] ARM: shmobile: sh73a0: Use generic irqchip_init()
In-Reply-To: <1358493373-28722-1-git-send-email-thierry.reding@avionic-design.de>
References: <1358493373-28722-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20130121005439.GF19062@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 08:16:12AM +0100, Thierry Reding wrote:
> The asm/hardware/gic.h header does no longer exist and the corresponding
> functionality was moved to linux/irqchip.h and linux/irqchip/arm-gic.h
> respectively. gic_handle_irq() and of_irq_init() are no longer available
> either and have been replaced by irqchip_init().

asm/hardware/gic.h Seems to still exist in Linus's tree.
Could you let me know which tree of which branch I should depend on
in order to apply this change?

> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> Changes in v2:
> - split off kzm9g board changes into a separate patch
> 
>  arch/arm/mach-shmobile/intc-sh73a0.c  | 9 ++-------
>  arch/arm/mach-shmobile/setup-sh73a0.c | 2 --
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
> index fc7c8da..91faba6 100644
> --- a/arch/arm/mach-shmobile/intc-sh73a0.c
> +++ b/arch/arm/mach-shmobile/intc-sh73a0.c
> @@ -21,9 +21,9 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/irq.h>
> -#include <linux/of_irq.h>
>  #include <linux/io.h>
>  #include <linux/sh_intc.h>
> +#include <linux/irqchip.h>
>  #include <linux/irqchip/arm-gic.h>
>  #include <mach/intc.h>
>  #include <mach/irqs.h>
> @@ -462,14 +462,9 @@ void __init sh73a0_init_irq(void)
>  }
>  
>  #ifdef CONFIG_OF
> -static const struct of_device_id irq_of_match[] __initconst = {
> -	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
> -	{ },
> -};
> -
>  void __init sh73a0_init_irq_dt(void)
>  {
> -	of_irq_init(irq_of_match);
> +	irqchip_init();
>  	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
>  }
>  #endif
> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
> index abf1eb0..2ecd668 100644
> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> @@ -36,7 +36,6 @@
>  #include <mach/irqs.h>
>  #include <mach/sh73a0.h>
>  #include <mach/common.h>
> -#include <asm/hardware/gic.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/arch.h>
> @@ -892,7 +891,6 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
>  	.init_early	= sh73a0_add_early_devices_dt,
>  	.nr_irqs	= NR_IRQS_LEGACY,
>  	.init_irq	= sh73a0_init_irq_dt,
> -	.handle_irq	= gic_handle_irq,
>  	.init_machine	= sh73a0_add_standard_devices_dt,
>  	.init_time	= shmobile_timer_init,
>  	.dt_compat	= sh73a0_boards_compat_dt,
> -- 
> 1.8.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
