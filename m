From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 11 Sep 2015 16:55:07 +0800
Subject: [PATCH v2 14/22] KVM: ARM64: Add reset and access handlers for
 PMOVSSET and PMOVSCLR register
In-Reply-To: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
References: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1441961715-11688-15-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Since the reset value of PMOVSSET and PMOVSCLR is UNKNOWN, use
reset_unknown for its reset handler. Add a new case to emulate writing
PMOVSSET or PMOVSCLR register.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c3d4fb5..11fc183 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -323,6 +323,18 @@ static bool access_pmu_regs(struct kvm_vcpu *vcpu,
 			vcpu_sys_reg(vcpu, PMINTENSET_EL1) &= ~val;
 			break;
 		}
+		case PMOVSSET_EL0: {
+			val = *vcpu_reg(vcpu, p->Rt);
+			vcpu_sys_reg(vcpu, r->reg) |= val;
+			vcpu_sys_reg(vcpu, PMOVSCLR_EL0) |= val;
+			break;
+		}
+		case PMOVSCLR_EL0: {
+			val = *vcpu_reg(vcpu, p->Rt);
+			vcpu_sys_reg(vcpu, r->reg) &= ~val;
+			vcpu_sys_reg(vcpu, PMOVSSET_EL0) &= ~val;
+			break;
+		}
 		case PMCR_EL0: {
 			/* Only update writeable bits of PMCR */
 			val = vcpu_sys_reg(vcpu, r->reg);
@@ -561,7 +573,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  access_pmu_regs, reset_unknown, PMCNTENCLR_EL0 },
 	/* PMOVSCLR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b011),
-	  trap_raz_wi },
+	  access_pmu_regs, reset_unknown, PMOVSCLR_EL0 },
 	/* PMSWINC_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b100),
 	  trap_raz_wi },
@@ -588,7 +600,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  trap_raz_wi },
 	/* PMOVSSET_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1110), Op2(0b011),
-	  trap_raz_wi },
+	  access_pmu_regs, reset_unknown, PMOVSSET_EL0 },
 
 	/* TPIDR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1101), CRm(0b0000), Op2(0b010),
@@ -809,6 +821,18 @@ static bool access_pmu_cp15_regs(struct kvm_vcpu *vcpu,
 			vcpu_cp15(vcpu, c9_PMINTENSET) &= ~val;
 			break;
 		}
+		case c9_PMOVSSET: {
+			val = *vcpu_reg(vcpu, p->Rt);
+			vcpu_cp15(vcpu, r->reg) |= val;
+			vcpu_cp15(vcpu, c9_PMOVSCLR) |= val;
+			break;
+		}
+		case c9_PMOVSCLR: {
+			val = *vcpu_reg(vcpu, p->Rt);
+			vcpu_cp15(vcpu, r->reg) &= ~val;
+			vcpu_cp15(vcpu, c9_PMOVSSET) &= ~val;
+			break;
+		}
 		case c9_PMCR: {
 			/* Only update writeable bits of PMCR */
 			val = vcpu_cp15(vcpu, r->reg);
@@ -881,7 +905,8 @@ static const struct sys_reg_desc cp15_regs[] = {
 	  reset_unknown_cp15, c9_PMCNTENSET },
 	{ Op1( 0), CRn( 9), CRm(12), Op2( 2), access_pmu_cp15_regs,
 	  reset_unknown_cp15, c9_PMCNTENCLR },
-	{ Op1( 0), CRn( 9), CRm(12), Op2( 3), trap_raz_wi },
+	{ Op1( 0), CRn( 9), CRm(12), Op2( 3), access_pmu_cp15_regs,
+	  reset_unknown_cp15, c9_PMOVSCLR },
 	{ Op1( 0), CRn( 9), CRm(12), Op2( 5), access_pmu_cp15_regs,
 	  reset_unknown_cp15, c9_PMSELR },
 	{ Op1( 0), CRn( 9), CRm(12), Op2( 6), access_pmu_cp15_regs,
@@ -899,6 +924,8 @@ static const struct sys_reg_desc cp15_regs[] = {
 	  reset_unknown_cp15, c9_PMINTENSET },
 	{ Op1( 0), CRn( 9), CRm(14), Op2( 2), access_pmu_cp15_regs,
 	  reset_unknown_cp15, c9_PMINTENCLR },
+	{ Op1( 0), CRn( 9), CRm(14), Op2( 3), access_pmu_cp15_regs,
+	  reset_unknown_cp15, c9_PMOVSSET },
 
 	{ Op1( 0), CRn(10), CRm( 2), Op2( 0), access_vm_reg, NULL, c10_PRRR },
 	{ Op1( 0), CRn(10), CRm( 2), Op2( 1), access_vm_reg, NULL, c10_NMRR },
-- 
2.0.4
