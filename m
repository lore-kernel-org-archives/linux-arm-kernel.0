From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 5 Feb 2016 15:14:06 +0800
Subject: [PATCH v11 11/21] KVM: ARM64: Add access handler for PMINTENSET and
 PMINTENCLR register
In-Reply-To: <1454656456-11640-1-git-send-email-zhaoshenglong@huawei.com>
References: <1454656456-11640-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1454656456-11640-12-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Since the reset value of PMINTENSET and PMINTENCLR is UNKNOWN, use
reset_unknown for its reset handler. Add a handler to emulate writing
PMINTENSET or PMINTENCLR register.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 arch/arm64/kvm/sys_regs.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index ef8012a..bf8d170 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -626,6 +626,30 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	return true;
 }
 
+static bool access_pminten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+			   const struct sys_reg_desc *r)
+{
+	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
+
+	if (!kvm_arm_pmu_v3_ready(vcpu))
+		return trap_raz_wi(vcpu, p, r);
+
+	if (p->is_write) {
+		u64 val = p->regval & mask;
+
+		if (r->Op2 & 0x1)
+			/* accessing PMINTENSET_EL1 */
+			vcpu_sys_reg(vcpu, PMINTENSET_EL1) |= val;
+		else
+			/* accessing PMINTENCLR_EL1 */
+			vcpu_sys_reg(vcpu, PMINTENSET_EL1) &= ~val;
+	} else {
+		p->regval = vcpu_sys_reg(vcpu, PMINTENSET_EL1) & mask;
+	}
+
+	return true;
+}
+
 /* Silly macro to expand the DBG{BCR,BVR,WVR,WCR}n_EL1 registers in one go */
 #define DBG_BCR_BVR_WCR_WVR_EL1(n)					\
 	/* DBGBVRn_EL1 */						\
@@ -784,10 +808,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	/* PMINTENSET_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b001),
-	  trap_raz_wi },
+	  access_pminten, reset_unknown, PMINTENSET_EL1 },
 	/* PMINTENCLR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b010),
-	  trap_raz_wi },
+	  access_pminten, NULL, PMINTENSET_EL1 },
 
 	/* MAIR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1010), CRm(0b0010), Op2(0b000),
@@ -1182,8 +1206,8 @@ static const struct sys_reg_desc cp15_regs[] = {
 	{ Op1( 0), CRn( 9), CRm(13), Op2( 1), access_pmu_evtyper },
 	{ Op1( 0), CRn( 9), CRm(13), Op2( 2), access_pmu_evcntr },
 	{ Op1( 0), CRn( 9), CRm(14), Op2( 0), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(14), Op2( 1), trap_raz_wi },
-	{ Op1( 0), CRn( 9), CRm(14), Op2( 2), trap_raz_wi },
+	{ Op1( 0), CRn( 9), CRm(14), Op2( 1), access_pminten },
+	{ Op1( 0), CRn( 9), CRm(14), Op2( 2), access_pminten },
 
 	{ Op1( 0), CRn(10), CRm( 2), Op2( 0), access_vm_reg, NULL, c10_PRRR },
 	{ Op1( 0), CRn(10), CRm( 2), Op2( 1), access_vm_reg, NULL, c10_NMRR },
-- 
2.0.4
