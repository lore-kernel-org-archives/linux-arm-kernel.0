From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 24 Jul 2015 10:43:53 +0100
Subject: [RFC PATCH 07/10] arm64: Expose feature registers by emulating MRS
In-Reply-To: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1437731037-25795-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This patch adds the hook for emulating MRS instruction to
export the 'user visible' value of supported system registers.
We emulate only the following id space for system registers:
	Op0=0, Op1=0, CRn=0.

The rest will fall back to SIGILL.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpu.h |    6 ++++
 arch/arm64/kernel/cpuinfo.c  |   82 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index c7b0b89..2df3d81 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -61,6 +61,12 @@
 #define SYS_CTR_EL0			SYS_REG(3, 3, 0, 0, 1)
 #define SYS_DCZID_EL0			SYS_REG(3, 3, 0, 0, 7)
 
+#define SYSREG_Op0(id)		(((id) >> 14) & 0x3)
+#define SYSREG_Op1(id)		(((id) >> 11) & 0x7)
+#define SYSREG_CRn(id)		(((id) >> 7) & 0xf)
+#define SYSREG_CRm(id)		(((id) >> 3) & 0xf)
+#define SYSREG_Op2(id)		(((id) >> 0) & 0x7)
+
 enum sys_id {
 	sys_cntfrq = SYS_CNTFRQ_EL0,
 	sys_ctr = SYS_CTR_EL0,
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index ae2a37f..36e5058 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -19,6 +19,8 @@
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
+#include <asm/insn.h>
+#include <asm/traps.h>
 
 #include <linux/bitops.h>
 #include <linux/bug.h>
@@ -787,3 +789,83 @@ const struct seq_operations cpuinfo_op = {
 	.show	= c_show
 };
 
+/*
+ * We emulate only the following system register space.
+ * 	Op0 = 0x3, CRn = 0x0, Op1 = 0x0
+ * Further, at the moment,  with CRm = 0, Op2 should be one of :
+ *	0(MIDR_EL1)
+ *	5(MPIDR_EL1),
+ *  	6(REVIDR_EL1)
+ * See Table C5-6 System instruction encodings for System register accesses,
+ * ARMv8 ARM(ARM DDI 0487A.f) for more details.
+ */
+static int is_emulated(u32 id)
+{
+	if (SYSREG_Op0(id) != 0x3 ||
+	    SYSREG_CRn(id) != 0x0 ||
+	    SYSREG_Op1(id) != 0x0)
+		return 0;
+	if (SYSREG_CRm(id) == 0) {
+		switch(SYSREG_Op2(id)) {
+		default:
+			return 0;
+		case 0:
+		case 5:
+		case 6:
+			return 1;
+		}
+	}
+	return 1;
+}
+
+static int emulate_sys_reg(u32 id, u64 *valp)
+{
+	struct arm64_ftr_reg *regp;
+
+	if (!is_emulated(id))
+		return -EINVAL;
+
+	regp = get_arm64_sys_reg(id);
+	if (regp)
+		*valp = regp->user_val | (regp->sys_val & regp->user_mask);
+	else {
+		/*
+		 * Registers we don't track are either IMPLEMENTAION DEFINED
+		 * (e.g, ID_AFR0_EL1) or reserved RAZ.
+		 */
+		*valp = 0;
+	}
+	return 0;
+}
+
+static int emulate_mrs(struct pt_regs *regs, u32 insn)
+{
+	int rc = 0;
+	u32 sys_reg, dst;
+	u64 val = 0;
+
+	sys_reg = (u32)aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn);
+	rc = emulate_sys_reg(sys_reg, &val);
+	if (rc)
+		return rc;
+	dst = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT ,insn);
+	regs->user_regs.regs[dst] = val;
+	regs->pc += 4;
+	return 0;
+}
+
+static struct undef_hook mrs_hook = {
+	.instr_mask = 0xfff00000,
+	.instr_val  = 0xd5300000,
+	.pstate_mask = COMPAT_PSR_MODE_MASK,
+	.pstate_val = PSR_MODE_EL0t,
+	.fn = emulate_mrs,
+};
+
+int __init arm64_cpuinfo_init(void)
+{
+	register_undef_hook(&mrs_hook);
+	return 0;
+}
+
+late_initcall(arm64_cpuinfo_init);
-- 
1.7.9.5
