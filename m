From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sat, 7 Jan 2012 12:47:01 +0100
Subject: [PATCH] irqdomain: Initialize number of IRQs for simple domains
In-Reply-To: <20120107055817.GG4790@S2101-09.ap.freescale.net>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
 <20120107055817.GG4790@S2101-09.ap.freescale.net>
Message-ID: <20120107114701.GA3698@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo wrote:
> On Fri, Jan 06, 2012 at 03:28:25PM +0100, Thierry Reding wrote:
[...]
> > diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> > index c257281..9ed7812 100644
> > --- a/arch/arm/mach-imx/mach-imx6q.c
> > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > @@ -95,9 +95,11 @@ static int __init imx6q_gpio_add_irq_domain(struct device_node *np,
> >  				struct device_node *interrupt_parent)
> >  {
> >  	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
> > +	struct irq_domain *domain;
> >  
> >  	gpio_irq_base -= 32;
> > -	irq_domain_add_simple(np, gpio_irq_base);
> > +	domain = irq_domain_add_simple(np, gpio_irq_base, 32);
> > +	WARN_ON(IS_ERR(domain));
> 
> Why do we handle the error in a different pattern that is used for
> all above?

Because I wasn't paying attention =) It should be returning an error of
course. With the changes that Grant requested, domain will be NULL on error
and I guess returning -ENOMEM would be fine here (and in the above hunks).

It is of course different behaviour because the code would previously
continue execution and ignore the error, but I guess that's okay since
without the IRQ domain being registered the board will not work properly
anyway.

> I just made a small change on top of yours.  Can you please consider
> to amend it to your patch if it looks sane to you?
> 
> diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
> index 2fda5aa..70376e0 100644
> --- a/arch/arm/plat-mxc/include/mach/irqs.h
> +++ b/arch/arm/plat-mxc/include/mach/irqs.h
> @@ -13,19 +13,20 @@
> 
>  #include <asm-generic/gpio.h>
> 
> +#define GIC_NUM_IRQS           160
> +#define TZIC_NUM_IRQS          128
> +#define AVIC_NUM_IRQS          64
> +
>  /*
> - * SoCs with GIC interrupt controller have 160 IRQs, those with TZIC
> - * have 128 IRQs, and those with AVIC have 64.
> - *
>   * To support single image, the biggest number should be defined on
>   * top of the list.
>   */
>  #if defined CONFIG_ARM_GIC
> -#define MXC_INTERNAL_IRQS      160
> +#define MXC_INTERNAL_IRQS      GIC_NUM_IRQS
>  #elif defined CONFIG_MXC_TZIC
> -#define MXC_INTERNAL_IRQS      128
> +#define MXC_INTERNAL_IRQS      TZIC_NUM_IRQS
>  #else
> -#define MXC_INTERNAL_IRQS      64
> +#define MXC_INTERNAL_IRQS      AVIC_NUM_IRQS
>  #endif
> 
>  #define MXC_GPIO_IRQ_START     MXC_INTERNAL_IRQS
> @@ -54,7 +55,6 @@
>  /* REVISIT: Add IPU irqs on IMX51 */
> 
>  #define NR_IRQS                        (MXC_IPU_IRQ_START + MX3_IPU_IRQS)
> -#define TZIC_NUM_IRQS          128
> 
>  extern int imx_irq_set_priority(unsigned char irq, unsigned char prio);
> 

Looks good. I'll add it to the patch along with the other requested changes.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120107/e9cc369f/attachment-0001.sig>
