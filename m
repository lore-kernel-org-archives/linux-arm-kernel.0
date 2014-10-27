From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 27 Oct 2014 18:40:06 +0000
Subject: [PATCHv3 4/5] arm64: Emulate CP15 Barrier instructions
In-Reply-To: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1414435207-30240-6-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CP15 barrier instructions (CP15ISB, CP15DSB and CP15DMB) are
deprecated in the ARMv7 architecture, superseded by ISB, DSB and DMB
instructions respectively. Some implementations may provide the
ability to disable the CP15 barriers by disabling the CP15BEN bit in
SCTLR_EL1. If not enabled, the encodings for these instructions become
undefined.

To support legacy software using these instructions, this patch
register hooks to -
* emulate CP15 barriers and warn the user about their use
* toggle CP15BEN in SCTLR_EL1

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 Documentation/arm64/legacy_instructions.txt |   5 ++
 arch/arm64/Kconfig                          |  15 ++++
 arch/arm64/include/asm/insn.h               |   2 +
 arch/arm64/kernel/armv8_deprecated.c        | 124 ++++++++++++++++++++++++++++
 arch/arm64/kernel/insn.c                    |  13 +++
 5 files changed, 159 insertions(+)

diff --git a/Documentation/arm64/legacy_instructions.txt b/Documentation/arm64/legacy_instructions.txt
index 5ab5861..a3b3da2 100644
--- a/Documentation/arm64/legacy_instructions.txt
+++ b/Documentation/arm64/legacy_instructions.txt
@@ -38,3 +38,8 @@ Supported legacy instructions
 Node: /proc/sys/abi/swp
 Status: Obsolete
 Default: Undef (0)
+
+* CP15 Barriers
+Node: /proc/sys/abi/cp15_barrier
+Status: Deprecated
+Default: Emulate (1)
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6ae8079..2f7026e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -199,6 +199,21 @@ config SWP_EMULATION
 
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
index 6b8fb3b..e5a512b 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -362,6 +362,8 @@ bool aarch32_insn_is_wide_instruction(u32 insn);
 #define A32_RT2_OFFSET	 0
 
 u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
+u32 aarch32_insn_mcr_extract_opc2(u32 insn);
+u32 aarch32_insn_mcr_extract_crm(u32 insn);
 #endif /* __ASSEMBLY__ */
 
 #endif	/* __ASM_INSN_H */
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 6fdacc9..fded15f 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -6,6 +6,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -236,6 +237,126 @@ static struct insn_emulation_ops swp_ops = {
 	.set_hw_mode = NULL,
 };
 
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
+static int cp15_barrier_set_hw_mode(bool enable)
+{
+	if (enable) {
+		register_cpu_notifier(&cpu_hotplug_notifier);
+		on_each_cpu(enable_cp15_ben, NULL, true);
+	} else {
+		unregister_cpu_notifier(&cpu_hotplug_notifier);
+		on_each_cpu(disable_cp15_ben, NULL, true);
+	}
+
+	return 0;
+}
+
+static struct undef_hook cp15_barrier_hooks[] = {
+	{
+		.instr_mask	= 0x0fff0fdf,
+		.instr_val	= 0x0e070f9a,
+		.pstate_mask	= COMPAT_PSR_MODE_MASK,
+		.pstate_val	= COMPAT_PSR_MODE_USR,
+		.fn		= cp15barrier_handler,
+	},
+	{
+		.instr_mask	= 0x0fff0fff,
+		.instr_val	= 0x0e070f95,
+		.pstate_mask	= COMPAT_PSR_MODE_MASK,
+		.pstate_val	= COMPAT_PSR_MODE_USR,
+		.fn		= cp15barrier_handler,
+	},
+	{ }
+};
+
+static struct insn_emulation_ops cp15_barrier_ops = {
+	.name = "cp15_barrier",
+	.status = INSN_DEPRECATED,
+	.hooks = cp15_barrier_hooks,
+	.set_hw_mode = cp15_barrier_set_hw_mode,
+};
+
 static LIST_HEAD(insn_emulation);
 static int nr_insn_emulated;
 static DEFINE_RAW_SPINLOCK(insn_emulation_lock);
@@ -394,6 +515,9 @@ static int __init armv8_deprecated_init(void)
 	if (IS_ENABLED(CONFIG_SWP_EMULATION))
 		register_insn_emulation(&swp_ops);
 
+	if (IS_ENABLED(CONFIG_CP15_BARRIER_EMULATION))
+		register_insn_emulation(&cp15_barrier_ops);
+
 	register_insn_emulation_sysctl(ctl_abi);
 
 	return 0;
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 58574c5..056bedf 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -972,3 +972,16 @@ u32 aarch32_insn_extract_reg_num(u32 insn, int offset)
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
2.1.1
