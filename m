From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Mar 2015 09:34:19 +0100
Subject: sunxi: cpufreq-dt usage causes schedule_delayed_work to execute
 sooner?
In-Reply-To: <55073A9E.3070600@redhat.com>
References: <55073A9E.3070600@redhat.com>
Message-ID: <20150317083419.GC4638@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 16, 2015 at 09:18:38PM +0100, Hans de Goede wrote:
> Hi ChenYu, Maxime,
> 
> For the sunxi musb code I've been writing uses schedule_delayed_work in a few places,
> while looking at debugging printk-s in dmesg I noticed that the time stamps between
> scheduling the work and executing it are of.
> 
> If I build a kernel without cpufreq-dt or do:
> 
> echo performance > scaling_governor
> 
> The problem goes away.
> 
> I've done some debugging and the problem is not the actual timing of the
> code, the timestamps in the dmesg output are wrong, very wrong even
> here are 2 messages where I plugged in a cable, then waited 10 seconds
> using a clock with a second hand to count them of, then unplugged:
> 
> 
> [  635.006201] musb vbus 0 -> 1
> [  637.877098] musb vbus 1 -> 0
> 
> This is after doing:
> 
> echo powersave > scaling_governor
> 
> So it seems that the clocksource used by printk to generate timestamps
> goes slower as we scale down cpufreq, not good (tm).

Indeed.

> This:
> 
> [root at localhost clocksource0]# cat available_clocksource
> arch_sys_counter timer hstimer
> [root at localhost clocksource0]# echo timer > current_clocksource
> [  725.728887] Switched to clocksource timer
> 
> Does not help.
> 
> I believe that the "sched_clock_register(sun5i_timer_sched_read, 32, rate);"
> call in drivers/clocksource/timer-sun5i.c is the culprit, it seems this ends
> up overriding the sched_clock_register call in
> drivers/clocksource/arm_arch_timer.c which likely does not suffer from cpufreq
> issues, and is faster (part of the cpucore) then using the hstimer anyways.

We were kind of having the same issues on the A31, with the AHB clock
that gets reparented to PLL6 halfway through the boot, and after the
timer has been probed.

I have a patchset that handles this by removing the sched_clock
registration and add a clock notifier to handle that the clock change
for clock sources and clock events.

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328115.html

Since the system won't use the hstimer by default anyway, could you just
test applying this patch ?

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328114.html

> Note I've not tested yet if disabling the hstimer fixes things, but I believe
> it will. Note that the hstimer will likewise be a bad clockevent source too,
> this can be fixed by registering a cpufreq notifier and calling clockevents_update_freq
> whenever the cpufreq, and thus the hstimer clkrate changes.

Without the above set, yep, it will.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150317/647b587a/attachment.sig>
