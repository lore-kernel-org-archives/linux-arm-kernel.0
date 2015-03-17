From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Mar 2015 09:37:16 +0100
Subject: sunxi: cpufreq-dt usage causes schedule_delayed_work to execute
 sooner?
In-Reply-To: <CAGb2v66V0rOpz+GgdOSb52NZGgb36OcXCTpHV2SOyKT3QmQ1JQ@mail.gmail.com>
References: <55073A9E.3070600@redhat.com>
 <CAGb2v66V0rOpz+GgdOSb52NZGgb36OcXCTpHV2SOyKT3QmQ1JQ@mail.gmail.com>
Message-ID: <20150317083716.GD4638@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 10:39:04AM +0800, Chen-Yu Tsai wrote:
> Hi Hans,
> 
> On Tue, Mar 17, 2015 at 4:18 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> > Hi ChenYu, Maxime,
> >
> > For the sunxi musb code I've been writing uses schedule_delayed_work in a
> > few places,
> > while looking at debugging printk-s in dmesg I noticed that the time stamps
> > between
> > scheduling the work and executing it are of.
> >
> > If I build a kernel without cpufreq-dt or do:
> >
> > echo performance > scaling_governor
> >
> > The problem goes away.
> >
> > I've done some debugging and the problem is not the actual timing of the
> > code, the timestamps in the dmesg output are wrong, very wrong even
> > here are 2 messages where I plugged in a cable, then waited 10 seconds
> > using a clock with a second hand to count them of, then unplugged:
> >
> >
> > [  635.006201] musb vbus 0 -> 1
> > [  637.877098] musb vbus 1 -> 0
> >
> > This is after doing:
> >
> > echo powersave > scaling_governor
> >
> > So it seems that the clocksource used by printk to generate timestamps
> > goes slower as we scale down cpufreq, not good (tm).
> >
> > This:
> >
> > [root at localhost clocksource0]# cat available_clocksource
> > arch_sys_counter timer hstimer
> > [root at localhost clocksource0]# echo timer > current_clocksource
> > [  725.728887] Switched to clocksource timer
> >
> > Does not help.
> >
> > I believe that the "sched_clock_register(sun5i_timer_sched_read, 32, rate);"
> > call in drivers/clocksource/timer-sun5i.c is the culprit, it seems this ends
> > up overriding the sched_clock_register call in
> > drivers/clocksource/arm_arch_timer.c which likely does not suffer from
> > cpufreq
> > issues, and is faster (part of the cpucore) then using the hstimer anyways.
> >
> > Note I've not tested yet if disabling the hstimer fixes things, but I
> > believe
> > it will. Note that the hstimer will likewise be a bad clockevent source too,
> > this can be fixed by registering a cpufreq notifier and calling
> > clockevents_update_freq
> > whenever the cpufreq, and thus the hstimer clkrate changes.
> >
> > Alternatively we could simply remove the driver altogether since the kernel
> > prefers the sun4i_tick eventsource anyways.
> 
> Maxime has a series of patches to fix this:
> 
>     https://lkml.org/lkml/2015/1/11/52
> 
> Another thing we could do is mux AHB to PLL6 on sun5+i.
> I have a clock driver patch somewhere...

That wouldn't really fix things.

If we reparent the clock during the boot, it will very likely be after
the timer has been registered. The slowdown won't be dynamic depending
on the cpu frequency, but it would still be there.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150317/f313c293/attachment.sig>
