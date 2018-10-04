From: nicolas.cavallari@green-communications.fr (Nicolas Cavallari)
Date: Thu,  4 Oct 2018 18:23:37 +0200
Subject: Reboot using an i2c power-system-controller ?
Message-ID: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So i got this ARM board with a rtc controlled by i2c that can also cut
power.  I want to use it to reboot, because it will also cut power to
clumsy USB and MMC devices.
So the natural thing to do would be to just register a restart_handler
that will kindly do i2c (saw at least a driver doing it), or use
arm_pm_restart and be done with it.

Well that what I though.  Most of my naive attempts were met with
occasional failures and now my understanding is that I do not
understand why anything works in the first place.

So the first thing I saw while doing i2c in a restart_handler are
kernel splats about sleeping in a RCU critical section.
Since i2c is slow, most i2c controllers either sleep until the i2c
transfer is complete or they wait for an interrupt.  restart_handler
is an atomic notifier chain, so sleeping in there should be bad.

So I looked at drivers to see what they do and it seems many of them
sleep inside their restart_handler callbacks.  Some even have infinite
loops.  And there is the rn5t618 driver which does i2c (as well as a
small mdelay(1)), which is used in some meson8 boards, whose i2c
controller wait for completion of interrupts.  So I'm wondering why am I
the only one with these problems.

So i cobbled a patch that turns restart_handler into a notifier call
chain that can block.  It removes the splat, but reboot still
occasionally fails.

By the time we get to arm_pm_restart() or do_machine_restart(),
interrupts are disabled and only one processor is running.
The first thing i did was to enable interrupts on the remaining
processor, so that i2c could work, but it turns out my i2c controller
does not use interrupts, so that didn't change anything.  Still, i would
consider this to be desirable anyway.

The remaining problems turns out to be timers that never fires. sysrq Q
shows:

active timers:
 #0: <e5d80165> , hrtimer_wakeup , S:01
 # expires at 349641289373-349641389373 nsecs [in -1000130841786 to -1000130741786 nsecs]
 #1: <b06a222c> , tick_sched_timer , S:01
 # expires at 349650000000-349650000000 nsecs [in -1000122131159 to -1000122131159 nsecs]
 #2: sched_clock_timer , sched_clock_poll , S:01
 # expires at 715827882841-715827882841 nsecs [in -633944248318 to -633944248318 nsecs]

with no matching .next_timer in any clockevent device.

I think it is because when we call send_smp_stop(), we don't unregister the
twd clockevent of the affected CPU and we may still allocate timers on
it.

I noticed that the CPU hotplug code handles this fine, so my current
workaround is to enable CPU hotplug in the kernel and manually
deactivate CPUs in the init system before rebooting

So did I missing something ? What would be the correct to fix all this ?
