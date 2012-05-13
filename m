From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 13 May 2012 17:25:57 +0200
Subject: [PATCH] ARM: S3C24XX: add support for second irq set of S3C2416
In-Reply-To: <201204251511.26072.heiko@sntech.de>
References: <201203032219.45813.heiko@sntech.de>
 <201204022128.10321.heiko@sntech.de> <201204251511.26072.heiko@sntech.de>
Message-ID: <201205131725.58200.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

Am Mittwoch 25 April 2012, 15:11:25 schrieb Heiko St?bner:
> Am Montag, 2. April 2012, 21:28:09 schrieb Heiko St?bner:
> > Am Samstag 03 M?rz 2012, 22:19:45 schrieb Heiko St?bner:
> > > The S3C2416 has a separate second interrupt register-set to support
> > > additional irqs. This patch adds the necessary constants and registers
> > > the irq handlers for it.
> > > 
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > 
> > and also "ping" :-)
> 
> and another one :-)

could you take a look at this patch please?

Thanks
Heiko


> 
> > Thanks
> > Heiko
> > 
> > > ---
> > > Patch should go on top of the current s3c24xx consolidation
> > > 
> > >  arch/arm/mach-s3c24xx/include/mach/irqs.h    |   15 ++++-
> > >  arch/arm/mach-s3c24xx/irq-s3c2416.c          |   98
> > > 
> > > ++++++++++++++++++++++++++ arch/arm/mach-s3c24xx/s3c2416.c             
> > > |
> > > 
> > >   1 +
> > >  
> > >  arch/arm/plat-samsung/include/plat/s3c2416.h |    3 +
> > >  4 files changed, 116 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-s3c24xx/include/mach/irqs.h
> > > b/arch/arm/mach-s3c24xx/include/mach/irqs.h index e53b217..e120576
> > > 100644 --- a/arch/arm/mach-s3c24xx/include/mach/irqs.h
> > > +++ b/arch/arm/mach-s3c24xx/include/mach/irqs.h
> > > @@ -134,6 +134,17 @@
> > > 
> > >  #define IRQ_S32416_WDT		S3C2410_IRQSUB(27)
> > >  #define IRQ_S32416_AC97		S3C2410_IRQSUB(28)
> > > 
> > > +/* second interrupt-register of s3c2416/s3c2450 */
> > > +
> > > +#define S3C2416_IRQ(x)		S3C2410_IRQ((x)+54+29)
> > > +#define IRQ_S3C2416_2D		S3C2416_IRQ(0)
> > > +#define IRQ_S3C2416_IIC1	S3C2416_IRQ(1)
> > > +#define IRQ_S3C2416_RESERVED2	S3C2416_IRQ(2)
> > > +#define IRQ_S3C2416_RESERVED3	S3C2416_IRQ(3)
> > > +#define IRQ_S3C2416_PCM0	S3C2416_IRQ(4)
> > > +#define IRQ_S3C2416_PCM1	S3C2416_IRQ(5)
> > > +#define IRQ_S3C2416_I2S0	S3C2416_IRQ(6)
> > > +#define IRQ_S3C2416_I2S1	S3C2416_IRQ(7)
> > > 
> > >  /* extra irqs for s3c2440 */
> > > 
> > > @@ -175,7 +186,9 @@
> > > 
> > >  #define IRQ_S3C2443_WDT		S3C2410_IRQSUB(27)
> > >  #define IRQ_S3C2443_AC97	S3C2410_IRQSUB(28)
> > > 
> > > -#if defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
> > > +#if defined(CONFIG_CPU_S3C2416)
> > > +#define NR_IRQS (IRQ_S3C2416_I2S1+1)
> > > +#elif defined(CONFIG_CPU_S3C2443)
> > > 
> > >  #define NR_IRQS (IRQ_S3C2443_AC97+1)
> > >  #else
> > >  #define NR_IRQS (IRQ_S3C2440_AC97+1)
> > > 
> > > diff --git a/arch/arm/mach-s3c24xx/irq-s3c2416.c
> > > b/arch/arm/mach-s3c24xx/irq-s3c2416.c index fd49f35..d92f879 100644
> > > --- a/arch/arm/mach-s3c24xx/irq-s3c2416.c
> > > +++ b/arch/arm/mach-s3c24xx/irq-s3c2416.c
> > > @@ -27,6 +27,7 @@
> > > 
> > >  #include <linux/ioport.h>
> > >  #include <linux/device.h>
> > >  #include <linux/io.h>
> > > 
> > > +#include <linux/syscore_ops.h>
> > > 
> > >  #include <mach/hardware.h>
> > >  #include <asm/irq.h>
> > > 
> > > @@ -192,6 +193,43 @@ static struct irq_chip s3c2416_irq_uart3 = {
> > > 
> > >  	.irq_ack	= s3c2416_irq_uart3_ack,
> > >  
> > >  };
> > > 
> > > +/* second interrupt register */
> > > +
> > > +static inline void s3c2416_irq_ack_second(struct irq_data *data)
> > > +{
> > > +	unsigned long bitval = 1UL << (data->irq - IRQ_S3C2416_2D);
> > > +
> > > +	__raw_writel(bitval, S3C2416_SRCPND2);
> > > +	__raw_writel(bitval, S3C2416_INTPND2);
> > > +}
> > > +
> > > +static void s3c2416_irq_mask_second(struct irq_data *data)
> > > +{
> > > +	unsigned long bitval = 1UL << (data->irq - IRQ_S3C2416_2D);
> > > +	unsigned long mask;
> > > +
> > > +	mask = __raw_readl(S3C2416_INTMSK2);
> > > +	mask |= bitval;
> > > +	__raw_writel(mask, S3C2416_INTMSK2);
> > > +}
> > > +
> > > +static void s3c2416_irq_unmask_second(struct irq_data *data)
> > > +{
> > > +	unsigned long bitval = 1UL << (data->irq - IRQ_S3C2416_2D);
> > > +	unsigned long mask;
> > > +
> > > +	mask = __raw_readl(S3C2416_INTMSK2);
> > > +	mask &= ~bitval;
> > > +	__raw_writel(mask, S3C2416_INTMSK2);
> > > +}
> > > +
> > > +struct irq_chip s3c2416_irq_second = {
> > > +	.irq_ack	= s3c2416_irq_ack_second,
> > > +	.irq_mask	= s3c2416_irq_mask_second,
> > > +	.irq_unmask	= s3c2416_irq_unmask_second,
> > > +};
> > > +
> > > +
> > > 
> > >  /* IRQ initialisation code */
> > >  
> > >  static int __init s3c2416_add_sub(unsigned int base,
> > > 
> > > @@ -213,6 +251,42 @@ static int __init s3c2416_add_sub(unsigned int
> > > base,
> > > 
> > >  	return 0;
> > >  
> > >  }
> > > 
> > > +static void __init s3c2416_add_second(void)
> > > +{
> > > +	unsigned long pend;
> > > +	unsigned long last;
> > > +	int irqno;
> > > +	int i;
> > > +
> > > +	/* first, clear all interrupts pending... */
> > > +	last = 0;
> > > +	for (i = 0; i < 4; i++) {
> > > +		pend = __raw_readl(S3C2416_INTPND2);
> > > +
> > > +		if (pend == 0 || pend == last)
> > > +			break;
> > > +
> > > +		__raw_writel(pend, S3C2416_SRCPND2);
> > > +		__raw_writel(pend, S3C2416_INTPND2);
> > > +		printk(KERN_INFO "irq: clearing pending status %08x\n",
> > > +		       (int)pend);
> > > +		last = pend;
> > > +	}
> > > +
> > > +	for (irqno = IRQ_S3C2416_2D; irqno <= IRQ_S3C2416_I2S1; irqno++) {
> > > +		switch (irqno) {
> > > +		case IRQ_S3C2416_RESERVED2:
> > > +		case IRQ_S3C2416_RESERVED3:
> > > +			/* no IRQ here */
> > > +			break;
> > > +		default:
> > > +			irq_set_chip_and_handler(irqno, &s3c2416_irq_second,
> > > +						 handle_edge_irq);
> > > +			set_irq_flags(irqno, IRQF_VALID);
> > > +		}
> > > +	}
> > > +}
> > > +
> > > 
> > >  static int __init s3c2416_irq_add(struct device *dev,
> > >  
> > >  				  struct subsys_interface *sif)
> > >  
> > >  {
> > > 
> > > @@ -232,6 +306,8 @@ static int __init s3c2416_irq_add(struct device
> > > *dev,
> > > 
> > >  			&s3c2416_irq_wdtac97,
> > >  			IRQ_S3C2443_WDT, IRQ_S3C2443_AC97);
> > > 
> > > +	s3c2416_add_second();
> > > +
> > > 
> > >  	return 0;
> > >  
> > >  }
> > > 
> > > @@ -248,3 +324,25 @@ static int __init s3c2416_irq_init(void)
> > > 
> > >  arch_initcall(s3c2416_irq_init);
> > > 
> > > +#ifdef CONFIG_PM
> > > +static struct sleep_save irq_save[] = {
> > > +	SAVE_ITEM(S3C2416_INTMSK2),
> > > +};
> > > +
> > > +int s3c2416_irq_suspend(void)
> > > +{
> > > +	s3c_pm_do_save(irq_save, ARRAY_SIZE(irq_save));
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +void s3c2416_irq_resume(void)
> > > +{
> > > +	s3c_pm_do_restore(irq_save, ARRAY_SIZE(irq_save));
> > > +}
> > > +
> > > +struct syscore_ops s3c2416_irq_syscore_ops = {
> > > +	.suspend	= s3c2416_irq_suspend,
> > > +	.resume		= s3c2416_irq_resume,
> > > +};
> > > +#endif
> > > diff --git a/arch/arm/mach-s3c24xx/s3c2416.c
> > > b/arch/arm/mach-s3c24xx/s3c2416.c index 0e9a71c..694977e 100644
> > > --- a/arch/arm/mach-s3c24xx/s3c2416.c
> > > +++ b/arch/arm/mach-s3c24xx/s3c2416.c
> > > @@ -105,6 +105,7 @@ int __init s3c2416_init(void)
> > > 
> > >  	register_syscore_ops(&s3c2416_pm_syscore_ops);
> > >  
> > >  #endif
> > >  
> > >  	register_syscore_ops(&s3c24xx_irq_syscore_ops);
> > > 
> > > +	register_syscore_ops(&s3c2416_irq_syscore_ops);
> > > 
> > >  	return device_register(&s3c2416_dev);
> > >  
> > >  }
> > > 
> > > diff --git a/arch/arm/plat-samsung/include/plat/s3c2416.h
> > > b/arch/arm/plat-samsung/include/plat/s3c2416.h index de2b5bd..7178e33
> > > 100644
> > > --- a/arch/arm/plat-samsung/include/plat/s3c2416.h
> > > +++ b/arch/arm/plat-samsung/include/plat/s3c2416.h
> > > @@ -24,6 +24,9 @@ extern void s3c2416_init_clocks(int xtal);
> > > 
> > >  extern  int s3c2416_baseclk_add(void);
> > >  
> > >  extern void s3c2416_restart(char mode, const char *cmd);
> > > 
> > > +
> > > +extern struct syscore_ops s3c2416_irq_syscore_ops;
> > > +
> > > 
> > >  #else
> > >  #define s3c2416_init_clocks NULL
> > >  #define s3c2416_init_uarts NULL
> 
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-samsung-soc" in the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
