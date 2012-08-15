From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 14 Aug 2012 17:03:00 -0700
Subject: [rtc-linux] [PATCH v3] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <1342164663-31351-1-git-send-email-shawn.guo@linaro.org>
References: <1342164663-31351-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120814170300.8f97afcf.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jul 2012 15:31:03 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> +static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(1);
> +	unsigned long flags;
> +	u32 lpcr;
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +
> +	lpcr = readl(data->ioaddr + SNVS_LPCR);
> +	if (enable)
> +		lpcr |= SNVS_LPCR_SRTC_ENV;
> +	else
> +		lpcr &= ~SNVS_LPCR_SRTC_ENV;
> +	writel(lpcr, data->ioaddr + SNVS_LPCR);
> +
> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	while (1) {
> +		lpcr = readl(data->ioaddr + SNVS_LPCR);
> +
> +		if (enable) {
> +			if (lpcr & SNVS_LPCR_SRTC_ENV)
> +				break;
> +		} else {
> +			if (!(lpcr & SNVS_LPCR_SRTC_ENV))
> +				break;
> +		}
> +
> +		if (time_after(jiffies, timeout))
> +			return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}

The timeout code here is fragile.  If acquiring the spinlock takes more
than a millisecond or if this thread gets interrupted or preempted then
we could easily execute that loop just a single time, and fail.

It would be better to retry a fixed number of times, say 1000?  That
would take around 1 millisecond, but might be overkill.
