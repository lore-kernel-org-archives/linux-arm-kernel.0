From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:12:49 +0100
Subject: [PATCH 2/5] ARM: hw_breakpoint: reserve one breakpoint for watchpoint
	stepping
In-Reply-To: <1312823572-9807-1-git-send-email-will.deacon@arm.com>
References: <1312823572-9807-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823572-9807-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current hw_breakpoint code on ARM reserves 1 breakpoint for each
watchpoint that is available. Since debug architectures prior to 7.1
are restricted to 1 watchpoint anyway, only one breakpoint was ever
reserved.

This patch changes the reservation strategy so that a single breakpoint
is reserved, regardless of the number of watchpoints. This is in
preparation for multiple-watchpoint support on debug architectures
from 7.1 onwards.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |   63 +++++++++++++++------------------------
 1 files changed, 24 insertions(+), 39 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 9848157..485087c 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -45,7 +45,6 @@ static DEFINE_PER_CPU(struct perf_event *, wp_on_reg[ARM_MAX_WRP]);
 
 /* Number of BRP/WRP registers on this CPU. */
 static int core_num_brps;
-static int core_num_reserved_brps;
 static int core_num_wrps;
 
 /* Debug architecture version. */
@@ -157,7 +156,15 @@ static int debug_arch_supported(void)
 	return arch >= ARM_DEBUG_ARCH_V6 && arch <= ARM_DEBUG_ARCH_V7_1;
 }
 
-/* Determine number of BRP register available. */
+/* Determine number of WRP registers available. */
+static int get_num_wrp_resources(void)
+{
+	u32 didr;
+	ARM_DBG_READ(c0, 0, didr);
+	return ((didr >> 28) & 0xf) + 1;
+}
+
+/* Determine number of BRP registers available. */
 static int get_num_brp_resources(void)
 {
 	u32 didr;
@@ -176,9 +183,10 @@ static int core_has_mismatch_brps(void)
 static int get_num_wrps(void)
 {
 	/*
-	 * FIXME: When a watchpoint fires, the only way to work out which
-	 * watchpoint it was is by disassembling the faulting instruction
-	 * and working out the address of the memory access.
+	 * On debug architectures prior to 7.1, when a watchpoint fires, the
+	 * only way to work out which watchpoint it was is by disassembling
+	 * the faulting instruction and working out the address of the memory
+	 * access.
 	 *
 	 * Furthermore, we can only do this if the watchpoint was precise
 	 * since imprecise watchpoints prevent us from calculating register
@@ -192,36 +200,17 @@ static int get_num_wrps(void)
 	 * [the ARM ARM states that the DFAR is UNKNOWN, but experience shows
 	 * that it is set on some implementations].
 	 */
+	if (get_debug_arch() < ARM_DEBUG_ARCH_V7_1)
+		return 1;
 
-#if 0
-	int wrps;
-	u32 didr;
-	ARM_DBG_READ(c0, 0, didr);
-	wrps = ((didr >> 28) & 0xf) + 1;
-#endif
-	int wrps = 1;
-
-	if (core_has_mismatch_brps() && wrps >= get_num_brp_resources())
-		wrps = get_num_brp_resources() - 1;
-
-	return wrps;
-}
-
-/* We reserve one breakpoint for each watchpoint. */
-static int get_num_reserved_brps(void)
-{
-	if (core_has_mismatch_brps())
-		return get_num_wrps();
-	return 0;
+	return get_num_wrp_resources();
 }
 
 /* Determine number of usable BRPs available. */
 static int get_num_brps(void)
 {
 	int brps = get_num_brp_resources();
-	if (core_has_mismatch_brps())
-		brps -= get_num_reserved_brps();
-	return brps;
+	return core_has_mismatch_brps() ? brps - 1 : brps;
 }
 
 /*
@@ -718,7 +707,7 @@ static void watchpoint_single_step_handler(unsigned long pc)
 
 	slots = (struct perf_event **)__get_cpu_var(wp_on_reg);
 
-	for (i = 0; i < core_num_reserved_brps; ++i) {
+	for (i = 0; i < core_num_wrps; ++i) {
 		rcu_read_lock();
 
 		wp = slots[i];
@@ -837,7 +826,7 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
  */
 static void reset_ctrl_regs(void *info)
 {
-	int i, err = 0, cpu = smp_processor_id();
+	int i, raw_num_brps, err = 0, cpu = smp_processor_id();
 	u32 dbg_power;
 	cpumask_t *cpumask = info;
 
@@ -893,7 +882,8 @@ static void reset_ctrl_regs(void *info)
 		return;
 
 	/* We must also reset any reserved registers. */
-	for (i = 0; i < core_num_brps + core_num_reserved_brps; ++i) {
+	raw_num_brps = get_num_brp_resources();
+	for (i = 0; i < raw_num_brps; ++i) {
 		write_wb_reg(ARM_BASE_BCR + i, 0UL);
 		write_wb_reg(ARM_BASE_BVR + i, 0UL);
 	}
@@ -930,15 +920,11 @@ static int __init arch_hw_breakpoint_init(void)
 
 	/* Determine how many BRPs/WRPs are available. */
 	core_num_brps = get_num_brps();
-	core_num_reserved_brps = get_num_reserved_brps();
 	core_num_wrps = get_num_wrps();
 
-	pr_info("found %d breakpoint and %d watchpoint registers.\n",
-		core_num_brps + core_num_reserved_brps, core_num_wrps);
-
-	if (core_num_reserved_brps)
-		pr_info("%d breakpoint(s) reserved for watchpoint "
-				"single-step.\n", core_num_reserved_brps);
+	pr_info("found %d " "%s" "breakpoint and %d watchpoint registers.\n",
+		core_num_brps, core_has_mismatch_brps() ? "(+1 reserved) " :
+		"", core_num_wrps);
 
 	/*
 	 * Reset the breakpoint resources. We assume that a halting
@@ -947,7 +933,6 @@ static int __init arch_hw_breakpoint_init(void)
 	on_each_cpu(reset_ctrl_regs, &cpumask, 1);
 	if (!cpumask_empty(&cpumask)) {
 		core_num_brps = 0;
-		core_num_reserved_brps = 0;
 		core_num_wrps = 0;
 		return 0;
 	}
-- 
1.7.0.4
