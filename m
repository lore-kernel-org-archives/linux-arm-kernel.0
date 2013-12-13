From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 Dec 2013 17:42:02 -0800
Subject: [PATCH 1/3] clocksource: timer-keystone: introduce clocksource
 driver for Keystone
In-Reply-To: <1386784830-15863-2-git-send-email-ivan.khoronzhuk@ti.com>
References: <1386784830-15863-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1386784830-15863-2-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <52AA65EA.20902@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/13 10:00, Ivan Khoronzhuk wrote:
> diff --git a/drivers/clocksource/timer-keystone.c b/drivers/clocksource/timer-keystone.c
> new file mode 100644
> index 0000000..4a8083a
> --- /dev/null
> +++ b/drivers/clocksource/timer-keystone.c
[...]
> +#include <linux/interrupt.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +#define TIMER_NAME			"timer64-event"

Why not have keystone in the name? Or should this file be renamed?

> +
> +static inline u32 keystone_timer_readl(unsigned long rg)
> +{
> +	return readl(timer.base + rg);
> +}
> +
> +static inline void keystone_timer_writel(u32 val, unsigned long rg)
> +{
> +	writel(val, timer.base + rg);
> +}

It's probably better to use the relaxed variants here to avoid any
memory barriers that aren't necessary.

> +
> +static irqreturn_t keystone_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = &timer.event_dev;
> +
> +	evt->event_handler(evt);
> +	return IRQ_HANDLED;
> +}

Why not just pass the evt pointer via dev_id? That would be faster and
we want this function to be as fast as possible.

> +
> +static int keystone_set_next_event(unsigned long cycles,
> +				  struct clock_event_device *evt)
> +{
> +	return keystone_timer_config(cycles, evt->mode);
> +}
> +
> +static void keystone_set_mode(enum clock_event_mode mode,
> +			     struct clock_event_device *evt)
> +{
> +	u64 period;
> +
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		period = timer.clk_rate / (HZ);

Why not just store the period instead of calculating it here?

> +		keystone_timer_config(period, CLOCK_EVT_MODE_PERIODIC);
> +		break;
> +	case CLOCK_EVT_MODE_UNUSED:
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		keystone_timer_config(0, CLOCK_EVT_MODE_SHUTDOWN);
> +	default:
> +		break;
> +	}
> +}
> +
> +static void __init keystone_timer_init(struct device_node *np)
> +{
[...]
> +
> +	/* enable timer interrupts */
> +	keystone_timer_writel(INTCTLSTAT_ENINT_MASK, INTCTLSTAT);
> +
> +	keystone_timer_config(0, CLOCK_EVT_MODE_UNUSED);
> +
> +	/* init irqaction */
> +	irqaction->flags = IRQF_TIMER;
> +	irqaction->handler = keystone_timer_interrupt;
> +	irqaction->name = TIMER_NAME;
> +	irqaction->dev_id = (void *)&timer;
> +	error = setup_irq(irq, irqaction);
> +	if (error) {
> +		pr_err("%s: failed to setup irq\n", __func__);
> +		goto err;
> +	}

Why not use request_irq() here? This isn't called really early, is it?

> +
> +	/* setup clockevent */
> +	event_dev->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> +	event_dev->set_next_event = keystone_set_next_event;
> +	event_dev->set_mode = keystone_set_mode;
> +	event_dev->cpumask = cpu_all_mask;
> +	event_dev->owner = THIS_MODULE;
> +	event_dev->name = TIMER_NAME;

Please assign the irq here too.

> +
> +	clockevents_config_and_register(event_dev, rate, 1, ULONG_MAX);
> +
> +	pr_info("keystone timer clock @%lu Hz\n", rate);
> +	return;
> +err:
> +	clk_put(clk);
> +	iounmap(timer.base);
> +}
> +
> +CLOCKSOURCE_OF_DECLARE(keystone_timer, "ti,keystone-timer",
> +					keystone_timer_init);


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
