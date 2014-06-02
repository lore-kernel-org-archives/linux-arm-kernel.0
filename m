From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 2 Jun 2014 10:21:21 +0800
Subject: [PATCH 1/3] ARM: i.MX: avic: Use irqchip_init() for IRQ
 initialization in DT case
In-Reply-To: <1401516095-31020-1-git-send-email-shc_work@mail.ru>
References: <1401516095-31020-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140602022120.GL8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 31, 2014 at 10:01:30AM +0400, Alexander Shiyan wrote:
> Use generic irqchip_init() DT call to initialize IRQs, so after this patch,
> the mxc-avic driver is quite prepared to move to drivers/irqchip.

What's the whole plan of the moving?  IOW, what's left after this patch
and what's the plan for those?

> As a temporary solution to do it, we use OF_DECLARE_2()

I do not see OF_DECLARE_2() is defined anywhere?

> instead of IRQCHIP_DECLARE().
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

The patch number in the subject is confusing.  There are 6 patches in
the series rather than 3.

Shawn

> ---
>  arch/arm/mach-imx/avic.c     | 29 ++++++++++++++++++++++-------
>  arch/arm/mach-imx/imx25-dt.c |  1 -
>  arch/arm/mach-imx/imx27-dt.c |  1 -
>  arch/arm/mach-imx/imx31-dt.c |  1 -
>  arch/arm/mach-imx/imx35-dt.c |  3 ++-
>  5 files changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
> index 24b103c..9adcad2 100644
> --- a/arch/arm/mach-imx/avic.c
> +++ b/arch/arm/mach-imx/avic.c
> @@ -22,6 +22,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <asm/mach/irq.h>
>  #include <asm/exception.h>
>  
> @@ -153,13 +154,10 @@ static void __exception_irq_entry avic_handle_irq(struct pt_regs *regs)
>   * interrupts. It registers the interrupt enable and disable functions
>   * to the kernel for each interrupt source.
>   */
> -void __init mxc_init_irq(void __iomem *irqbase)
> +static void __init _avic_init_irq(struct device_node *np)
>  {
> -	struct device_node *np;
>  	int irq_base;
> -	int i;
> -
> -	avic_base = irqbase;
> +	unsigned i;
>  
>  	/* put the AVIC into the reset value with
>  	 * all interrupts disabled
> @@ -178,7 +176,6 @@ void __init mxc_init_irq(void __iomem *irqbase)
>  	irq_base = irq_alloc_descs(-1, 0, AVIC_NUM_IRQS, numa_node_id());
>  	WARN_ON(irq_base < 0);
>  
> -	np = of_find_compatible_node(NULL, NULL, "fsl,avic");
>  	domain = irq_domain_add_legacy(np, AVIC_NUM_IRQS, irq_base, 0,
>  				       &irq_domain_simple_ops, NULL);
>  	WARN_ON(!domain);
> @@ -196,6 +193,24 @@ void __init mxc_init_irq(void __iomem *irqbase)
>  	/* Initialize FIQ */
>  	init_FIQ(FIQ_START);
>  #endif
> +}
> +
> +void __init mxc_init_irq(void __iomem *irqbase)
> +{
> +	avic_base = irqbase;
> +
> +	_avic_init_irq(NULL);
> +}
>  
> -	printk(KERN_INFO "MXC IRQ initialized\n");
> +static int __init avic_init_irq_dt(struct device_node *np,
> +				   struct device_node *parent)
> +{
> +	avic_base = of_iomap(np, 0);
> +	if (!avic_base)
> +		return -ENOMEM;
> +
> +	_avic_init_irq(np);
> +
> +	return 0;
>  }
> +OF_DECLARE_2(irqchip, mxc_avic, "fsl,avic", avic_init_irq_dt);
> diff --git a/arch/arm/mach-imx/imx25-dt.c b/arch/arm/mach-imx/imx25-dt.c
> index 42a65e0..2f97743 100644
> --- a/arch/arm/mach-imx/imx25-dt.c
> +++ b/arch/arm/mach-imx/imx25-dt.c
> @@ -37,7 +37,6 @@ static void __init imx25_timer_init(void)
>  DT_MACHINE_START(IMX25_DT, "Freescale i.MX25 (Device Tree Support)")
>  	.map_io		= mx25_map_io,
>  	.init_early	= imx25_init_early,
> -	.init_irq	= mx25_init_irq,
>  	.init_time	= imx25_timer_init,
>  	.init_machine	= imx25_dt_init,
>  	.dt_compat	= imx25_dt_board_compat,
> diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
> index 17bd405..09c577c 100644
> --- a/arch/arm/mach-imx/imx27-dt.c
> +++ b/arch/arm/mach-imx/imx27-dt.c
> @@ -42,7 +42,6 @@ static void __init imx27_timer_init(void)
>  DT_MACHINE_START(IMX27_DT, "Freescale i.MX27 (Device Tree Support)")
>  	.map_io		= mx27_map_io,
>  	.init_early	= imx27_init_early,
> -	.init_irq	= mx27_init_irq,
>  	.init_time	= imx27_timer_init,
>  	.init_machine	= imx27_dt_init,
>  	.dt_compat	= imx27_dt_board_compat,
> diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
> index 581f4d6..6e7a4c2 100644
> --- a/arch/arm/mach-imx/imx31-dt.c
> +++ b/arch/arm/mach-imx/imx31-dt.c
> @@ -38,7 +38,6 @@ static void __init imx31_dt_timer_init(void)
>  DT_MACHINE_START(IMX31_DT, "Freescale i.MX31 (Device Tree Support)")
>  	.map_io		= mx31_map_io,
>  	.init_early	= imx31_init_early,
> -	.init_irq	= mx31_init_irq,
>  	.init_time	= imx31_dt_timer_init,
>  	.init_machine	= imx31_dt_init,
>  	.dt_compat	= imx31_dt_board_compat,
> diff --git a/arch/arm/mach-imx/imx35-dt.c b/arch/arm/mach-imx/imx35-dt.c
> index a62854c..6b74123 100644
> --- a/arch/arm/mach-imx/imx35-dt.c
> +++ b/arch/arm/mach-imx/imx35-dt.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/irq.h>
> +#include <linux/irqchip.h>
>  #include <linux/irqdomain.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> @@ -31,7 +32,7 @@ static void __init imx35_dt_init(void)
>  static void __init imx35_irq_init(void)
>  {
>  	imx_init_l2cache();
> -	mx35_init_irq();
> +	irqchip_init();
>  }
>  
>  static const char *imx35_dt_board_compat[] __initconst = {
> -- 
> 1.8.5.5
> 
