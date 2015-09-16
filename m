From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 16 Sep 2015 15:21:18 +0100
Subject: [PATCH 20/22] arm64: Expose feature registers by emulating MRS
In-Reply-To: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
References: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1442413280-31885-21-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This patch adds the hook for emulating MRS instruction to
export the 'user visible' value of supported system registers.
We emulate only the following id space for system registers:
	Op0=0, Op1=0, CRn=0.

The rest will fall back to SIGILL.

This capability is also advertised via a new HWCAP_CPUID.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 Changes since V1:
   - Add a new HWCAP_CPUID to advertise the availability of the
     emulation.
---
 arch/arm64/include/asm/sysreg.h     |    3 ++
 arch/arm64/include/uapi/asm/hwcap.h |    1 +
 arch/arm64/kernel/cpufeature.c      |   94 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c         |    1 +
 4 files changed, 99 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index dc72fc6..b44ad93 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -192,6 +192,9 @@
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
index c898ef1..6c92c81 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -24,6 +24,7 @@
 #include <asm/cpufeature.h>
 #include <asm/processor.h>
 #include <asm/sysreg.h>
+#include <asm/traps.h>
 
 unsigned long elf_hwcap __read_mostly;
 EXPORT_SYMBOL_GPL(elf_hwcap);
@@ -709,6 +710,8 @@ void check_cpu_hwcaps(void)
 {
 	int i;
 	const struct arm64_cpu_capabilities *hwcaps = arm64_hwcaps;
+
+	elf_hwcap |= HWCAP_CPUID;
 	for(i = 0; i < ARRAY_SIZE(arm64_hwcaps); i ++)
 		if (hwcaps[i].matches(&hwcaps[i]))
 			cap_set_hwcap(&hwcaps[i]);
@@ -880,3 +883,94 @@ void __init setup_cpu_features(void)
 			L1_CACHE_BYTES, cls);
 }
 
+/*
+ * We emulate only the following system register space.
+ * 	Op0 = 0x3, CRn = 0x0, Op1 = 0x0
+ * See Table C5-6 System instruction encodings for System register accesses,
+ * ARMv8 ARM(ARM DDI 0487A.f) for more details.
+ */
+static int __attribute_const__ is_emulated(u32 id)
+{
+	if (sys_reg_Op0(id) != 0x3 ||
+	    sys_reg_CRn(id) != 0x0 ||
+	    sys_reg_Op1(id) != 0x0)
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
+	switch(id) {
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
+	struct arm64_ftr_reg *regp;
+
+	if (!is_emulated(id))
+		return -EINVAL;
+
+	if (sys_reg_CRm(id) == 0)
+		return emulate_id_reg(id, valp);
+
+	regp = get_arm64_sys_reg(id);
+	if (regp)
+		*valp = regp->user_val | (regp->sys_val & regp->user_mask);
+	else
+		/*
+		 * Registers we don't track are either IMPLEMENTAION DEFINED
+		 * (e.g, ID_AFR0_EL1) or reserved RAZ.
+		 */
+		*valp = 0;
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
