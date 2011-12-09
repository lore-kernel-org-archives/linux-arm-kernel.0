From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 9 Dec 2011 07:16:06 +0100
Subject: [PATCH] ARM: at91: make st soc independent
In-Reply-To: <4EE13E32.7030905@gmail.com>
References: <1323358532-21135-1-git-send-email-plagnioj@jcrosoft.com>
 <4EE13E32.7030905@gmail.com>
Message-ID: <20111209061606.GI23884@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:46 Fri 09 Dec     , Ryan Mallon wrote:
> On 09/12/11 02:35, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > ---
> >  arch/arm/mach-at91/at91rm9200.c              |    4 +-
> >  arch/arm/mach-at91/at91rm9200_time.c         |   37 ++++++++++++++++----------
> >  arch/arm/mach-at91/generic.h                 |    1 +
> >  arch/arm/mach-at91/include/mach/at91_st.h    |   32 +++++++++++++++-------
> >  arch/arm/mach-at91/include/mach/at91rm9200.h |    2 +-
> >  drivers/watchdog/at91rm9200_wdt.c            |    8 +++---
> >  6 files changed, 53 insertions(+), 31 deletions(-)
> 
> Some comments below,
> 
> ~Ryan
> 
> > diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> > index 9163d7d..6b819c0 100644
> > --- a/arch/arm/mach-at91/at91rm9200.c
> > +++ b/arch/arm/mach-at91/at91rm9200.c
> > @@ -294,8 +294,8 @@ static void at91rm9200_reset(void)
> >  	/*
> >  	 * Perform a hardware reset with the use of the Watchdog timer.
> >  	 */
> > -	at91_sys_write(AT91_ST_WDMR, AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
> > -	at91_sys_write(AT91_ST_CR, AT91_ST_WDRST);
> > +	at91_st_write(AT91_ST_WDMR, AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
> > +	at91_st_write(AT91_ST_CR, AT91_ST_WDRST);
> >  }
> >  
> >  /* --------------------------------------------------------------------
> > diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
> > index a028cdf..52d4b45 100644
> > --- a/arch/arm/mach-at91/at91rm9200_time.c
> > +++ b/arch/arm/mach-at91/at91rm9200_time.c
> > @@ -43,9 +43,9 @@ static inline unsigned long read_CRTR(void)
> >  {
> >  	unsigned long x1, x2;
> >  
> > -	x1 = at91_sys_read(AT91_ST_CRTR);
> > +	x1 = at91_st_read(AT91_ST_CRTR);
> >  	do {
> > -		x2 = at91_sys_read(AT91_ST_CRTR);
> > +		x2 = at91_st_read(AT91_ST_CRTR);
> >  		if (x1 == x2)
> >  			break;
> >  		x1 = x2;
> > @@ -58,7 +58,7 @@ static inline unsigned long read_CRTR(void)
> >   */
> >  static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
> >  {
> > -	u32	sr = at91_sys_read(AT91_ST_SR) & irqmask;
> > +	u32	sr = at91_st_read(AT91_ST_SR) & irqmask;
> >  
> >  	/*
> >  	 * irqs should be disabled here, but as the irq is shared they are only
> > @@ -110,22 +110,22 @@ static void
> >  clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
> >  {
> >  	/* Disable and flush pending timer interrupts */
> > -	at91_sys_write(AT91_ST_IDR, AT91_ST_PITS | AT91_ST_ALMS);
> > -	(void) at91_sys_read(AT91_ST_SR);
> > +	at91_st_write(AT91_ST_IDR, AT91_ST_PITS | AT91_ST_ALMS);
> > +	(void) at91_st_read(AT91_ST_SR);
> 
> 
> Drop the void cast or check the return value.
this is not he scope of this patch

the change are by script
> 
> >  
> >  	last_crtr = read_CRTR();
> >  	switch (mode) {
> >  	case CLOCK_EVT_MODE_PERIODIC:
> >  		/* PIT for periodic irqs; fixed rate of 1/HZ */
> >  		irqmask = AT91_ST_PITS;
> > -		at91_sys_write(AT91_ST_PIMR, RM9200_TIMER_LATCH);
> > +		at91_st_write(AT91_ST_PIMR, RM9200_TIMER_LATCH);
> >  		break;
> >  	case CLOCK_EVT_MODE_ONESHOT:
> >  		/* ALM for oneshot irqs, set by next_event()
> >  		 * before 32 seconds have passed
> >  		 */
> >  		irqmask = AT91_ST_ALMS;
> > -		at91_sys_write(AT91_ST_RTAR, last_crtr);
> > +		at91_st_write(AT91_ST_RTAR, last_crtr);
> >  		break;
> >  	case CLOCK_EVT_MODE_SHUTDOWN:
> >  	case CLOCK_EVT_MODE_UNUSED:
> > @@ -133,7 +133,7 @@ clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
> >  		irqmask = 0;
> >  		break;
> >  	}
> > -	at91_sys_write(AT91_ST_IER, irqmask);
> > +	at91_st_write(AT91_ST_IER, irqmask);
> >  }
> >  
> >  static int
> > @@ -156,12 +156,12 @@ clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
> >  	alm = read_CRTR();
> >  
> >  	/* Cancel any pending alarm; flush any pending IRQ */
> > -	at91_sys_write(AT91_ST_RTAR, alm);
> > -	(void) at91_sys_read(AT91_ST_SR);
> > +	at91_st_write(AT91_ST_RTAR, alm);
> > +	(void) at91_st_read(AT91_ST_SR);
> 
> 
> Same here, remove the void cast or check the return value.
ditti
> 
> >  
> >  	/* Schedule alarm by writing RTAR. */
> >  	alm += delta;
> > -	at91_sys_write(AT91_ST_RTAR, alm);
> > +	at91_st_write(AT91_ST_RTAR, alm);
> >  
> >  	return status;
> >  }
> > @@ -175,15 +175,24 @@ static struct clock_event_device clkevt = {
> >  	.set_mode	= clkevt32k_mode,
> >  };
> >  
> > +void __iomem *at91_st_base;
> > +
> > +void __init at91rm9200_ioremap_st(u32 addr)
> > +{
> > +	at91_st_base = ioremap(AT91RM9200_BASE_ST, 256);
> > +	if (!at91_st_base)
> > +		panic("Impossible to ioremap ST\n");
> > +}
> 
> 
> I'm unsure about this. Only at91rm9200 has the ST, so is it worth
> ioremapping it and having a global variable? At the very least could we
> make at91_st_base static and move at91_st_read/write here.
no we need it at different place in the kernel
> 
> > +
> >  /*
> >   * ST (system timer) module supports both clockevents and clocksource.
> >   */
> >  void __init at91rm9200_timer_init(void)
> >  {
> >  	/* Disable all timer interrupts, and clear any pending ones */
> > -	at91_sys_write(AT91_ST_IDR,
> > +	at91_st_write(AT91_ST_IDR,
> >  		AT91_ST_PITS | AT91_ST_WDOVF | AT91_ST_RTTINC | AT91_ST_ALMS);
> > -	(void) at91_sys_read(AT91_ST_SR);
> > +	(void) at91_st_read(AT91_ST_SR);
> 
> 
> Drop the cast.
> 
> >  
> >  	/* Make IRQs happen for the system timer */
> >  	setup_irq(AT91_ID_SYS, &at91rm9200_timer_irq);
> > @@ -192,7 +201,7 @@ void __init at91rm9200_timer_init(void)
> >  	 * directly for the clocksource and all clockevents, after adjusting
> >  	 * its prescaler from the 1 Hz default.
> >  	 */
> > -	at91_sys_write(AT91_ST_RTMR, 1);
> > +	at91_st_write(AT91_ST_RTMR, 1);
> >  
> >  	/* Setup timer clockevent, with minimum of two ticks (important!!) */
> >  	clkevt.mult = div_sc(AT91_SLOW_CLOCK, NSEC_PER_SEC, clkevt.shift);
> > diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
> > index 4030958..445c00d 100644
> > --- a/arch/arm/mach-at91/generic.h
> > +++ b/arch/arm/mach-at91/generic.h
> > @@ -28,6 +28,7 @@ extern void __init at91_aic_init(unsigned int priority[]);
> >  
> >   /* Timer */
> >  struct sys_timer;
> > +extern void at91rm9200_ioremap_st(u32 addr);
> >  extern struct sys_timer at91rm9200_timer;
> >  extern void at91sam926x_ioremap_pit(u32 addr);
> >  extern struct sys_timer at91sam926x_timer;
> > diff --git a/arch/arm/mach-at91/include/mach/at91_st.h b/arch/arm/mach-at91/include/mach/at91_st.h
> > index 8847173..969aac2 100644
> > --- a/arch/arm/mach-at91/include/mach/at91_st.h
> > +++ b/arch/arm/mach-at91/include/mach/at91_st.h
> > @@ -16,34 +16,46 @@
> >  #ifndef AT91_ST_H
> >  #define AT91_ST_H
> >  
> > -#define	AT91_ST_CR		(AT91_ST + 0x00)	/* Control Register */
> > +#ifndef __ASSEMBLY__
> > +extern void __iomem *at91_st_base;
> > +
> > +#define at91_st_read(field) \
> > +	__raw_readl(at91_st_base + field)
> > +
> > +#define at91_st_write(field, value) \
> > +	__raw_writel(value, at91_st_base + field);
> 
> 
> Static inline functions are nicer for readability/type checking.
sorry no this will improve nothing
> 
> > +#else
> > +.extern at91_st_base
> 
> 
> Typo: remove the . in front of the extern. Has this been compile tested?
certainly not it's assembly
.extern is right

Best Regards,
J.
