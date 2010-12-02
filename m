From: will.deacon@arm.com (Will Deacon)
Date: Thu,  2 Dec 2010 13:45:56 +0000
Subject: [PATCH 05/11] ARM: hw_breakpoint: don't advertise reserved breakpoints
In-Reply-To: <1291297562-8052-1-git-send-email-will.deacon@arm.com>
References: <1291297562-8052-1-git-send-email-will.deacon@arm.com>
Message-ID: <1291297562-8052-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To permit handling of watchpoint exceptions without signalling a
debugger, it is necessary to reserve breakpoint registers for in-kernel
use only.

This patch ensures that we record and subtract the number of reserved
breakpoints from the number of usable breakpoint registers that we
advertise to userspace via the ptrace API.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |  206 ++++++++++++++++++++++-----------------
 1 files changed, 117 insertions(+), 89 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index eeba380..b16c456 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -45,6 +45,7 @@ static DEFINE_PER_CPU(struct perf_event *, wp_on_reg[ARM_MAX_WRP]);
 
 /* Number of BRP/WRP registers on this CPU. */
 static int core_num_brps;
+static int core_num_reserved_brps;
 static int core_num_wrps;
 
 /* Debug architecture version. */
@@ -53,87 +54,6 @@ static u8 debug_arch;
 /* Maximum supported watchpoint length. */
 static u8 max_watchpoint_len;
 
-/* Determine number of BRP registers available. */
-static int get_num_brps(void)
-{
-	u32 didr;
-	ARM_DBG_READ(c0, 0, didr);
-	return ((didr >> 24) & 0xf) + 1;
-}
-
-/* Determine number of WRP registers available. */
-static int get_num_wrps(void)
-{
-	/*
-	 * FIXME: When a watchpoint fires, the only way to work out which
-	 * watchpoint it was is by disassembling the faulting instruction
-	 * and working out the address of the memory access.
-	 *
-	 * Furthermore, we can only do this if the watchpoint was precise
-	 * since imprecise watchpoints prevent us from calculating register
-	 * based addresses.
-	 *
-	 * For the time being, we only report 1 watchpoint register so we
-	 * always know which watchpoint fired. In the future we can either
-	 * add a disassembler and address generation emulator, or we can
-	 * insert a check to see if the DFAR is set on watchpoint exception
-	 * entry [the ARM ARM states that the DFAR is UNKNOWN, but
-	 * experience shows that it is set on some implementations].
-	 */
-
-#if 0
-	u32 didr, wrps;
-	ARM_DBG_READ(c0, 0, didr);
-	return ((didr >> 28) & 0xf) + 1;
-#endif
-
-	return 1;
-}
-
-int hw_breakpoint_slots(int type)
-{
-	/*
-	 * We can be called early, so don't rely on
-	 * our static variables being initialised.
-	 */
-	switch (type) {
-	case TYPE_INST:
-		return get_num_brps();
-	case TYPE_DATA:
-		return get_num_wrps();
-	default:
-		pr_warning("unknown slot type: %d\n", type);
-		return 0;
-	}
-}
-
-/* Determine debug architecture. */
-static u8 get_debug_arch(void)
-{
-	u32 didr;
-
-	/* Do we implement the extended CPUID interface? */
-	if (((read_cpuid_id() >> 16) & 0xf) != 0xf) {
-		pr_warning("CPUID feature registers not supported. "
-				"Assuming v6 debug is present.\n");
-		return ARM_DEBUG_ARCH_V6;
-	}
-
-	ARM_DBG_READ(c0, 0, didr);
-	return (didr >> 16) & 0xf;
-}
-
-/* Does this core support mismatch breakpoints? */
-static int core_has_mismatch_bps(void)
-{
-	return debug_arch >= ARM_DEBUG_ARCH_V7_ECP14 && core_num_brps > 1;
-}
-
-u8 arch_get_debug_arch(void)
-{
-	return debug_arch;
-}
-
 #define READ_WB_REG_CASE(OP2, M, VAL)		\
 	case ((OP2 << 4) + M):			\
 		ARM_DBG_READ(c ## M, OP2, VAL); \
@@ -211,6 +131,111 @@ static void write_wb_reg(int n, u32 val)
 	isb();
 }
 
+/* Determine debug architecture. */
+static u8 get_debug_arch(void)
+{
+	u32 didr;
+
+	/* Do we implement the extended CPUID interface? */
+	if (((read_cpuid_id() >> 16) & 0xf) != 0xf) {
+		pr_warning("CPUID feature registers not supported. "
+				"Assuming v6 debug is present.\n");
+		return ARM_DEBUG_ARCH_V6;
+	}
+
+	ARM_DBG_READ(c0, 0, didr);
+	return (didr >> 16) & 0xf;
+}
+
+u8 arch_get_debug_arch(void)
+{
+	return debug_arch;
+}
+
+/* Determine number of BRP register available. */
+static int get_num_brp_resources(void)
+{
+	u32 didr;
+	ARM_DBG_READ(c0, 0, didr);
+	return ((didr >> 24) & 0xf) + 1;
+}
+
+/* Does this core support mismatch breakpoints? */
+static int core_has_mismatch_brps(void)
+{
+	return (get_debug_arch() >= ARM_DEBUG_ARCH_V7_ECP14 &&
+		get_num_brp_resources() > 1);
+}
+
+/* Determine number of usable WRPs available. */
+static int get_num_wrps(void)
+{
+	/*
+	 * FIXME: When a watchpoint fires, the only way to work out which
+	 * watchpoint it was is by disassembling the faulting instruction
+	 * and working out the address of the memory access.
+	 *
+	 * Furthermore, we can only do this if the watchpoint was precise
+	 * since imprecise watchpoints prevent us from calculating register
+	 * based addresses.
+	 *
+	 * Providing we have more than 1 breakpoint register, we only report
+	 * a single watchpoint register for the time being. This way, we always
+	 * know which watchpoint fired. In the future we can either add a
+	 * disassembler and address generation emulator, or we can insert a
+	 * check to see if the DFAR is set on watchpoint exception entry
+	 * [the ARM ARM states that the DFAR is UNKNOWN, but experience shows
+	 * that it is set on some implementations].
+	 */
+
+#if 0
+	int wrps;
+	u32 didr;
+	ARM_DBG_READ(c0, 0, didr);
+	wrps = ((didr >> 28) & 0xf) + 1;
+#endif
+	int wrps = 1;
+
+	if (core_has_mismatch_brps() && wrps >= get_num_brp_resources())
+		wrps = get_num_brp_resources() - 1;
+
+	return wrps;
+}
+
+/* We reserve one breakpoint for each watchpoint. */
+static int get_num_reserved_brps(void)
+{
+	if (core_has_mismatch_brps())
+		return get_num_wrps();
+	return 0;
+}
+
+/* Determine number of usable BRPs available. */
+static int get_num_brps(void)
+{
+	int brps = get_num_brp_resources();
+	if (core_has_mismatch_brps())
+		brps -= get_num_reserved_brps();
+	return brps;
+}
+
+int hw_breakpoint_slots(int type)
+{
+	/*
+	 * We can be called early, so don't rely on
+	 * our static variables being initialised.
+	 */
+	switch (type) {
+	case TYPE_INST:
+		return get_num_brps();
+	case TYPE_DATA:
+		return get_num_wrps();
+	default:
+		pr_warning("unknown slot type: %d\n", type);
+		return 0;
+	}
+}
+
 /*
  * In order to access the breakpoint/watchpoint control registers,
  * we must be running in debug monitor mode. Unfortunately, we can
@@ -326,7 +351,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 		ctrl_base = ARM_BASE_BCR;
 		val_base = ARM_BASE_BVR;
 		slots = __get_cpu_var(bp_on_reg);
-		max_slots = core_num_brps - 1;
+		max_slots = core_num_brps;
 
 		if (bp_is_single_step(bp)) {
 			info->ctrl.mismatch = 1;
@@ -377,7 +402,7 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 		/* Breakpoint */
 		base = ARM_BASE_BCR;
 		slots = __get_cpu_var(bp_on_reg);
-		max_slots = core_num_brps - 1;
+		max_slots = core_num_brps;
 
 		if (bp_is_single_step(bp)) {
 			i = max_slots;
@@ -611,7 +636,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * we can use the mismatch feature as a poor-man's hardware single-step.
 	 */
 	if (WARN_ONCE(!bp->overflow_handler &&
-		(arch_check_bp_in_kernelspace(bp) || !core_has_mismatch_bps()),
+		(arch_check_bp_in_kernelspace(bp) || !core_has_mismatch_brps()),
 			"overflow handler required but none found")) {
 		ret = -EINVAL;
 	}
@@ -698,7 +723,7 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
 	/* The exception entry code places the amended lr in the PC. */
 	addr = regs->ARM_pc;
 
-	for (i = 0; i < core_num_brps; ++i) {
+	for (i = 0; i < core_num_brps + core_num_reserved_brps; ++i) {
 		rcu_read_lock();
 
 		bp = slots[i];
@@ -801,7 +826,8 @@ static void reset_ctrl_regs(void *unused)
 	if (enable_monitor_mode())
 		return;
 
-	for (i = 0; i < core_num_brps; ++i) {
+	/* We must also reset any reserved registers. */
+	for (i = 0; i < core_num_brps + core_num_reserved_brps; ++i) {
 		write_wb_reg(ARM_BASE_BCR + i, 0UL);
 		write_wb_reg(ARM_BASE_BVR + i, 0UL);
 	}
@@ -839,13 +865,15 @@ static int __init arch_hw_breakpoint_init(void)
 
 	/* Determine how many BRPs/WRPs are available. */
 	core_num_brps = get_num_brps();
+	core_num_reserved_brps = get_num_reserved_brps();
 	core_num_wrps = get_num_wrps();
 
 	pr_info("found %d breakpoint and %d watchpoint registers.\n",
-			core_num_brps, core_num_wrps);
+		core_num_brps + core_num_reserved_brps, core_num_wrps);
 
-	if (core_has_mismatch_bps())
-		pr_info("1 breakpoint reserved for watchpoint single-step.\n");
+	if (core_num_reserved_brps)
+		pr_info("%d breakpoint(s) reserved for watchpoint "
+				"single-step.\n", core_num_reserved_brps);
 
 	ARM_DBG_READ(c1, 0, dscr);
 	if (dscr & ARM_DSCR_HDBGEN) {
-- 
1.7.0.4
