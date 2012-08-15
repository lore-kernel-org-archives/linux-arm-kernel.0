From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Aug 2012 22:16:10 +0800
Subject: [rtc-linux] [PATCH v3] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <20120814170300.8f97afcf.akpm@linux-foundation.org>
References: <1342164663-31351-1-git-send-email-shawn.guo@linaro.org>
 <20120814170300.8f97afcf.akpm@linux-foundation.org>
Message-ID: <20120815141606.GA2457@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for looking at the patch, Andrew.

On Tue, Aug 14, 2012 at 05:03:00PM -0700, Andrew Morton wrote:
> On Fri, 13 Jul 2012 15:31:03 +0800
> Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > +static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
> > +{
> > +	unsigned long timeout = jiffies + msecs_to_jiffies(1);
> > +	unsigned long flags;
> > +	u32 lpcr;
> > +
> > +	spin_lock_irqsave(&data->lock, flags);
> > +
> > +	lpcr = readl(data->ioaddr + SNVS_LPCR);
> > +	if (enable)
> > +		lpcr |= SNVS_LPCR_SRTC_ENV;
> > +	else
> > +		lpcr &= ~SNVS_LPCR_SRTC_ENV;
> > +	writel(lpcr, data->ioaddr + SNVS_LPCR);
> > +
> > +	spin_unlock_irqrestore(&data->lock, flags);
> > +
> > +	while (1) {
> > +		lpcr = readl(data->ioaddr + SNVS_LPCR);
> > +
> > +		if (enable) {
> > +			if (lpcr & SNVS_LPCR_SRTC_ENV)
> > +				break;
> > +		} else {
> > +			if (!(lpcr & SNVS_LPCR_SRTC_ENV))
> > +				break;
> > +		}
> > +
> > +		if (time_after(jiffies, timeout))
> > +			return -ETIMEDOUT;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> The timeout code here is fragile.  If acquiring the spinlock takes more
> than a millisecond or if this thread gets interrupted or preempted then
> we could easily execute that loop just a single time, and fail.
> 
So what about moving the timeout initialization to right above the
while(1) loop?

> It would be better to retry a fixed number of times, say 1000?  That
> would take around 1 millisecond, but might be overkill.
> 
How long a 1000 times loop takes really depends on the cpu frequency,
right?

BTW, I have received the notification telling that the patch has been
applied on -mm tree.  So should I just send you an incremental patch
to address the comment?

-- 
Regards,
Shawn
