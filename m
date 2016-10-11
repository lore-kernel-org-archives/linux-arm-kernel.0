From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 11 Oct 2016 09:58:51 +0900
Subject: [GIT PULL 1/3] ARM: soc: exynos: Drivers for v4.9
In-Reply-To: <50A42280-0A39-44E3-8E35-C24031EB4DF0@gmail.com>
References: <1474216788-17282-1-git-send-email-krzk@kernel.org>
 <1474216788-17282-2-git-send-email-krzk@kernel.org>
 <2663426.T8oUku18qe@wuerfel> <20160919155302.GA4447@kozik-book>
 <CAOesGMgSu=bfVwWYkEG0+eDKBxh_zqSM0uxFAq3Y3X-O0vLGKQ@mail.gmail.com>
 <20161003074825.GA2724@kozik-lap>
 <53745281-AF17-4A3A-8BB5-63EED3563298@gmail.com>
 <CGME20161011004655epcas2p32d799fa4820430f044393375a9db3438@epcas2p3.samsung.com>
 <50A42280-0A39-44E3-8E35-C24031EB4DF0@gmail.com>
Message-ID: <001d01d2235a$a43289d0$ec979d70$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:

- Krzysztof's samsung email because he is not using now

> 
> 2016. 10. 3. 21:19 Kukjin Kim <kgene.kim@gmail.com> wrote:
> 
> + my samsung email
> 
> > 2016. 10. 3. 15:48 Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> >>>> On Sun, Oct 02, 2016 at 05:25:07PM -0700, Olof Johansson wrote:
> >>>>> On Mon, Sep 19, 2016 at 8:53 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>>>>> On Mon, Sep 19, 2016 at 05:02:40PM +0200, Arnd Bergmann wrote:
> >>>>>> On Sunday, September 18, 2016 6:39:46 PM CEST Krzysztof Kozlowski wrote:
> >>>>>> Samsung drivers/soc update for v4.9:
> >>>>>> 1. Allow compile testing of exynos-mct clocksource driver on ARM64.
> >>>>>> 2. Document Exynos5433 PMU compatible (already used by clkout
> >>>>>> driver and more  will be coming soon).
> >>>>>
> >>>>> Pulled into next/drivers, thanks
> >>>>>
> >>>>> Just for my understanding: why do we need the exynos-mct driver on
> >>>>> ARM64 but not the delay-timer portion of it?
> >>>>
> >>>> I think we want all of it but Doug's optimization 3252a646aa2c
> >>>> ("clocksource: exynos_mct: Only use 32-bits where possible") is not
> >>>> ARM64 friendly. One way of dealing with it would be to prepare two
> >>>> versions of exynos4_read_current_timer(). One reading only lower
> >>>> 32-bit value for ARMv7 and second (slow) reading lower and upper for ARMv8.
> >>>>
> >>>>>
> >>>>> Is there an advantage in using MCT over the architected timer on
> >>>>> these chips? If so, should we also have a way to use it as the delay timer?
> >>>>
> >>>> No, there is no real advantage... except that the SoC has some
> >>>> interesting "characteristics"... The timers are tightly coupled.
> >>>> Very tightly. I spent a lot of time and failed to boot my ARMv8
> >>>> board without some MCT magic.
> >>>
> >>> What kind of magic is that?
> >>
> >> Most notably: the arch timer starts when MCT forward running counter
> >> starts. Without kicking MCT, the arch timer seems to be frozen.
> >>
> >>> I can understand that needing the MCT for some system-level timer
> >>> functionality might be true (wakeups, etc),

Yes correct, the MCT is designed for the power consumption related
functionalities such as cluster power down

> >>> but for system
> >>> timesource avoiding the MMIO timer and using the arch ones is a
> >>> substantial performance improvement for gettimeofday() and friends.
> >>>

At this moment, we can use the ARM arch timers as clocksource so I think
no performance degradation (some latency?) with using the CP15 access for
the gettimeofday() and friends

> >>> There was extensive discussion last year over using arch timers on
> >>> 5420/5422, and it fizzled out with vague comments about something
> >>> not working right between A15/A7 on b.L. hardware.

Current Exynos SoCs including ARMv8 architecture based have no hardware
something which means 'not working right'

> >>> I'm presuming
> >>> whatever implementation details of that SoC has since been fixed on
> >>> later chips (including v8). Any chance you can confirm? It'd be very
> >>> nice to leave MCT behind on v8 as a system time source.

It is depending on system level design architecture. If we don't need to
support some power mode such as cluster power down, we can use arch timers
without the MCT but actual product needed to support it for power consumption.

Let me add some comments.
According to the ARM architecture design, the ARM arch timers require toggle
from outside of the core as timer source and we're using the MCT for it. And
we can use the ARM arch timers as clocksource not the MCT on current Exynos.

> >> Unfortunately, I cannot confirm this, at least on Exynos5433 (ARMv8).
> >> I played with arch and MCT timers on it and failed to get the
> >> arch-timer-only setup working. I did not have access to newer Exynos
> >> designs (Exynos 7) so I do not know how it works there.
> >
> > Hi guys,
> >
> > I know what Olof want to know and actually several days ago someone asked me about that. As you guys
> talked, a couple of years ago there were some discussions...BTW I need to contact to hardware designer
> before let you guys know because something needs to be confirmed by them even I know roughly.
> >
> > Note I'm in vacation with my family. Will be back on this in several days with exact information.
> >
> > BRs,
> > Kukjin

k-gene
