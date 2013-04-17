From: robherring2@gmail.com (Rob Herring)
Date: Wed, 17 Apr 2013 10:46:52 -0500
Subject: [PATCH] ARM: highbank: fix cache flush ordering for cpu hotplug
Message-ID: <1366213612-13526-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The L1 data cache flush needs to be after highbank_set_cpu_jump call which
pollutes the cache with the l2x0_lock. This causes other cores to deadlock
waiting for the l2x0_lock. Moving the flush of the entire data cache after
highbank_set_cpu_jump fixes the problem. Use flush_cache_louis instead of
flush_cache_all are that is sufficient to flush only the L1 data cache.
flush_cache_louis did not exist when highbank_cpu_die was originally
written.

With PL310 errata 769419 enabled, a wmb is inserted into idle which takes
the l2x0_lock. This makes the problem much more easily hit and causes
reset to hang.

Reported-by: Paolo Pisati <p.pisati@gmail.com>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
Olof, Arnd,

If you have any more 3.9 fixes, please send this in. Otherwise, it can
wait for 3.10 and mark for stable.

Rob

 arch/arm/mach-highbank/hotplug.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-highbank/hotplug.c b/arch/arm/mach-highbank/hotplug.c
index f30c528..890cae2 100644
--- a/arch/arm/mach-highbank/hotplug.c
+++ b/arch/arm/mach-highbank/hotplug.c
@@ -28,13 +28,11 @@ extern void secondary_startup(void);
  */
 void __ref highbank_cpu_die(unsigned int cpu)
 {
-	flush_cache_all();
-
 	highbank_set_cpu_jump(cpu, phys_to_virt(0));
-	highbank_set_core_pwr();
 
-	cpu_do_idle();
+	flush_cache_louis();
+	highbank_set_core_pwr();
 
-	/* We should never return from idle */
-	panic("highbank: cpu %d unexpectedly exit from shutdown\n", cpu);
+	while (1)
+		cpu_do_idle();
 }
-- 
1.7.10.4
