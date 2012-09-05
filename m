From: gerg@snapgear.com (Greg Ungerer)
Date: Wed, 5 Sep 2012 16:19:07 +1000
Subject: [PATCH 4/4 v5] ARM: ks8695: convert to generic time and
 clocksource
In-Reply-To: <1346822595-8487-1-git-send-email-linus.walleij@linaro.org>
References: <1346822595-8487-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <5046EEDB.3030909@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 05/09/12 15:23, Linus Walleij wrote:
> Old platforms using ancient gettimeoffset() and other arcane
> APIs are standing in the way of cleaning up the ARM kernel.
> The gettimeoffset() was also broken: it would try to read out
> the timer counter value, while this would not work (the
> counter statically returns the initially programmed value)
> so the implementation would anyway fall back to a homebrew
> version of jiffie calculation.
>
> This is an attempt at blind-coding a generic time and clocksource
> driver for the platform by way of a datasheet and looking at the
> old code.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This is all good. So take your pick:

Tested-by: Greg Ungerer <gerg@snapgear.com>
Acked-by: Greg Ungerer <gerg@snapgear.com>

Regards
Greg



> ---
> ChangeLog v4->v5:
> - Don't unconditionally disable timer 1 in the set_mode()
>    function, this reportedly hangs the platform in loop
>    calibration.
> ChangeLog v3->v4:
> - Skip trying to provide an MMIO clocksource, there is no
>    clocksource to be found on this system, so set up a clockevent
>    and let the timekeeping core fall back to jiffies.
> ChangeLog v2->v3:
> - Correct the MMIO timer read function: this timer counts DOWN
>    not up - since clocksources shall move forward in time, the
>    ever decreasing clocksource was likely ignored.
> ChangeLog v1->v2:
> - Corrected the mask when setting clockevents from & TMCON_T1EN
>    to & ~TMCON_T1EN so it doesn't shut down the clock source.
> ---
>   arch/arm/Kconfig            |   3 +-
>   arch/arm/mach-ks8695/time.c | 105 ++++++++++++++++++++++++++++----------------
>   2 files changed, 69 insertions(+), 39 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 6d6e18f..e9ce038 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -652,8 +652,9 @@ config ARCH_KS8695
>   	bool "Micrel/Kendin KS8695"
>   	select CPU_ARM922T
>   	select ARCH_REQUIRE_GPIOLIB
> -	select ARCH_USES_GETTIMEOFFSET
>   	select NEED_MACH_MEMORY_H
> +	select CLKSRC_MMIO
> +	select GENERIC_CLOCKEVENTS
>   	help
>   	  Support for Micrel/Kendin KS8695 "Centaur" (ARM922T) based
>   	  System-on-Chip devices.
> diff --git a/arch/arm/mach-ks8695/time.c b/arch/arm/mach-ks8695/time.c
> index 6974c23..46c84bc 100644
> --- a/arch/arm/mach-ks8695/time.c
> +++ b/arch/arm/mach-ks8695/time.c
> @@ -25,6 +25,7 @@
>   #include <linux/kernel.h>
>   #include <linux/sched.h>
>   #include <linux/io.h>
> +#include <linux/clockchips.h>
>
>   #include <asm/mach/time.h>
>   #include <asm/system_misc.h>
> @@ -53,44 +54,69 @@
>   /* Timer0 Timeout Counter Register */
>   #define T0TC_WATCHDOG		(0xff)		/* Enable watchdog mode */
>
> -/*
> - * Returns number of ms since last clock interrupt.  Note that interrupts
> - * will have been disabled by do_gettimeoffset()
> - */
> -static unsigned long ks8695_gettimeoffset (void)
> +static void ks8695_set_mode(enum clock_event_mode mode,
> +			    struct clock_event_device *evt)
>   {
> -	unsigned long elapsed, tick2, intpending;
> +	u32 tmcon;
>
> -	/*
> -	 * Get the current number of ticks.  Note that there is a race
> -	 * condition between us reading the timer and checking for an
> -	 * interrupt.  We solve this by ensuring that the counter has not
> -	 * reloaded between our two reads.
> -	 */
> -	elapsed = readl_relaxed(KS8695_TMR_VA + KS8695_T1TC) + readl_relaxed(KS8695_TMR_VA + KS8695_T1PD);
> -	do {
> -		tick2 = elapsed;
> -		intpending = readl_relaxed(KS8695_IRQ_VA + KS8695_INTST) & (1 << KS8695_IRQ_TIMER1);
> -		elapsed = readl_relaxed(KS8695_TMR_VA + KS8695_T1TC) + readl_relaxed(KS8695_TMR_VA + KS8695_T1PD);
> -	} while (elapsed > tick2);
> -
> -	/* Convert to number of ticks expired (not remaining) */
> -	elapsed = (CLOCK_TICK_RATE / HZ) - elapsed;
> -
> -	/* Is interrupt pending?  If so, then timer has been reloaded already. */
> -	if (intpending)
> -		elapsed += (CLOCK_TICK_RATE / HZ);
> -
> -	/* Convert ticks to usecs */
> -	return (unsigned long)(elapsed * (tick_nsec / 1000)) / LATCH;
> +	if (mode == CLOCK_EVT_FEAT_PERIODIC) {
> +		u32 rate = DIV_ROUND_CLOSEST(KS8695_CLOCK_RATE, HZ);
> +		u32 half = DIV_ROUND_CLOSEST(rate, 2);
> +
> +		/* Disable timer 1 */
> +		tmcon = readl_relaxed(KS8695_TMR_VA + KS8695_TMCON);
> +		tmcon &= ~TMCON_T1EN;
> +		writel_relaxed(tmcon, KS8695_TMR_VA + KS8695_TMCON);
> +
> +		/* Both registers need to count down */
> +		writel_relaxed(half, KS8695_TMR_VA + KS8695_T1TC);
> +		writel_relaxed(half, KS8695_TMR_VA + KS8695_T1PD);
> +
> +		/* Re-enable timer1 */
> +		tmcon |= TMCON_T1EN;
> +		writel_relaxed(tmcon, KS8695_TMR_VA + KS8695_TMCON);
> +	}
> +}
> +
> +static int ks8695_set_next_event(unsigned long cycles,
> +				 struct clock_event_device *evt)
> +
> +{
> +	u32 half = DIV_ROUND_CLOSEST(cycles, 2);
> +	u32 tmcon;
> +
> +	/* Disable timer 1 */
> +	tmcon = readl_relaxed(KS8695_TMR_VA + KS8695_TMCON);
> +	tmcon &= ~TMCON_T1EN;
> +	writel_relaxed(tmcon, KS8695_TMR_VA + KS8695_TMCON);
> +
> +	/* Both registers need to count down */
> +	writel_relaxed(half, KS8695_TMR_VA + KS8695_T1TC);
> +	writel_relaxed(half, KS8695_TMR_VA + KS8695_T1PD);
> +
> +	/* Re-enable timer1 */
> +	tmcon |= TMCON_T1EN;
> +	writel_relaxed(tmcon, KS8695_TMR_VA + KS8695_TMCON);
> +
> +	return 0;
>   }
>
> +static struct clock_event_device clockevent_ks8695 = {
> +	.name		= "ks8695_t1tc",
> +	.rating		= 300, /* Reasonably fast and accurate clock event */
> +	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
> +	.set_next_event	= ks8695_set_next_event,
> +	.set_mode	= ks8695_set_mode,
> +};
> +
>   /*
>    * IRQ handler for the timer.
>    */
>   static irqreturn_t ks8695_timer_interrupt(int irq, void *dev_id)
>   {
> -	timer_tick();
> +	struct clock_event_device *evt = &clockevent_ks8695;
> +
> +	evt->event_handler(evt);
>   	return IRQ_HANDLED;
>   }
>
> @@ -102,18 +128,22 @@ static struct irqaction ks8695_timer_irq = {
>
>   static void ks8695_timer_setup(void)
>   {
> -	unsigned long tmout = CLOCK_TICK_RATE / HZ;
>   	unsigned long tmcon;
>
> -	/* disable timer1 */
> +	/* Disable timer 0 and 1 */
>   	tmcon = readl_relaxed(KS8695_TMR_VA + KS8695_TMCON);
> -	writel_relaxed(tmcon & ~TMCON_T1EN, KS8695_TMR_VA + KS8695_TMCON);
> -
> -	writel_relaxed(tmout / 2, KS8695_TMR_VA + KS8695_T1TC);
> -	writel_relaxed(tmout / 2, KS8695_TMR_VA + KS8695_T1PD);
> +	tmcon &= ~TMCON_T0EN;
> +	tmcon &= ~TMCON_T1EN;
> +	writel_relaxed(tmcon, KS8695_TMR_VA + KS8695_TMCON);
>
> -	/* re-enable timer1 */
> -	writel_relaxed(tmcon | TMCON_T1EN, KS8695_TMR_VA + KS8695_TMCON);
> +	/*
> +	 * Use timer 1 to fire IRQs on the timeline, minimum 2 cycles
> +	 * (one on each counter) maximum 2*2^32, but the API will only
> +	 * accept up to a 32bit full word (0xFFFFFFFFU).
> +	 */
> +	clockevents_config_and_register(&clockevent_ks8695,
> +					KS8695_CLOCK_RATE, 2,
> +					0xFFFFFFFFU);
>   }
>
>   static void __init ks8695_timer_init (void)
> @@ -126,7 +156,6 @@ static void __init ks8695_timer_init (void)
>
>   struct sys_timer ks8695_timer = {
>   	.init		= ks8695_timer_init,
> -	.offset		= ks8695_gettimeoffset,
>   };
>
>   void ks8695_restart(char mode, const char *cmd)
>


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
