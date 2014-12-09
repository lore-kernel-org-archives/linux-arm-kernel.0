From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue,  9 Dec 2014 12:26:08 +0100
Subject: [GIT PULL 9/9] arm/arm64: KVM: vgic: kick the specific vcpu instead
 of iterating through all
In-Reply-To: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
References: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1418124368-28418-10-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <zhaoshenglong@huawei.com>

When call kvm_vgic_inject_irq to inject interrupt, we can known which
vcpu the interrupt for by the irq_num and the cpuid. So we should just
kick this vcpu to avoid iterating through all.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 631a472..21e035c 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1607,7 +1607,7 @@ static int vgic_validate_injection(struct kvm_vcpu *vcpu, int irq, int level)
 	}
 }
 
-static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
+static int vgic_update_irq_pending(struct kvm *kvm, int cpuid,
 				  unsigned int irq_num, bool level)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
@@ -1673,7 +1673,7 @@ static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
 out:
 	spin_unlock(&dist->lock);
 
-	return ret;
+	return ret ? cpuid : -EINVAL;
 }
 
 /**
@@ -1693,9 +1693,14 @@ out:
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
 			bool level)
 {
-	if (likely(vgic_initialized(kvm)) &&
-	    vgic_update_irq_pending(kvm, cpuid, irq_num, level))
-		vgic_kick_vcpus(kvm);
+	int vcpu_id;
+
+	if (likely(vgic_initialized(kvm))) {
+		vcpu_id = vgic_update_irq_pending(kvm, cpuid, irq_num, level);
+		if (vcpu_id >= 0)
+			/* kick the specified vcpu */
+			kvm_vcpu_kick(kvm_get_vcpu(kvm, vcpu_id));
+	}
 
 	return 0;
 }
-- 
2.1.2.330.g565301e.dirty
