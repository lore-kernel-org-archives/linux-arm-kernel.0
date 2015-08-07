From: eric.auger@linaro.org (Eric Auger)
Date: Fri,  7 Aug 2015 18:08:31 +0200
Subject: [PATCH v2 2/4] KVM: arm/arm64: check power_off in
 kvm_arch_vcpu_runnable
In-Reply-To: <1438963713-10460-1-git-send-email-eric.auger@linaro.org>
References: <1438963713-10460-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1438963713-10460-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kvm_arch_vcpu_runnable now also checks whether the power_off
flag is set.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 arch/arm/kvm/arm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 3ac6b4c..4f50be3 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -347,7 +347,8 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
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
