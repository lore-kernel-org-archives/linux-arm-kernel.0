From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 24 Jul 2015 10:43:54 +0100
Subject: [RFC PATCH 08/10] arm64: Emulate ID registers
In-Reply-To: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1437731037-25795-9-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This patch adds the emulation for the id registers(i,e Op0=0,
Op1=0, CRn=0, CRm=0).

Expose MIDR_EL1 for the current cpu where the 'mrs' instruction
is executed. The users should be aware that, on a heterogeneous
system, there is no guarantee that the 'value' read belongs to
the current CPU where it is executing, as we could get migrated
to another CPU in between.

MPIDR and REVIDR are not visible and hence contain safe default
value as per the rules.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpu.h |    7 +++++++
 arch/arm64/kernel/cpuinfo.c  |   20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 2df3d81..cb25cb9 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -25,6 +25,10 @@
 #define SYS_REG(op0, op1, crn, crm, op2) \
 			(sys_reg(op0, op1, crn, crm, op2) >> 5)
 
+#define SYS_MIDR_EL1			SYS_REG(3, 0, 0, 0, 0)
+#define SYS_MPIDR_EL1			SYS_REG(3, 0, 0, 0, 5)
+#define SYS_REVIDR_EL1			SYS_REG(3, 0, 0, 0, 6)
+
 #define SYS_ID_PFR0_EL1			SYS_REG(3, 0, 0, 1, 0)
 #define SYS_ID_PFR1_EL1			SYS_REG(3, 0, 0, 1, 1)
 #define SYS_ID_DFR0_EL1			SYS_REG(3, 0, 0, 1, 2)
@@ -67,6 +71,9 @@
 #define SYSREG_CRm(id)		(((id) >> 3) & 0xf)
 #define SYSREG_Op2(id)		(((id) >> 0) & 0x7)
 
+/* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:1 */
+#define SYS_MPIDR_SAFE_VAL	((1UL<<31)|(1UL<<24))
+
 enum sys_id {
 	sys_cntfrq = SYS_CNTFRQ_EL0,
 	sys_ctr = SYS_CTR_EL0,
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 36e5058..9145eef 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -818,6 +818,23 @@ static int is_emulated(u32 id)
 	return 1;
 }
 
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
 static int emulate_sys_reg(u32 id, u64 *valp)
 {
 	struct arm64_ftr_reg *regp;
@@ -825,6 +842,9 @@ static int emulate_sys_reg(u32 id, u64 *valp)
 	if (!is_emulated(id))
 		return -EINVAL;
 
+	if (SYSREG_CRm(id) == 0)
+		return emulate_id_reg(id, valp);
+
 	regp = get_arm64_sys_reg(id);
 	if (regp)
 		*valp = regp->user_val | (regp->sys_val & regp->user_mask);
-- 
1.7.9.5
