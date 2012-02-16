From: robherring2@gmail.com (Rob Herring)
Date: Wed, 15 Feb 2012 21:43:01 -0600
Subject: [PATCH v2 2/7] ARM: imx5: adopt generic_chip irq_domain support
 for tzic
In-Reply-To: <1329331668-30325-3-git-send-email-shawn.guo@linaro.org>
References: <1329331668-30325-1-git-send-email-shawn.guo@linaro.org>
 <1329331668-30325-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F3C7B45.1080907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2012 12:47 PM, Shawn Guo wrote:
> It separates the DT initialization for tzic and gpt from non-DT code
> path, so that base address and irq can retrieved from device tree
> rather than static definition.
> 
> With the DT initialization flow corrected as above, the generic_chip
> irq_domain support is adopted for tzic interrupt controller, so that
> the irq_domain initialization for tzic in imx5 DT platform code can be
> removed.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

One comment below, otherwise:

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  arch/arm/boot/dts/imx51.dtsi            |    6 ++++
>  arch/arm/boot/dts/imx53.dtsi            |    6 ++++
>  arch/arm/mach-mx5/clock-mx51-mx53.c     |   47 ++++++++++++++++++++++++++++--
>  arch/arm/mach-mx5/imx51-dt.c            |   22 ++++++++++----
>  arch/arm/mach-mx5/imx53-dt.c            |   22 ++++++++++----
>  arch/arm/mach-mx5/mm.c                  |    6 ++--
>  arch/arm/plat-mxc/include/mach/common.h |    3 +-
>  arch/arm/plat-mxc/tzic.c                |   32 ++++++++++-----------
>  8 files changed, 105 insertions(+), 39 deletions(-)
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
> index 4cb2769..200a3d7 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -16,6 +16,8 @@
>  #include <linux/io.h>
>  #include <linux/clkdev.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  
>  #include <asm/div64.h>
>  
> @@ -1555,10 +1557,16 @@ static void clk_tree_init(void)
>  	__raw_writel(reg, MXC_CCM_CBCDR);
>  }
>  
> +static inline void __iomem *get_gpt_base_dt(struct device_node *np);
> +static inline int get_gpt_irq_dt(struct device_node *np);
> +
>  int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
>  			unsigned long ckih1, unsigned long ckih2)
>  {
>  	int i;
> +	int gpt_irq = MX51_INT_GPT;
> +	void __iomem *gpt_base = MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR);
> +	struct device_node *np = of_find_compatible_node(NULL, NULL, "fsl,gpt");
>  
>  	external_low_reference = ckil;
>  	external_high_reference = ckih1;
> @@ -1592,8 +1600,12 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
>  	clk_set_rate(&esdhc2_clk, 166250000);
>  
>  	/* System timer */
> -	mxc_timer_init(&gpt_clk, MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR),
> -		MX51_INT_GPT);
> +	if (np) {
> +		gpt_base = get_gpt_base_dt(np);
> +		gpt_irq = get_gpt_irq_dt(np);
> +	}
> +	WARN_ON(!gpt_base);
> +	mxc_timer_init(&gpt_clk, gpt_base, gpt_irq);
>  	return 0;
>  }
>  
> @@ -1601,6 +1613,9 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
>  			unsigned long ckih1, unsigned long ckih2)
>  {
>  	int i;
> +	int gpt_irq = MX53_INT_GPT;
> +	void __iomem *gpt_base = MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR);
> +	struct device_node *np = of_find_compatible_node(NULL, NULL, "fsl,gpt");
>  
>  	external_low_reference = ckil;
>  	external_high_reference = ckih1;
> @@ -1629,8 +1644,12 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
>  	clk_set_rate(&esdhc3_mx53_clk, 200000000);
>  
>  	/* System timer */
> -	mxc_timer_init(&gpt_clk, MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR),
> -		MX53_INT_GPT);
> +	if (np) {
> +		gpt_base = get_gpt_base_dt(np);
> +		gpt_irq = get_gpt_irq_dt(np);
> +	}
> +	WARN_ON(!gpt_base);
> +	mxc_timer_init(&gpt_clk, gpt_base, gpt_irq);
>  	return 0;
>  }
>  
> @@ -1672,4 +1691,24 @@ int __init mx53_clocks_init_dt(void)
>  	clk_get_freq_dt(&ckil, &osc, &ckih1, &ckih2);
>  	return mx53_clocks_init(ckil, osc, ckih1, ckih2);
>  }
> +
> +static inline void __iomem *get_gpt_base_dt(struct device_node *np)
> +{
> +	return of_iomap(np, 0);
> +}
> +
> +static inline int get_gpt_irq_dt(struct device_node *np)
> +{
> +	return irq_of_parse_and_map(np, 0);
> +}
> +#else
> +static inline void __iomem *get_gpt_base_dt(struct device_node *np)
> +{
> +	return NULL;
> +}
> +
> +static inline int get_gpt_irq_dt(struct device_node *np)
> +{
> +	return -ENODEV;
> +}

Reorder so you don't need forward declarations.

Once again, I think this is too intermixed with DT and non-DT, but you
are getting the data from DT so I guess it's fine for now.

>  #endif
> diff --git a/arch/arm/mach-mx5/imx51-dt.c b/arch/arm/mach-mx5/imx51-dt.c
> index 1e03ef4..636ef34 100644
> --- a/arch/arm/mach-mx5/imx51-dt.c
> +++ b/arch/arm/mach-mx5/imx51-dt.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <asm/mach/arch.h>
> @@ -44,10 +45,14 @@ static const struct of_dev_auxdata imx51_auxdata_lookup[] __initconst = {
>  	{ /* sentinel */ }
>  };
>  
> -static int __init imx51_tzic_add_irq_domain(struct device_node *np,
> -				struct device_node *interrupt_parent)
> +static int __init imx51_tzic_init_cb(struct device_node *np,
> +				     struct device_node *interrupt_parent)
>  {
> -	irq_domain_add_legacy(np, 128, 0, 0, &irq_domain_simple_ops, NULL);
> +	void __iomem *base = of_iomap(np, 0);
> +
> +	WARN_ON(!base);
> +	tzic_init_irq(base, np);
> +
>  	return 0;
>  }
>  
> @@ -63,7 +68,7 @@ static int __init imx51_gpio_add_irq_domain(struct device_node *np,
>  }
>  
>  static const struct of_device_id imx51_irq_match[] __initconst = {
> -	{ .compatible = "fsl,imx51-tzic", .data = imx51_tzic_add_irq_domain, },
> +	{ .compatible = "fsl,imx51-tzic", .data = imx51_tzic_init_cb, },
>  	{ .compatible = "fsl,imx51-gpio", .data = imx51_gpio_add_irq_domain, },
>  	{ /* sentinel */ }
>  };
> @@ -73,14 +78,17 @@ static const struct of_device_id imx51_iomuxc_of_match[] __initconst = {
>  	{ /* sentinel */ }
>  };
>  
> +static void __init imx51_dt_irq_init(void)
> +{
> +	of_irq_init(imx51_irq_match);
> +}
> +
>  static void __init imx51_dt_init(void)
>  {
>  	struct device_node *node;
>  	const struct of_device_id *of_id;
>  	void (*func)(void);
>  
> -	of_irq_init(imx51_irq_match);
> -
>  	node = of_find_matching_node(NULL, imx51_iomuxc_of_match);
>  	if (node) {
>  		of_id = of_match_node(imx51_iomuxc_of_match, node);
> @@ -110,7 +118,7 @@ static const char *imx51_dt_board_compat[] __initdata = {
>  DT_MACHINE_START(IMX51_DT, "Freescale i.MX51 (Device Tree Support)")
>  	.map_io		= mx51_map_io,
>  	.init_early	= imx51_init_early,
> -	.init_irq	= mx51_init_irq,
> +	.init_irq	= imx51_dt_irq_init,
>  	.handle_irq	= imx51_handle_irq,
>  	.timer		= &imx51_timer,
>  	.init_machine	= imx51_dt_init,
> diff --git a/arch/arm/mach-mx5/imx53-dt.c b/arch/arm/mach-mx5/imx53-dt.c
> index fd5be0f..ce2b700 100644
> --- a/arch/arm/mach-mx5/imx53-dt.c
> +++ b/arch/arm/mach-mx5/imx53-dt.c
> @@ -13,6 +13,7 @@
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <asm/mach/arch.h>
> @@ -48,10 +49,14 @@ static const struct of_dev_auxdata imx53_auxdata_lookup[] __initconst = {
>  	{ /* sentinel */ }
>  };
>  
> -static int __init imx53_tzic_add_irq_domain(struct device_node *np,
> -				struct device_node *interrupt_parent)
> +static int __init imx53_tzic_init_cb(struct device_node *np,
> +				     struct device_node *interrupt_parent)
>  {
> -	irq_domain_add_legacy(np, 128, 0, 0, &irq_domain_simple_ops, NULL);
> +	void __iomem *base = of_iomap(np, 0);
> +
> +	WARN_ON(!base);
> +	tzic_init_irq(base, np);
> +
>  	return 0;
>  }
>  
> @@ -67,7 +72,7 @@ static int __init imx53_gpio_add_irq_domain(struct device_node *np,
>  }
>  
>  static const struct of_device_id imx53_irq_match[] __initconst = {
> -	{ .compatible = "fsl,imx53-tzic", .data = imx53_tzic_add_irq_domain, },
> +	{ .compatible = "fsl,imx53-tzic", .data = imx53_tzic_init_cb, },
>  	{ .compatible = "fsl,imx53-gpio", .data = imx53_gpio_add_irq_domain, },
>  	{ /* sentinel */ }
>  };
> @@ -80,14 +85,17 @@ static const struct of_device_id imx53_iomuxc_of_match[] __initconst = {
>  	{ /* sentinel */ }
>  };
>  
> +static void __init imx53_dt_irq_init(void)
> +{
> +	of_irq_init(imx53_irq_match);
> +}
> +
>  static void __init imx53_dt_init(void)
>  {
>  	struct device_node *node;
>  	const struct of_device_id *of_id;
>  	void (*func)(void);
>  
> -	of_irq_init(imx53_irq_match);
> -
>  	node = of_find_matching_node(NULL, imx53_iomuxc_of_match);
>  	if (node) {
>  		of_id = of_match_node(imx53_iomuxc_of_match, node);
> @@ -120,7 +128,7 @@ static const char *imx53_dt_board_compat[] __initdata = {
>  DT_MACHINE_START(IMX53_DT, "Freescale i.MX53 (Device Tree Support)")
>  	.map_io		= mx53_map_io,
>  	.init_early	= imx53_init_early,
> -	.init_irq	= mx53_init_irq,
> +	.init_irq	= imx53_dt_irq_init,
>  	.handle_irq	= imx53_handle_irq,
>  	.timer		= &imx53_timer,
>  	.init_machine	= imx53_dt_init,
> diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
> index bc17dfe..bed8562 100644
> --- a/arch/arm/mach-mx5/mm.c
> +++ b/arch/arm/mach-mx5/mm.c
> @@ -120,17 +120,17 @@ void __init imx53_init_early(void)
>  
>  void __init mx50_init_irq(void)
>  {
> -	tzic_init_irq(MX50_IO_ADDRESS(MX50_TZIC_BASE_ADDR));
> +	tzic_init_irq(MX50_IO_ADDRESS(MX50_TZIC_BASE_ADDR), NULL);
>  }
>  
>  void __init mx51_init_irq(void)
>  {
> -	tzic_init_irq(MX51_IO_ADDRESS(MX51_TZIC_BASE_ADDR));
> +	tzic_init_irq(MX51_IO_ADDRESS(MX51_TZIC_BASE_ADDR), NULL);
>  }
>  
>  void __init mx53_init_irq(void)
>  {
> -	tzic_init_irq(MX53_IO_ADDRESS(MX53_TZIC_BASE_ADDR));
> +	tzic_init_irq(MX53_IO_ADDRESS(MX53_TZIC_BASE_ADDR), NULL);
>  }
>  
>  static struct sdma_script_start_addrs imx51_sdma_script __initdata = {
> diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
> index 1bf0df8..4291992 100644
> --- a/arch/arm/plat-mxc/include/mach/common.h
> +++ b/arch/arm/plat-mxc/include/mach/common.h
> @@ -11,6 +11,7 @@
>  #ifndef __ASM_ARCH_MXC_COMMON_H__
>  #define __ASM_ARCH_MXC_COMMON_H__
>  
> +struct device_node;
>  struct platform_device;
>  struct clk;
>  enum mxc_cpu_pwr_mode;
> @@ -34,7 +35,7 @@ extern void imx50_init_early(void);
>  extern void imx51_init_early(void);
>  extern void imx53_init_early(void);
>  extern void mxc_init_irq(void __iomem *);
> -extern void tzic_init_irq(void __iomem *);
> +extern void tzic_init_irq(void __iomem *, struct device_node *np);
>  extern void mx1_init_irq(void);
>  extern void mx21_init_irq(void);
>  extern void mx25_init_irq(void);
> diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
> index 98308ec..8288187 100644
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
> @@ -140,7 +135,8 @@ asmlinkage void __exception_irq_entry tzic_handle_irq(struct pt_regs *regs)
>  			while (stat) {
>  				handled = 1;
>  				irqofs = fls(stat) - 1;
> -				handle_IRQ(irqofs + i * 32, regs);
> +				handle_IRQ(irq_find_mapping(tzic_gc->domain,
> +						irqofs + i * 32), regs);
>  				stat &= ~(1 << irqofs);
>  			}
>  		}
> @@ -152,7 +148,7 @@ asmlinkage void __exception_irq_entry tzic_handle_irq(struct pt_regs *regs)
>   * interrupts. It registers the interrupt enable and disable functions
>   * to the kernel for each interrupt source.
>   */
> -void __init tzic_init_irq(void __iomem *irqbase)
> +void __init tzic_init_irq(void __iomem *irqbase, struct device_node *np)
>  {
>  	int i;
>  
> @@ -175,8 +171,10 @@ void __init tzic_init_irq(void __iomem *irqbase)
>  
>  	/* all IRQ no FIQ Warning :: No selection */
>  
> -	for (i = 0; i < TZIC_NUM_IRQS; i += 32)
> -		tzic_init_gc(i);
> +	irq_setup_generic_chip_domain("tzic", np, 1, 0, tzic_base,
> +				      handle_level_irq, TZIC_NUM_IRQS, 0,
> +				      IRQ_NOREQUEST, 0,
> +				      tzic_init_gc, &tzic_extra_irq);
>  
>  #ifdef CONFIG_FIQ
>  	/* Initialize FIQ */
