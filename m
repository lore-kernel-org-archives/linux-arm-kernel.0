From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 2 Jun 2014 10:44:13 +0800
Subject: [PATCH RFT] ARM: imx6q: Remove static memory mapping for SCU
In-Reply-To: <1401522016-25024-1-git-send-email-shc_work@mail.ru>
References: <1401522016-25024-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140602024412.GM8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 31, 2014 at 11:40:16AM +0400, Alexander Shiyan wrote:
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
> Completely untested.
> ---
>  arch/arm/mach-imx/common.h     |  1 -
>  arch/arm/mach-imx/mach-imx6q.c |  8 +-------
>  arch/arm/mach-imx/platsmp.c    | 30 +++++++-----------------------
>  3 files changed, 8 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index 9586187..7fdbb18 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -96,7 +96,6 @@ u32 imx_get_cpu_arg(int cpu);
>  void imx_set_cpu_arg(int cpu, u32 arg);
>  #ifdef CONFIG_SMP
>  void v7_secondary_startup(void);
> -void imx_scu_map_io(void);
>  void imx_smp_prepare(void);
>  void imx_scu_standby_enable(void);
>  #else
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index e60456d..f3a0170 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -381,12 +381,6 @@ static void __init imx6q_init_late(void)
>  	}
>  }
>  
> -static void __init imx6q_map_io(void)
> -{
> -	debug_ll_io_init();
> -	imx_scu_map_io();
> -}
> -
>  static void __init imx6q_init_irq(void)
>  {
>  	imx_init_revision_from_anatop();
> @@ -404,7 +398,7 @@ static const char *imx6q_dt_compat[] __initconst = {
>  
>  DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad/DualLite (Device Tree)")
>  	.smp		= smp_ops(imx_smp_ops),
> -	.map_io		= imx6q_map_io,
> +	.map_io		= debug_ll_io_init,
>  	.init_irq	= imx6q_init_irq,
>  	.init_machine	= imx6q_init_machine,
>  	.init_late      = imx6q_init_late,
> diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
> index 5b57c17..4d3aba0 100644
> --- a/arch/arm/mach-imx/platsmp.c
> +++ b/arch/arm/mach-imx/platsmp.c
> @@ -11,40 +11,18 @@
>   */
>  
>  #include <linux/init.h>
> +#include <linux/io.h>
>  #include <linux/smp.h>
>  #include <asm/cacheflush.h>
> -#include <asm/page.h>
>  #include <asm/smp_scu.h>
> -#include <asm/mach/map.h>
>  
>  #include "common.h"
> -#include "hardware.h"
>  
>  #define SCU_STANDBY_ENABLE	(1 << 5)
>  
>  u32 g_diag_reg;
>  static void __iomem *scu_base;
>  
> -static struct map_desc scu_io_desc __initdata = {
> -	/* .virtual and .pfn are run-time assigned */
> -	.length		= SZ_4K,
> -	.type		= MT_DEVICE,
> -};
> -
> -void __init imx_scu_map_io(void)
> -{
> -	unsigned long base;
> -
> -	/* Get SCU base */
> -	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
> -
> -	scu_io_desc.virtual = IMX_IO_P2V(base);
> -	scu_io_desc.pfn = __phys_to_pfn(base);
> -	iotable_init(&scu_io_desc, 1);
> -
> -	scu_base = IMX_IO_ADDRESS(base);
> -}
> -
>  void imx_scu_standby_enable(void)
>  {
>  	u32 val = readl_relaxed(scu_base);
> @@ -66,8 +44,14 @@ static int imx_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   */
>  static void __init imx_smp_init_cpus(void)
>  {
> +	unsigned long base;
>  	int i, ncores;
>  
> +	/* Get SCU base */
> +	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
> +
> +	scu_base = ioremap(base, SZ_4K);

No.  I do not think that ioremap() is ready at this point.

Shawn

> +
>  	ncores = scu_get_core_count(scu_base);
>  
>  	for (i = ncores; i < NR_CPUS; i++)
> -- 
> 1.8.5.5
> 
