From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Mar 2014 14:39:33 +0000
Subject: mach-spear SMP questions
In-Reply-To: <533428B2.2050906@linaro.org>
References: <533428B2.2050906@linaro.org>
Message-ID: <20140327143933.GD7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 08:33:38AM -0500, Alex Elder wrote:
> I'm doing some code cleanup and have a question about
> something related to SMP in mach-spear.  Can anyone
> help me with these questions?

I think you're working in a similar area to that which I have been - but
with different ends in mind.  Have a look for my L2 cache series on LAKML.

> My question has to do with how secondary cores start for
> SMP.  Most machines need to send a wakeup event from the
> boot core to each secondary core as it is told to start.
> But mach-spear does not do this.  I'd like to know if this
> is an oversight, or confirm that this is simply not necessary
> for this machine.

It could be that the "BootMonitor" waits for spear13xx_smp_prepare_cpus()
to write the address of the function to jump to into SYS_LOCATION - I can't
see any other way this code would work (there's nothing else there to tell
the secondary CPUs where to start executing from or when to start executing
from that point.)

> Also, while most machines touch a memory location and then
> do a targeted cache involving only that location, mach-spear
> does a full flush.  Is the full flush really required for
> some reason?

It's not required.  As part of the L2 cache cleanup, I have this
change:

Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sat Mar 15 16:47:47 2014 +0000

    ARM: l2c: avoid calling outer_flush_all() unnecessarily (Spear)

    Spear calls outer_flush_all() from it's SMP bringup function.  This
    is potentially dangerous as the L2C set/way operations which implement
    this don't take kindly to concurrent operations.  Besides, there's
    better solutions to this, as implemented on other platforms.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

@@ -20,6 +20,18 @@
+/*
+ * Write pen_release in a way that is guaranteed to be visible to all
+ * observers, irrespective of whether they're taking part in coherency
+ * or not.  This is necessary for the hotplug code to work reliably.
+ */
+static void write_pen_release(int val)
+{
+       pen_release = val;
+       smp_wmb();
+       sync_cache_w(&pen_release);
+}
+
...
@@ -30,8 +42,7 @@ static void spear13xx_secondary_init(unsigned int cpu)
-       pen_release = -1;
-       smp_wmb();
+       write_pen_release(-1);
...
@@ -58,9 +69,7 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct t
-       pen_release = cpu;
-       flush_cache_all();
-       outer_flush_all();
+       write_pen_release(cpu);

for Spear, which makes it behave like every other platform we have using
this pen release method.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
