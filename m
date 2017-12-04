From: cdall@kernel.org (Christoffer Dall)
Date: Mon,  4 Dec 2017 14:56:20 +0100
Subject: [PULL 02/19] KVM: arm/arm64: VGIC: extend !vgic_is_initialized guard
In-Reply-To: <20171204135637.21620-1-cdall@kernel.org>
References: <20171204135637.21620-1-cdall@kernel.org>
Message-ID: <20171204135637.21620-3-cdall@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

Commit f39d16cbabf9 ("KVM: arm/arm64: Guard kvm_vgic_map_is_active against
!vgic_initialized") introduced a check whether the VGIC has been
initialized before accessing the spinlock and the VGIC data structure.
However the vgic_get_irq() call in the variable declaration sneaked
through the net, so lets make sure that this also gets called only after
we actually allocated the arrays this function accesses.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index b168a328a9e0..786cce7bd2ec 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -823,13 +823,14 @@ void vgic_kick_vcpus(struct kvm *kvm)
 
 bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, unsigned int vintid)
 {
-	struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, vintid);
+	struct vgic_irq *irq;
 	bool map_is_active;
 	unsigned long flags;
 
 	if (!vgic_initialized(vcpu->kvm))
 		return false;
 
+	irq = vgic_get_irq(vcpu->kvm, vcpu, vintid);
 	spin_lock_irqsave(&irq->irq_lock, flags);
 	map_is_active = irq->hw && irq->active;
 	spin_unlock_irqrestore(&irq->irq_lock, flags);
-- 
2.14.2
