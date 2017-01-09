From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:11 -0500
Subject: [RFC 15/55] KVM: arm64: Trap EL1 VM register accesses in virtual EL2
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-16-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

When running in virtual EL2 mode, we actually run the hardware in EL1
and therefore have to use the EL1 registers to ensure correct operation.

By setting the HCR.TVM and HCR.TVRM we ensure that the virtual EL2 mode
doesn't shoot itself in the foot when setting up what it believes to be
a different mode's system register state (for example when preparing to
switch to a VM).

We can leverage the existing sysregs infrastructure to support trapped
accesses to these registers.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/kvm/hyp/switch.c | 2 ++
 arch/arm64/kvm/sys_regs.c   | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 83037cd..c05c48f 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -82,6 +82,8 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
 		write_sysreg(1 << 30, fpexc32_el2);
 		isb();
 	}
+	if (vcpu_mode_el2(vcpu))
+		val |= HCR_TVM | HCR_TRVM;
 	write_sysreg(val, hcr_el2);
 	/* Trap on AArch32 cp15 c15 accesses (EL1 or EL0) */
 	write_sysreg(1 << 15, hstr_el2);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 202f64d..b8e993a 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -101,7 +101,12 @@ static bool access_vm_reg(struct kvm_vcpu *vcpu,
 {
 	bool was_enabled = vcpu_has_cache_enabled(vcpu);
 
-	BUG_ON(!p->is_write);
+	BUG_ON(!vcpu_mode_el2(vcpu) && !p->is_write);
+
+	if (!p->is_write) {
+		p->regval = vcpu_sys_reg(vcpu, r->reg);
+		return true;
+	}
 
 	if (!p->is_aarch32) {
 		vcpu_sys_reg(vcpu, r->reg) = p->regval;
-- 
1.9.1
