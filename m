From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 8 Dec 2015 20:47:28 +0800
Subject: [PATCH v6 09/21] KVM: ARM64: Add access handler for PMXEVTYPER
 register
In-Reply-To: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
References: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1449578860-15808-10-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Accessing PMXEVTYPER register is mapped to the PMEVTYPERn or
PMCCFILTR which is selected by PMSELR. If the value of PMSELR is valid,
call kvm_pmu_set_counter_event_type to create a perf_event.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 55 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2d8bd15..c116a1b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -465,6 +465,57 @@ static void reset_pmceid(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	vcpu_sys_reg(vcpu, r->reg) = pmceid;
 }
 
+static bool pmu_counter_idx_valid(u64 pmcr, u64 idx)
+{
+	u64 val;
+
+	val = (pmcr >> ARMV8_PMCR_N_SHIFT) & ARMV8_PMCR_N_MASK;
+	if (idx >= val && idx != ARMV8_COUNTER_MASK)
+		return false;
+
+	return true;
+}
+
+static bool access_pmu_pmxevtyper(struct kvm_vcpu *vcpu,
+				  struct sys_reg_params *p,
+				  const struct sys_reg_desc *r)
+{
+	u64 pmcr, idx;
+
+	if (!vcpu_mode_is_32bit(vcpu)) {
+		pmcr = vcpu_sys_reg(vcpu, PMCR_EL0);
+		idx = vcpu_sys_reg(vcpu, PMSELR_EL0) & ARMV8_COUNTER_MASK;
+
+		if (!pmu_counter_idx_valid(pmcr, idx))
+			goto out;
+
+		if (!p->is_write) {
+			p->regval = vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + idx);
+			goto out;
+		}
+
+		vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + idx) = p->regval;
+	} else {
+		pmcr = vcpu_cp15(vcpu, c9_PMCR);
+		idx = vcpu_cp15(vcpu, c9_PMSELR) & ARMV8_COUNTER_MASK;
+
+		if (!pmu_counter_idx_valid(pmcr, idx))
+			goto out;
+
+		if (!p->is_write) {
+			p->regval = vcpu_cp15(vcpu, c14_PMEVTYPER0 + idx);
+			goto out;
+		}
+
+		vcpu_cp15(vcpu, c14_PMEVTYPER0 + idx) = p->regval;
+	}
+
+	kvm_pmu_set_counter_event_type(vcpu, p->regval, idx);
+
+out:
+	return true;
+}
+
 /* PMU registers accessor. */
 static bool access_pmu_regs(struct kvm_vcpu *vcpu,
 			    struct sys_reg_params *p,
@@ -731,7 +782,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  trap_raz_wi },
 	/* PMXEVTYPER_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b001),
-	  trap_raz_wi },
+	  access_pmu_pmxevtyper },
 	/* PMXEVCNTR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b010),
 	  trap_raz_wi },
@@ -1069,7 +1120,7 @@ static const struct sys_reg_desc cp15_regs[] = {
 	{ Op1( 0), CRn( 9), CRm(12), Op2( 7), access_pmu_cp15_regs,
 	  NULL, c9_PMCEID1 },
 	{ Op1( 0), CRn( 9), CRm(13), Op2( 0), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(13), Op2( 1), trap_raz_wi },
+	{ Op1( 0), CRn( 9), CRm(13), Op2( 1), access_pmu_pmxevtyper },
 	{ Op1( 0), CRn( 9), CRm(13), Op2( 2), trap_raz_wi },
 	{ Op1( 0), CRn( 9), CRm(14), Op2( 0), trap_raz_wi },
 	{ Op1( 0), CRn( 9), CRm(14), Op2( 1), trap_raz_wi },
-- 
2.0.4
