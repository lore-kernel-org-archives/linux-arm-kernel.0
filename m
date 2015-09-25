From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 25 Sep 2015 23:41:15 +0200
Subject: [PATCH v3 2/4] KVM: arm/arm64: check power_off in
 kvm_arch_vcpu_runnable
In-Reply-To: <1443217277-13173-1-git-send-email-eric.auger@linaro.org>
References: <1443217277-13173-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1443217277-13173-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kvm_arch_vcpu_runnable now also checks whether the power_off
flag is set.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 2b19ef7..9d16f76 100644
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
1.9.1
