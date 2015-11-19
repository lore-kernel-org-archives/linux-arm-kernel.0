From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 19 Nov 2015 14:54:01 +0000
Subject: [PATCH v4 11/13] KVM: arm/arm64: vgic: implement clear active for non
 shared mapped IRQ
In-Reply-To: <1447944843-17731-1-git-send-email-eric.auger@linaro.org>
References: <1447944843-17731-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1447944843-17731-12-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When disabling a non shared mapped IRQs, we must manually deactivate
the corresponding physical IRQ on top of removing the active state
from the distributor.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 virt/kvm/arm/vgic.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index bd500b4..98ae15f 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -604,14 +604,34 @@ bool vgic_handle_clear_active_reg(struct kvm *kvm,
 				  struct kvm_exit_mmio *mmio,
 				  phys_addr_t offset, int vcpu_id)
 {
-	u32 *reg;
+	u32 *reg, orig, cleared;
 	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct kvm_vcpu *vcpu = kvm_get_vcpu(kvm, vcpu_id);
+	unsigned int i;
 
 	reg = vgic_bitmap_get_reg(&dist->irq_active, vcpu_id, offset);
+	orig = *reg;
 	vgic_reg_access(mmio, reg, offset,
 			ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
 
 	if (mmio->is_write) {
+		cleared = orig ^ *reg;
+
+		for (i = 0; i < 32; i++) {
+			struct irq_phys_map *map;
+			unsigned int irq_num;
+
+			if (!(cleared && (1 << i)))
+				continue;
+			irq_num = (offset * 8) + i;
+			map = vgic_irq_map_search(vcpu, irq_num);
+			if (!map || (map && map->shared))
+				continue;
+			irq_set_irqchip_state(map->irq,
+					      IRQCHIP_STATE_ACTIVE,
+					      false);
+		}
+
 		vgic_update_state(kvm);
 		return true;
 	}
-- 
1.9.1
