From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:41 +0200
Subject: [PULL 31/79] arm64: KVM: PMU: Inject UNDEF on read access to
 PMSWINC_EL0
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-32-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

PMSWINC_EL0 is a WO register, so let's UNDEF when reading from it
(in the highly hypothetical case where this doesn't UNDEF at EL1).

Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 20f90c0..3fef01d 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -772,16 +772,15 @@ static bool access_pmswinc(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	if (!kvm_arm_pmu_v3_ready(vcpu))
 		return trap_raz_wi(vcpu, p, r);
 
+	if (!p->is_write)
+		return read_from_write_only(vcpu, p);
+
 	if (pmu_write_swinc_el0_disabled(vcpu))
 		return false;
 
-	if (p->is_write) {
-		mask = kvm_pmu_valid_counter_mask(vcpu);
-		kvm_pmu_software_increment(vcpu, p->regval & mask);
-		return true;
-	}
-
-	return false;
+	mask = kvm_pmu_valid_counter_mask(vcpu);
+	kvm_pmu_software_increment(vcpu, p->regval & mask);
+	return true;
 }
 
 static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-- 
2.9.0
