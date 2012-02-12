From: robherring2@gmail.com (Rob Herring)
Date: Sat, 11 Feb 2012 21:31:29 -0600
Subject: [PATCH 3/8] ARM: imx5: adopt generic_chip irq_domain support
 for tzic
In-Reply-To: <1328980472-11923-4-git-send-email-shawn.guo@linaro.org>
References: <1328980472-11923-1-git-send-email-shawn.guo@linaro.org>
 <1328980472-11923-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F373291.7020407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On 02/11/2012 11:14 AM, Shawn Guo wrote:
> It adopts generic_chip irq_domain support for tzic, so that the
> irq_domain initialization for tzic in imx5 DT platform code can be
> removed.
> 

As I found in my attempt to re-factor this and we discussed, the init
flow is all wrong for mx5.

The mach .init_irq function should call of_irq_init. mx5 is initializing
tzic and then calling of_irq_init in the platform init calls which is
wrong. Ultimately the compatible list should probably include avic,
tzic, gic and any other secondary controllers you have. The of_irq_init
callbacks need to do ioremap and initialize the controller. You're
basically removing the use of of_irq_init here.

Some more comments below.

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx51.dtsi            |    6 +++++
>  arch/arm/boot/dts/imx53.dtsi            |    6 +++++
>  arch/arm/mach-mx5/clock-mx51-mx53.c     |    4 +-
>  arch/arm/mach-mx5/imx51-dt.c            |    8 -------
>  arch/arm/mach-mx5/imx53-dt.c            |    8 -------
>  arch/arm/plat-mxc/include/mach/common.h |    2 +
>  arch/arm/plat-mxc/tzic.c                |   32 ++++++++++++++++--------------
>  7 files changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 6663986..a5fda43 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -171,6 +171,12 @@
>  				status = "disabled";
>  			};
>  
> +			gpt at 73fa0000 {
> +				compatible = "fsl,imx51-gpt", "fsl,gpt";
> +				reg = <0x73fa0000 0x4000>;
> +				interrupts = <39>;
> +			};
> +
>  			uart1: uart at 73fbc000 {
>  				compatible = "fsl,imx51-uart", "fsl,imx21-uart";
>  				reg = <0x73fbc000 0x4000>;
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 5dd91b9..05e6412 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -173,6 +173,12 @@
>  				status = "disabled";
>  			};
>  
> +			gpt at 53fa0000 {
> +				compatible = "fsl,imx53-gpt", "fsl,gpt";
> +				reg = <0x53fa0000 0x4000>;
> +				interrupts = <39>;
> +			};
> +
>  			uart1: uart at 53fbc000 {
>  				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
>  				reg = <0x53fbc000 0x4000>;
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index 4cb2769..c558cb1 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1593,7 +1593,7 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
>  
>  	/* System timer */
>  	mxc_timer_init(&gpt_clk, MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR),
> -		MX51_INT_GPT);
> +		       tzic_irq_create_mapping(MX51_INT_GPT));

In the DT case, you should be calling irq_of_parse_and_map to setup the
timer irq.

I really think you need to separate DT and non-DT init functions. You
need to ultimately be getting both the base address and the irq from the
dts. This applies to both timer and irq controllers. If you make the
init code better separated, then you won't have the problems with legacy
vs. linear domains.

>  	return 0;
>  }
>  
> @@ -1630,7 +1630,7 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
>  
>  	/* System timer */
>  	mxc_timer_init(&gpt_clk, MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR),
> -		MX53_INT_GPT);
> +		       tzic_irq_create_mapping(MX53_INT_GPT));
>  	return 0;
>  }
>  
> diff --git a/arch/arm/mach-mx5/imx51-dt.c b/arch/arm/mach-mx5/imx51-dt.c
> index 1e03ef4..45abf11 100644
> --- a/arch/arm/mach-mx5/imx51-dt.c
> +++ b/arch/arm/mach-mx5/imx51-dt.c
> @@ -44,13 +44,6 @@ static const struct of_dev_auxdata imx51_auxdata_lookup[] __initconst = {
>  	{ /* sentinel */ }
>  };
>  
> -static int __init imx51_tzic_add_irq_domain(struct device_node *np,
> -				struct device_node *interrupt_parent)
> -{
> -	irq_domain_add_legacy(np, 128, 0, 0, &irq_domain_simple_ops, NULL);
> -	return 0;
> -}
> -
>  static int __init imx51_gpio_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
>  {
> @@ -63,7 +56,6 @@ static int __init imx51_gpio_add_irq_domain(struct device_node *np,
>  }
>  
>  static const struct of_device_id imx51_irq_match[] __initconst = {
> -	{ .compatible = "fsl,imx51-tzic", .data = imx51_tzic_add_irq_domain, },
>  	{ .compatible = "fsl,imx51-gpio", .data = imx51_gpio_add_irq_domain, },
>  	{ /* sentinel */ }
>  };
> diff --git a/arch/arm/mach-mx5/imx53-dt.c b/arch/arm/mach-mx5/imx53-dt.c
> index fd5be0f..52efb32 100644
> --- a/arch/arm/mach-mx5/imx53-dt.c
> +++ b/arch/arm/mach-mx5/imx53-dt.c
> @@ -48,13 +48,6 @@ static const struct of_dev_auxdata imx53_auxdata_lookup[] __initconst = {
>  	{ /* sentinel */ }
>  };
>  
> -static int __init imx53_tzic_add_irq_domain(struct device_node *np,
> -				struct device_node *interrupt_parent)
> -{
> -	irq_domain_add_legacy(np, 128, 0, 0, &irq_domain_simple_ops, NULL);
> -	return 0;
> -}
> -
>  static int __init imx53_gpio_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
>  {
> @@ -67,7 +60,6 @@ static int __init imx53_gpio_add_irq_domain(struct device_node *np,
>  }
>  
>  static const struct of_device_id imx53_irq_match[] __initconst = {
> -	{ .compatible = "fsl,imx53-tzic", .data = imx53_tzic_add_irq_domain, },
>  	{ .compatible = "fsl,imx53-gpio", .data = imx53_gpio_add_irq_domain, },
>  	{ /* sentinel */ }
>  };
> diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
> index 1bf0df8..590153c 100644
> --- a/arch/arm/plat-mxc/include/mach/common.h
> +++ b/arch/arm/plat-mxc/include/mach/common.h
> @@ -101,6 +101,8 @@ void tzic_handle_irq(struct pt_regs *);
>  #define imx53_handle_irq tzic_handle_irq
>  #define imx6q_handle_irq gic_handle_irq
>  
> +extern unsigned int tzic_irq_create_mapping(unsigned int hwirq);
> +
>  extern void imx_enable_cpu(int cpu, bool enable);
>  extern void imx_set_cpu_jump(int cpu, void *jump_addr);
>  #ifdef CONFIG_DEBUG_LL
> diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
> index 98308ec..69afe59 100644
> --- a/arch/arm/plat-mxc/tzic.c
> +++ b/arch/arm/plat-mxc/tzic.c
> @@ -15,6 +15,7 @@
>  #include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
> +#include <linux/irqdomain.h>
>  
>  #include <asm/mach/irq.h>
>  #include <asm/exception.h>
> @@ -49,6 +50,7 @@
>  #define TZIC_ID0	0x0FD0	/* Indentification Register 0 */
>  
>  void __iomem *tzic_base; /* Used as irq controller base in entry-macro.S */
> +static struct irq_chip_generic *tzic_gc;
>  
>  #define TZIC_NUM_IRQS 128
>  
> @@ -77,15 +79,14 @@ static int tzic_set_irq_fiq(unsigned int irq, unsigned int type)
>  static void tzic_irq_suspend(struct irq_data *d)
>  {
>  	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> -	int idx = gc->irq_base >> 5;
> +	int idx = d->hwirq / 32;
>  
>  	__raw_writel(gc->wake_active, tzic_base + TZIC_WAKEUP0(idx));
>  }
>  
>  static void tzic_irq_resume(struct irq_data *d)
>  {
> -	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> -	int idx = gc->irq_base >> 5;
> +	int idx = d->hwirq / 32;
>  
>  	__raw_writel(__raw_readl(tzic_base + TZIC_ENSET0(idx)),
>  		     tzic_base + TZIC_WAKEUP0(idx));
> @@ -102,18 +103,14 @@ static struct mxc_extra_irq tzic_extra_irq = {
>  #endif
>  };
>  
> -static __init void tzic_init_gc(unsigned int irq_start)
> +static __init void tzic_init_gc(struct irq_chip_generic *gc)
>  {
> -	struct irq_chip_generic *gc;
> -	struct irq_chip_type *ct;
> -	int idx = irq_start >> 5;
> +	struct irq_chip_type *ct = gc->chip_types;
> +	int idx = gc->hwirq_base / 32;
>  
> -	gc = irq_alloc_generic_chip("tzic", 1, irq_start, tzic_base,
> -				    handle_level_irq);
> -	gc->private = &tzic_extra_irq;
> +	tzic_gc = gc;
>  	gc->wake_enabled = IRQ_MSK(32);
>  
> -	ct = gc->chip_types;
>  	ct->chip.irq_mask = irq_gc_mask_disable_reg;
>  	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
>  	ct->chip.irq_set_wake = irq_gc_set_wake;
> @@ -121,8 +118,6 @@ static __init void tzic_init_gc(unsigned int irq_start)
>  	ct->chip.irq_resume = tzic_irq_resume;
>  	ct->regs.disable = TZIC_ENCLEAR0(idx);
>  	ct->regs.enable = TZIC_ENSET0(idx);
> -
> -	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, IRQ_NOREQUEST, 0);
>  }
>  
>  asmlinkage void __exception_irq_entry tzic_handle_irq(struct pt_regs *regs)
> @@ -175,8 +170,10 @@ void __init tzic_init_irq(void __iomem *irqbase)
>  
>  	/* all IRQ no FIQ Warning :: No selection */
>  
> -	for (i = 0; i < TZIC_NUM_IRQS; i += 32)
> -		tzic_init_gc(i);
> +	irq_setup_generic_chip_domain("tzic",
> +			of_find_compatible_node(NULL, NULL, "fsl,tzic"),

You should already have a node pointer at this point. Pass it into this
function and get it from the of_irq_init callback.

Rob

> +			1, 0, tzic_base, handle_level_irq, TZIC_NUM_IRQS,
> +			0, IRQ_NOREQUEST, 0, tzic_init_gc, &tzic_extra_irq);
>  
>  #ifdef CONFIG_FIQ
>  	/* Initialize FIQ */
> @@ -205,3 +202,8 @@ int tzic_enable_wake(void)
>  
>  	return 0;
>  }
> +
> +unsigned int tzic_irq_create_mapping(unsigned int hwirq)
> +{
> +	return irq_create_mapping(tzic_gc->domain, hwirq);
> +}
