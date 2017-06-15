From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 Jun 2017 21:40:44 +0200
Subject: [PATCH] clockevents/tcb_clksrc: implement suspend/resume
In-Reply-To: <7100599f-529a-7d56-f43f-01513293d313@linaro.org>
References: <20170411154826.5883-1-alexandre.belloni@free-electrons.com>
 <7100599f-529a-7d56-f43f-01513293d313@linaro.org>
Message-ID: <20170615194044.6x6c6icnsrxgpscv@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/2017 at 21:13:36 +0200, Daniel Lezcano wrote:
> > +void tc_clksrc_resume(struct clocksource *cs)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < 3; i++) {
> 
> s/3/ARRAY_SIZE(tcb_cache)/
> 
> > +		__raw_writel(tcb_cache[i].cmr, tcaddr + ATMEL_TC_REG(i, CMR));
> 
> Why __raw_writel?
> 

Ok, I got to the bottom of that question and I think it is worth
answering it. __raw_{read,write}l were necessary to make the driver work
on AVR32, because its core is BE and the IP LE and the regular
readl/writel are (were) not doing the proper conversion.

This was supposed to be changed in a patch that was never applied:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331775.html

But everything is fine, as AVR32 is now removed from the kernel. I think
I'll switch the driver to regular readl/writel, using the _relaxed
version in the hot path. Is that fine for you?

I'll also do so in the rework if at some point we can agree on some
bindings, I'll try to address that soon too.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
