From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Mon,  6 Jul 2015 10:17:40 +0800
Subject: [PATCH 10/18] KVM: ARM64: Add reset and access handlers for
 PMCCNTR_EL0 register
In-Reply-To: <1436149068-3784-1-git-send-email-shannon.zhao@linaro.org>
References: <1436149068-3784-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1436149068-3784-11-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Since the reset value of PMCCNTR_EL0 is UNKNOWN, use reset_unknown for
its reset handler. Add access handler which emulates writing and reading
PMCCNTR_EL0 register.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2bcf1a0..29883df 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -375,6 +375,23 @@ static bool access_pmxevcntr(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static bool access_pmccntr(struct kvm_vcpu *vcpu,
+			   const struct sys_reg_params *p,
+			   const struct sys_reg_desc *r)
+{
+	unsigned long val;
+
+	if (p->is_write) {
+		val = *vcpu_reg(vcpu, p->Rt);
+		kvm_pmu_set_counter_value(vcpu, 31, val);
+	} else {
+		val = kvm_pmu_get_counter_value(vcpu, 31);
+		*vcpu_reg(vcpu, p->Rt) = val;
+	}
+
+	return true;
+}
+
 /* Silly macro to expand the DBG{BCR,BVR,WVR,WCR}n_EL1 registers in one go */
 #define DBG_BCR_BVR_WCR_WVR_EL1(n)					\
 	/* DBGBVRn_EL1 */						\
@@ -590,7 +607,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  access_pmceid, reset_pmceid, PMCEID1_EL0, },
 	/* PMCCNTR_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b000),
-	  trap_raz_wi },
+	  access_pmccntr, reset_unknown, PMCCNTR_EL0 },
 	/* PMXEVTYPER_EL0 */
 	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b001),
 	  access_pmxevtyper, reset_unknown, PMXEVTYPER_EL0 },
-- 
2.1.0
