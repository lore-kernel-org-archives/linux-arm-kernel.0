From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 22 Jan 2013 20:35:30 +0530
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <20130122145113.GK23505@n2100.arm.linux.org.uk>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <20130121232322.GK15361@atomide.com> <50FE307F.9000701@ti.com>
 <201301220931.24570.arnd@arndb.de> <50FE666B.10902@ti.com>
 <20130122145113.GK23505@n2100.arm.linux.org.uk>
Message-ID: <50FEAABA.6050307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 January 2013 08:21 PM, Russell King - ARM Linux wrote:
> On Tue, Jan 22, 2013 at 03:44:03PM +0530, Santosh Shilimkar wrote:
>> Sorry for not being clear enough. On OMAP, 32KHz is the only clock which
>> is always running(even during low power states) and hence the clock
>> source and clock event have been clocked using 32KHz clock. As mentioned
>> by RMK, with 32768 Hz clock and HZ = 100, there will be always an
>> error of 0.1 %. This accuracy also impacts the timer tick interval.
>> This was the reason, OMAP has been using the HZ = 128.
>
> Ok.  Let's look at this.  As far as time-of-day is concerned, this
> shouldn't really matter with the clocksource/clockevent based system
> that we now have (where *important point* platforms have been converted
> over.)
>
> Any platform providing a clocksource will override the jiffy-based
> clocksource.  The measurement of time-of-day passing is now based on
> the difference in values read from the clocksource, not from the actual
> tick rate.
>
> Anything _not_ providing a clock source will be reliant on jiffies
> incrementing, which in turn _requires_ one timer interrupt per jiffies
> at a known rate (which is HZ).
>
> Now, that's the time of day, what about jiffies?  Well, jiffies is
> incremented based on a certain number of nsec having passed since the
> last jiffy update.  That means the code copes with dropped ticks and
> the like.
>
> However, if your actual interrupt rate is close to the desired HZ, then
> it can lead to some interesting effects (and noise):
>
> - if the interrupt rate is slightly faster than HZ, then you can end up
>    with updates being delayed by 2x interrupt rate.
> - if the interrupt rate is slightly slower than HZ, you can occasionally
>    end up with jiffies incrementing by two.
> - if your interrupt rate is dead on HZ, then other system noise can come
>    into effect and you may get maybe zero, one or two jiffy increments per
>    interrupt.
>
> (You have to think about time passing in NS, where jiffy updates should
> be vs where the timer interrupts happen.)  See tick_do_update_jiffies64()
> for the details.
>
> The timer infrastructure is jiffy based - which includes scheduling where
> the scheduler does not use hrtimers.  That means a slight discrepency
> between HZ and the actual interrupt rate can cause around 1/HZ jitter.
> That's a matter of fact due to how the code works.
>
> So, actually, I think the accuracy of HZ has much overall effect _provided_
> a platform provides a clocksource to the accuracy of jiffy based timers
> nor timekeeping.  For those which don't, the accuracy of the timer
> interrupt to HZ is very important.
>
> (This is just based on reading some code and not on practical
> experiments - I'd suggest some research of this is done, trying HZ=100
> on OMAP's 32kHz timers, checking whether there's any drift, checking
> how accurately a single task can be woken from various select/poll/epoll
> delays, and checking whether NTP works.)
>
Thanks for expanding it. It is really helpful.

> And I think further discussion is pointless until such research has been
> done (or someone who _really_ knows the time keeping/timer/sched code
> inside out comments.)
>
Fully agree about experimentation to re-asses the drift.
 From what I recollect from past, few OMAP customers did
report the time drift issue and that is how the switch
from 100 --> 128 happened.

Anyway I have added the suggested task to my long todo list.

Regards,
Santosh
