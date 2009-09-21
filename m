From: kristoffer.ericson@gmail.com (Kristoffer Ericson)
Date: Mon, 21 Sep 2009 14:32:57 +0200
Subject: [PATCH] Don't disable irqs in set_next_event and set_mode
	callbacks
In-Reply-To: <1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20090921143257.e36dd8f3.kristoffer.ericson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dont see the harm (will do a formal test later today), so feel
free to add acked-by.

/Kristoffer

On Mon, 21 Sep 2009 09:39:22 +0200
Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> These functions are called with irqs already off.
> 
> at91rm2000 had a WARN_ON_ONCE if irqs were enabled since Nov 2008 with
> noone reporting having hit it.
> 
> It should be safe to remove now.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Andrea Gallo <andrea.gallo@stericsson.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Eric Miao <eric.miao@marvell.com>
> Cc: Hugh Dickins <hugh@veritas.com>
> Cc: John Stultz <johnstul@us.ibm.com>
> Cc: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
> Cc: Magnus Damm <damm@igel.co.jp>
> Cc: Nicolas Pitre <nico@marvell.com>
> Cc: Remy Bohmer <linux@bohmer.net>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> ---
> Hello,
> 
> should I split the patch?  Would you prefer to add a WARN_ON_ONCE for
> some time (as at91rm9200 had it)?
> 
> Best regards
> Uwe
> 
>  arch/arm/mach-at91/at91rm9200_time.c  |   14 --------------
>  arch/arm/mach-at91/at91sam926x_time.c |    6 +-----
>  arch/arm/mach-nomadik/timer.c         |    9 +--------
>  arch/arm/mach-pxa/time.c              |   10 +---------
>  arch/arm/mach-sa1100/time.c           |    8 +-------
>  5 files changed, 4 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
> index 309f351..f27ccf6 100644
> --- a/arch/arm/mach-at91/at91rm9200_time.c
> +++ b/arch/arm/mach-at91/at91rm9200_time.c
> @@ -132,24 +132,11 @@ clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
>  static int
>  clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
>  {
> -	unsigned long	flags;
>  	u32		alm;
>  	int		status = 0;
>  
>  	BUG_ON(delta < 2);
>  
> -	/* Use "raw" primitives so we behave correctly on RT kernels. */
> -	raw_local_irq_save(flags);
> -
> -	/*
> -	 * According to Thomas Gleixner irqs are already disabled here.  Simply
> -	 * removing raw_local_irq_save above (and the matching
> -	 * raw_local_irq_restore) was not accepted.  See
> -	 * http://thread.gmane.org/gmane.linux.ports.arm.kernel/41174
> -	 * So for now (2008-11-20) just warn once if irqs were not disabled ...
> -	 */
> -	WARN_ON_ONCE(!raw_irqs_disabled_flags(flags));
> -
>  	/* The alarm IRQ uses absolute time (now+delta), not the relative
>  	 * time (delta) in our calling convention.  Like all clockevents
>  	 * using such "match" hardware, we have a race to defend against.
> @@ -169,7 +156,6 @@ clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
>  	alm += delta;
>  	at91_sys_write(AT91_ST_RTAR, alm);
>  
> -	raw_local_irq_restore(flags);
>  	return status;
>  }
>  
> diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
> index 4bd56ae..c26cd6e 100644
> --- a/arch/arm/mach-at91/at91sam926x_time.c
> +++ b/arch/arm/mach-at91/at91sam926x_time.c
> @@ -62,16 +62,12 @@ static struct clocksource pit_clk = {
>  static void
>  pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
>  {
> -	unsigned long	flags;
> -
>  	switch (mode) {
>  	case CLOCK_EVT_MODE_PERIODIC:
> -		/* update clocksource counter, then enable the IRQ */
> -		raw_local_irq_save(flags);
> +		/* update clocksource counter */
>  		pit_cnt += pit_cycle * PIT_PICNT(at91_sys_read(AT91_PIT_PIVR));
>  		at91_sys_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN
>  				| AT91_PIT_PITIEN);
> -		raw_local_irq_restore(flags);
>  		break;
>  	case CLOCK_EVT_MODE_ONESHOT:
>  		BUG();
> diff --git a/arch/arm/mach-nomadik/timer.c b/arch/arm/mach-nomadik/timer.c
> index d1738e7..e361be6 100644
> --- a/arch/arm/mach-nomadik/timer.c
> +++ b/arch/arm/mach-nomadik/timer.c
> @@ -54,24 +54,17 @@ static struct clocksource nmdk_clksrc = {
>  static void nmdk_clkevt_mode(enum clock_event_mode mode,
>  			     struct clock_event_device *dev)
>  {
> -	unsigned long flags;
> -
>  	switch (mode) {
>  	case CLOCK_EVT_MODE_PERIODIC:
> -		/* enable interrupts -- and count current value? */
> -		raw_local_irq_save(flags);
> +		/* count current value? */
>  		writel(readl(mtu_base + MTU_IMSC) | 1, mtu_base + MTU_IMSC);
> -		raw_local_irq_restore(flags);
>  		break;
>  	case CLOCK_EVT_MODE_ONESHOT:
>  		BUG(); /* Not supported, yet */
>  		/* FALLTHROUGH */
>  	case CLOCK_EVT_MODE_SHUTDOWN:
>  	case CLOCK_EVT_MODE_UNUSED:
> -		/* disable irq */
> -		raw_local_irq_save(flags);
>  		writel(readl(mtu_base + MTU_IMSC) & ~1, mtu_base + MTU_IMSC);
> -		raw_local_irq_restore(flags);
>  		break;
>  	case CLOCK_EVT_MODE_RESUME:
>  		break;
> diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
> index 750c448..293e40a 100644
> --- a/arch/arm/mach-pxa/time.c
> +++ b/arch/arm/mach-pxa/time.c
> @@ -76,14 +76,12 @@ pxa_ost0_interrupt(int irq, void *dev_id)
>  static int
>  pxa_osmr0_set_next_event(unsigned long delta, struct clock_event_device *dev)
>  {
> -	unsigned long flags, next, oscr;
> +	unsigned long next, oscr;
>  
> -	raw_local_irq_save(flags);
>  	OIER |= OIER_E0;
>  	next = OSCR + delta;
>  	OSMR0 = next;
>  	oscr = OSCR;
> -	raw_local_irq_restore(flags);
>  
>  	return (signed)(next - oscr) <= MIN_OSCR_DELTA ? -ETIME : 0;
>  }
> @@ -91,23 +89,17 @@ pxa_osmr0_set_next_event(unsigned long delta, struct clock_event_device *dev)
>  static void
>  pxa_osmr0_set_mode(enum clock_event_mode mode, struct clock_event_device *dev)
>  {
> -	unsigned long irqflags;
> -
>  	switch (mode) {
>  	case CLOCK_EVT_MODE_ONESHOT:
> -		raw_local_irq_save(irqflags);
>  		OIER &= ~OIER_E0;
>  		OSSR = OSSR_M0;
> -		raw_local_irq_restore(irqflags);
>  		break;
>  
>  	case CLOCK_EVT_MODE_UNUSED:
>  	case CLOCK_EVT_MODE_SHUTDOWN:
>  		/* initializing, released, or preparing for suspend */
> -		raw_local_irq_save(irqflags);
>  		OIER &= ~OIER_E0;
>  		OSSR = OSSR_M0;
> -		raw_local_irq_restore(irqflags);
>  		break;
>  
>  	case CLOCK_EVT_MODE_RESUME:
> diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
> index 95d92e8..a7a6091 100644
> --- a/arch/arm/mach-sa1100/time.c
> +++ b/arch/arm/mach-sa1100/time.c
> @@ -35,14 +35,12 @@ static irqreturn_t sa1100_ost0_interrupt(int irq, void *dev_id)
>  static int
>  sa1100_osmr0_set_next_event(unsigned long delta, struct clock_event_device *c)
>  {
> -	unsigned long flags, next, oscr;
> +	unsigned long next, oscr;
>  
> -	raw_local_irq_save(flags);
>  	OIER |= OIER_E0;
>  	next = OSCR + delta;
>  	OSMR0 = next;
>  	oscr = OSCR;
> -	raw_local_irq_restore(flags);
>  
>  	return (signed)(next - oscr) <= MIN_OSCR_DELTA ? -ETIME : 0;
>  }
> @@ -50,16 +48,12 @@ sa1100_osmr0_set_next_event(unsigned long delta, struct clock_event_device *c)
>  static void
>  sa1100_osmr0_set_mode(enum clock_event_mode mode, struct clock_event_device *c)
>  {
> -	unsigned long flags;
> -
>  	switch (mode) {
>  	case CLOCK_EVT_MODE_ONESHOT:
>  	case CLOCK_EVT_MODE_UNUSED:
>  	case CLOCK_EVT_MODE_SHUTDOWN:
> -		raw_local_irq_save(flags);
>  		OIER &= ~OIER_E0;
>  		OSSR = OSSR_M0;
> -		raw_local_irq_restore(flags);
>  		break;
>  
>  	case CLOCK_EVT_MODE_RESUME:
> -- 
> 1.6.4.3
> 


-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>
