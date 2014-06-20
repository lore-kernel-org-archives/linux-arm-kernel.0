From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Jun 2014 14:00:05 +0100
Subject: [PATCH v3 7/9] arm64: KVM: add trap handlers for AArch32 debug
 registers
In-Reply-To: <1403269207-1625-1-git-send-email-marc.zyngier@arm.com>
References: <1403269207-1625-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403269207-1625-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add handlers for all the AArch32 debug registers that are accessible
from EL0 or EL1. The code follow the same strategy as the AArch64
counterpart with regards to tracking the dirty state of the debug
registers.

Reviewed-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_asm.h |   9 +++
 arch/arm64/kvm/sys_regs.c        | 144 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 12f9dd7..993a7db 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -93,6 +93,15 @@
 #define c10_AMAIR0	(AMAIR_EL1 * 2)	/* Aux Memory Attr Indirection Reg */
 #define c10_AMAIR1	(c10_AMAIR0 + 1)/* Aux Memory Attr Indirection Reg */
 #define c14_CNTKCTL	(CNTKCTL_EL1 * 2) /* Timer Control Register (PL1) */
+
+#define cp14_DBGDSCRext	(MDSCR_EL1 * 2)
+#define cp14_DBGBCR0	(DBGBCR0_EL1 * 2)
+#define cp14_DBGBVR0	(DBGBVR0_EL1 * 2)
+#define cp14_DBGBXVR0	(cp14_DBGBVR0 + 1)
+#define cp14_DBGWCR0	(DBGWCR0_EL1 * 2)
+#define cp14_DBGWVR0	(DBGWVR0_EL1 * 2)
+#define cp14_DBGDCCINT	(MDCCINT_EL1 * 2)
+
 #define NR_COPRO_REGS	(NR_SYS_REGS * 2)
 
 #define ARM_EXCEPTION_IRQ	  0
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 9147b0c..daa635e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -483,12 +483,153 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  NULL, reset_val, FPEXC32_EL2, 0x70 },
 };
 
-/* Trapped cp14 registers */
+static bool trap_dbgidr(struct kvm_vcpu *vcpu,
+			const struct sys_reg_params *p,
+			const struct sys_reg_desc *r)
+{
+	if (p->is_write) {
+		return ignore_write(vcpu, p);
+	} else {
+		u64 dfr = read_cpuid(ID_AA64DFR0_EL1);
+		u64 pfr = read_cpuid(ID_AA64PFR0_EL1);
+		u32 el3 = !!((pfr >> 12) & 0xf);
+
+		*vcpu_reg(vcpu, p->Rt) = ((((dfr >> 20) & 0xf) << 28) |
+					  (((dfr >> 12) & 0xf) << 24) |
+					  (((dfr >> 28) & 0xf) << 20) |
+					  (6 << 16) | (el3 << 14) | (el3 << 12));
+		return true;
+	}
+}
+
+static bool trap_debug32(struct kvm_vcpu *vcpu,
+			 const struct sys_reg_params *p,
+			 const struct sys_reg_desc *r)
+{
+	if (p->is_write) {
+		vcpu_cp14(vcpu, r->reg) = *vcpu_reg(vcpu, p->Rt);
+		vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_DIRTY;
+	} else {
+		*vcpu_reg(vcpu, p->Rt) = vcpu_cp14(vcpu, r->reg);
+	}
+
+	return true;
+}
+
+#define DBG_BCR_BVR_WCR_WVR(n)					\
+	/* DBGBVRn */						\
+	{ Op1( 0), CRn( 0), CRm((n)), Op2( 4), trap_debug32,	\
+	  NULL, (cp14_DBGBVR0 + (n) * 2) },			\
+	/* DBGBCRn */						\
+	{ Op1( 0), CRn( 0), CRm((n)), Op2( 5), trap_debug32,	\
+	  NULL, (cp14_DBGBCR0 + (n) * 2) },			\
+	/* DBGWVRn */						\
+	{ Op1( 0), CRn( 0), CRm((n)), Op2( 6), trap_debug32,	\
+	  NULL, (cp14_DBGWVR0 + (n) * 2) },			\
+	/* DBGWCRn */						\
+	{ Op1( 0), CRn( 0), CRm((n)), Op2( 7), trap_debug32,	\
+	  NULL, (cp14_DBGWCR0 + (n) * 2) }
+
+#define DBGBXVR(n)						\
+	{ Op1( 0), CRn( 1), CRm((n)), Op2( 1), trap_debug32,	\
+	  NULL, cp14_DBGBXVR0 + n * 2 }
+
+/*
+ * Trapped cp14 registers. We generally ignore most of the external
+ * debug, on the principle that they don't really make sense to a
+ * guest. Revisit this one day, whould this principle change.
+ */
 static const struct sys_reg_desc cp14_regs[] = {
+	/* DBGIDR */
+	{ Op1( 0), CRn( 0), CRm( 0), Op2( 0), trap_dbgidr },
+	/* DBGDTRRXext */
+	{ Op1( 0), CRn( 0), CRm( 0), Op2( 2), trap_raz_wi },
+
+	DBG_BCR_BVR_WCR_WVR(0),
+	/* DBGDSCRint */
+	{ Op1( 0), CRn( 0), CRm( 1), Op2( 0), trap_raz_wi },
+	DBG_BCR_BVR_WCR_WVR(1),
+	/* DBGDCCINT */
+	{ Op1( 0), CRn( 0), CRm( 2), Op2( 0), trap_debug32 },
+	/* DBGDSCRext */
+	{ Op1( 0), CRn( 0), CRm( 2), Op2( 2), trap_debug32 },
+	DBG_BCR_BVR_WCR_WVR(2),
+	/* DBGDTR[RT]Xint */
+	{ Op1( 0), CRn( 0), CRm( 3), Op2( 0), trap_raz_wi },
+	/* DBGDTR[RT]Xext */
+	{ Op1( 0), CRn( 0), CRm( 3), Op2( 2), trap_raz_wi },
+	DBG_BCR_BVR_WCR_WVR(3),
+	DBG_BCR_BVR_WCR_WVR(4),
+	DBG_BCR_BVR_WCR_WVR(5),
+	/* DBGWFAR */
+	{ Op1( 0), CRn( 0), CRm( 6), Op2( 0), trap_raz_wi },
+	/* DBGOSECCR */
+	{ Op1( 0), CRn( 0), CRm( 6), Op2( 2), trap_raz_wi },
+	DBG_BCR_BVR_WCR_WVR(6),
+	/* DBGVCR */
+	{ Op1( 0), CRn( 0), CRm( 7), Op2( 0), trap_debug32 },
+	DBG_BCR_BVR_WCR_WVR(7),
+	DBG_BCR_BVR_WCR_WVR(8),
+	DBG_BCR_BVR_WCR_WVR(9),
+	DBG_BCR_BVR_WCR_WVR(10),
+	DBG_BCR_BVR_WCR_WVR(11),
+	DBG_BCR_BVR_WCR_WVR(12),
+	DBG_BCR_BVR_WCR_WVR(13),
+	DBG_BCR_BVR_WCR_WVR(14),
+	DBG_BCR_BVR_WCR_WVR(15),
+
+	/* DBGDRAR (32bit) */
+	{ Op1( 0), CRn( 1), CRm( 0), Op2( 0), trap_raz_wi },
+
+	DBGBXVR(0),
+	/* DBGOSLAR */
+	{ Op1( 0), CRn( 1), CRm( 0), Op2( 4), trap_raz_wi },
+	DBGBXVR(1),
+	/* DBGOSLSR */
+	{ Op1( 0), CRn( 1), CRm( 1), Op2( 4), trap_oslsr_el1 },
+	DBGBXVR(2),
+	DBGBXVR(3),
+	/* DBGOSDLR */
+	{ Op1( 0), CRn( 1), CRm( 3), Op2( 4), trap_raz_wi },
+	DBGBXVR(4),
+	/* DBGPRCR */
+	{ Op1( 0), CRn( 1), CRm( 4), Op2( 4), trap_raz_wi },
+	DBGBXVR(5),
+	DBGBXVR(6),
+	DBGBXVR(7),
+	DBGBXVR(8),
+	DBGBXVR(9),
+	DBGBXVR(10),
+	DBGBXVR(11),
+	DBGBXVR(12),
+	DBGBXVR(13),
+	DBGBXVR(14),
+	DBGBXVR(15),
+
+	/* DBGDSAR (32bit) */
+	{ Op1( 0), CRn( 2), CRm( 0), Op2( 0), trap_raz_wi },
+
+	/* DBGDEVID2 */
+	{ Op1( 0), CRn( 7), CRm( 0), Op2( 7), trap_raz_wi },
+	/* DBGDEVID1 */
+	{ Op1( 0), CRn( 7), CRm( 1), Op2( 7), trap_raz_wi },
+	/* DBGDEVID */
+	{ Op1( 0), CRn( 7), CRm( 2), Op2( 7), trap_raz_wi },
+	/* DBGCLAIMSET */
+	{ Op1( 0), CRn( 7), CRm( 8), Op2( 6), trap_raz_wi },
+	/* DBGCLAIMCLR */
+	{ Op1( 0), CRn( 7), CRm( 9), Op2( 6), trap_raz_wi },
+	/* DBGAUTHSTATUS */
+	{ Op1( 0), CRn( 7), CRm(14), Op2( 6), trap_dbgauthstatus_el1 },
 };
 
 /* Trapped cp14 64bit registers */
 static const struct sys_reg_desc cp14_64_regs[] = {
+	/* DBGDRAR (64bit) */
+	{ Op1( 0), CRm( 1), .access = trap_raz_wi },
+
+	/* DBGDSAR (64bit) */
+	{ Op1( 0), CRm( 2), .access = trap_raz_wi },
 };
 
 /*
@@ -536,7 +677,6 @@ static const struct sys_reg_desc cp15_regs[] = {
 	{ Op1( 0), CRn(10), CRm( 3), Op2( 0), access_vm_reg, NULL, c10_AMAIR0 },
 	{ Op1( 0), CRn(10), CRm( 3), Op2( 1), access_vm_reg, NULL, c10_AMAIR1 },
 	{ Op1( 0), CRn(13), CRm( 0), Op2( 1), access_vm_reg, NULL, c13_CID },
-
 };
 
 static const struct sys_reg_desc cp15_64_regs[] = {
-- 
1.8.3.4
