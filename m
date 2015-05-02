From: peter.griffin@linaro.org (Peter Griffin)
Date: Sat, 2 May 2015 17:36:59 +0100
Subject: [PATCH 1/5] clocksource: st_lpc: Add LPC timer as a clocksource.
In-Reply-To: <alpine.DEB.2.11.1504211153580.13914@nanos>
References: <1429267823-8879-1-git-send-email-peter.griffin@linaro.org>
 <1429267823-8879-2-git-send-email-peter.griffin@linaro.org>
 <alpine.DEB.2.11.1504211153580.13914@nanos>
Message-ID: <20150502163659.GA23998@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Tue, 21 Apr 2015, Thomas Gleixner wrote:

> On Fri, 17 Apr 2015, Peter Griffin wrote:
> > +/* Low Power Timer */
> > +#define LPC_LPT_LSB_OFF		0x400
> > +#define LPC_LPT_MSB_OFF		0x404
> > +#define LPC_LPT_START_OFF	0x408
> > +
> > +struct st_lpc {
> > +	struct clk *clk;
> > +	void __iomem *iomem_cs;
> > +};
> > +
> > +static struct st_lpc *st_lpc;
> > +
> > +static u64 notrace st_lpc_counter_read(void)
> > +{
> > +	u64 counter;
> > +	u32 lower;
> > +	u32 upper, old_upper;
> > +
> > +	upper = readl_relaxed(st_lpc->iomem_cs + LPC_LPT_MSB_OFF);
> > +	do {
> > +		old_upper = upper;
> > +		lower = readl_relaxed(st_lpc->iomem_cs + LPC_LPT_LSB_OFF);
> > +		upper = readl_relaxed(st_lpc->iomem_cs + LPC_LPT_MSB_OFF);
> > +	} while (upper != old_upper);
> > +
> > +	counter = upper;
> > +	counter <<= 32;
> > +	counter |= lower;
> > +	return counter;
> 
> 
> What's the point of this exercise? The kernel can handle 32bit
> clocksources nicely. So why do you want to artificially expand them to
> 64bit by adding useless loops and hoops to a hotpath?

Thanks for reviewing, yes your correct, we don't really need to be
doing this. We will fix this in the v2 version.

Lee Jones has also pointed out something which I was not aware of when
submitting this, and that is this IP has shared registers with the RTC
driver.

He has been working on some patches here https://lkml.org/lkml/2015/4/9/609
which deal with configuring between watchdog and rtc and ensuring only one
can be configured at a time, and this driver should also be making use of
that mechanism.

As he is already working on this, we decided it would be best if he takes
over for the V2 submission, and aligns it with the work he has already done
for this IP.

regards,

Peter.
