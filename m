From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 18 Jul 2015 10:12:03 +0200 (CEST)
Subject: [PATCH 1/3] clocksource: atmel-st: Remove irq handler when clock
 event is unused
In-Reply-To: <1437161608-26782-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1437161608-26782-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <alpine.DEB.2.11.1507180942360.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Jul 2015, Alexandre Belloni wrote:
> +static int atmel_st_request_irq(struct clock_event_device *dev)
> +{
> +	int ret;
> +
> +	if (clockevent_state_periodic(dev) || clockevent_state_oneshot(dev))
> +		return 0;
> +
> +	ret = request_irq(irq, at91rm9200_timer_interrupt,
> +			  IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
> +			  "at91_tick", regmap_st);
> +	if (ret) {
> +		pr_alert("Unable to setup IRQ\n");
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
>  static int clkevt32k_set_oneshot(struct clock_event_device *dev)
>  {
> +	int ret;
> +
>  	clkdev32k_disable_and_flush_irq();
>  
>  	/*
>  	 * ALM for oneshot irqs, set by next_event()
>  	 * before 32 seconds have passed.
>  	 */
> +	ret = atmel_st_request_irq(dev);

You cannot call request_irq() from interrupt disabled context. It
works during early boot because might_sleep() is not active then, but
if that happens during normal runtime it wont work.

Thanks,

	tglx
