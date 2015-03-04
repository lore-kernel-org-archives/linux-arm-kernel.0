From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Mar 2015 18:23:56 +0000
Subject: [PATCH v2 2/6] rtc: at91sam9: rework wakeup and interrupt handling
In-Reply-To: <1425287898-15093-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150304182356.GC22156@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Mon, Mar 02, 2015 at 09:18:14AM +0000, Boris Brezillon wrote:
> The IRQ line used by the RTC device is usually shared with the system timer
> (PIT) on at91 platforms.
> Since timers are registering their handlers with IRQF_NO_SUSPEND, we should
> expect being called in suspended state, and properly wake the system up
> when this is the case.
> 
> Set IRQF_COND_SUSPEND flag when registering the IRQ handler to inform
> irq core that it can safely be called while the system is suspended.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/rtc/rtc-at91sam9.c | 73 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 61 insertions(+), 12 deletions(-)

[...]

> +/*
> + * IRQ handler for the RTC
> + */
> +static irqreturn_t at91_rtc_interrupt(int irq, void *_rtc)
> +{
> +	struct sam9_rtc *rtc = _rtc;
> +	int ret;
> +
> +	spin_lock(&rtc->lock);
> +
> +	ret = at91_rtc_cache_events(rtc);
> +
> +	/* We're called in suspended state */
> +	if (rtc->suspended) {
> +		/* Mask irqs coming from this peripheral */
> +		rtt_writel(rtc, MR,
> +			   rtt_readl(rtc, MR) &
> +			   ~(AT91_RTT_ALMIEN | AT91_RTT_RTTINCIEN));
> +		/* Trigger a system wakeup */
> +		pm_system_wakeup();
> +	} else {
> +		at91_rtc_flush_events(rtc);
> +	}
> +
> +	spin_unlock(&rtc->lock);
> +
> +	return ret;

[...]

> @@ -421,7 +456,8 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  
>  	/* register irq handler after we know what name we'll use */
>  	ret = devm_request_irq(&pdev->dev, rtc->irq, at91_rtc_interrupt,
> -				IRQF_SHARED, dev_name(&rtc->rtcdev->dev), rtc);
> +			       IRQF_SHARED | IRQF_COND_SUSPEND,
> +			       dev_name(&rtc->rtcdev->dev), rtc);

To try to avoid thie getting cargo-culted, it's probably worth expanding
the comment to cover the IRQF_COND_SUSPEND usage. Something like:

	/* 
	 * Register irq handler after we know what name we'll use.
	 *
	 * The interrupt line may be shared with a timer (the PIT), so
	 * we must use IRQF_COND_SUSPEND and call pm_system_wakeup()
	 * when a genuine wakeup event occurs.
	 */

Otherwise this looks good to me.

Thanks,
Mark.
