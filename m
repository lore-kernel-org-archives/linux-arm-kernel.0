From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Nov 2011 16:07:31 +0000
Subject: [RFC 0/5] restart cleanups
Message-ID: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series cleans up some of the restart code for ARM.  It doesn't go
as far as Will's patch set (or even anywhere close to it) mainly because
of the poor state of the various implementations in various platforms.

Effectively, the various platforms themselves stand in the way of optimal
cleanup of this code.

We already have a function pointer to allow the restart to be hooked at
runtime - it's called arm_pm_restart().

What a lot of platforms use this for is to intercept the restart call,
do something, and then continue on by calling arm_machine_restart().

One platform (mioa701) in particular thinks its a good idea to call
functions like gpio_free() and free_irq() from here.  This is soo far
from reality its untrue; the restart paths can be called from _any_
context including IRQ context.  This alone effectively stands in the
way of moving the IRQ disables before the call to arm_pm_restart().

Other platforms use arm_pm_restart() to intercept the restart, and
force the mode to 'g', 'h' or 's'.  As the mode already defaults to
'h' I don't understand why people felt forcing it in that case was
necessary.  As for the 's' case, this can be done by merely specifying
".soft_reboot = 1" in the machine record.  We can solve the 'g' case
by changing .soft_reboot to be a char "restart_mode" argument which
sets the default restart mode.

Although I have a patch (not published as part of this series) which
makes that change, I've found it less than useful for getting rid of
some of the intercept crap because of other games platforms play in
there (like writing magic values to registers.)

Essentially, we want to move to a state where arm_pm_restart() is _the_
hook for platforms to insert their restart code into, with the default
function being a no-op.  All platforms which want to have working
restart support then have to insert their restart code into this hook.

So, this patch set takes us a little way there by cleaning up some of
the restart code:

1. remove the useless argument to setup_mm_for_reboot()
2. remove the silly indirection in AT91 code and do this like other
   platforms do.
3. remove any local_irq_disable() calls inside arch_reset() because
   this is already the case.
4. factor out the code which fiddles with the MMU tables.
5. provide (and use) a function for soft rebooting which includes the
   setup of the MMU tables and call cpu_reset() - and remove the MMU
   setup from the code paths before arch_reset() is called.
