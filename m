From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Mar 2015 10:40:24 +0100
Subject: sunxi: cpufreq-dt usage causes schedule_delayed_work to execute
 sooner?
In-Reply-To: <5507EB41.9000400@redhat.com>
References: <55073A9E.3070600@redhat.com>
 <CAGb2v66V0rOpz+GgdOSb52NZGgb36OcXCTpHV2SOyKT3QmQ1JQ@mail.gmail.com>
 <20150317083716.GD4638@lukather> <5507EB41.9000400@redhat.com>
Message-ID: <20150318094024.GL4638@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 17, 2015 at 09:52:17AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 17-03-15 09:37, Maxime Ripard wrote:
> >On Tue, Mar 17, 2015 at 10:39:04AM +0800, Chen-Yu Tsai wrote:
> >>Hi Hans,
> >>
> >>On Tue, Mar 17, 2015 at 4:18 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> >>>Hi ChenYu, Maxime,
> >>>
> >>>For the sunxi musb code I've been writing uses schedule_delayed_work in a
> >>>few places,
> >>>while looking at debugging printk-s in dmesg I noticed that the time stamps
> >>>between
> >>>scheduling the work and executing it are of.
> >>>
> >>>If I build a kernel without cpufreq-dt or do:
> >>>
> >>>echo performance > scaling_governor
> >>>
> >>>The problem goes away.
> >>>
> >>>I've done some debugging and the problem is not the actual timing of the
> >>>code, the timestamps in the dmesg output are wrong, very wrong even
> >>>here are 2 messages where I plugged in a cable, then waited 10 seconds
> >>>using a clock with a second hand to count them of, then unplugged:
> >>>
> >>>
> >>>[  635.006201] musb vbus 0 -> 1
> >>>[  637.877098] musb vbus 1 -> 0
> >>>
> >>>This is after doing:
> >>>
> >>>echo powersave > scaling_governor
> >>>
> >>>So it seems that the clocksource used by printk to generate timestamps
> >>>goes slower as we scale down cpufreq, not good (tm).
> >>>
> >>>This:
> >>>
> >>>[root at localhost clocksource0]# cat available_clocksource
> >>>arch_sys_counter timer hstimer
> >>>[root at localhost clocksource0]# echo timer > current_clocksource
> >>>[  725.728887] Switched to clocksource timer
> >>>
> >>>Does not help.
> >>>
> >>>I believe that the "sched_clock_register(sun5i_timer_sched_read, 32, rate);"
> >>>call in drivers/clocksource/timer-sun5i.c is the culprit, it seems this ends
> >>>up overriding the sched_clock_register call in
> >>>drivers/clocksource/arm_arch_timer.c which likely does not suffer from
> >>>cpufreq
> >>>issues, and is faster (part of the cpucore) then using the hstimer anyways.
> >>>
> >>>Note I've not tested yet if disabling the hstimer fixes things, but I
> >>>believe
> >>>it will. Note that the hstimer will likewise be a bad clockevent source too,
> >>>this can be fixed by registering a cpufreq notifier and calling
> >>>clockevents_update_freq
> >>>whenever the cpufreq, and thus the hstimer clkrate changes.
> >>>
> >>>Alternatively we could simply remove the driver altogether since the kernel
> >>>prefers the sun4i_tick eventsource anyways.
> >>
> >>Maxime has a series of patches to fix this:
> >>
> >>     https://lkml.org/lkml/2015/1/11/52
> >>
> >>Another thing we could do is mux AHB to PLL6 on sun5+i.
> >>I have a clock driver patch somewhere...
> >
> >That wouldn't really fix things.
> 
> Unless we do this in u-boot, I know that does not fix things for people
> with older u-boot, but I think that making the AHB speed not scale with the
> cpu clock is a good thing to do in general.
> 
> So lets assume we make this change in u-boot to make things better in the
> long run (when everyone has a new u-boot).
> 
> Then we're left with a number of different but related issues:

To sum up our IRC discussion:

> 1) sched_clock implementation
> 
> 1a) hstimer sched_clock is suboptimal on sun7i, the ARM arch timer is a
> better sched_clock source and we should not override it -> only
> register sched_clock on sun5i
> 
> 1b) sched_clock is unreliable when ahb clock may change -> add some code
> in the sun5i hstimer triver to detect what the parent is, and if the parent
> is PLL1 do not register sched_clock

This actually boils down to the fact that the sched_clock has no
priority what so ever, and that it frequency can't be updated.

This will be solved by:
   - Removing the hstimer sched_clock implementation
   - Register a sched clock for the sun4i timer only on sun4i and
     sun5i, since on the other SoCs, we will have the arch timer
     sched_clock. That would also allow to have only a single
     sched_clock implementation registered, together with allowing to
     shutdown entirely the sun4i timer.

> 2) timer implementation
> 
> This too is sensitive to ahb clock changes, we need Maxime's patchset for this.

And for that, we already have the patches sent, that just need to be
picked up by Daniel.

This will also be solved by moving the AHB clock to a PLL of its own,
so that the whole clock won't be impacted by the CPU clock rate
changes. That would be also an acceptable change for 4.0 fixes.

So we actually need to merge a few patches:
  - One to reparent the AHB clock to PLL6.
    + Chen-Yu has some code to do that already, it needs to be sent
      for reviews.

  - One to fix the hstimer by removing its sched_clock and adding a
    clock notifier to handle the case where the hstimer clock rate
    would change (if that ever happens)
    + It's actually part of serie I already sent, that doesn't seem to
      be having a lot of issues left, and need to be picked by Daniel

  - One to register only the sched_clock on the sun4i timer driver on
    A10, A10s and A13.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/a3194cd1/attachment.sig>
