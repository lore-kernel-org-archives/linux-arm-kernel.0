From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 7 Jan 2012 13:58:20 +0800
Subject: [PATCH] irqdomain: Initialize number of IRQs for simple domains
In-Reply-To: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120107055817.GG4790@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Fri, Jan 06, 2012 at 03:28:25PM +0100, Thierry Reding wrote:
> The irq_domain_add() function needs the number of interrupts in the
> domain to properly initialize them. In addition the allocated domain
> is now returned by the irq_domain_{add,generate}_simple() helpers.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
...
>  arch/arm/mach-imx/imx51-dt.c          |   13 +++++++++++--
>  arch/arm/mach-imx/imx53-dt.c          |   13 +++++++++++--
>  arch/arm/mach-imx/mach-imx6q.c        |    4 +++-
...
>  arch/arm/plat-mxc/include/mach/irqs.h |    1 +
>  arch/arm/plat-mxc/tzic.c              |    2 --

Thanks for patching imx.  It looks good to me, except a couple minor
comments below.

...

> diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
> index e6bad17..72bf94c 100644
> --- a/arch/arm/mach-imx/imx51-dt.c
> +++ b/arch/arm/mach-imx/imx51-dt.c
> @@ -47,7 +47,12 @@ static const struct of_dev_auxdata imx51_auxdata_lookup[] __initconst = {
>  static int __init imx51_tzic_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
>  {
> -	irq_domain_add_simple(np, 0);
> +	struct irq_domain *domain;
> +
> +	domain = irq_domain_add_simple(np, 0, TZIC_NUM_IRQS);
> +	if (IS_ERR(domain))
> +		return PTR_ERR(domain);
> +
>  	return 0;
>  }
>  
> @@ -55,9 +60,13 @@ static int __init imx51_gpio_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
>  {
>  	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
> +	struct irq_domain *domain;
>  
>  	gpio_irq_base -= 32;
> -	irq_domain_add_simple(np, gpio_irq_base);
> +
> +	domain = irq_domain_add_simple(np, gpio_irq_base, 32);
> +	if (IS_ERR(domain))
> +		return PTR_ERR(domain);
>  
>  	return 0;
>  }
> diff --git a/arch/arm/mach-imx/imx53-dt.c b/arch/arm/mach-imx/imx53-dt.c
> index 05ebb3e..ccae620 100644
> --- a/arch/arm/mach-imx/imx53-dt.c
> +++ b/arch/arm/mach-imx/imx53-dt.c
> @@ -51,7 +51,12 @@ static const struct of_dev_auxdata imx53_auxdata_lookup[] __initconst = {
>  static int __init imx53_tzic_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
>  {
> -	irq_domain_add_simple(np, 0);
> +	struct irq_domain *domain;
> +
> +	domain = irq_domain_add_simple(np, 0, TZIC_NUM_IRQS);
> +	if (IS_ERR(domain))
> +		return PTR_ERR(domain);
> +
>  	return 0;
>  }
>  
> @@ -59,9 +64,13 @@ static int __init imx53_gpio_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
>  {
>  	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
> +	struct irq_domain *domain;
>  
>  	gpio_irq_base -= 32;
> -	irq_domain_add_simple(np, gpio_irq_base);
> +
> +	domain = irq_domain_add_simple(np, gpio_irq_base, 32);
> +	if (IS_ERR(domain))
> +		return PTR_ERR(domain);
>  
>  	return 0;
>  }
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index c257281..9ed7812 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -95,9 +95,11 @@ static int __init imx6q_gpio_add_irq_domain(struct device_node *np,
>  				struct device_node *interrupt_parent)
>  {
>  	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
> +	struct irq_domain *domain;
>  
>  	gpio_irq_base -= 32;
> -	irq_domain_add_simple(np, gpio_irq_base);
> +	domain = irq_domain_add_simple(np, gpio_irq_base, 32);
> +	WARN_ON(IS_ERR(domain));

Why do we handle the error in a different pattern that is used for
all above?

>  
>  	return 0;
>  }

...

> diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
> index fd9efb0..2fda5aa 100644
> --- a/arch/arm/plat-mxc/include/mach/irqs.h
> +++ b/arch/arm/plat-mxc/include/mach/irqs.h
> @@ -54,6 +54,7 @@
>  /* REVISIT: Add IPU irqs on IMX51 */
>  
>  #define NR_IRQS			(MXC_IPU_IRQ_START + MX3_IPU_IRQS)
> +#define TZIC_NUM_IRQS		128
>  
>  extern int imx_irq_set_priority(unsigned char irq, unsigned char prio);
>  
I just made a small change on top of yours.  Can you please consider
to amend it to your patch if it looks sane to you?

diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index 2fda5aa..70376e0 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -13,19 +13,20 @@

 #include <asm-generic/gpio.h>

+#define GIC_NUM_IRQS           160
+#define TZIC_NUM_IRQS          128
+#define AVIC_NUM_IRQS          64
+
 /*
- * SoCs with GIC interrupt controller have 160 IRQs, those with TZIC
- * have 128 IRQs, and those with AVIC have 64.
- *
  * To support single image, the biggest number should be defined on
  * top of the list.
  */
 #if defined CONFIG_ARM_GIC
-#define MXC_INTERNAL_IRQS      160
+#define MXC_INTERNAL_IRQS      GIC_NUM_IRQS
 #elif defined CONFIG_MXC_TZIC
-#define MXC_INTERNAL_IRQS      128
+#define MXC_INTERNAL_IRQS      TZIC_NUM_IRQS
 #else
-#define MXC_INTERNAL_IRQS      64
+#define MXC_INTERNAL_IRQS      AVIC_NUM_IRQS
 #endif

 #define MXC_GPIO_IRQ_START     MXC_INTERNAL_IRQS
@@ -54,7 +55,6 @@
 /* REVISIT: Add IPU irqs on IMX51 */

 #define NR_IRQS                        (MXC_IPU_IRQ_START + MX3_IPU_IRQS)
-#define TZIC_NUM_IRQS          128

 extern int imx_irq_set_priority(unsigned char irq, unsigned char prio);

-- 
Regards,
Shawn
