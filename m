From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jul 2012 09:57:47 +0100
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay
 implementation to be selected
In-Reply-To: <4FFF8509.2050302@renesas.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
 <4FFE7DB2.4040702@renesas.com>
 <20120712084432.GA2816@mudshark.cambridge.arm.com>
 <4FFE9A69.3060301@renesas.com> <4FFEFDE3.5000403@codeaurora.org>
 <4FFF8509.2050302@renesas.com>
Message-ID: <20120713085746.GA18079@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 03:16:41AM +0100, Shinya Kuribayashi wrote:
> On 7/13/2012 1:40 AM, Stephen Boyd wrote:
> >>>> As a result, actual udelay()s may be toooo long than expected, in
> >>>> particular udelay()s used between init_current_timer_delay() and
> >>>> calibrate_delay().  It's unlikely be short, as the frequency of a
> >>>> counter for read_current_timer is typically slower than CPU frequency.
> >>> Surely using udelay before calibrate_delay_loop has been called is a
> >>> fundamental error?
> >> Got it.  I'm just not confident about disallowing early use of udelay().
> >>
> > 
> > I don't think it's an error. Instead you get a very large delay, similar
> > to what would happen if you called udelay() before calibrate_delay()
> > anyway (see the comment in init/main.c above loops_per_jiffy).

Interesting, I didn't notice it was initialised to 4k, so yes I suppose you
could make use of some sort of delay. I don't think it's necessarily `very
large' though -- anything ticking at over ~400KHz with HZ=100 would give you
a smaller delay.

> Thanks, so I'd set up loops_per_jiffy early, along with lpj_fine in
> init_current_timer_delay().

That should work, providing you can get a sensible initial estimate for
loops_per_jiffy.

Will
