From: wpdster@gmail.com (Patrick Doyle)
Date: Wed, 23 Dec 2015 11:11:20 -0500
Subject: What happens if sched_clock_suspend() is never called?
Message-ID: <CAF_dkJAJ3g7S2i2zW81OD50Bwsg7NzuakbeeQaBhJvtVCyg86w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm looking at the source code for the (Atmel) 4.1 kernel,
specifically at the sched_clock_timer in sched_clock.c, and I see that
it gets initialized by a call to sched_clock_postinit() fairly early
in the boot process.  In particular, it is called when only my PIT
timer has been initialized.  It registers sched_clock_poll() to be
called at the wrap interval for the jiffy based clock source.

Later in the boot process, my clocksource driver gets called, and it
registers itself as a sched_clock source with a much higher update
rate (10 MHz vs 1kHz), but the sched_clock_timer does not get updated
at this point, it remains set up to run at the wrap rate for the 1 kHz
jiffy sched_clock.

The only way it gets changed is if somebody calls
sched_clock_suspend() and sched_clock_resume().

This feels like a bug to me.  It seems like sched_clock_register()
should update the sched_clock_timer whenever it changes cd.wrap_kt.

Ummm... am I missing something here?  I feel kinda funny suggesting
that I may have found a bug in the kernel for something this much in
the core.

I guess its possible that most other platforms run with options and
timers that don't highlight this code path.

I am going to traverse down a path of fixing this for me, will
certainly submit a patch for it, but I would appreciate any feedback
on the basic concept before I go too far down this road.

--wpd
