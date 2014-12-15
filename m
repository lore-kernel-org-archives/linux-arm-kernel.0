From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 15 Dec 2014 12:41:58 +0100
Subject: [GIT PULL 11/12] arm/arm64: KVM: Initialize the vgic on-demand when
 injecting IRQs
In-Reply-To: <1418643719-25966-1-git-send-email-christoffer.dall@linaro.org>
References: <1418643719-25966-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1418643719-25966-12-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Userspace assumes that it can wire up IRQ injections after having
created all VCPUs and after having created the VGIC, but potentially
before starting the first VCPU.  This can currently lead to lost IRQs
because the state of that IRQ injection is not stored anywhere and we
don't return an error to userspace.

We haven't seen this problem manifest itself yet, presumably because
guests reset the devices on boot, but this could cause issues with
migration and other non-standard startup configurations.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index d862ea5..e373b76 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1694,16 +1694,26 @@ out:
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
 			bool level)
 {
+	int ret = 0;
 	int vcpu_id;
 
-	if (likely(vgic_ready(kvm))) {
-		vcpu_id = vgic_update_irq_pending(kvm, cpuid, irq_num, level);
-		if (vcpu_id >= 0)
-			/* kick the specified vcpu */
-			kvm_vcpu_kick(kvm_get_vcpu(kvm, vcpu_id));
+	if (unlikely(!vgic_initialized(kvm))) {
+		mutex_lock(&kvm->lock);
+		ret = vgic_init(kvm);
+		mutex_unlock(&kvm->lock);
+
+		if (ret)
+			goto out;
 	}
 
-	return 0;
+	vcpu_id = vgic_update_irq_pending(kvm, cpuid, irq_num, level);
+	if (vcpu_id >= 0) {
+		/* kick the specified vcpu */
+		kvm_vcpu_kick(kvm_get_vcpu(kvm, vcpu_id));
+	}
+
+out:
+	return ret;
 }
 
 static irqreturn_t vgic_maintenance_handler(int irq, void *data)
-- 
2.1.2.330.g565301e.dirty
