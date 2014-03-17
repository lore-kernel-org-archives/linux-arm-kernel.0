From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:13:46 +0000
Subject: [PATCH 03/44] ARM: l2c: avoid calling outer_flush_all() unnecessarily
 (Spear)
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLBa-0002bv-64@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spear calls outer_flush_all() from it's SMP bringup function.  This
is potentially dangerous as the L2C set/way operations which implement
this don't take kindly to concurrent operations.  Besides, there's
better solutions to this, as implemented on other platforms.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-spear/platsmp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
index 5c4a19887b2b..eb9f2ef1e974 100644
--- a/arch/arm/mach-spear/platsmp.c
+++ b/arch/arm/mach-spear/platsmp.c
@@ -20,6 +20,18 @@
 #include <mach/spear.h>
 #include "generic.h"
 
+/*
+ * Write pen_release in a way that is guaranteed to be visible to all
+ * observers, irrespective of whether they're taking part in coherency
+ * or not.  This is necessary for the hotplug code to work reliably.
+ */
+static void write_pen_release(int val)
+{
+	pen_release = val;
+	smp_wmb();
+	sync_cache_w(&pen_release);
+}
+
 static DEFINE_SPINLOCK(boot_lock);
 
 static void __iomem *scu_base = IOMEM(VA_SCU_BASE);
@@ -30,8 +42,7 @@ static void spear13xx_secondary_init(unsigned int cpu)
 	 * let the primary processor know we're out of the
 	 * pen, then head off into the C entry point
 	 */
-	pen_release = -1;
-	smp_wmb();
+	write_pen_release(-1);
 
 	/*
 	 * Synchronise with the boot thread.
@@ -58,9 +69,7 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Note that "pen_release" is the hardware CPU ID, whereas
 	 * "cpu" is Linux's internal ID.
 	 */
-	pen_release = cpu;
-	flush_cache_all();
-	outer_flush_all();
+	write_pen_release(cpu);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
-- 
1.8.3.1
