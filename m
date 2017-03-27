From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 27 Mar 2017 17:03:39 +0100
Subject: [PATCH v2 3/9] arm64: KVM: PMU: Inject UNDEF on non-privileged
 accesses
In-Reply-To: <20170327160345.12402-1-marc.zyngier@arm.com>
References: <20170327160345.12402-1-marc.zyngier@arm.com>
Message-ID: <20170327160345.12402-4-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

access_pminten() and access_pmuserenr() can only be accessed when
the CPU is in a priviledged mode. If it is not, let's inject an
UNDEF exception.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index d98ce9a52291..5e3ce7890b35 100644
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
2.11.0
