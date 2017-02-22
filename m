From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Feb 2017 11:47:24 +0000
Subject: [PATCH 4/8] arm64: KVM: pmu: Inject UNDEF exception on illegal
 register access
In-Reply-To: <20170222114728.2472-1-marc.zyngier@arm.com>
References: <20170222114728.2472-1-marc.zyngier@arm.com>
Message-ID: <20170222114728.2472-5-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both pmu_*_el0_disabled() and pmu_counter_idx_valid() perform checks
on the calidity of an access, but only return a boolean indicating
if the access is valid or not.

Let's allow these functions to also inject an UNDEF exception if
the access was illegal. This is where we start flagging a pending
exception.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 0ebf27f40f98..eec543906e21 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -460,11 +460,20 @@ static void reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	vcpu_sys_reg(vcpu, PMCR_EL0) = val;
 }
 
+static void pend_undef(struct kvm_vcpu *vcpu)
+{
+	kvm_inject_undefined(vcpu);
+	vcpu->arch.sys_reg->exception_pending = true;
+}
+
 static bool check_disabled(struct kvm_vcpu *vcpu, u64 flags)
 {
 	u64 reg = vcpu_sys_reg(vcpu, PMUSERENR_EL0);
 	bool cond = (reg & flags) || vcpu_mode_priv(vcpu);
 
+	if (!cond)
+		pend_undef(vcpu);
+
 	return !cond;
 }
 
@@ -564,8 +573,10 @@ static bool pmu_counter_idx_valid(struct kvm_vcpu *vcpu, u64 idx)
 
 	pmcr = vcpu_sys_reg(vcpu, PMCR_EL0);
 	val = (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
-	if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX)
+	if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX) {
+		pend_undef(vcpu);
 		return false;
+	}
 
 	return true;
 }
-- 
2.11.0
