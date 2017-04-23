From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:39 +0200
Subject: [PULL 29/79] arm64: KVM: PMU: Inject UNDEF on non-privileged accesses
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-30-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

access_pminten() and access_pmuserenr() can only be accessed when
the CPU is in a priviledged mode. If it is not, let's inject an
UNDEF exception.

Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 750c129..d343c0f 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -709,8 +709,10 @@ static bool access_pminten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	if (!kvm_arm_pmu_v3_ready(vcpu))
 		return trap_raz_wi(vcpu, p, r);
 
-	if (!vcpu_mode_priv(vcpu))
+	if (!vcpu_mode_priv(vcpu)) {
+		kvm_inject_undefined(vcpu);
 		return false;
+	}
 
 	if (p->is_write) {
 		u64 val = p->regval & mask;
@@ -780,8 +782,10 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 		return trap_raz_wi(vcpu, p, r);
 
 	if (p->is_write) {
-		if (!vcpu_mode_priv(vcpu))
+		if (!vcpu_mode_priv(vcpu)) {
+			kvm_inject_undefined(vcpu);
 			return false;
+		}
 
 		vcpu_sys_reg(vcpu, PMUSERENR_EL0) = p->regval
 						    & ARMV8_PMU_USERENR_MASK;
-- 
2.9.0
