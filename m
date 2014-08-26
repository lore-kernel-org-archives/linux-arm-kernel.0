From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 26 Aug 2014 11:28:50 +0100
Subject: [PATCH 6/6] arm64: Emulate CP15 Barrier instructions
In-Reply-To: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1409048930-21598-7-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CP15 barrier instructions (CP15ISB, CP15DSB and CP15DMB) are
deprecated in the ARMv7 architecture, superseded by ISB, DSB and DMB
instructions respectively. Some implementations may provide support
for these instructions which can then be enabled by setting the
CP15BEN bit in the SCTLR in ARMv7 or SCTLR_EL1 in ARMv8. If not
enabled, the encodings for these instructions become undefined.

To support legacy software that uses these instructions, this patch
emulates the barrier instructions by installing an undefined
instruction handler. The patch also adds a debugfs entry to track
the occurrence of the deprecated barrier instructions. It is possible
to runtime disable them from debugfs.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/Kconfig              |   15 +++++++
 arch/arm64/include/asm/insn.h   |    2 +
 arch/arm64/kernel/insn.c        |   12 ++++++
 arch/arm64/kernel/v7_obsolete.c |   91 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ba780b1..135c15f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -181,6 +181,21 @@ config SWP_EMULATION
 
 	  If unsure, say N
 
+config CP15_BARRIER_EMULATION
+	bool "Emulate CP15 Barrier instructions"
+	help
+	  ARMv7 architecture deprecates the use of CP15 barrier
+	  instructions - CP15ISB, CP15DSB and CP15DMB. It is strongly
+	  recommended to use the ISB, DSB and DMB instructions
+	  instead.
+
+	  Say Y here to enable software emulation of these
+	  instructions for AArch32 userspace code. When emulation
+	  is enabled, statistics related to the occurrence of these
+	  instructions are also made available via debugfs.
+
+	  If unsure, say N
+
 endif
 
 endmenu
diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 2861cc6..165a8dd 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -112,6 +112,8 @@ int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
 #define RT2_OFFSET	 0
 
 u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
+u32 aarch32_insn_mcr_extract_opc2(u32 insn);
+u32 aarch32_insn_mcr_extract_crm(u32 insn);
 #endif /* CONFIG_V7_OBSOLETE */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 5db9d35..10c6104 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -312,4 +312,16 @@ u32 aarch32_insn_extract_reg_num(u32 insn, int offset)
 	return (insn & (0xf << offset)) >> offset;
 }
 
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
 #endif /* CONFIG_V7_OBSOLETE */
diff --git a/arch/arm64/kernel/v7_obsolete.c b/arch/arm64/kernel/v7_obsolete.c
index e9427cb..ed77889 100644
--- a/arch/arm64/kernel/v7_obsolete.c
+++ b/arch/arm64/kernel/v7_obsolete.c
@@ -227,6 +227,94 @@ static void __init swp_emulation_init(void)
 		pr_notice("Registered SWP/SWPB emulation handler\n");
 }
 
+static atomic_t cp15_barrier_count;
+static u32 cp15_barrier_enabled = 1;
+
+static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
+{
+	if (!cp15_barrier_enabled)
+		return -EFAULT;
+
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
+	switch(aarch32_insn_mcr_extract_crm(instr)) {
+	case 10:
+		/*
+		 * dmb - mcr p15, 0, Rt, c7, c10, 5
+		 * dsb - mcr p15, 0, Rt, c7, c10, 4
+		 */
+		if (aarch32_insn_mcr_extract_opc2(instr) == 5)
+			dmb();
+		else
+			dsb();
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
+	atomic_inc(&cp15_barrier_count);
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
+static void __init cp15_barrier_emulation_init(void)
+{
+	struct dentry *cp15_d;
+
+	atomic_set(&cp15_barrier_count, 0);
+
+	cp15_d = debugfs_create_dir("cp15_barrier_emulation", arch_debugfs_dir);
+	if (!IS_ERR_OR_NULL(cp15_d)) {
+		debugfs_create_atomic_t("cp15_barrier_count", S_IRUGO, cp15_d,
+				&cp15_barrier_count);
+		debugfs_create_bool("enabled", S_IRUGO | S_IWUSR, cp15_d,
+				&cp15_barrier_enabled);
+	}
+
+	if (register_undef_hook(&cp15db_hook) == 0 &&
+		register_undef_hook(&cp15isb_hook) == 0)
+		pr_notice("Registered CP15 Barrier emulation handler\n");
+}
+
 /*
  * Invoked as late_initcall, since not needed before init spawned.
  */
@@ -235,6 +323,9 @@ static int __init v7_obsolete_init(void)
 	if (IS_ENABLED(CONFIG_SWP_EMULATION))
 		swp_emulation_init();
 
+	if (IS_ENABLED(CONFIG_CP15_BARRIER_EMULATION))
+		cp15_barrier_emulation_init();
+
 	return 0;
 }
 
-- 
1.7.10.4
