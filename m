From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Jan 2011 12:11:21 +0000
Subject: [PATCH V2] ARM: S5PV310: Implement kernel timers using MCT
In-Reply-To: <019e01cbae63$2511a5e0$6f34f1a0$%kim@samsung.com>
References: <1294107527-27915-1-git-send-email-kgene.kim@samsung.com>
	<20110106155358.GH31708@n2100.arm.linux.org.uk>
	<019e01cbae63$2511a5e0$6f34f1a0$%kim@samsung.com>
Message-ID: <20110107121121.GR31708@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 07, 2011 at 09:05:11PM +0900, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> > 
> > On Tue, Jan 04, 2011 at 11:18:47AM +0900, Kukjin Kim wrote:
> > > From: Changhwan Youn <chaos.youn@samsung.com>
> > >
> > > The Multi-Core Timer(MCT) of S5PV310 is designed for implementing
> > > clock source timer and clock event timers. This patch implements
> > > 1 clock source timer with 64 bit free running counter of MCT and
> > > 2 clock event timers with two of 31-bit tick counters.
> > 
> > I want to wait until after this merge window before commenting too much
> > on this; some of this patch will be impacted by changes in this merge
> > window.
> > 
> Hmmm...Ok, I understood.

That stuff is now in mainline - not only the new sched_clock() support
but also the SMP changes (which impact on your MCT code.)  Please rebase
on latest mainline and re-send.

> > > +static void s5pv310_frc_suspend(struct clocksource *cs)
> > > +{
> > > +	time_suspended = s5pv310_frc_read(cs);
> > > +};
> > > +
> > > +static void s5pv310_frc_resume(struct clocksource *cs)
> > > +{
> > > +	s5pv310_mct_frc_start((u32)(time_suspended >> 32),
> > (u32)time_suspended);
> > > +};
> > 
> > Is this something which other clocksource drivers need to do, or does the
> > core automatically deal with the clocksource being irregular across a
> > suspend/resume event?
> > 
> Normally this is not necessary because core deals with the irregularity of
> clocksource, but for sched_clock() implementation, clocksource had better be
> regular across a suspend/resume event. One example is "Show timing
> information on printks" kernel configuration. Without this code, timing
> information resets after suspend/resume event.
> 
> Following is not submitted but will be submitted :-)
> 
> unsigned long long sched_clock(void)
> {
> 	struct clocksource *cs = &mct_frc;
> 
> 	return clocksource_cyc2ns(cs->read(NULL), sched_mult, sched_shift);
> }

Please use the new sched_clock stuff which guarantees to return a 64-bit
cycle count (which is what sched_clock() is required to do.)
