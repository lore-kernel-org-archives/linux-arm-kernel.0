From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Apr 2012 08:53:05 +0200
Subject: [PATCH 25/40] ARM: imx: add common clock support for clk busy
In-Reply-To: <4F848301.4080607@codeaurora.org>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-26-git-send-email-s.hauer@pengutronix.de>
 <4F848301.4080607@codeaurora.org>
Message-ID: <20120411065305.GH3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 11:59:13AM -0700, Stephen Boyd wrote:
> On 04/10/12 06:45, Sascha Hauer wrote:
> > +static int clk_busy_wait(void __iomem *reg, u8 shift)
> > +{
> > +	unsigned long timeout = jiffies + msecs_to_jiffies(10);
> > +
> > +	while (readl_relaxed(reg) & (1 << shift))
> > +		if (time_after(jiffies, timeout))
> > +			return -ETIMEDOUT;
> > +
> > +	return 0;
> > +}
> 
> MSM also has a bit to poll to see if a clock is enabled or not, similar
> to this rate switch complete bit. Would it make sense to have another
> few clock ops like wait_for_enable(), wait_for_rate(),
> wait_for_disable()? Then you should be able to copy the basic divider
> ops and assign the wait ops and avoid the wrappers.

I think this won't work. What arguments would your wait_for_* functions
take?

> 
> Also, why are these drivers in arch/arm? Shouldn't we be putting all
> clock drivers into drivers/clk/ now?

The last time this topic came up this was not entirely clear. Personally
I do not have a preference.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
