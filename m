From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:34 +0200
Subject: [PULL 26/50] arm: KVM: Preserve pending Virtual Abort in world switch
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-27-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

The HCR.VA bit is used to signal an Abort to a guest, and has
the peculiar feature of getting cleared when the guest has taken
the abort (this is the only bit that behaves as such in this register).

This means that if we signal such an abort, we must leave it in
the guest context until it disappears from HCR, and at which point
it must be cleared from the context.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/hyp/switch.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/kvm/hyp/switch.c b/arch/arm/kvm/hyp/switch.c
index 37b3365..9da16fd 100644
--- a/arch/arm/kvm/hyp/switch.c
+++ b/arch/arm/kvm/hyp/switch.c
@@ -54,6 +54,15 @@ static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
 {
 	u32 val;
 
+	/*
+	 * If we pended a virtual abort, preserve it until it gets
+	 * cleared. See B1.9.9 (Virtual Abort exception) for details,
+	 * but the crucial bit is the zeroing of HCR.VA in the
+	 * pseudocode.
+	 */
+	if (vcpu->arch.hcr & HCR_VA)
+		vcpu->arch.hcr = read_sysreg(HCR);
+
 	write_sysreg(0, HCR);
 	write_sysreg(0, HSTR);
 	val = read_sysreg(HDCR);
-- 
2.9.0
