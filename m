From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 6 Dec 2017 12:05:03 +0100
Subject: [PATCH v2 5/5] rtc: add mxc driver for i.MX53 SRTC
In-Reply-To: <20171205140646.30367-6-linux-kernel-dev@beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-6-linux-kernel-dev@beckhoff.com>
Message-ID: <20171206110503.GO21780@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2017 at 15:06:46 +0100, linux-kernel-dev at beckhoff.com wrote:
> +/* This function is the RTC interrupt service routine. */
> +static irqreturn_t mxc_rtc_interrupt(int irq, void *dev_id)
> +{
> +	struct platform_device *pdev = dev_id;
> +	struct mxc_rtc_data *pdata = platform_get_drvdata(pdev);
> +	void __iomem *ioaddr = pdata->ioaddr;
> +	unsigned long flags;
> +	u32 events = 0;
> +	u32 lp_status;
> +	u32 lp_cr;
> +
> +	spin_lock_irqsave(&pdata->lock, flags);
> +	if (clk_prepare_enable(pdata->clk)) {
> +		spin_unlock_irqrestore(&pdata->lock, flags);
> +		return IRQ_NONE;
> +	}
> +
> +	lp_status = readl(ioaddr + SRTC_LPSR);
> +	lp_cr = readl(ioaddr + SRTC_LPCR);
> +
> +	/* update irq data & counter */
> +	if (lp_status & SRTC_LPSR_ALP) {
> +		if (lp_cr & SRTC_LPCR_ALP)
> +			events = (RTC_AF | RTC_IRQF);

I would just call rtc_update_irq here...

> +
> +		/* disable further lp alarm interrupts */
> +		lp_cr &= ~(SRTC_LPCR_ALP | SRTC_LPCR_WAE);
> +	}
> +
> +	/* Update interrupt enables */
> +	writel(lp_cr, ioaddr + SRTC_LPCR);
> +
> +	/* clear interrupt status */
> +	writel(lp_status, ioaddr + SRTC_LPSR);
> +
> +	mxc_rtc_sync_lp_locked(ioaddr);
> +	rtc_update_irq(pdata->rtc, 1, events);

... because calling it here with events == 0 will result in a lot of
work for nothing (the core will walk through the timers and set the
alarm again).


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
