From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 Oct 2017 16:33:48 +0100
Subject: [PATCH v4 13/26] KVM: arm/arm64: GICv4: Handle CLEAR applied to a VLPI
In-Reply-To: <20171006153401.5481-1-marc.zyngier@arm.com>
References: <20171006153401.5481-1-marc.zyngier@arm.com>
Message-ID: <20171006153401.5481-14-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handling CLEAR is pretty easy. Just ask the ITS driver to clear
the corresponding pending bit (which will turn into a CLEAR
command on the physical side).

Acked-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 42ffb9084bb7..5778b50911e8 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1070,6 +1070,10 @@ static int vgic_its_cmd_handle_clear(struct kvm *kvm, struct vgic_its *its,
 
 	ite->irq->pending_latch = false;
 
+	if (ite->irq->hw)
+		return irq_set_irqchip_state(ite->irq->host_irq,
+					     IRQCHIP_STATE_PENDING, false);
+
 	return 0;
 }
 
-- 
2.14.1
