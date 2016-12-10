From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 10 Dec 2016 21:47:12 +0100
Subject: [RFC PATCH 7/7] KVM: arm/arm64: Guard kvm_vgic_map_is_active against
 !vgic_initialized
In-Reply-To: <20161210204712.21830-1-christoffer.dall@linaro.org>
References: <20161210204712.21830-1-christoffer.dall@linaro.org>
Message-ID: <20161210204712.21830-8-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the vgic is not initialized, don't try to grab its spinlocks or
traverse its data structures.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 67d231d..a53e215 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -733,6 +733,9 @@ bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, unsigned int virt_irq)
 	struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, virt_irq);
 	bool map_is_active;
 
+	if (!vgic_initialized(vcpu->kvm))
+		return false;
+
 	DEBUG_SPINLOCK_BUG_ON(!irqs_disabled());
 
 	spin_lock(&irq->irq_lock);
-- 
2.9.0
