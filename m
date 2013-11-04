From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 4 Nov 2013 10:48:10 +0100
Subject: [PATCH] ARM: imx: drop support for irq priorisation
In-Reply-To: <20131104084129.GS24559@pengutronix.de>
References: <1383553022-6983-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131104084129.GS24559@pengutronix.de>
Message-ID: <20131104094810.GH14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

I didn't add you to the list of recipents for this patch after
consulting the MAINTAINERS file. Sascha now told me that it's probably
you who takes this patch?! I suggest to fix MAINTAINERS accordingly.
Maybe just merge the entries "ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
and "ARM/FREESCALE IMX6"?

Best regards
Uwe

On Mon, Nov 04, 2013 at 09:41:29AM +0100, Sascha Hauer wrote:
> On Mon, Nov 04, 2013 at 09:17:02AM +0100, Uwe Kleine-K?nig wrote:
> > The code for irq priorisation support doesn't have any in-tree users and
> > the Kconfig description does wrong promises because nowadays irq
> > handlers are called with irqs disabled, so no high prioritized irq can
> > interrupt a lower prioritized handler.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Sascha
> 
> > ---
> >  arch/arm/mach-imx/Kconfig      | 10 ----------
> >  arch/arm/mach-imx/avic.c       | 25 -------------------------
> >  arch/arm/mach-imx/irq-common.h |  1 -
> >  3 files changed, 36 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index 15c9ae3..9431729 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -20,16 +20,6 @@ config ARCH_MXC
> >  menu "Freescale i.MX support"
> >  	depends on ARCH_MXC
> >  
> > -config MXC_IRQ_PRIOR
> > -	bool "Use IRQ priority"
> > -	help
> > -	  Select this if you want to use prioritized IRQ handling.
> > -	  This feature prevents higher priority ISR to be interrupted
> > -	  by lower priority IRQ.
> > -	  This may be useful in embedded applications, where are strong
> > -	  requirements for timing.
> > -	  Say N here, unless you have a specialized requirement.
> > -
> >  config MXC_TZIC
> >  	bool
> >  
> > diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
> > index e163ec7..8d1df2e 100644
> > --- a/arch/arm/mach-imx/avic.c
> > +++ b/arch/arm/mach-imx/avic.c
> > @@ -54,28 +54,6 @@
> >  static void __iomem *avic_base;
> >  static struct irq_domain *domain;
> >  
> > -#ifdef CONFIG_MXC_IRQ_PRIOR
> > -static int avic_irq_set_priority(unsigned char irq, unsigned char prio)
> > -{
> > -	struct irq_data *d = irq_get_irq_data(irq);
> > -	unsigned int temp;
> > -	unsigned int mask = 0x0F << irq % 8 * 4;
> > -
> > -	irq = d->hwirq;
> > -
> > -	if (irq >= AVIC_NUM_IRQS)
> > -		return -EINVAL;
> > -
> > -	temp = __raw_readl(avic_base + AVIC_NIPRIORITY(irq / 8));
> > -	temp &= ~mask;
> > -	temp |= prio & mask;
> > -
> > -	__raw_writel(temp, avic_base + AVIC_NIPRIORITY(irq / 8));
> > -
> > -	return 0;
> > -}
> > -#endif
> > -
> >  #ifdef CONFIG_FIQ
> >  static int avic_set_irq_fiq(unsigned int irq, unsigned int type)
> >  {
> > @@ -102,9 +80,6 @@ static int avic_set_irq_fiq(unsigned int irq, unsigned int type)
> >  
> >  
> >  static struct mxc_extra_irq avic_extra_irq = {
> > -#ifdef CONFIG_MXC_IRQ_PRIOR
> > -	.set_priority = avic_irq_set_priority,
> > -#endif
> >  #ifdef CONFIG_FIQ
> >  	.set_irq_fiq = avic_set_irq_fiq,
> >  #endif
> > diff --git a/arch/arm/mach-imx/irq-common.h b/arch/arm/mach-imx/irq-common.h
> > index 5b2dabb..6e3175d 100644
> > --- a/arch/arm/mach-imx/irq-common.h
> > +++ b/arch/arm/mach-imx/irq-common.h
> > @@ -24,7 +24,6 @@
> >  
> >  struct mxc_extra_irq
> >  {
> > -	int (*set_priority)(unsigned char irq, unsigned char prio);
> >  	int (*set_irq_fiq)(unsigned int irq, unsigned int type);
> >  };
> >  
> > -- 
> > 1.8.4.rc3
> > 
> > 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
