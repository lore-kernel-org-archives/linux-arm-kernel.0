From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed,  4 Nov 2015 15:49:50 +0100
Subject: [PULL 11/21] KVM: arm/arm64: check power_off in kvm_arch_vcpu_runnable
In-Reply-To: <1446648600-27297-1-git-send-email-christoffer.dall@linaro.org>
References: <1446648600-27297-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1446648600-27297-12-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@linaro.org>

kvm_arch_vcpu_runnable now also checks whether the power_off
flag is set.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9d2fb47..d04deeb 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -352,7 +352,8 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
  */
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
-	return !!v->arch.irq_lines || kvm_vgic_vcpu_pending_irq(v);
+	return ((!!v->arch.irq_lines || kvm_vgic_vcpu_pending_irq(v))
+		&& !v->arch.power_off);
 }
 
 /* Just ensure a guest exit from a particular CPU */
-- 
2.1.2.330.g565301e.dirty
