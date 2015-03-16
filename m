From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 16 Mar 2015 21:18:38 +0100
Subject: sunxi: cpufreq-dt usage causes schedule_delayed_work to execute
 sooner?
Message-ID: <55073A9E.3070600@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ChenYu, Maxime,

For the sunxi musb code I've been writing uses schedule_delayed_work in a few places,
while looking at debugging printk-s in dmesg I noticed that the time stamps between
scheduling the work and executing it are of.

If I build a kernel without cpufreq-dt or do:

echo performance > scaling_governor

The problem goes away.

I've done some debugging and the problem is not the actual timing of the
code, the timestamps in the dmesg output are wrong, very wrong even
here are 2 messages where I plugged in a cable, then waited 10 seconds
using a clock with a second hand to count them of, then unplugged:


[  635.006201] musb vbus 0 -> 1
[  637.877098] musb vbus 1 -> 0

This is after doing:

echo powersave > scaling_governor

So it seems that the clocksource used by printk to generate timestamps
goes slower as we scale down cpufreq, not good (tm).

This:

[root at localhost clocksource0]# cat available_clocksource
arch_sys_counter timer hstimer
[root at localhost clocksource0]# echo timer > current_clocksource
[  725.728887] Switched to clocksource timer

Does not help.

I believe that the "sched_clock_register(sun5i_timer_sched_read, 32, rate);"
call in drivers/clocksource/timer-sun5i.c is the culprit, it seems this ends
up overriding the sched_clock_register call in
drivers/clocksource/arm_arch_timer.c which likely does not suffer from cpufreq
issues, and is faster (part of the cpucore) then using the hstimer anyways.

Note I've not tested yet if disabling the hstimer fixes things, but I believe
it will. Note that the hstimer will likewise be a bad clockevent source too,
this can be fixed by registering a cpufreq notifier and calling clockevents_update_freq
whenever the cpufreq, and thus the hstimer clkrate changes.

Alternatively we could simply remove the driver altogether since the kernel
prefers the sun4i_tick eventsource anyways.

Regards,

Hans
