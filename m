From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 8 Jul 2013 09:27:40 -0700
Subject: [PATCH] clocksource/cadence_ttc: Reuse clocksource as sched_clock
In-Reply-To: <alpine.DEB.2.02.1307051819530.32106@ionos.tec.linutronix.de>
References: <1372888216-10726-1-git-send-email-soren.brinkmann@xilinx.com>
 <alpine.DEB.2.02.1307050819000.11637@ionos.tec.linutronix.de>
 <fbeb6f36-f07a-4518-b6f2-0b8e36028fe9@CH1EHSMHS012.ehs.local>
 <alpine.DEB.2.02.1307051802560.32106@ionos.tec.linutronix.de>
 <e55e70b7-7e63-4718-ad48-f5d4479b5326@DB9EHSMHS006.ehs.local>
 <alpine.DEB.2.02.1307051819530.32106@ionos.tec.linutronix.de>
Message-ID: <ad28a9ee-541e-4b28-8b4e-9ebb2e1c4283@TX2EHSMHS015.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 06:23:19PM +0200, Thomas Gleixner wrote:
> On Fri, 5 Jul 2013, S?ren Brinkmann wrote:
> > On Fri, Jul 05, 2013 at 06:05:14PM +0200, Thomas Gleixner wrote:
> > > On Fri, 5 Jul 2013, S?ren Brinkmann wrote:
> > > > On Fri, Jul 05, 2013 at 08:30:47AM +0200, Thomas Gleixner wrote:
> > > > > On Wed, 3 Jul 2013, Soren Brinkmann wrote:
> > > > > 
> > > > > > Reuse the TTC clocksource timer as sched clock, too. Since only a single
> > > > > > sched clock is supported in Linux, this feature optional and can be
> > > > > > selected through Kconfig.
> > > > > 
> > > > > This changelog doesn't make sense.
> > > > > 
> > > > > There can be only one active sched_clock, but that does no mean, that
> > > > > you cannot have different implementations compiled in.
> > > > > 
> > > > > So if you disable this config which sched_clock is your kernel using?
> > > > Jiffies
> > > > 
> > > > > And if you enable it, how is guaranteed that you end up with the ttc
> > > > > sched_clock as the active one? Just due to initcall ordering?
> > > > I assumed so. Is there a different mechanism?
> > > 
> > > jiffies is the default one. If you setup an explicit sched clock then
> > > this is used. initcall ordering only matters if you have two possible
> > > sched clocks which might replace jiffies. The one which gets
> > > registered last wins.
> > > 
> > > So the question is, why you want to disable your sched clock at
> > > compile time.
> > The timer drivers I have seen unconditionally register themselves as
> > sched_clock. There does not seem to be a runtime mechanism to choose the
> > best one - I might miss it though.
> > I was thinking about this due to the arm_global_timer driver which has
> > been dicussed on lkml recently, which seemed to do it this way too. And since
> > that timer would be an alternative sched_clock for Zynq too, I thought I
> > follow the same approach for the TTC.
> 
> Hmm, ok. So there is a generic one as well. If we end up with multiple
> choices for that sched_clock, then there should be a mechanism to
> avoid that #ifdeffery and have it runtime selected.
> 
> Having a setup call with a rating argument would be a first step. So
> the one with the highest rating wins. If people want to have it
> selectable from the kernel commandline, it would need some string
> matching as well.
I revisited the code:
My original reason for adding the Kconfig option was that I hit this
warning when I had multiple sched_clock providers:
	arch/arm/kernel/sched_clock.c:setup_sched_clock():
		WARN_ON(read_sched_clock != jiffy_sched_clock_read);

That code is gone in the lates Linux tree.

Furthermore the now used setup_sched_clock routine, only updates the
sched clock provider, if the new one is faster than the old one:
	if (cd.rate > rate)                                                      
                return;

Which is good enough in terms of a rating mechanism, at least for this case.

So, I'll remove all the #ifdefs and Kconfig stuff and send a v2.

	S?ren
