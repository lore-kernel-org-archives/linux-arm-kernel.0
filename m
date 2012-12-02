From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sun, 2 Dec 2012 14:37:33 +0100
Subject: [PATCH 1/2] ARM: ixp4xx: Moving the timer flags control in
 ixp4xx_irq_ack() procedure
In-Reply-To: <1354435770-2719-1-git-send-email-shc_work@mail.ru>
References: <201212020011.42105.arnd@arndb.de>
 <1354435770-2719-1-git-send-email-shc_work@mail.ru>
Message-ID: <20667.22941.433988.716964@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Shiyan writes:
 > Rather than modify the EOI flags directly in the timer interrupt,
 > let's deal with these flags in the ixp4xx_irq_ack() procedure.

Why?

All I see is that you're removing simple unconditional code from two
interrupt handlers and adding a large conditional to ixp4xx_irq_ack,
which will slow down all interrupt acks.

So in what way is this an improvement?

/Mikael

 > 
 > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
 > ---
 >  arch/arm/mach-ixp4xx/common.c      |   35 ++++++++++++++++++++++++++---------
 >  drivers/input/misc/ixp4xx-beeper.c |    3 ---
 >  2 files changed, 26 insertions(+), 12 deletions(-)
 > 
 > diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
 > index 7443e1d..8e2a3b8 100644
 > --- a/arch/arm/mach-ixp4xx/common.c
 > +++ b/arch/arm/mach-ixp4xx/common.c
 > @@ -204,10 +204,28 @@ static void ixp4xx_irq_mask(struct irq_data *d)
 >  
 >  static void ixp4xx_irq_ack(struct irq_data *d)
 >  {
 > -	int line = (d->irq < 32) ? irq2gpio[d->irq] : -1;
 > +	int line;
 >  
 > -	if (line >= 0)
 > -		writel_relaxed(1 << line, IXP4XX_GPIO_GPISR);
 > +	switch (d->irq) {
 > +	case IRQ_IXP4XX_TIMER1:
 > +		writel_relaxed(IXP4XX_OSST_TIMER_1_PEND, IXP4XX_OSST);
 > +		break;
 > +	case IRQ_IXP4XX_TIMER2:
 > +		writel_relaxed(IXP4XX_OSST_TIMER_2_PEND, IXP4XX_OSST);
 > +		break;
 > +	case IRQ_IXP4XX_TIMESTAMP:
 > +		writel_relaxed(IXP4XX_OSST_TIMER_TS_PEND, IXP4XX_OSST);
 > +		break;
 > +	case IRQ_IXP4XX_WDOG:
 > +		writel_relaxed(IXP4XX_OSST_TIMER_WDOG_PEND, IXP4XX_OSST);
 > +		break;
 > +	default:
 > +		line = (d->irq < 32) ? irq2gpio[d->irq] : -1;
 > +
 > +		if (line >= 0)
 > +			writel_relaxed(1 << line, IXP4XX_GPIO_GPISR);
 > +		break;
 > +	}
 >  }
 >  
 >  /*
 > @@ -249,6 +267,11 @@ void __init ixp4xx_init_irq(void)
 >  	/* Disable all interrupt */
 >  	writel_relaxed(0, IXP4XX_ICMR);
 >  
 > +	/* Clear Timer Pending Interrupts */
 > +	writel_relaxed(IXP4XX_OSST_TIMER_1_PEND | IXP4XX_OSST_TIMER_2_PEND |
 > +		       IXP4XX_OSST_TIMER_TS_PEND | IXP4XX_OSST_TIMER_WDOG_PEND,
 > +		       IXP4XX_OSST);
 > +
 >  	if (cpu_is_ixp46x() || cpu_is_ixp43x()) {
 >  		/* Route upper 32 sources to IRQ instead of FIQ */
 >  		writel_relaxed(0, IXP4XX_ICLR2);
 > @@ -276,9 +299,6 @@ static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
 >  {
 >  	struct clock_event_device *evt = dev_id;
 >  
 > -	/* Clear Pending Interrupt by writing '1' to it */
 > -	writel_relaxed(IXP4XX_OSST_TIMER_1_PEND, IXP4XX_OSST);
 > -
 >  	evt->event_handler(evt);
 >  
 >  	return IRQ_HANDLED;
 > @@ -296,9 +316,6 @@ void __init ixp4xx_timer_init(void)
 >  	/* Reset/disable counter */
 >  	writel_relaxed(0, IXP4XX_OSRT1);
 >  
 > -	/* Clear Pending Interrupt by writing '1' to it */
 > -	writel_relaxed(IXP4XX_OSST_TIMER_1_PEND, IXP4XX_OSST);
 > -
 >  	/* Reset time-stamp counter */
 >  	writel_relaxed(0, IXP4XX_OSTS);
 >  
 > diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
 > index eae50fe..6b40950 100644
 > --- a/drivers/input/misc/ixp4xx-beeper.c
 > +++ b/drivers/input/misc/ixp4xx-beeper.c
 > @@ -78,9 +78,6 @@ static int ixp4xx_spkr_event(struct input_dev *dev, unsigned int type, unsigned
 >  
 >  static irqreturn_t ixp4xx_spkr_interrupt(int irq, void *dev_id)
 >  {
 > -	/* clear interrupt */
 > -	writel_relaxed(IXP4XX_OSST_TIMER_2_PEND, IXP4XX_OSST);
 > -
 >  	/* flip the beeper output */
 >  	writel_relaxed(readl_relaxed(IXP4XX_GPIO_GPOUTR) ^ (1 << (unsigned int) dev_id), IXP4XX_GPIO_GPOUTR);
 >  
 > -- 
 > 1.7.8.6
 > 
 > 
 > _______________________________________________
 > linux-arm-kernel mailing list
 > linux-arm-kernel at lists.infradead.org
 > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
 > 
