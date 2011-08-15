From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Aug 2011 18:41:56 +0100
Subject: [PATCH v2 4/5] ARM: hw_breakpoint: trap undef instruction exceptions
	in reset_ctrl_regs
In-Reply-To: <1313430117-3439-1-git-send-email-will.deacon@arm.com>
References: <1313430117-3439-1-git-send-email-will.deacon@arm.com>
Message-ID: <1313430117-3439-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM debug registers can only be accessed if the DBGSWENABLE signal
to the core is driven HIGH by the DAP. The architecture does not provide
a way to detect the value of this signal, so the best we can do is
register an undef_hook to trap debug register co-processor accesses and
then fail if the trap is taken.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |   46 +++++++++++++++++++++++++++++++-------
 1 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 448143e..64ac5c6 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -857,11 +857,31 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 /*
  * One-time initialisation.
  */
-static void reset_ctrl_regs(void *info)
+static cpumask_t debug_err_mask;
+
+static int debug_reg_trap(struct pt_regs *regs, unsigned int instr)
+{
+	int cpu = smp_processor_id();
+
+	pr_warning("Debug register access (0x%x) caused undefined instruction on CPU %d\n",
+		   instr, cpu);
+
+	/* Set the error flag for this CPU and skip the faulting instruction. */
+	cpumask_set_cpu(cpu, &debug_err_mask);
+	instruction_pointer(regs) += 4;
+	return 0;
+}
+
+static struct undef_hook debug_reg_hook = {
+	.instr_mask	= 0x0fe80f10,
+	.instr_val	= 0x0e000e10,
+	.fn		= debug_reg_trap,
+};
+
+static void reset_ctrl_regs(void *unused)
 {
 	int i, raw_num_brps, err = 0, cpu = smp_processor_id();
 	u32 dbg_power;
-	cpumask_t *cpumask = info;
 
 	/*
 	 * v7 debug contains save and restore registers so that debug state
@@ -893,7 +913,7 @@ static void reset_ctrl_regs(void *info)
 
 	if (err) {
 		pr_warning("CPU %d debug is powered down!\n", cpu);
-		cpumask_or(cpumask, cpumask, cpumask_of(cpu));
+		cpumask_or(&debug_err_mask, &debug_err_mask, cpumask_of(cpu));
 		return;
 	}
 
@@ -932,6 +952,7 @@ static int __cpuinit dbg_reset_notify(struct notifier_block *self,
 {
 	if (action == CPU_ONLINE)
 		smp_call_function_single((int)cpu, reset_ctrl_regs, NULL, 1);
+
 	return NOTIFY_OK;
 }
 
@@ -942,7 +963,6 @@ static struct notifier_block __cpuinitdata dbg_reset_nb = {
 static int __init arch_hw_breakpoint_init(void)
 {
 	u32 dscr;
-	cpumask_t cpumask = { CPU_BITS_NONE };
 
 	debug_arch = get_debug_arch();
 
@@ -955,21 +975,29 @@ static int __init arch_hw_breakpoint_init(void)
 	core_num_brps = get_num_brps();
 	core_num_wrps = get_num_wrps();
 
-	pr_info("found %d " "%s" "breakpoint and %d watchpoint registers.\n",
-		core_num_brps, core_has_mismatch_brps() ? "(+1 reserved) " :
-		"", core_num_wrps);
+	/*
+	 * We need to tread carefully here because DBGSWENABLE may be
+	 * driven low on this core and there isn't an architected way to
+	 * determine that.
+	 */
+	register_undef_hook(&debug_reg_hook);
 
 	/*
 	 * Reset the breakpoint resources. We assume that a halting
 	 * debugger will leave the world in a nice state for us.
 	 */
-	on_each_cpu(reset_ctrl_regs, &cpumask, 1);
-	if (!cpumask_empty(&cpumask)) {
+	on_each_cpu(reset_ctrl_regs, NULL, 1);
+	unregister_undef_hook(&debug_reg_hook);
+	if (!cpumask_empty(&debug_err_mask)) {
 		core_num_brps = 0;
 		core_num_wrps = 0;
 		return 0;
 	}
 
+	pr_info("found %d " "%s" "breakpoint and %d watchpoint registers.\n",
+		core_num_brps, core_has_mismatch_brps() ? "(+1 reserved) " :
+		"", core_num_wrps);
+
 	ARM_DBG_READ(c1, 0, dscr);
 	if (dscr & ARM_DSCR_HDBGEN) {
 		max_watchpoint_len = 4;
-- 
1.7.0.4
