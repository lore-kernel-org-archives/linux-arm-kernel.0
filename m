From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:37 +0200
Subject: [PULL 27/79] arm64: KVM: PMU: Refactor pmu_*_el0_disabled
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-28-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

There is a lot of duplication in the pmu_*_el0_disabled helpers,
and as we're going to modify them shortly, let's move all the
common stuff in a single function.

No functional change.

Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 0e26f8c..036efc97 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -460,35 +460,32 @@ static void reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	vcpu_sys_reg(vcpu, PMCR_EL0) = val;
 }
 
-static bool pmu_access_el0_disabled(struct kvm_vcpu *vcpu)
+static bool check_pmu_access_disabled(struct kvm_vcpu *vcpu, u64 flags)
 {
 	u64 reg = vcpu_sys_reg(vcpu, PMUSERENR_EL0);
+	bool enabled = (reg & flags) || vcpu_mode_priv(vcpu);
 
-	return !((reg & ARMV8_PMU_USERENR_EN) || vcpu_mode_priv(vcpu));
+	return !enabled;
 }
 
-static bool pmu_write_swinc_el0_disabled(struct kvm_vcpu *vcpu)
+static bool pmu_access_el0_disabled(struct kvm_vcpu *vcpu)
 {
-	u64 reg = vcpu_sys_reg(vcpu, PMUSERENR_EL0);
+	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_EN);
+}
 
-	return !((reg & (ARMV8_PMU_USERENR_SW | ARMV8_PMU_USERENR_EN))
-		 || vcpu_mode_priv(vcpu));
+static bool pmu_write_swinc_el0_disabled(struct kvm_vcpu *vcpu)
+{
+	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_SW | ARMV8_PMU_USERENR_EN);
 }
 
 static bool pmu_access_cycle_counter_el0_disabled(struct kvm_vcpu *vcpu)
 {
-	u64 reg = vcpu_sys_reg(vcpu, PMUSERENR_EL0);
-
-	return !((reg & (ARMV8_PMU_USERENR_CR | ARMV8_PMU_USERENR_EN))
-		 || vcpu_mode_priv(vcpu));
+	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_CR | ARMV8_PMU_USERENR_EN);
 }
 
 static bool pmu_access_event_counter_el0_disabled(struct kvm_vcpu *vcpu)
 {
-	u64 reg = vcpu_sys_reg(vcpu, PMUSERENR_EL0);
-
-	return !((reg & (ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_EN))
-		 || vcpu_mode_priv(vcpu));
+	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_EN);
 }
 
 static bool access_pmcr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-- 
2.9.0
