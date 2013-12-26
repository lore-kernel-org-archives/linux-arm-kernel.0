From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 26 Dec 2013 10:22:54 -0800
Subject: [PATCH v3 1/3] clocksource: timer-keystone: introduce
 clocksource driver for Keystone
In-Reply-To: <1387974724-31138-2-git-send-email-ivan.khoronzhuk@ti.com>
References: <1387974724-31138-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1387974724-31138-2-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <20131226182254.GG31766@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/25, Ivan Khoronzhuk wrote:
> +
> +	/* enable timer interrupts */
> +	keystone_timer_writel(INTCTLSTAT_ENINT_MASK, INTCTLSTAT);
> +
> +	error = request_irq(irq, keystone_timer_interrupt, IRQF_TIMER,
> +			    TIMER_NAME, event_dev);
> +	if (error) {
> +		pr_err("%s: failed to setup irq\n", __func__);
> +		goto err;
> +	}
> +
> +	/* setup clockevent */
> +	event_dev->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> +	event_dev->set_next_event = keystone_set_next_event;
> +	event_dev->set_mode = keystone_set_mode;
> +	event_dev->cpumask = cpu_all_mask;
> +	event_dev->owner = THIS_MODULE;
> +	event_dev->name = TIMER_NAME;
> +	event_dev->irq = irq;
> +
> +	clockevents_config_and_register(event_dev, rate, 1, ULONG_MAX);
> +

I hope you don't get an interrupt before you register the
clockevent. You might want to reorder the interrupt request and
the clockevent registration so that it isn't a problem. Other
than that you can have my

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
