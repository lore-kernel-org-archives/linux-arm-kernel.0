From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 10 Oct 2011 18:57:58 +0900
Subject: [PATCH 2/5] ARM: s3c64xx: Add generic high resolution time support
	using PWM timers.
In-Reply-To: <3260808.zUY9bHslbC@flatron>
References: <1731819.jJi37IsjvJ@flatron> <3260808.zUY9bHslbC@flatron>
Message-ID: <039d01cc8733$16c5ded0$44519c70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> From d1fa581f09d8f8a3cc24d05420e9e65112fd8c12 Mon Sep 17 00:00:00 2001
> From: Tomasz Figa <tomasz.figa@gmail.com>
> Date: Sun, 28 Aug 2011 02:45:06 +0200
> Subject: [PATCH 2/5] ARM: s3c64xx: Add generic high resolution time
support
>  using PWM timers.
> 
> This patch adds a sys_timer implementing generic clock source and clock
event
> device on S3C64xx using PWM timers 3 and 4. It can be enabled by a Kconfig
> option, based on which either the new sys_timer is used as s3c64xx_timer
or
> s3c64xx_timer is defined to s3c24xx_timer which is the old tick timer.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  arch/arm/Kconfig                         |    1 -
>  arch/arm/mach-s3c64xx/Kconfig            |   12 ++
>  arch/arm/mach-s3c64xx/Makefile           |    3 +
>  arch/arm/mach-s3c64xx/time.c             |  320
> ++++++++++++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/cpu.h |    7 +
>  5 files changed, 342 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-s3c64xx/time.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9adc278..05941f6 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -700,7 +700,6 @@ config ARCH_S3C64XX
>  	select ARM_VIC
>  	select HAVE_CLK
>  	select NO_IOPORT
> -	select ARCH_USES_GETTIMEOFFSET
>  	select ARCH_HAS_CPUFREQ
>  	select ARCH_REQUIRE_GPIOLIB
>  	select SAMSUNG_CLKSRC
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index e4177e2..2db76fd 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -25,6 +25,18 @@ config CPU_S3C6410
>  	help
>  	  Enable S3C6410 CPU support
> 
> +config S3C64XX_GENERIC_CLOCKEVENTS
> +	bool "Enable high resolution generic time support using PWM timers"
> +	select GENERIC_CLOCKEVENTS
> +	help
> +	  This option enables high resolution generic time support
> +	  on S3C6400/S3C6410 SoCs using PWM timers 3 and 4 instead
> +	  of standard periodic tick using PWM timer 4.
> +
> +config S3C64XX_ARCH_USES_GETTIMEOFFSET
> +	def_bool y if !S3C64XX_GENERIC_CLOCKEVENTS
> +	select ARCH_USES_GETTIMEOFFSET
> +
>  config S3C64XX_DMA
>  	bool "S3C64XX DMA"
>  	select S3C_DMA
> diff --git a/arch/arm/mach-s3c64xx/Makefile
b/arch/arm/mach-s3c64xx/Makefile
> index 4657363..a152002 100644
> --- a/arch/arm/mach-s3c64xx/Makefile
> +++ b/arch/arm/mach-s3c64xx/Makefile
> @@ -15,6 +15,9 @@ obj-y				+= cpu.o
>  obj-y				+= clock.o
>  obj-y				+= gpiolib.o
> 
> +# Generic clockevents
> +obj-$(CONFIG_S3C64XX_GENERIC_CLOCKEVENTS) += time.o
> +
>  # Core support for S3C6400 system
> 
>  obj-$(CONFIG_CPU_S3C6400)	+= s3c6400.o
> diff --git a/arch/arm/mach-s3c64xx/time.c b/arch/arm/mach-s3c64xx/time.c
> new file mode 100644
> index 0000000..4fa57f0
> --- /dev/null
> +++ b/arch/arm/mach-s3c64xx/time.c
> @@ -0,0 +1,320 @@
> +/* linux/arch/arm/mach-s3c64xx/time.c
> + *
> + * Copyright (c) 2011 Tomasz Figa <tomasz.figa@gmail.com>
> + *
> + * based on linux/arch/arm/plat-samsung/s5p-time.c
> + *
> + * S3C64XX generic high resolution time support using PWM 3 and PWM 4
timers.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Notes:
> + * - Frequency divisors are currently hardcoded to make both timers
operate
> + *   at 1/6 the frequency of PCLK, so with the usual PCLK frequency of 66
MHz,
> + *   the timers are clocked at 11 MHz giving us the operating range from
> + *   90 nsec to 386 sec.
> + * - PWM registers, especially TCON, are shared with PWM driver, but
since
> + *   all the clock event callbacks are run in atomic context
synchronization
> + *   is not needed.
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/platform_device.h>
> +
> +#include <mach/map.h>
> +#include <plat/regs-timer.h>
> +#include <asm/mach/time.h>
> +
> +#define PWM_EVENT	(3)
> +#define PWM_SOURCE	(4)
> +
> +#define ONESHOT		(0)
> +#define PERIODIC	(1)
> +
> +#define TCNT_MAX	(0xffffffff)
> +
> +static struct clk *timerclk;
> +
> +/*
> + * PWM timers setup code
> + */
> +
> +static inline void s3c64xx_pwm_stop(unsigned int pwm_id)
> +{
> +	unsigned long tcon = __raw_readl(S3C2410_TCON);
> +
> +	switch (pwm_id) {
> +	case 3:
> +		tcon &= ~S3C2410_TCON_T3START;
> +		break;
> +	case 4:
> +		tcon &= ~S3C2410_TCON_T4START;
> +		break;
> +	}
> +
> +	__raw_writel(tcon, S3C2410_TCON);
> +}
> +
> +static inline void s3c64xx_pwm_init(unsigned int pwm_id, unsigned long
tcnt)
> +{
> +	unsigned long tcon = __raw_readl(S3C2410_TCON);
> +
> +	/* timers reload after counting zero, so reduce the count by 1 */
> +	--tcnt;
> +
> +	/* stop the timer and ask it to load the new value */
> +	switch (pwm_id) {
> +	case 3:
> +		tcon &= ~(0xf<<16);
> +		tcon |= S3C2410_TCON_T3MANUALUPD;
> +		break;
> +	case 4:
> +		tcon &= ~(7<<20);
> +		tcon |= S3C2410_TCON_T4MANUALUPD;
> +		break;
> +	}
> +
> +	__raw_writel(tcnt, S3C2410_TCNTB(pwm_id));
> +	__raw_writel(tcnt, S3C2410_TCMPB(pwm_id));
> +	__raw_writel(tcon, S3C2410_TCON);
> +}
> +
> +static inline void s3c64xx_pwm_start(unsigned int pwm_id, bool periodic)
> +{
> +	unsigned long tcon = __raw_readl(S3C2410_TCON);
> +
> +	switch (pwm_id) {
> +	case 3:
> +		tcon |= S3C2410_TCON_T3START;
> +		tcon &= ~S3C2410_TCON_T3MANUALUPD;
> +
> +		if (periodic)
> +			tcon |= S3C2410_TCON_T3RELOAD;
> +		else
> +			tcon &= ~S3C2410_TCON_T3RELOAD;
> +		break;
> +	case 4:
> +		tcon |= S3C2410_TCON_T4START;
> +		tcon &= ~S3C2410_TCON_T4MANUALUPD;
> +
> +		if (periodic)
> +			tcon |= S3C2410_TCON_T4RELOAD;
> +		else
> +			tcon &= ~S3C2410_TCON_T4RELOAD;
> +		break;
> +	}
> +
> +	__raw_writel(tcon, S3C2410_TCON);
> +}
> +
> +/*
> + * Clock event
> + */
> +
> +static struct clk *event_in;
> +static struct clk *event_div;
> +
> +static unsigned long clock_count_per_tick;
> +
> +static int s3c64xx_clock_event_set_next_event(unsigned long cycles,
> +						struct clock_event_device
> *evt)
> +{
> +	s3c64xx_pwm_init(PWM_EVENT, cycles);
> +	s3c64xx_pwm_start(PWM_EVENT, ONESHOT);
> +	return 0;
> +}
> +
> +static void s3c64xx_clock_event_resume(void)
> +{
> +	unsigned long pclk;
> +	struct clk *tscaler;
> +
> +	pclk = clk_get_rate(timerclk);
> +	tscaler = clk_get_parent(event_div);
> +	clk_set_rate(tscaler, pclk / 3);
> +
> +	clk_set_rate(event_div, pclk / 6);
> +	clk_set_parent(event_in, event_div);
> +
> +	s3c64xx_pwm_init(PWM_EVENT, clock_count_per_tick);
> +	s3c64xx_pwm_start(PWM_EVENT, PERIODIC);
> +}
> +
> +static void s3c64xx_clock_event_set_mode(enum clock_event_mode mode,
> +						struct clock_event_device
> *evt)
> +{
> +	s3c64xx_pwm_stop(PWM_EVENT);
> +
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		s3c64xx_pwm_init(PWM_EVENT, clock_count_per_tick);
> +		s3c64xx_pwm_start(PWM_EVENT, PERIODIC);
> +		break;
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		break;
> +	case CLOCK_EVT_MODE_UNUSED:
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +		break;
> +	case CLOCK_EVT_MODE_RESUME:
> +		s3c64xx_clock_event_resume();
> +		break;
> +	}
> +}
> +
> +static struct clock_event_device s3c64xx_clock_event_device = {
> +	.name		= "s3c64xx_clkevt",
> +	.features       = CLOCK_EVT_FEAT_PERIODIC |
> CLOCK_EVT_FEAT_ONESHOT,
> +	.rating		= 200,
> +	.shift		= 32,
> +	.set_next_event	= s3c64xx_clock_event_set_next_event,
> +	.set_mode	= s3c64xx_clock_event_set_mode,
> +};
> +
> +static irqreturn_t s3c64xx_clock_event_isr(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = &s3c64xx_clock_event_device;
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irqaction s3c64xx_clock_event_irq = {
> +	.name		= "s3c64xx_clkevt_irq",
> +	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
> +	.handler	= s3c64xx_clock_event_isr,
> +};
> +
> +static void __init s3c64xx_clock_event_init(void)
> +{
> +	unsigned long clock_rate;
> +
> +	clock_rate = clk_get_rate(event_in);
> +
> +	clock_count_per_tick = clock_rate / HZ;
> +
> +	s3c64xx_clock_event_device.mult = div_sc(clock_rate,
> +			NSEC_PER_SEC, s3c64xx_clock_event_device.shift);
> +	s3c64xx_clock_event_device.max_delta_ns =
> +			clockevent_delta2ns(-1,
&s3c64xx_clock_event_device);
> +	s3c64xx_clock_event_device.min_delta_ns =
> +			clockevent_delta2ns(1, &s3c64xx_clock_event_device);
> +
> +	s3c64xx_clock_event_device.cpumask = cpumask_of(0);
> +	clockevents_register_device(&s3c64xx_clock_event_device);
> +
> +	setup_irq(IRQ_TIMER3, &s3c64xx_clock_event_irq);
> +}
> +
> +/*
> + * Clock source
> + */
> +
> +static struct clk *source_in;
> +static struct clk *source_div;
> +
> +static cycle_t s3c64xx_clocksource_read(struct clocksource *cs)
> +{
> +	return (cycle_t) ~__raw_readl(S3C2410_TCNTO(PWM_SOURCE));
> +}
> +
> +static void s3c64xx_clocksource_resume(struct clocksource *cs)
> +{
> +	unsigned long pclk;
> +	struct clk *tscaler;
> +
> +	pclk = clk_get_rate(timerclk);
> +	tscaler = clk_get_parent(source_div);
> +	clk_set_rate(tscaler, pclk / 3);
> +
> +	clk_set_rate(source_div, pclk / 6);
> +	clk_set_parent(source_in, source_div);
> +
> +	s3c64xx_pwm_init(PWM_SOURCE, TCNT_MAX);
> +	s3c64xx_pwm_start(PWM_SOURCE, PERIODIC);
> +}
> +
> +static struct clocksource pwm_clocksource = {
> +	.name		= "s3c64xx_clksrc",
> +	.rating		= 250,
> +	.read		= s3c64xx_clocksource_read,
> +	.mask		= CLOCKSOURCE_MASK(32),
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.resume		= s3c64xx_clocksource_resume,
> +};
> +
> +static void __init s3c64xx_clocksource_init(void)
> +{
> +	unsigned long clock_rate;
> +
> +	clock_rate = clk_get_rate(source_in);
> +
> +	s3c64xx_pwm_init(PWM_SOURCE, TCNT_MAX);
> +	s3c64xx_pwm_start(PWM_SOURCE, PERIODIC);
> +
> +	if (clocksource_register_hz(&pwm_clocksource, clock_rate))
> +		panic("%s: can't register clocksource\n",
> pwm_clocksource.name);
> +}
> +
> +static void __init s3c64xx_timer_init_common(void)
> +{
> +	struct platform_device tmpdev;
> +	unsigned long pclk;
> +	struct clk *tscaler;
> +
> +	tmpdev.dev.bus = &platform_bus_type;
> +
> +	timerclk = clk_get(NULL, "timers");
> +	if (IS_ERR(timerclk))
> +		panic("failed to get timers clock for system timer");
> +
> +	tmpdev.id = PWM_EVENT;
> +	event_in = clk_get(&tmpdev.dev, "pwm-tin");
> +	if (IS_ERR(event_in))
> +		panic("failed to get pwm-event_in clock for system timer");
> +
> +	event_div = clk_get(&tmpdev.dev, "pwm-tdiv");
> +	if (IS_ERR(event_div))
> +		panic("failed to get pwm-event_div clock for system timer");
> +
> +	tmpdev.id = PWM_SOURCE;
> +	source_in = clk_get(&tmpdev.dev, "pwm-tin");
> +	if (IS_ERR(source_in))
> +		panic("failed to get pwm-source_in clock for system timer");
> +
> +	source_div = clk_get(&tmpdev.dev, "pwm-tdiv");
> +	if (IS_ERR(source_div))
> +		panic("failed to get pwm-source_div clock for system
timer");
> +
> +	pclk = clk_get_rate(timerclk);
> +	tscaler = clk_get_parent(event_div);
> +	clk_set_rate(tscaler, pclk / 3);
> +
> +	clk_set_rate(event_div, pclk / 6);
> +	clk_set_parent(event_in, event_div);
> +
> +	clk_set_rate(source_div, pclk / 6);
> +	clk_set_parent(source_in, source_div);
> +
> +	clk_enable(timerclk);
> +	clk_enable(event_in);
> +	clk_enable(source_in);
> +}
> +
> +static void __init s3c64xx_timer_init(void)
> +{
> +	s3c64xx_timer_init_common();
> +	s3c64xx_clock_event_init();
> +	s3c64xx_clocksource_init();
> +}
> +
> +struct sys_timer s3c64xx_timer = {
> +	.init		= s3c64xx_timer_init,
> +};
> diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-
> samsung/include/plat/cpu.h
> index c0a5741..e1fcad0 100644
> --- a/arch/arm/plat-samsung/include/plat/cpu.h
> +++ b/arch/arm/plat-samsung/include/plat/cpu.h
> @@ -74,6 +74,13 @@ extern struct syscore_ops s3c2416_pm_syscore_ops;
>  extern struct syscore_ops s3c244x_pm_syscore_ops;
>  extern struct syscore_ops s3c64xx_irq_syscore_ops;
> 
> +/* timer for 64xx */
> +#ifdef CONFIG_S3C64XX_GENERIC_CLOCKEVENTS
> +extern struct sys_timer s3c64xx_timer;
> +#else
> +#define s3c64xx_timer s3c24xx_timer
> +#endif
> +
>  /* system device classes */
> 
>  extern struct sysdev_class s3c2410_sysclass;
> --
> 1.7.6.1

Hi Tomasz Figa,

Sorry for late response, probably I'm missing this......and I couldn't
review this in detail :(

But as you know above mach-s3c64xx/time.c is similar with
plat-s5p/s5p-time.c so I'd prefer that you could consolidate them,
samsung_timer into plat-samsung directory. In addition, if you need to
implement SoC specific feature, you can use soc_is_xxxx() like
soc_is_s3c64xx() there.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
