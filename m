From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 8 Jun 2011 11:14:50 +0800
Subject: [PATCH,RFC] mmp clockevent handling race
In-Reply-To: <BANLkTi=MhX97=pXTFfJfO8=E=2Q98YdC6A@mail.gmail.com>
References: <20110607140456.GE11275@wantstofly.org>
	<alpine.LFD.2.00.1106071416230.2142@xanadu.home>
	<1307499937.8890.2.camel@Lily>
	<BANLkTi=MhX97=pXTFfJfO8=E=2Q98YdC6A@mail.gmail.com>
Message-ID: <1307502890.8890.9.camel@Lily>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-06-07 at 20:05 -0700, Eric Miao wrote:
> On Wed, Jun 8, 2011 at 10:25 AM, Haojian Zhuang
> <haojian.zhuang@marvell.com> wrote:
> > On Tue, 2011-06-07 at 11:29 -0700, Nicolas Pitre wrote:
> >> On Tue, 7 Jun 2011, Lennert Buytenhek wrote:
> >>
> >> > Hi!
> >> >
> >> > The patch below has been sitting around in the OLPC XO-1.75 (MMP2-based
> >> > XO) bringup kernel tree for some time now, and upon recent rebasing of
> >> > this tree to 3.0, it was discovered that something like this patch is
> >> > still needed.
> >> >
> >> > Symptoms: e.g. as described here: http://dev.laptop.org/ticket/10945
> >> > -- applications hang for a couple of minutes at a time, and sometimes
> >> > there are several-minute hangs during the boot process.
> >> >
> >> > >From the ticket:
> >> >
> >> >     The problem in the current upstream mmp timer handling code
> >> >     that appears to be triggered here is that it handles clockevents
> >> >     by setting up a comparator on the free-running clocksource timer
> >> >     to match and trigger an interrupt at 'current_time + delta',
> >> >     which if delta is small enough can lead to 'current_time + delta'
> >> >     already being in the past when comparator setup has finished,
> >> >     and the requested event will not trigger.
> >>
> >> This is a classical issue that was solved on the SA1100 more than 10
> >> years ago.
> >>
> >> > What this patch does is to rewrite the timer handling code to use
> >> > two timers, one for the free-running clocksource, and one to trigger
> >> > clockevents with, which is more or less the standard approach to this.
> >> > It's kind of invasive, though (certainly more invasive than it strictly
> >> > needs to be, as it reorganises time.c somewhat at the same time), and
> >> > something like this is probably too invasive for 3.0 at this point.
> >> >
> >> > A safer "fix" for 3.0 may be to disallow NO_HZ/HIGH_RES_TIMERS on mmp.
> >> >
> >> > Any thoughts?
> >>
> >> What about simply this:
> >>
> >> diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
> >> index 99833b9..8b8f99a 100644
> >> --- a/arch/arm/mach-mmp/time.c
> >> +++ b/arch/arm/mach-mmp/time.c
> >> @@ -39,7 +39,7 @@
> >>
> >>  #define TIMERS_VIRT_BASE     TIMERS1_VIRT_BASE
> >>
> >> -#define MAX_DELTA            (0xfffffffe)
> >> +#define MAX_DELTA            (0xfffffffe - 16)
> >>  #define MIN_DELTA            (16)
> >>
> >>  static DEFINE_CLOCK_DATA(cd);
> >> @@ -85,7 +85,7 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
> >>  static int timer_set_next_event(unsigned long delta,
> >>                               struct clock_event_device *dev)
> >>  {
> >> -     unsigned long flags, next;
> >> +     unsigned long flags, next, now;
> >>
> >>       local_irq_save(flags);
> >>
> >> @@ -95,9 +95,10 @@ static int timer_set_next_event(unsigned long delta,
> >>
> >>       next = timer_read() + delta;
> >>       __raw_writel(next, TIMERS_VIRT_BASE + TMR_TN_MM(0, 0));
> >> +     now = timer_read();
> >>
> >>       local_irq_restore(flags);
> >> -     return 0;
> >> +     return (signed)(next - now) <= MIN_DELTA ? -ETIME : 0;
> >>  }
> >>
> >>  static void timer_set_mode(enum clock_event_mode mode,
> >>
> >>
> >> Nicolas
> > It seems good. But we still need to use two different timer. Because
> > writing match register needs to stop counter register first. This is a
> > limitation in the silicon.
> 
> Well, the first thing is Lennert's RFC patch needs a bit cleanup :-) I tried
> very hard to figure out the actual changes.
> 
> Using two timers isn't a bad idea. Yet if it has to disable timer0 when
> modifying timer1's next triggering event, it doesn't seem to solve the
> real problem with two timers.
Since timer registers is defined as group mode. Counter register and
match register exist in each group. We can use timer 0 as clock source,
only read timer counter. We can use timer 1 as clock event. While we're
writing match register, we just need to disable counter register of
group 1, not group 0. Since it's silicon limitation.
> 
> Haojian,
> 
> Do we have any other timer that could be used as an independent
> clock source?
So both timer 0 and timer 1 are necessary. Timer0 can be used as clock
source. Timer 1 can be used as clock event. And we needn't other timer
to be used as clock source.
