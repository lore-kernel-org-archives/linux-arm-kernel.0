From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 16 Nov 2010 23:15:02 +0100
Subject: [PATCH] nomadik: prevent sched_clock() wraparound
In-Reply-To: <1289940829.3860.22.camel@localhost.localdomain>
References: <1289898690-29910-1-git-send-email-linus.walleij@stericsson.com>
	<1289940829.3860.22.camel@localhost.localdomain>
Message-ID: <AANLkTimvyo-2eHrvU=LNdBjrJfAxv9Jpza8Mh4iG4ts6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/16 john stultz <johnstul@us.ibm.com>:
> On Tue, 2010-11-16 at 10:11 +0100, Linus Walleij wrote:

> The cycle value being passed as v is likely to be large, and the
> clocksource mult and shift are calculated to be as large as possible
> without overflowing when given only a few seconds worth of cycles.
>
> So its very likely that after a few seconds of running (or even less,
> with the 32_to_63 conversion), the cyc2ns function will overflow, as
> v*mult will be greater then 64bits.

Darn you're right of course.

I'll attempt to use
clocks_calc_mult_shift(&mult, &shift, rate, NSEC_PER_SEC, 3600*24*365);

For getting a somewhat more proper mult+shift for sched_clock().

>> + ? ? mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
>> + ? ? (void) sched_clock();
>
> Also, just FYI: This can be problematic on PREEMPT_RT systems, where
> timers can be delayed by high priority processes hogging the cpu.

Hm is there a proper remedy for this? The watchdog in kernel/watchdog.c
creates a HRtimer based thread, SCHED_FIFO and prio MAX_RT_PRIO-1
is that what you should do for the ultimate sched_clock()
cnt32_to_63 guard?

In that case this is ripe for breaking out into a separate helper
somewhere, like a callable
setup_cnt32_to_63_guard_timer(max_rate, sched_clock);

Yours,
Linus Walleij
