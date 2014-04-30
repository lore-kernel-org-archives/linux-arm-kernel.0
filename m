From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 30 Apr 2014 11:21:51 +0200
Subject: [PATCH] ARM: imx6q: work around faulty PMU irq routing
In-Reply-To: <CAHrpEqQ8C2ziWobckGHhZtu5Q0e_xQz7BncZnoUUX0WT96Sz1g@mail.gmail.com>
References: <1398371029-21176-1-git-send-email-l.stach@pengutronix.de>
 <5359F4AB.9090502@de.bosch.com>
 <1398417205.4657.10.camel@weser.hi.pengutronix.de>
 <20140429052824.GD16451@dragon>
 <1398765300.4677.8.camel@weser.hi.pengutronix.de>
 <535F8A2F.2060507@de.bosch.com>
 <CAHrpEqQ8C2ziWobckGHhZtu5Q0e_xQz7BncZnoUUX0WT96Sz1g@mail.gmail.com>
Message-ID: <1398849711.4653.3.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 29.04.2014, 13:33 -0500 schrieb Frank Li:
> On Tue, Apr 29, 2014 at 6:17 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> > On 29.04.2014 11:55, Lucas Stach wrote:
> >>
> >> Am Dienstag, den 29.04.2014, 13:28 +0800 schrieb Shawn Guo:
> >>>
> >>> On Fri, Apr 25, 2014 at 11:13:25AM +0200, Lucas Stach wrote:
> >>>>
> >>>> Am Freitag, den 25.04.2014, 07:37 +0200 schrieb Dirk Behme:
> >>>>>
> >>>>> On 24.04.2014 22:23, Lucas Stach wrote:
> >>>>>>
> >>>>>> The i.MX6 PMU has a design errata where the interrupts of all cores
> >>>>>> are
> >>>>>> wired together into a single irq line. To work around this we have to
> >>>>>> bounce the interrupt around all cores until we find the one where the
> >>>>>> PMU
> >>>>>> counter overflow has happened.
> >>>>>>
> >>>>>> This causes the perf measurements to be less accurate and we can't
> >>>>>> really
> >>>>>> handle the case where two cores fire a PMU irq at the same time. The
> >>>>>> implemented woraround makes perf at least somewhat useable on imx6
> >>>>>> SoCs
> >>>>>> with more than one core.
> >>>>>>
> >> [...]
> >>>>>
> >>>>> Do you have anything like a test case which shows that it works (at
> >>>>> least better) on a !single core with this patch? Compared to a
> >>>>> non-patched system?
> >>>>>
> >>>> Without this patch, running perf top completely kills the system on
> >>>> i.MX6q, most likely because of the sheer number of spurious interrupts
> >>>> hitting the system from 4 cores. Even the spurious killer doesn't work
> >>>> sometimes, so perf is completely busted right now.
> >>>>
> >>>> With this patch perf has to reduce the sample frequency in order to
> >>>> compensate the added irq latency, but at least we get some plausible
> >>>> numbers out. Though I won't take any blame if the amount of salt you
> >>>> have to apply while looking at those numbers is already a deadly
> >>>> dose. ;)
> >>>>
> >>>> I don't yet have any numbers on how accurate the measurement is, but at
> >>>> least things didn't look completely off.
> >>>
> >>>
> >>> If it cannot provide correct/accurate data, I'd say let's not fake it
> >>> to, and just let it be completely broken there, so that people can be
> >>> aware of the brokenness, and not take inaccurate data as accurate one.
> >>>
> >> The data isn't bogus, it just isn't as accurate as it could be with a
> >> properly working PMU. I'll run some tests with a defined load on
> >> Solo/Quad to see how far the measurements are off. I'm fine with holding
> >> this patch until then.
> >>
> >> But the thing is this patch also fixes a serious userspace triggerable
> >> DoS on i.MX6q. Just running perf top completely locks up the system
> >> because of the sheer number of stray irqs. This isn't the case anymore
> >> with this patch applied.
> 
> I am very strange. Why PMU can work because below errata?
> 
> ERR006259 ARM: Debug/trace functions (PMU, PTM and ETB) are disabled
> with absence of JTAG_TCK clock after POR
> 
> Default it should no any PMU irqs happen.

Hm, I wasn't aware of this errata and I have to say it confuses me a
bit, as contrary to what the errata claims the PMU is working just fine
on imx6 without a JTAG_TCK connected. I've just tested this on 3
different boards (2 of them imx6q, 1 imx6dl) and you can clearly see the
interrupt hitting.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
