From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 Feb 2011 10:13:05 +0000
Subject: [PATCH] ARM: hw_breakpoint: ensure debug logic is powered up on v7
	cores
Message-ID: <1298628785-29936-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv7 allows the debug core logic to be powered down and provides the
DBGPRSR register so that software can power-up and check the status of
the logic.

This patch ensures that the debug logic is powered up on ARMv7 cores
before we attempt to access the extended debug registers.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index d600bd3..44b84fe 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -836,9 +836,11 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 /*
  * One-time initialisation.
  */
-static void reset_ctrl_regs(void *unused)
+static void reset_ctrl_regs(void *info)
 {
-	int i;
+	int i, cpu = smp_processor_id();
+	u32 dbg_power;
+	cpumask_t *cpumask = info;
 
 	/*
 	 * v7 debug contains save and restore registers so that debug state
@@ -850,6 +852,17 @@ static void reset_ctrl_regs(void *unused)
 	 */
 	if (debug_arch >= ARM_DEBUG_ARCH_V7_ECP14) {
 		/*
+		 * Ensure sticky power-down is clear (i.e. debug logic is
+		 * powered up).
+		 */
+		asm volatile("mrc p14, 0, %0, c1, c5, 4" : "=r" (dbg_power));
+		if ((dbg_power & 0x1) == 0) {
+			pr_warning("CPU %d debug is powered down!\n", cpu);
+			cpumask_or(cpumask, cpumask, cpumask_of(cpu));
+			return;
+		}
+
+		/*
 		 * Unconditionally clear the lock by writing a value
 		 * other than 0xC5ACCE55 to the access register.
 		 */
@@ -887,6 +900,7 @@ static struct notifier_block __cpuinitdata dbg_reset_nb = {
 static int __init arch_hw_breakpoint_init(void)
 {
 	u32 dscr;
+	cpumask_t cpumask = { CPU_BITS_NONE };
 
 	debug_arch = get_debug_arch();
 
@@ -911,7 +925,13 @@ static int __init arch_hw_breakpoint_init(void)
 	 * Reset the breakpoint resources. We assume that a halting
 	 * debugger will leave the world in a nice state for us.
 	 */
-	on_each_cpu(reset_ctrl_regs, NULL, 1);
+	on_each_cpu(reset_ctrl_regs, &cpumask, 1);
+	if (!cpumask_empty(&cpumask)) {
+		core_num_brps = 0;
+		core_num_reserved_brps = 0;
+		core_num_wrps = 0;
+		return 0;
+	}
 
 	ARM_DBG_READ(c1, 0, dscr);
 	if (dscr & ARM_DSCR_HDBGEN) {
-- 
1.7.0.4
