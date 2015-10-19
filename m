From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:25:00 +0100
Subject: [PATCHv4 23/24] arm64: Expose feature registers by emulating MRS
In-Reply-To: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
References: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445261101-22344-24-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the hook for emulating MRS instruction to
export the 'user visible' value of supported system registers.
We emulate only the following id space for system registers:
	Op0=0, Op1=0, CRn=0.

The rest will fall back to SIGILL.

This capability is also advertised via a new HWCAP_CPUID.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/sysreg.h     |    6 ++
 arch/arm64/include/uapi/asm/hwcap.h |    1 +
 arch/arm64/kernel/cpufeature.c      |  105 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c         |    1 +
 4 files changed, 113 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 22f1a88..2ee98db 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -54,6 +54,9 @@
 #define sys_reg_CRm(id)	(((id) >> CRm_shift) & CRm_mask)
 #define sys_reg_Op2(id)	(((id) >> Op2_shift) & Op2_mask)
 
+/* sys_reg() encoding of id is shifted by 5 for use in mrs */
+#define SYS_REG_IMM_SHIFT		5
+
 #define SYS_MIDR_EL1			sys_reg(3, 0, 0, 0, 0)
 #define SYS_MPIDR_EL1			sys_reg(3, 0, 0, 0, 5)
 #define SYS_REVIDR_EL1			sys_reg(3, 0, 0, 0, 6)
@@ -188,6 +191,9 @@
 #define MVFR1_FPFTZ_SHIFT		0
 
 
+/* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:1 */
+#define SYS_MPIDR_SAFE_VAL	((1UL<<31)|(1UL<<24))
+
 #ifdef __ASSEMBLY__
 
 	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 361c8a8..3386e64 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -28,5 +28,6 @@
 #define HWCAP_SHA2		(1 << 6)
 #define HWCAP_CRC32		(1 << 7)
 #define HWCAP_ATOMICS		(1 << 8)
+#define HWCAP_CPUID		(1 << 9)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 896a821..c44da31 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -26,6 +26,7 @@
 #include <asm/cpu_ops.h>
 #include <asm/processor.h>
 #include <asm/sysreg.h>
+#include <asm/traps.h>
 
 unsigned long elf_hwcap __read_mostly;
 EXPORT_SYMBOL_GPL(elf_hwcap);
@@ -716,6 +717,7 @@ static void setup_cpu_hwcaps(void)
 	int i;
 	const struct arm64_cpu_capabilities *hwcaps = arm64_hwcaps;
 
+	elf_hwcap |= HWCAP_CPUID;
 	for (i = 0; hwcaps[i].desc; i++)
 		if (hwcaps[i].matches(&hwcaps[i]))
 			cap_set_hwcap(&hwcaps[i]);
@@ -908,3 +910,106 @@ void __init setup_cpu_features(void)
 		pr_warn("L1_CACHE_BYTES smaller than the Cache Writeback Granule (%d < %d)\n",
 			L1_CACHE_BYTES, cls);
 }
+
+/*
+ * We emulate only the following system register space.
+ * 	Op0 = 0x3, CRn = 0x0, Op1 = 0x0, CRm = [0 - 7]
+ * See Table C5-6 System instruction encodings for System register accesses,
+ * ARMv8 ARM(ARM DDI 0487A.f) for more details.
+ */
+static int __attribute_const__ is_emulated(u32 id)
+{
+	if (sys_reg_Op0(id) != 0x3 ||
+	    sys_reg_CRn(id) != 0x0 ||
+	    sys_reg_Op1(id) != 0x0 ||
+	    sys_reg_CRm(id) > 7)
+		return 0;
+	return 1;
+}
+
+/*
+ * With CRm = 0, id should be one of :
+ *	MIDR_EL1
+ *	MPIDR_EL1
+ *  	REVIDR_EL1
+ */
+static int emulate_id_reg(u32 id, u64 *valp)
+{
+	switch (id) {
+	case SYS_MIDR_EL1:
+		*valp = read_cpuid_id();
+		return 0;
+	case SYS_MPIDR_EL1:
+		*valp = SYS_MPIDR_SAFE_VAL;
+		return 0;
+	case SYS_REVIDR_EL1:
+		*valp = 0;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int emulate_sys_reg(u32 id, u64 *valp)
+{
+	int rc = -EINVAL;
+	struct arm64_ftr_reg *regp;
+
+	if (!is_emulated(id))
+		goto out;
+
+	if (sys_reg_CRm(id) == 0)
+		rc = emulate_id_reg(id, valp);
+	else {
+		/* We emulate all id's in the space 3, 0, 0, [1-7],x */
+		rc = 0;
+		regp = get_arm64_ftr_reg(id);
+		if (regp)
+			*valp = regp->user_val | (regp->sys_val & regp->user_mask);
+		else
+			/*
+			 * Registers we don't track are either IMPLEMENTAION DEFINED
+			 * (e.g, ID_AFR0_EL1) or reserved RAZ.
+			 */
+			*valp = 0;
+	}
+
+out:
+	return rc;
+}
+
+static int emulate_mrs(struct pt_regs *regs, u32 insn)
+{
+	int rc = 0;
+	u32 sys_reg, dst;
+	u64 val = 0;
+
+	/*
+	 * sys_reg values are defined as used in mrs/msr instruction.
+	 * shift the imm value to get the encoding.
+	 */
+	sys_reg = (u32)aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn) << SYS_REG_IMM_SHIFT;
+	rc = emulate_sys_reg(sys_reg, &val);
+	if (rc)
+		return rc;
+	dst = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
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
+int __init arm64_cpufeature_init(void)
+{
+	register_undef_hook(&mrs_hook);
+	return 0;
+}
+
+late_initcall(arm64_cpufeature_init);
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 789fbea..52331ff 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -58,6 +58,7 @@ static const char *hwcap_str[] = {
 	"sha2",
 	"crc32",
 	"atomics",
+	"cpuid",
 	NULL
 };
 
-- 
1.7.9.5
