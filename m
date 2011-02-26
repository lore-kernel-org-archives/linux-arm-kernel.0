From: kmpark@infradead.org (Kyungmin Park)
Date: Sat, 26 Feb 2011 13:31:18 +0900
Subject: [PATCH 1/3] ARM: S5P: Add s5p_timer support for HRT
In-Reply-To: <1298688357-20775-2-git-send-email-sbkim73@samsung.com>
References: <1298688357-20775-1-git-send-email-sbkim73@samsung.com>
	<1298688357-20775-2-git-send-email-sbkim73@samsung.com>
Message-ID: <AANLkTi=wz5cfWnZU2eP4r8pNqf=mACAm80oBUxYwz563@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 26, 2011 at 11:45 AM, Sangbeom Kim <sbkim73@samsung.com> wrote:
> This patch adds support HR-Timer(High Resolution Timer) and dynamic
> tick system for S5P SoCs. There are many clock sources for HR-Timer
> on S5P SoCs. The PWM timer, RTC, System Timer, and MCT can be used
> for clock source.
> This patch can only support PWM timer for clocksource of
> S5P64x0 and S5PV210.
>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> ---
> ?arch/arm/plat-s5p/Makefile ? ? ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/plat-s5p/include/plat/s5p-time.h | ? 37 +++
> ?arch/arm/plat-s5p/s5p-time.c ? ? ? ? ? ? ?| ?395 +++++++++++++++++++++++++++++
> ?3 files changed, 433 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/plat-s5p/include/plat/s5p-time.h
> ?create mode 100644 arch/arm/plat-s5p/s5p-time.c
>
> diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
> index 4bd5cf9..3b8cc2f 100644
> --- a/arch/arm/plat-s5p/Makefile
> +++ b/arch/arm/plat-s5p/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_S5P_GPIO_INT) ? ?+= irq-gpioint.o
> ?obj-$(CONFIG_S5P_SYSTEM_MMU) ? += sysmmu.o
> ?obj-$(CONFIG_PM) ? ? ? ? ? ? ? += pm.o
> ?obj-$(CONFIG_PM) ? ? ? ? ? ? ? += irq-pm.o
> +obj-$(CONFIG_GENERIC_CLOCKEVENTS) += s5p-time.o
>
> ?# devices
>
> diff --git a/arch/arm/plat-s5p/include/plat/s5p-time.h b/arch/arm/plat-s5p/include/plat/s5p-time.h
> new file mode 100644
> index 0000000..e478f0c
> --- /dev/null
> +++ b/arch/arm/plat-s5p/include/plat/s5p-time.h
> @@ -0,0 +1,37 @@
> +/* linux/arch/arm/plat-s5p/include/plat/s5p-time.h
> + *
> + * Copyright 2011 Samsung Electronics Co., Ltd.
> + * ? ? ? ? ? ? http://www.samsung.com/
> + *
> + * Header file for s5p time support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_PLAT_S5P_TIME_H
> +#define __ASM_PLAT_S5P_TIME_H __FILE__
> +
> +/* S5P HR-Timer Clock mode */
> +enum s5p_timer_mode {
> + ? ? ? S5P_PWM0,
> + ? ? ? S5P_PWM1,
> + ? ? ? S5P_PWM2,
> + ? ? ? S5P_PWM3,
> + ? ? ? S5P_PWM4,
> +};
> +
> +struct s5p_timer_source {
> + ? ? ? unsigned int event_id;
> + ? ? ? unsigned int source_id;
> +};
> +
> +#define TCNT_MAX ? ? ? ? ? ? ? 0xffffffff
> +#define NON_PERIODIC ? ? ? ? ? 0
> +#define PERIODIC ? ? ? ? ? ? ? 1
> +
> +extern void __init s5p_set_timer_source(enum s5p_timer_mode event,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? enum s5p_timer_mode source);
> +extern struct sys_timer s5p_timer;
> +#endif /* __ASM_PLAT_S5P_TIME_H */
> diff --git a/arch/arm/plat-s5p/s5p-time.c b/arch/arm/plat-s5p/s5p-time.c
> new file mode 100644
> index 0000000..4691728
> --- /dev/null
> +++ b/arch/arm/plat-s5p/s5p-time.c
> @@ -0,0 +1,395 @@
> +/* linux/arch/arm/plat-s5p/s5p-time.c
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + * ? ? ? ? ? ? http://www.samsung.com/
> + *
> + * S5P - Common hr-timer support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/sched.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/smp_twd.h>
> +#include <asm/mach/time.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include <mach/map.h>
> +#include <plat/regs-timer.h>
> +#include <plat/s5p-time.h>
> +
> +static struct clk *tin_event;
> +static struct clk *tin_source;
> +static struct clk *tdiv_event;
> +static struct clk *tdiv_source;
> +static struct clk *timerclk;
> +static struct s5p_timer_source timer_source;
> +static unsigned long clock_count_per_tick;
> +static void s5p_timer_resume(void);
> +
> +static void s5p_time_stop(enum s5p_timer_mode mode)
> +{
> + ? ? ? unsigned long tcon;
> +
> + ? ? ? tcon = __raw_readl(S3C2410_TCON);
> +
> + ? ? ? switch (mode) {
> + ? ? ? case S5P_PWM0:
> + ? ? ? ? ? ? ? tcon &= ~S3C2410_TCON_T0START;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case S5P_PWM1:
> + ? ? ? ? ? ? ? tcon &= ~S3C2410_TCON_T1START;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case S5P_PWM2:
> + ? ? ? ? ? ? ? tcon &= ~S3C2410_TCON_T2START;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case S5P_PWM3:
> + ? ? ? ? ? ? ? tcon &= ~S3C2410_TCON_T3START;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case S5P_PWM4:
> + ? ? ? ? ? ? ? tcon &= ~S3C2410_TCON_T4START;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? default:
> + ? ? ? ? ? ? ? printk(KERN_ERR "Invalid Timer %d\n", mode);
> + ? ? ? ? ? ? ? break;
> + ? ? ? }
> + ? ? ? __raw_writel(tcon, S3C2410_TCON);
> +}
> +
> +static void s5p_time_setup(enum s5p_timer_mode mode, unsigned long tcnt)
> +{
> + ? ? ? unsigned long tcon;
> +
> + ? ? ? tcon = __raw_readl(S3C2410_TCON);
> +
> + ? ? ? tcnt--;
> +
> + ? ? ? switch (mode) {
> + ? ? ? case S5P_PWM0:
> + ? ? ? ? ? ? ? tcon &= ~(0x0f << 0);
> + ? ? ? ? ? ? ? tcon |= S3C2410_TCON_T0MANUALUPD;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case S5P_PWM1:
> + ? ? ? ? ? ? ? tcon &= ~(0x0f << 8);
> + ? ? ? ? ? ? ? tcon |= S3C2410_TCON_T1MANUALUPD;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case S5P_PWM2:
> + ? ? ? ? ? ? ? tcon &= ~(0x0f << 0x0c);
> + ? ? ? ? ? ? ? tcon |= S3C2410_TCON_T2MANUALUPD;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case S5P_PWM3:
> + ? ? ? ? ? ? ? tcon &= ~(0xf << 0x10);
> + ? ? ? ? ? ? ? tcon |= S3C2410_TCON_T3MANUALUPD;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case S5P_PWM4:
> + ? ? ? ? ? ? ? tcon &= ~(7 << 0x14);
> + ? ? ? ? ? ? ? tcon |= S3C2410_TCON_T4MANUALUPD;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? default:
> + ? ? ? ? ? ? ? printk(KERN_ERR "Invalid Timer %d\n", mode);
> + ? ? ? ? ? ? ? break;
> + ? ? ? }
> +
> + ? ? ? __raw_writel(tcnt, S3C2410_TCNTB(mode));
> + ? ? ? __raw_writel(tcnt, S3C2410_TCMPB(mode));
> + ? ? ? __raw_writel(tcon, S3C2410_TCON);
> +}
> +
> +static void s5p_time_start(enum s5p_timer_mode mode, bool periodic)
> +{
> + ? ? ? unsigned long tcon;
> +
> + ? ? ? tcon ?= __raw_readl(S3C2410_TCON);
> +
> + ? ? ? switch (mode) {
> + ? ? ? case S5P_PWM0:
> + ? ? ? ? ? ? ? tcon |= S3C2410_TCON_T0START;
> + ? ? ? ? ? ? ? tcon &= ~S3C2410_TCON_T0MANUALUPD;
> +
> + ? ? ? ? ? ? ? if (periodic)
> + ? ? ? ? ? ? ? ? ? ? ? tcon |= S3C2410_TCON_T0RELOAD;
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? tcon &= ~S3C2410_TCON_T0RELOAD;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case S5P_PWM1:
> + ? ? ? ? ? ? ? tcon |= S3C2410_TCON_T1START;
> + ? ? ? ? ? ? ? tcon &= ~S3C2410_TCON_T1MANUALUPD;
> +
> + ? ? ? ? ? ? ? if (periodic)
> + ? ? ? ? ? ? ? ? ? ? ? tcon |= S3C2410_TCON_T1RELOAD;
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? tcon &= ~S3C2410_TCON_T1RELOAD;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case S5P_PWM2:
> + ? ? ? ? ? ? ? tcon |= S3C2410_TCON_T2START;
> + ? ? ? ? ? ? ? tcon &= ~S3C2410_TCON_T2MANUALUPD;
> +
> + ? ? ? ? ? ? ? if (periodic)
> + ? ? ? ? ? ? ? ? ? ? ? tcon |= S3C2410_TCON_T2RELOAD;
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? tcon &= ~S3C2410_TCON_T2RELOAD;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case S5P_PWM3:
> + ? ? ? ? ? ? ? tcon |= S3C2410_TCON_T3START;
> + ? ? ? ? ? ? ? tcon &= ~S3C2410_TCON_T3MANUALUPD;
> +
> + ? ? ? ? ? ? ? if (periodic)
> + ? ? ? ? ? ? ? ? ? ? ? tcon |= S3C2410_TCON_T3RELOAD;
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? tcon &= ~S3C2410_TCON_T3RELOAD;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case S5P_PWM4:
> + ? ? ? ? ? ? ? tcon |= S3C2410_TCON_T4START;
> + ? ? ? ? ? ? ? tcon &= ~S3C2410_TCON_T4MANUALUPD;
> +
> + ? ? ? ? ? ? ? if (periodic)
> + ? ? ? ? ? ? ? ? ? ? ? tcon |= S3C2410_TCON_T4RELOAD;
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? tcon &= ~S3C2410_TCON_T4RELOAD;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? default:
> + ? ? ? ? ? ? ? printk(KERN_ERR "Invalid Timer %d\n", mode);
> + ? ? ? ? ? ? ? break;
> + ? ? ? }
> + ? ? ? __raw_writel(tcon, S3C2410_TCON);
> +}
> +
> +static int s5p_set_next_event(unsigned long cycles,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct clock_event_device *evt)
> +{
> + ? ? ? s5p_time_setup(timer_source.event_id, cycles);
> + ? ? ? s5p_time_start(timer_source.event_id, NON_PERIODIC);
> +
> + ? ? ? return 0;
> +}
> +
> +static void s5p_set_mode(enum clock_event_mode mode,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct clock_event_device *evt)
> +{
> +
> + ? ? ? s5p_time_stop(timer_source.event_id);
> +
> + ? ? ? switch (mode) {
> + ? ? ? case CLOCK_EVT_MODE_PERIODIC:
> + ? ? ? ? ? ? ? s5p_time_setup(timer_source.event_id, clock_count_per_tick);
> + ? ? ? ? ? ? ? s5p_time_start(timer_source.event_id, PERIODIC);
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case CLOCK_EVT_MODE_ONESHOT:
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case CLOCK_EVT_MODE_UNUSED:
> + ? ? ? case CLOCK_EVT_MODE_SHUTDOWN:
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case CLOCK_EVT_MODE_RESUME:
> + ? ? ? ? ? ? ? s5p_timer_resume();
> + ? ? ? ? ? ? ? break;
> + ? ? ? }
> +}
> +
> +static void s5p_timer_resume(void)
> +{
> + ? ? ? /* event timer restart */
> + ? ? ? s5p_time_setup(timer_source.event_id, clock_count_per_tick);
> + ? ? ? s5p_time_start(timer_source.event_id, PERIODIC);
> +
> + ? ? ? /* source timer restart */
> + ? ? ? s5p_time_setup(timer_source.source_id, TCNT_MAX);
> + ? ? ? s5p_time_start(timer_source.source_id, PERIODIC);
> +}
> +
> +void __init s5p_set_timer_source(enum s5p_timer_mode event,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?enum s5p_timer_mode source)
> +{
> + ? ? ? timer_source.event_id = event;
> + ? ? ? timer_source.source_id = source;
> +}
> +
> +static struct clock_event_device time_event_device = {
> + ? ? ? .name ? ? ? ? ? = "s5p_event_timer",
> + ? ? ? .features ? ? ? = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> + ? ? ? .rating ? ? ? ? = 200,
> + ? ? ? .shift ? ? ? ? ?= 32,
Please use the new clock event function. I can't remember the exact
function name, but there's function set the proper shift value instead
of hard-coded.
> + ? ? ? .set_next_event = s5p_set_next_event,
> + ? ? ? .set_mode ? ? ? = s5p_set_mode,
> +};
> +
> +static irqreturn_t s5p_clock_event_isr(int irq, void *dev_id)
> +{
> + ? ? ? struct clock_event_device *evt = &time_event_device;
> +
> + ? ? ? evt->event_handler(evt);
> +
> + ? ? ? return IRQ_HANDLED;
> +}
> +
> +static struct irqaction s5p_clock_event_irq = {
> + ? ? ? .name ? ? ? ? ? = "s5p_time_irq",
> + ? ? ? .flags ? ? ? ? ?= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
> + ? ? ? .handler ? ? ? ?= s5p_clock_event_isr,
> +};
> +
> +static void s5p_clockevent_init(void)

Please add __init since it's only used at __init function.
> +{
> + ? ? ? unsigned long pclk;
> + ? ? ? unsigned long clock_rate;
> + ? ? ? unsigned int irq_number;
> + ? ? ? struct clk *tscaler;
> +
> + ? ? ? pclk = clk_get_rate(timerclk);
> +
> + ? ? ? tscaler = clk_get_parent(tdiv_event);
> +
> + ? ? ? clk_set_rate(tscaler, pclk / 2);
> + ? ? ? clk_set_rate(tdiv_event, pclk / 2);
> + ? ? ? clk_set_parent(tin_event, tdiv_event);
> +
> + ? ? ? clock_rate = clk_get_rate(tin_event);
> + ? ? ? clock_count_per_tick = clock_rate / HZ;
> +
> + ? ? ? time_event_device.mult =
> + ? ? ? ? ? ? ? div_sc(clock_rate, NSEC_PER_SEC, time_event_device.shift);
> + ? ? ? time_event_device.max_delta_ns =
> + ? ? ? ? ? ? ? clockevent_delta2ns(-1, &time_event_device);
> + ? ? ? time_event_device.min_delta_ns =
> + ? ? ? ? ? ? ? clockevent_delta2ns(1, &time_event_device);
> +
> + ? ? ? time_event_device.cpumask = cpumask_of(0);
> + ? ? ? clockevents_register_device(&time_event_device);
> +
> + ? ? ? irq_number = timer_source.event_id + IRQ_TIMER0;
> +
> + ? ? ? setup_irq(irq_number, &s5p_clock_event_irq);
> +}
> +
> +static cycle_t s5p_timer_read(struct clocksource *cs)
> +{
> + ? ? ? unsigned long offset = 0;
> +
> + ? ? ? switch (timer_source.source_id) {
> + ? ? ? case S5P_PWM0:
> + ? ? ? case S5P_PWM1:
> + ? ? ? case S5P_PWM2:
> + ? ? ? case S5P_PWM3:
> + ? ? ? ? ? ? ? offset = (timer_source.source_id * 0x0c) + 0x14;
> + ? ? ? case S5P_PWM4:
> + ? ? ? ? ? ? ? offset = 0x40;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? default:
> + ? ? ? ? ? ? ? printk(KERN_ERR "Invalid Timer %d\n", timer_source.source_id);
> + ? ? ? ? ? ? ? return 0;
> + ? ? ? }
> +
> + ? ? ? return (cycle_t) ~__raw_readl(S3C_TIMERREG(offset));
> +}
> +
> +struct clocksource time_clocksource = {
> + ? ? ? .name ? ? ? ? ? = "s5p_clocksource_timer",
> + ? ? ? .rating ? ? ? ? = 250,
> + ? ? ? .read ? ? ? ? ? = s5p_timer_read,
> + ? ? ? .mask ? ? ? ? ? = CLOCKSOURCE_MASK(32),
> + ? ? ? .flags ? ? ? ? ?= CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +static void s5p_clocksource_init(void)
ditto.
> +{
> + ? ? ? unsigned long pclk;
> + ? ? ? unsigned long clock_rate;
> +
> + ? ? ? pclk = clk_get_rate(timerclk);
> +
> + ? ? ? clk_set_rate(tdiv_source, pclk / 2);
> + ? ? ? clk_set_parent(tin_source, tdiv_source);
> +
> + ? ? ? clock_rate = clk_get_rate(tin_source);
> +
> + ? ? ? s5p_time_setup(timer_source.source_id, TCNT_MAX);
> + ? ? ? s5p_time_start(timer_source.source_id, PERIODIC);
> +
> + ? ? ? if (clocksource_register_hz(&time_clocksource, clock_rate))
> + ? ? ? ? ? ? ? panic("%s: can't register clocksource\n", time_clocksource.name);
> +}
> +
> +static void __init s5p_timer_resources(void)
> +{
> + ? ? ? struct platform_device tmpdev;
> +
> + ? ? ? tmpdev.dev.bus = &platform_bus_type;
> +
> + ? ? ? timerclk = clk_get(NULL, "timers");
> + ? ? ? if (IS_ERR(timerclk))
> + ? ? ? ? ? ? ? panic("failed to get timers clock for system timer");
> +
> + ? ? ? clk_enable(timerclk);
> +
> + ? ? ? tmpdev.id = timer_source.event_id;
> + ? ? ? tin_event = clk_get(&tmpdev.dev, "pwm-tin");
> + ? ? ? if (IS_ERR(tin_event)) {
> + ? ? ? ? ? ? ? clk_put(tin_event);
> + ? ? ? ? ? ? ? panic("failed to get pwm-tin2 clock for system timer");
> + ? ? ? }
> +
> + ? ? ? tdiv_event = clk_get(&tmpdev.dev, "pwm-tdiv");
> + ? ? ? if (IS_ERR(tdiv_event)) {
> + ? ? ? ? ? ? ? clk_put(tdiv_event);
> + ? ? ? ? ? ? ? panic("failed to get pwm-tdiv2 clock for system timer");
> + ? ? ? }
> +
> + ? ? ? clk_enable(tin_event);
> +
> + ? ? ? tmpdev.id = timer_source.source_id;
> + ? ? ? tin_source = clk_get(&tmpdev.dev, "pwm-tin");
> + ? ? ? if (IS_ERR(tin_source)) {
> + ? ? ? ? ? ? ? clk_put(tin_source);
> + ? ? ? ? ? ? ? panic("failed to get pwm-tin4 clock for system timer");
> + ? ? ? }
> +
> + ? ? ? tdiv_source = clk_get(&tmpdev.dev, "pwm-tdiv");
> + ? ? ? if (IS_ERR(tdiv_source)) {
> + ? ? ? ? ? ? ? clk_put(tdiv_source);
> + ? ? ? ? ? ? ? panic("failed to get pwm-tdiv4 clock for system timer");
> + ? ? ? }
> +
> + ? ? ? clk_enable(tin_source);
> +}
> +
> +static void __init s5p_timer_init(void)
> +{
> +#ifdef CONFIG_LOCAL_TIMERS
> + ? ? ? twd_base = S5P_VA_TWD;
> +#endif
> +
> + ? ? ? s5p_timer_resources();
> + ? ? ? s5p_clockevent_init();
> + ? ? ? s5p_clocksource_init();
> +}
> +
> +struct sys_timer s5p_timer = {
> + ? ? ? .init ? ? ? ? ? = s5p_timer_init,
> +};
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
