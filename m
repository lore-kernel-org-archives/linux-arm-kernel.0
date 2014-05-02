From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri,  2 May 2014 16:59:45 +0100
Subject: [PATCH] arm64: Remove boot thread synchronisation for spin-table
 release method
Message-ID: <1399046385-5904-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The synchronisation with the boot thread already happens in __cpu_up()
via wait_for_completion_timeout(). In addition, __cpu_up() calls are
protected by the cpu_add_remove_lock mutex and already serialised.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/smp_spin_table.c | 39 +-------------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 7a530d2cc807..0347d38eea29 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -30,7 +30,6 @@ extern void secondary_holding_pen(void);
 volatile unsigned long secondary_holding_pen_release = INVALID_HWID;
 
 static phys_addr_t cpu_release_addr[NR_CPUS];
-static DEFINE_RAW_SPINLOCK(boot_lock);
 
 /*
  * Write secondary_holding_pen_release in a way that is guaranteed to be
@@ -94,14 +93,6 @@ static int smp_spin_table_cpu_prepare(unsigned int cpu)
 
 static int smp_spin_table_cpu_boot(unsigned int cpu)
 {
-	unsigned long timeout;
-
-	/*
-	 * Set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	raw_spin_lock(&boot_lock);
-
 	/*
 	 * Update the pen release flag.
 	 */
@@ -112,34 +103,7 @@ static int smp_spin_table_cpu_boot(unsigned int cpu)
 	 */
 	sev();
 
-	timeout = jiffies + (1 * HZ);
-	while (time_before(jiffies, timeout)) {
-		if (secondary_holding_pen_release == INVALID_HWID)
-			break;
-		udelay(10);
-	}
-
-	/*
-	 * Now the secondary core is starting up let it run its
-	 * calibrations, then wait for it to finish
-	 */
-	raw_spin_unlock(&boot_lock);
-
-	return secondary_holding_pen_release != INVALID_HWID ? -ENOSYS : 0;
-}
-
-static void smp_spin_table_cpu_postboot(void)
-{
-	/*
-	 * Let the primary processor know we're out of the pen.
-	 */
-	write_pen_release(INVALID_HWID);
-
-	/*
-	 * Synchronise with the boot thread.
-	 */
-	raw_spin_lock(&boot_lock);
-	raw_spin_unlock(&boot_lock);
+	return 0;
 }
 
 const struct cpu_operations smp_spin_table_ops = {
@@ -147,5 +111,4 @@ const struct cpu_operations smp_spin_table_ops = {
 	.cpu_init	= smp_spin_table_cpu_init,
 	.cpu_prepare	= smp_spin_table_cpu_prepare,
 	.cpu_boot	= smp_spin_table_cpu_boot,
-	.cpu_postboot	= smp_spin_table_cpu_postboot,
 };
