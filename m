From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 8 Jan 2010 05:47:17 +0000
Subject: [PATCH] [ARM] [S3C64XX] Add support for hr timer
In-Reply-To: <1259656795-8766-1-git-send-email-aditya.ps@samsung.com>
References: <1259656795-8766-1-git-send-email-aditya.ps@samsung.com>
Message-ID: <20100108054717.GB1224@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2009 at 05:39:55PM +0900, aditya wrote:
> This patch add support for the S3C64XX hr timer.

would be nicer to use high resolution instead of hr in this text.
 
> Signed-off-by: Aditya Pratap Sharma <aditya.ps@samsung.com>
> ---
>  arch/arm/mach-s3c6410/Kconfig               |    2 +
>  arch/arm/plat-s3c/Makefile                  |   10 +
>  arch/arm/plat-s3c/hr-time.c                 |  301 +++++++++++++++++++++++++++
>  arch/arm/plat-s3c/include/plat/regs-timer.h |   11 +
>  4 files changed, 324 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-s3c/hr-time.c
> 
> diff --git a/arch/arm/mach-s3c6410/Kconfig b/arch/arm/mach-s3c6410/Kconfig
> index f9d0f09..29cfd0c 100644
> --- a/arch/arm/mach-s3c6410/Kconfig
> +++ b/arch/arm/mach-s3c6410/Kconfig
> @@ -11,6 +11,8 @@ config CPU_S3C6410
>  	bool
>  	select CPU_S3C6400_INIT
>  	select CPU_S3C6400_CLOCK
> +	select GENERIC_TIME
> +	select GENERIC_CLOCKEVENTS
>  	help
>  	  Enable S3C6410 CPU support
>  
> diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
> index 3c09109..6c612aa 100644
> --- a/arch/arm/plat-s3c/Makefile
> +++ b/arch/arm/plat-s3c/Makefile
> @@ -12,7 +12,17 @@ obj-				:=
>  # Core support for all Samsung SoCs
>  
>  obj-y				+=  init.o
> +ifdef CONFIG_NO_HZ
> +obj-y				+= hr-time.o
> +else
> +
> +ifndef CONFIG_HIGH_RES_TIMERS
>  obj-y				+= time.o
> +else
> +obj-y				+= hr-time.o
> +endif
> +
> +endif
>  obj-y				+= clock.o
>  obj-y				+= pwm-clock.o
>  obj-y				+= gpio.o

It would be nicer to allow both to be compiled in depending on what the
board files want to use.

> diff --git a/arch/arm/plat-s3c/hr-time.c b/arch/arm/plat-s3c/hr-time.c
> new file mode 100644
> index 0000000..76fd91f
> --- /dev/null
> +++ b/arch/arm/plat-s3c/hr-time.c
> @@ -0,0 +1,301 @@
> +/*
> + * linux/arch/arm/plat-s3c/hr-time.c
> + *
> + * S3C6410 high resolution Timers
> + *
> + * Copyright (c) 2006 Samsung Electronics
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/sched.h>
> +#include <linux/spinlock.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/clocksource.h>
> +#include <linux/clockchips.h>
> +#include <linux/io.h>
> +#include <linux/leds.h>

is <linux/leds.h> needed here?

> +#include <asm/system.h>
> +#include <asm/irq.h>
> +#include <asm/mach/irq.h>
> +#include <asm/mach/time.h>
> +#include <asm/mach-types.h>

do you really need mach-types.h? I now the old code
for the s3c2410 needed it for machine_is_xxx() but we've learned quite
a bit since that time.

there are also a lot of asm files being pulled in as well.

> +#include <mach/hardware.h>
> +#include <mach/map.h>
> +#include <mach/regs-irq.h>
> +#include <mach/tick.h>
> +#include <plat/regs-timer.h>
> +#include <plat/clock.h>
> +#include <plat/cpu.h>

some spacing in between the include files would make it neater and in
my opinion neater too.

> +
> +static void s3c64xx_timer_setup(void);
> +
> +static inline void s3c64xx_tick_set_autoreset(void)
> +{
> +	unsigned long tcon;
> +	tcon  = __raw_readl(S3C2410_TCON);
> +	tcon |= (S3C2410_TCON_T4RELOAD);
> +	__raw_writel(tcon, S3C2410_TCON);
> +}
> +
> +static inline void s3c64xx_tick_remove_autoreset(void)
> +{
> +	unsigned long tcon;
> +	tcon  = __raw_readl(S3C2410_TCON);
> +	tcon &= ~(S3C2410_TCON_T4RELOAD);
> +	__raw_writel(tcon, S3C2410_TCON);
> +}
> +
> +static void s3c64xx_tick_timer_start(unsigned long load_val,
> +					int autoreset)
> +{
> +	unsigned long tcon;
> +	unsigned long tcfg1;
> +	unsigned long tcfg0;
> +	unsigned long tcstat;
> +
> +	tcon  = __raw_readl(S3C2410_TCON);
> +	tcfg1 = __raw_readl(S3C2410_TCFG1);
> +	tcfg0 = __raw_readl(S3C2410_TCFG0);
> +
> +	tcstat = __raw_readl(S3C64XX_TINT_CSTAT);
> +	tcstat |=  S3C_TINT_CSTAT_T4INTEN;
> +	__raw_writel(tcstat, S3C64XX_TINT_CSTAT);
> +	__raw_writel(load_val - 1, S3C2410_TCNTB(4));

could the interrupt support for the pwm-timer clocks be used here?
 
are these protected against access from multiple sources, as the pwm
timer interrpt code might touch these too.

thirdly, you don't mask the interrupt status and thus may end up acknowleding
an extant interrupt.

> +	tcfg1 &= ~S3C2410_TCFG1_MUX4_MASK;
> +	tcfg1 |= S3C2410_TCFG1_MUX4_DIV2;
> +
> +	tcfg0 &= ~S3C2410_TCFG_PRESCALER1_MASK;
> +	tcfg0 |= (0) << S3C2410_TCFG_PRESCALER1_SHIFT;
> +
> +	__raw_writel(tcfg1, S3C2410_TCFG1);
> +	__raw_writel(tcfg0, S3C2410_TCFG0);
> +
> +	tcon &= ~(S3C2410_TCON_T4START|S3C2410_TCON_T4MANUALUPD
> +					|S3C2410_TCON_T4RELOAD);
> +	tcon |= S3C2410_TCON_T4MANUALUPD;
> +	if (autoreset)
> +		tcon |= S3C2410_TCON_T4RELOAD;
> +	__raw_writel(tcon, S3C2410_TCON);
> +
> +	/* start the timer running */
> +	tcon |= S3C2410_TCON_T4START;
> +	tcon &= ~S3C2410_TCON_T4MANUALUPD;
> +	__raw_writel(tcon, S3C2410_TCON);
> +}
> +
> +static inline void s3c64xx_tick_timer_stop(void)
> +{
> +	unsigned long tcon;
> +	tcon  = __raw_readl(S3C2410_TCON);
> +	tcon &= ~(S3C2410_TCON_T4START);
> +	__raw_writel(tcon, S3C2410_TCON);
> +}
> +
> +static void s3c64xx_sched_timer_start(unsigned long load_val,
> +					int autoreset)
> +{
> +	unsigned long tcon;
> +	unsigned long tcfg1;
> +	unsigned long tcfg0;
> +	unsigned long tcstat;
> +
> +	tcstat = __raw_readl(S3C64XX_TINT_CSTAT);
> +	tcstat |=  S3C_TINT_CSTAT_T2INTEN;
> +	__raw_writel(tcstat, S3C64XX_TINT_CSTAT);
> +
> +	tcon  = __raw_readl(S3C2410_TCON);
> +	tcfg1 = __raw_readl(S3C2410_TCFG1);
> +	tcfg0 = __raw_readl(S3C2410_TCFG0);
> +
> +	__raw_writel(load_val - 1, S3C2410_TCNTB(2));
> +	__raw_writel(load_val - 1, S3C2410_TCMPB(2));
> +
> +	tcon &= ~(S3C2410_TCON_T2RELOAD|(!S3C2410_TCON_T2INVERT)
> +			|S3C2410_TCON_T2MANUALUPD|S3C2410_TCON_T2START);
> +	if (autoreset)
> +		tcon |= S3C2410_TCON_T2RELOAD;
> +	tcon |= S3C2410_TCON_T2MANUALUPD;
> +	__raw_writel(tcon, S3C2410_TCON);
> +
> +	/* start the timer running */
> +	tcon |= S3C2410_TCON_T2START;
> +	tcon &= ~S3C2410_TCON_T2MANUALUPD;
> +	__raw_writel(tcon, S3C2410_TCON);
> +}
> +
> +/*
> + * ---------------------------------------------------------------------------
> + * PWM timer 4 ... count down to zero, interrupt, reload
> + * ---------------------------------------------------------------------------
> + */
> +static int s3c64xx_tick_set_next_event(unsigned long cycles,
> +				   struct clock_event_device *evt)
> +{
> +	s3c64xx_tick_timer_start(cycles, 0);
> +	return 0;
> +}
> +static void s3c64xx_tick_set_mode(enum clock_event_mode mode,
> +			      struct clock_event_device *evt)
> +{
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		s3c64xx_tick_set_autoreset();
> +		break;
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		s3c64xx_tick_timer_stop();
> +		s3c64xx_tick_remove_autoreset();
> +		break;
> +	case CLOCK_EVT_MODE_UNUSED:
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +		break;
> +	case CLOCK_EVT_MODE_RESUME:
> +		s3c64xx_timer_setup();
> +		break;
> +	}
> +}
> +
> +static struct clock_event_device tick_tmr = {
> +	.name		= "pwm_timer4",
> +	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> +	.shift		= 32,
> +	.set_next_event	= s3c64xx_tick_set_next_event,
> +	.set_mode	= s3c64xx_tick_set_mode,
> +};
> +
> +irqreturn_t s3c64xx_tick_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = &tick_tmr;
> +	evt->event_handler(evt);
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irqaction s3c64xx_tick_timer_irq = {
> +	.name		= "pwm_timer4",
> +	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
> +	.handler	= s3c64xx_tick_timer_interrupt,
> +};
> +
> +static void __init s3c64xx_init_dynamic_tick_timer(unsigned long rate)
> +{
> +	s3c64xx_tick_timer_start((rate / HZ) - 1, 1);
> +	tick_tmr.mult = div_sc(rate, NSEC_PER_SEC, tick_tmr.shift);
> +	tick_tmr.max_delta_ns = clockevent_delta2ns(-1, &tick_tmr);
> +	tick_tmr.min_delta_ns = clockevent_delta2ns(1, &tick_tmr);
> +
> +	tick_tmr.cpumask = get_cpu_mask(0);
> +	clockevents_register_device(&tick_tmr);
> +}
> +
> +/*
> + * ---------------------------------------------------------------------------
> + * PWM timer 2 ... free running 32-bit clock source and scheduler clock
> + * ---------------------------------------------------------------------------
> + */
> +static unsigned long s3c64xx_mpu_timer2_overflows;
> +
> +irqreturn_t s3c64xx_mpu_timer2_interrupt(int irq, void *dev_id)
> +{
> +	s3c64xx_mpu_timer2_overflows++;
> +	return IRQ_HANDLED;
> +}
> +
> +struct irqaction s3c64xx_timer2_irq = {
> +	.name		= "pwm_timer2",
> +	.flags		= IRQF_DISABLED ,
> +	.handler	= s3c64xx_mpu_timer2_interrupt,
> +};
> +
> +
> +/* Read timer 2 Count Observation Register */
> +static cycle_t s3c64xx_sched_timer_read(struct clocksource *cs)
> +{
> +	return (cycle_t)~__raw_readl(S3C_TIMERREG(0x2c));
> +}
> +
> +struct clocksource clocksource_s3c64xx = {
> +	.name		= "clock_source_timer2",
> +	.rating		= 300,
> +	.read		= s3c64xx_sched_timer_read,
> +	.mask		= CLOCKSOURCE_MASK(32),
> +	.shift		= 20,
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS ,
> +};
> +
> +static void __init s3c64xx_init_clocksource(unsigned long rate)
> +{
> +	clocksource_s3c64xx.mult
> +		= clocksource_khz2mult(rate/1000, clocksource_s3c64xx.shift);
> +	s3c64xx_sched_timer_start(~0, 1);
> +
> +	if (clocksource_register(&clocksource_s3c64xx))
> +		printk(KERN_ERR "%s: can't register clocksource\n",
> +			clocksource_s3c64xx.name);
> +}
> +
> +/*
> + * ---------------------------------------------------------------------------
> + *  Tick Timer initialization
> + * ---------------------------------------------------------------------------
> + */
> +static void s3c64xx_dynamic_timer_setup(void)
> +{
> +	struct clk	*ck_ref = clk_get(NULL, "timers");
> +	unsigned long	rate;
> +
> +	if (IS_ERR(ck_ref))
> +		panic("failed to get clock for system timer");
> +
> +	rate = clk_get_rate(ck_ref);
> +	clk_put(ck_ref);
> +
> +	s3c64xx_init_dynamic_tick_timer(rate);
> +	s3c64xx_init_clocksource(rate);
> +}
> +
> +static void s3c64xx_timer_setup(void)
> +{
> +	struct clk	*ck_ref = clk_get(NULL, "timers");
> +	unsigned long	rate;
> +
> +	if (IS_ERR(ck_ref))
> +		panic("failed to get clock for system timer");
> +
> +	rate = clk_get_rate(ck_ref);
> +	clk_put(ck_ref);
> +	s3c64xx_tick_timer_start((rate / HZ) - 1, 1);
> +	s3c64xx_sched_timer_start(~0, 1);
> +}
> +
> +
> +static void __init s3c64xx_dynamic_timer_init(void)
> +{
> +	s3c64xx_dynamic_timer_setup();
> +	setup_irq(IRQ_TIMER2, &s3c64xx_timer2_irq);
> +	setup_irq(IRQ_TIMER4, &s3c64xx_tick_timer_irq);
> +}
> +
> +
> +struct sys_timer s3c24xx_timer = {
> +	.init		= s3c64xx_dynamic_timer_init,
> +};

If we want both timer and highres timer support, this will need to
get renamed.

> diff --git a/arch/arm/plat-s3c/include/plat/regs-timer.h b/arch/arm/plat-s3c/include/plat/regs-timer.h
> index d097d92..e9994db 100644
> --- a/arch/arm/plat-s3c/include/plat/regs-timer.h
> +++ b/arch/arm/plat-s3c/include/plat/regs-timer.h
> @@ -117,6 +117,17 @@
>  #define S3C2410_TCON_T0INVERT	  (1<<2)
>  #define S3C2410_TCON_T0MANUALUPD  (1<<1)
>  #define S3C2410_TCON_T0START	  (1<<0)
> +/* Interrupt Control and Status register*/
> +#define S3C_TINT_CSTAT_T4INT	(1<<9)
> +#define S3C_TINT_CSTAT_T3INT	(1<<8)
> +#define S3C_TINT_CSTAT_T2INT	(1<<7)
> +#define S3C_TINT_CSTAT_T1INT	(1<<6)
> +#define S3C_TINT_CSTAT_T0INT	(1<<5)
> +#define S3C_TINT_CSTAT_T4INTEN	(1<<4)
> +#define S3C_TINT_CSTAT_T3INTEN	(1<<3)
> +#define S3C_TINT_CSTAT_T2INTEN	(1<<2)
> +#define S3C_TINT_CSTAT_T1INTEN	(1<<1)
> +#define S3C_TINT_CSTAT_T0INTEN	(1<<0)
>  
>  #endif /*  __ASM_ARCH_REGS_TIMER_H */

how about defining the following:

#define S3C_TINT_CTSTA_INTEN(x)	(1 << (x))
#define S3C_TINT_CSTAT_INT(x)	(1 << ((x) + 5))

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
