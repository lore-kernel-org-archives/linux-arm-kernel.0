From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 17 Dec 2013 15:43:29 -0500
Subject: [PATCH v2 1/3] clocksource: timer-keystone: introduce clocksource
 driver for Keystone
In-Reply-To: <1387297337-25493-2-git-send-email-ivan.khoronzhuk@ti.com>
References: <1387297337-25493-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1387297337-25493-2-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <52B0B771.70008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 December 2013 11:22 AM, Ivan Khoronzhuk wrote:
> Add broadcast clock-event device for the Keystone arch.
> 
> The timer can be configured as a general-purpose 64-bit timer,
> dual general-purpose 32-bit timers. When configured as dual 32-bit
> timers, each half can operate in conjunction (chain mode) or
> independently (unchained mode) of each other.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
>  drivers/clocksource/Makefile         |    1 +
>  drivers/clocksource/timer-keystone.c |  233 ++++++++++++++++++++++++++++++++++
>  2 files changed, 234 insertions(+)
>  create mode 100644 drivers/clocksource/timer-keystone.c
> 
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 33621ef..2acf3fc 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -36,3 +36,4 @@ obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
>  obj-$(CONFIG_ARM_GLOBAL_TIMER)		+= arm_global_timer.o
>  obj-$(CONFIG_CLKSRC_METAG_GENERIC)	+= metag_generic.o
>  obj-$(CONFIG_ARCH_HAS_TICK_BROADCAST)	+= dummy_timer.o
> +obj-$(CONFIG_ARCH_KEYSTONE)		+= timer-keystone.o
> diff --git a/drivers/clocksource/timer-keystone.c b/drivers/clocksource/timer-keystone.c
> new file mode 100644
> index 0000000..34c6ab8
> --- /dev/null
> +++ b/drivers/clocksource/timer-keystone.c
> @@ -0,0 +1,233 @@
> +/*
> + * Keystone broadcast clock-event
> + *
> + * Copyright 2013 Texas Instruments, Inc.
> + *
> + * Author: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +#define TIMER_NAME			"timer-keystone"
> +
> +/* Timer register offsets */
> +#define TIM12				0x10
> +#define TIM34				0x14
> +#define PRD12				0x18
> +#define PRD34				0x1c
> +#define TCR				0x20
> +#define TGCR				0x24
> +#define INTCTLSTAT			0x44
> +
> +/* Timer register bitfields */
> +#define TCR_ENAMODE_MASK		0xC0
> +#define TCR_ENAMODE_ONESHOT_MASK	0x40
> +#define TCR_ENAMODE_PERIODIC_MASK	0x80
> +
> +#define TGCR_TIM_UNRESET_MASK		0x03
> +#define INTCTLSTAT_ENINT_MASK		0x01
> +
> +/**
> + * struct keystone_timer: holds timer's data
> + * @base: timer memory base address
> + * @period: source clock rate
> + * @irqacrion: interrupt action descriptor
> + * @event_dev: event device based on timer
> + */
> +static struct keystone_timer {
> +	u64 hz_period;
> +	void __iomem *base;
> +	struct clock_event_device event_dev;
> +} timer;
> +
> +static inline u32 keystone_timer_readl(unsigned long rg)
> +{
> +	return readl_relaxed(timer.base + rg);
> +}
> +
> +static inline void keystone_timer_writel(u32 val, unsigned long rg)
> +{
> +	writel_relaxed(val, timer.base + rg);
> +}
> +
> +/**
> + * keystone_timer_config: configures timer to work in oneshot/periodic modes.
> + * @ mode: mode to configure
> + * @ period: cycles number to configure for
> + */
> +static int keystone_timer_config(u64 period, enum clock_event_mode mode)
> +{
> +	u32 tcr;
> +	u32 off;
> +
> +	tcr = keystone_timer_readl(TCR);
> +	off = tcr & ~(TCR_ENAMODE_MASK);
> +
> +	/* set enable mode */
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		tcr |= TCR_ENAMODE_ONESHOT_MASK;
> +		break;
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		tcr |= TCR_ENAMODE_PERIODIC_MASK;
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	/* disable timer */
> +	keystone_timer_writel(off, TCR);
> +	/* here we have to be sure the timer has been disabled */
> +	wmb();
> +
> +	/* reset counter to zero, set new period */
> +	keystone_timer_writel(0, TIM12);
> +	keystone_timer_writel(0, TIM34);
> +	keystone_timer_writel(period & 0xffffffff, PRD12);
> +	keystone_timer_writel(period >> 32, PRD34);
> +
> +	/* enable timer
> +	 * here we have to be sure that CNTLO, CNTHI, PRDLO, PRDHI registers
> +	 * have been written.
> +	 */
Comment style ?
/*
 *
 */

Other than the minor comment. The patch looks fine to me..
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
