From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 18 Jan 2011 19:52:32 +0100
Subject: [RFC 1/2] AT91: Support SAM9260 and SAM9G20-based boards in
	the same kernel image
In-Reply-To: <4D35CB56.8070603@xenomai.org>
References: <1295113835-6776-1-git-send-email-albin.tonnerre@free-electrons.com>
	<20110117075738.GI14798@game.jcrosoft.org>
	<20110118070016.GA9605@pc-ran3241>
	<20110118150030.GO14798@game.jcrosoft.org>
	<20110118153241.GE9719@n2100.arm.linux.org.uk>
	<4D35CB56.8070603@xenomai.org>
Message-ID: <20110118185232.GU14798@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:18 Tue 18 Jan     , Gilles Chanteperdrix wrote:
> Russell King - ARM Linux wrote:
> > On Tue, Jan 18, 2011 at 04:00:30PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >> this idea is to do not have CONFIG_ARCH_AT91SAM9G20 anymore only 9260
> >>
> >> and detect it
> >>
> >> but the man issue is the CLOCK_TICK_RATE which is different between both of
> >> them except if we use a common one for those soc or the sam9/11 we could not
> >> put them in the same kernel
> > 
> > If you switch to clocksource/clockevents, then I think CLOCK_TICK_RATE
> > is irrelevant as time advances according to the interval measured by
> > the previous and current clocksource read, rather than 1/HZ intervals.
> > 
> > However, I'm never happy to say "just set CLOCK_TICK_RATE to some random
> > value that's a multiple of HZ" because I can't convince myself that these
> > don't have any effect when using clocksources.  The list of symbols which
> > depend on CLOCK_TICK_RATE are:
> > 
> > ACTHZ
> > LATCH
> > TICK_NSEC
> > TICK_USEC_TO_NSEC
> > LOW_RES_NSEC
> > MONOTONIC_RES_NSEC
> > NSEC_PER_JIFFY
> > KTIME_LOW_RES
> > 
> > and if you grep for those outside of arch/, you find them being used in
> > a fair amount of code under kernel/, as well as the odd driver here and
> > there.
> 
> at91rm9200_time.c even seems to use LATCH, even though the clockevent
> frequency is not explicitly set to CLOCK_TICK_RATE.
we can fix it but the main idea is to allow the sam9/11 to be compiled
together in the same kernel
and the rm9200 is not a arm926ejs but a arm920t.

So the issue is not really important for this possiblity

Best Regards,
J.
