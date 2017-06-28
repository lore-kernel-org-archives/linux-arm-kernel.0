From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:04:02 +0100
Subject: [PATCH v2 43/52] KVM: arm/arm64: GICv4: Handle CLEAR applied to a VLPI
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-44-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handling CLEAR is pretty easy. Just ask the ITS driver to clear
the corresponding pending bit (which will turn into a CLEAR
command on the physical side).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index ee8355991bb1..21a7b3f00107 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1069,6 +1069,10 @@ static int vgic_its_cmd_handle_clear(struct kvm *kvm, struct vgic_its *its,
 
 	ite->irq->pending_latch = false;
 
+	if (ite->irq->hw)
+		return irq_set_irqchip_state(ite->irq->host_irq,
+					     IRQCHIP_STATE_PENDING, false);
+
 	return 0;
 }
 
-- 
2.11.0
