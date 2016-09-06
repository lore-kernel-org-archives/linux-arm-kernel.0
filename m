From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Sep 2016 14:02:00 +0100
Subject: [PATCH 02/19] arm64: KVM: Preserve pending vSError in world switch
In-Reply-To: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
References: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1473166937-15271-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HCR_EL2.VSE bit is used to signal an SError to a guest, and has
the peculiar feature of getting cleared when the guest has taken
the abort (this is the only bit that behaves as such in this register).

This means that if we signal such an abort, we must leave it
in the guest context until it disappears from HCR_EL2, and at which
point it must be cleared from the context. This is achieved by
reading back from HCR_EL2 until the guest takes the fault.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/switch.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index fcb7aae..5148b06 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -110,6 +110,15 @@ static hyp_alternate_select(__deactivate_traps_arch,
 
 static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * If we pended a virtual abort, preserve it until it gets
+	 * cleared. See D1.14.3 (Virtual Interrupts) for details, but
+	 * the crucial bit is "On taking a vSError interrupt,
+	 * HCR_EL2.VSE is cleared to 0."
+	 */
+	if (vcpu->arch.hcr_el2 & HCR_VSE)
+		vcpu->arch.hcr_el2 = read_sysreg(hcr_el2);
+
 	__deactivate_traps_arch()();
 	write_sysreg(0, hstr_el2);
 	write_sysreg(read_sysreg(mdcr_el2) & MDCR_EL2_HPMN_MASK, mdcr_el2);
-- 
2.1.4
