From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed,  1 Oct 2014 14:37:09 +0100
Subject: [PATCHv2 4/5] arm64: Emulate CP15 Barrier instructions
In-Reply-To: <1412170630-18408-1-git-send-email-punit.agrawal@arm.com>
References: <1412165279-8709-1-git-send-email-punit.agrawal@arm.com>
 <1412170630-18408-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1412170630-18408-5-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CP15 barrier instructions (CP15ISB, CP15DSB and CP15DMB) are
deprecated in the ARMv7 architecture, superseded by ISB, DSB and DMB
instructions respectively. Some implementations may provide the
ability to disable the CP15 barriers by disabling the CP15BEN bit in
SCTLR_EL1. If not enabled, the encodings for these instructions become
undefined.

To support legacy software using these instructions, this patch adds
support to -
* emulate CP15 barriers and warn the user about their use
* toggle CP15BEN in SCTLR_EL1

The choice between using emulation or hardware execution is controlled
via sysctl. To aid migration of software it defaults to emulation.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/Kconfig                   |   15 +++
 arch/arm64/include/asm/insn.h        |    2 +
 arch/arm64/kernel/armv8_deprecated.c |  189 +++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/insn.c             |   13 +++
 4 files changed, 218 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 89262da..0abaf7b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -186,6 +186,21 @@ config SWP_EMULATION
 
 	  If unsure, say N
 
+config CP15_BARRIER_EMULATION
+	bool "Emulate CP15 Barrier instructions"
+	help
+	  The CP15 barrier instructions - CP15ISB, CP15DSB, and
+	  CP15DMB - are deprecated in ARMv8 (and ARMv7). It is
+	  strongly recommended to use the ISB, DSB, and DMB
+	  instructions instead.
+
+	  Say Y here to enable software emulation of these
+	  instructions for AArch32 userspace code. When this option is
+	  enabled, CP15 barrier usage is traced which can help
+	  identify software that needs updating.
+
+	  If unsure, say N
+
 endif
 
 endmenu
diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index c3b7c2f..de684fe 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -113,6 +113,8 @@ bool aarch32_insn_is_wide_instruction(u32 instr);
 #define RT2_OFFSET	 0
 
 u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
+u32 aarch32_insn_mcr_extract_opc2(u32 insn);
+u32 aarch32_insn_mcr_extract_crm(u32 insn);
 #endif /* __ASSEMBLY__ */
 
 #endif	/* __ASM_INSN_H */
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 23fc6f8..53a6252 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/perf_event.h>
@@ -23,13 +24,15 @@
 
 /*
  * The runtime support for deprecated instruction support can be in one of
- * following two states -
+ * following three states -
  *
  * 0 = undef
  * 1 = emulate (software emulation)
+ * 2 = enable (supported in hardware)
  */
 #define INSTR_UNDEF (0)
 #define INSTR_EMULATE (1)
+#define INSTR_ENABLE (2)
 
 /*
  *  Implement emulation of the SWP/SWPB instructions using load-exclusive and
@@ -249,6 +252,178 @@ static int proc_swp_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
+/*
+ * CP15 barriers default to emulate as they have been deprecated in the
+ * architecture.
+ */
+static u32 cp15_barrier_enable = 1;
+static u32 cp15_barrier_enable_min = INSTR_UNDEF;
+static u32 cp15_barrier_enable_max = INSTR_ENABLE;
+
+static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
+{
+	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, regs->pc);
+
+	switch (arm_check_condition(instr, regs->pstate)) {
+	case ARM_OPCODE_CONDTEST_PASS:
+		break;
+	case ARM_OPCODE_CONDTEST_FAIL:
+		/* Condition failed - return to next instruction */
+		goto ret;
+	case ARM_OPCODE_CONDTEST_UNCOND:
+		/* If unconditional encoding - not a barrier instruction */
+		return -EFAULT;
+	default:
+		return -EINVAL;
+	}
+
+	switch (aarch32_insn_mcr_extract_crm(instr)) {
+	case 10:
+		/*
+		 * dmb - mcr p15, 0, Rt, c7, c10, 5
+		 * dsb - mcr p15, 0, Rt, c7, c10, 4
+		 */
+		if (aarch32_insn_mcr_extract_opc2(instr) == 5)
+			dmb(sy);
+		else
+			dsb(sy);
+		break;
+	case 5:
+		/*
+		 * isb - mcr p15, 0, Rt, c7, c5, 4
+		 */
+		isb();
+		break;
+	}
+
+ret:
+	pr_warn_ratelimited("\"%s\" (%ld) uses deprecated CP15 Barrier instruction at 0x%llx\n",
+			current->comm, (unsigned long)current->pid, regs->pc);
+
+	regs->pc += 4;
+	return 0;
+}
+
+/* data barrier */
+static struct undef_hook cp15db_hook = {
+	.instr_mask	= 0x0fff0fdf,
+	.instr_val	= 0x0e070f9a,
+	.pstate_mask	= COMPAT_PSR_MODE_MASK,
+	.pstate_val	= COMPAT_PSR_MODE_USR,
+	.fn		= cp15barrier_handler,
+};
+
+/* instruction barrier */
+static struct undef_hook cp15isb_hook = {
+	.instr_mask	= 0x0fff0fff,
+	.instr_val	= 0x0e070f95,
+	.pstate_mask	= COMPAT_PSR_MODE_MASK,
+	.pstate_val	= COMPAT_PSR_MODE_USR,
+	.fn		= cp15barrier_handler,
+};
+
+static void cp15_barrier_emulation_init(void)
+{
+	if (register_undef_hook(&cp15db_hook) == 0 &&
+		register_undef_hook(&cp15isb_hook) == 0)
+		pr_notice("Registered CP15 Barrier emulation handler\n");
+}
+
+static void cp15_barrier_emulation_remove(void)
+{
+	unregister_undef_hook(&cp15db_hook);
+	unregister_undef_hook(&cp15isb_hook);
+
+	pr_notice("Removed CP15 Barrier emulation handler\n");
+}
+
+#define SCTLR_EL1_CP15BEN (1 << 5)
+
+static inline void config_sctlr_el1(u32 clear, u32 set)
+{
+	u32 val;
+
+	asm volatile("mrs %0, sctlr_el1" : "=r" (val));
+	val &= ~clear;
+	val |= set;
+	asm volatile("msr sctlr_el1, %0" : : "r" (val));
+}
+
+static void enable_cp15_ben(void *info)
+{
+	config_sctlr_el1(0, SCTLR_EL1_CP15BEN);
+}
+
+static void disable_cp15_ben(void *info)
+{
+	config_sctlr_el1(SCTLR_EL1_CP15BEN, 0);
+}
+
+static int cpu_hotplug_notify(struct notifier_block *b, unsigned long action,
+			  void *hcpu)
+{
+	switch (action) {
+	case CPU_STARTING:
+		enable_cp15_ben(NULL);
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpu_hotplug_notifier = {
+	.notifier_call = cpu_hotplug_notify,
+};
+
+static void cp15_barrier_init(void)
+{
+	switch (cp15_barrier_enable) {
+	case INSTR_UNDEF: /* turned off, nothing to do */
+		break;
+	case INSTR_EMULATE: /* register emulation hooks */
+		cp15_barrier_emulation_init();
+		break;
+	case INSTR_ENABLE: /* Set CP15BEN in SCTLR_EL1 */
+		register_cpu_notifier(&cpu_hotplug_notifier);
+		on_each_cpu(enable_cp15_ben, NULL, true);
+		break;
+	}
+}
+
+static void cp15_barrier_remove(u32 deprecated_feature_state)
+{
+	/* Disable current handling */
+	switch (deprecated_feature_state) {
+	case INSTR_UNDEF: /* already off, do nothing */
+		break;
+	case INSTR_EMULATE: /* unregister emulation hooks */
+		cp15_barrier_emulation_remove();
+		break;
+	case INSTR_ENABLE: /* Clear CP15BEN in SCTLR_EL1 */
+		unregister_cpu_notifier(&cpu_hotplug_notifier);
+		on_each_cpu(disable_cp15_ben, NULL, true);
+		break;
+	}
+}
+
+static int proc_cp15_barrier_handler(struct ctl_table *table, int write,
+		void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	u32 prev = cp15_barrier_enable;
+	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (ret || !write || prev == cp15_barrier_enable)
+		return ret;
+
+	/* disable previous mechanism */
+	cp15_barrier_remove(prev);
+
+	/* Install new mechanism */
+	cp15_barrier_init();
+
+	return ret;
+}
+
 static struct ctl_table ctl_armv8_deprecated[] = {
 	{
 		.procname = "swp_enable",
@@ -259,6 +434,15 @@ static struct ctl_table ctl_armv8_deprecated[] = {
 		.extra1 = &swp_enable_min,
 		.extra2 = &swp_enable_max,
 	},
+	{
+		.procname = "cp15_barrier_enable",
+		.data = &cp15_barrier_enable,
+		.maxlen = sizeof(u32),
+		.mode = 0644,
+		.proc_handler = proc_cp15_barrier_handler,
+		.extra1 = &cp15_barrier_enable_min,
+		.extra2 = &cp15_barrier_enable_max,
+	},
 	{ }
 };
 
@@ -279,6 +463,9 @@ static int __init armv8_deprecated_init(void)
 	if (IS_ENABLED(CONFIG_SWP_EMULATION))
 		swp_init();
 
+	if (IS_ENABLED(CONFIG_CP15_BARRIER_EMULATION))
+		cp15_barrier_init();
+
 	register_sysctl_table(ctl_abi);
 
 	return 0;
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 6e77a54..b01b8e4 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -315,3 +315,16 @@ u32 aarch32_insn_extract_reg_num(u32 insn, int offset)
 {
 	return (insn & (0xf << offset)) >> offset;
 }
+
+#define OPC2_MASK	0x7
+#define OPC2_OFFSET	5
+u32 aarch32_insn_mcr_extract_opc2(u32 insn)
+{
+	return (insn & (OPC2_MASK << OPC2_OFFSET)) >> OPC2_OFFSET;
+}
+
+#define CRM_MASK	0xf
+u32 aarch32_insn_mcr_extract_crm(u32 insn)
+{
+	return insn & CRM_MASK;
+}
-- 
1.7.10.4
