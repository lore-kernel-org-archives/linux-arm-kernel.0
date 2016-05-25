From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 May 2016 15:26:38 +0100
Subject: [PATCH v2 6/7] arm64: KVM: vgic-v3: Prevent the guest from messing
 with ICC_SRE_EL1
In-Reply-To: <1464186399-16604-1-git-send-email-marc.zyngier@arm.com>
References: <1464186399-16604-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1464186399-16604-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both our GIC emulations are "strict", in the sense that we either
emulate a GICv2 or a GICv3, and not a GICv3 with GICv2 legacy
support.

But when running on a GICv3 host, we still allow the guest to
tinker with the ICC_SRE_EL1 register during its time slice:
it can switch SRE off, observe that it is off, and yet on the
next world switch, find the SRE bit to be set again. Not very
nice.

An obvious solution is to always trap accesses to ICC_SRE_EL1
(by clearing ICC_SRE_EL2.Enable), and to let the handler return
the programmed value on a read, or ignore the write.

That way, the guest can always observe that our GICv3 is SRE==1
only.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/vgic-v3-sr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/vgic-v3-sr.c b/arch/arm64/kvm/hyp/vgic-v3-sr.c
index 3129df9..40c3b4c 100644
--- a/arch/arm64/kvm/hyp/vgic-v3-sr.c
+++ b/arch/arm64/kvm/hyp/vgic-v3-sr.c
@@ -313,10 +313,8 @@ void __hyp_text __vgic_v3_restore_state(struct kvm_vcpu *vcpu)
 	 * Prevent the guest from touching the GIC system registers if
 	 * SRE isn't enabled for GICv3 emulation.
 	 */
-	if (!cpu_if->vgic_sre) {
-		write_gicreg(read_gicreg(ICC_SRE_EL2) & ~ICC_SRE_EL2_ENABLE,
-			     ICC_SRE_EL2);
-	}
+	write_gicreg(read_gicreg(ICC_SRE_EL2) & ~ICC_SRE_EL2_ENABLE,
+		     ICC_SRE_EL2);
 }
 
 void __hyp_text __vgic_v3_init_lrs(void)
-- 
2.1.4
