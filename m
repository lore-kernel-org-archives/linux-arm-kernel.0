From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 8 Dec 2015 20:47:32 +0800
Subject: [PATCH v6 13/21] KVM: ARM64: Add reset and access handlers for
 PMINTENSET and PMINTENCLR register
In-Reply-To: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
References: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1449578860-15808-14-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Since the reset value of PMINTENSET and PMINTENCLR is UNKNOWN, use
reset_unknown for its reset handler. Add a new case to emulate writing
PMINTENSET or PMINTENCLR register.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index a780cb5..c1dffb2 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -592,6 +592,15 @@ static bool access_pmu_regs(struct kvm_vcpu *vcpu,
 			}
 			break;
 		}
+		case PMINTENSET_EL1: {
+			if (r->Op2 == 1)
+				/* accessing PMINTENSET_EL1 */
+				vcpu_sys_reg(vcpu, r->reg) |= p->regval;
+			else
+				/* accessing PMINTENCLR_EL1 */
+				vcpu_sys_reg(vcpu, r->reg) &= ~p->regval;
+			break;
+		}
 		case PMCR_EL0: {
 			/* Only update writeable bits of PMCR */
 			val = vcpu_sys_reg(vcpu, r->reg);
@@ -789,10 +798,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	/* PMINTENSET_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b001),
-	  trap_raz_wi },
+	  access_pmu_regs, reset_unknown, PMINTENSET_EL1 },
 	/* PMINTENCLR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b010),
-	  trap_raz_wi },
+	  access_pmu_regs, reset_unknown, PMINTENSET_EL1 },
 
 	/* MAIR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1010), CRm(0b0010), Op2(0b000),
@@ -1166,6 +1175,15 @@ static bool access_pmu_cp15_regs(struct kvm_vcpu *vcpu,
 			}
 			break;
 		}
+		case c9_PMINTENSET: {
+			if (r->Op2 == 1)
+				/* accessing c9_PMCNTENSET */
+				vcpu_cp15(vcpu, r->reg) |= p->regval;
+			else
+				/* accessing c9_PMCNTENCLR */
+				vcpu_cp15(vcpu, r->reg) &= ~p->regval;
+			break;
+		}
 		case c9_PMCR: {
 			/* Only update writeable bits of PMCR */
 			val = vcpu_cp15(vcpu, r->reg);
@@ -1265,8 +1283,10 @@ static const struct sys_reg_desc cp15_regs[] = {
 	{ Op1( 0), CRn( 9), CRm(13), Op2( 1), access_pmu_pmxevtyper },
 	{ Op1( 0), CRn( 9), CRm(13), Op2( 2), access_pmu_pmxevcntr },
 	{ Op1( 0), CRn( 9), CRm(14), Op2( 0), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(14), Op2( 1), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(14), Op2( 2), trap_raz_wi },
+	{ Op1( 0), CRn( 9), CRm(14), Op2( 1), access_pmu_cp15_regs,
+	  NULL, c9_PMINTENSET },
+	{ Op1( 0), CRn( 9), CRm(14), Op2( 2), access_pmu_cp15_regs,
+	  NULL, c9_PMINTENSET },
 
 	{ Op1( 0), CRn(10), CRm( 2), Op2( 0), access_vm_reg, NULL, c10_PRRR },
 	{ Op1( 0), CRn(10), CRm( 2), Op2( 1), access_vm_reg, NULL, c10_NMRR },
-- 
2.0.4
