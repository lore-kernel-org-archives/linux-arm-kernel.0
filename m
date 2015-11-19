From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 19 Nov 2015 14:54:02 +0000
Subject: [PATCH v4 12/13] KVM: arm/arm64: vgic: implement clear pending for
 non shared mapped IRQ
In-Reply-To: <1447944843-17731-1-git-send-email-eric.auger@linaro.org>
References: <1447944843-17731-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1447944843-17731-13-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements the clear of a pending non shared mapped IRQ.
In case of an edge IRQ, we deactivate the physical IRQ that will never
be deactivated by the guest. In case of a level sensitive IRQ we check
the level of the input signal. If it is asserted we leave the virtual
IRQ pending. In the opposite, we remove the pending state and deactivate
the IRQ.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 virt/kvm/arm/vgic.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 98ae15f..4be5972 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -550,20 +550,50 @@ bool vgic_handle_clear_pending_reg(struct kvm *kvm,
 				   phys_addr_t offset, int vcpu_id)
 {
 	u32 *level_active;
-	u32 *reg, orig;
+	u32 *reg, orig, cleared;
 	int mode = ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT;
+	unsigned int i;
 	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct kvm_vcpu *vcpu = kvm_get_vcpu(kvm, vcpu_id);
 
 	reg = vgic_bitmap_get_reg(&dist->irq_pending, vcpu_id, offset);
 	orig = *reg;
 	vgic_reg_access(mmio, reg, offset, mode);
 	if (mmio->is_write) {
-		/* Re-set level triggered level-active interrupts */
 		level_active = vgic_bitmap_get_reg(&dist->irq_level,
 					  vcpu_id, offset);
+		cleared = orig ^ *reg;
+
+		/* Re-set level triggered level-active interrupts */
 		reg = vgic_bitmap_get_reg(&dist->irq_pending, vcpu_id, offset);
 		*reg |= *level_active;
 
+		for (i = 0; i < 32; i++) {
+			struct irq_phys_map *map;
+			bool phys_pending;
+			unsigned int irq_num;
+
+			if (!(cleared && (1 << i)))
+				continue;
+			irq_num = (offset * 8) + i;
+			map = vgic_irq_map_search(vcpu, irq_num);
+			if (!map || (map && map->shared))
+				continue;
+			/* check whether the signal is asserted */
+			irq_get_irqchip_state(map->irq,
+					      IRQCHIP_STATE_PENDING,
+					      &phys_pending);
+			if (!vgic_irq_is_edge(vcpu, irq_num) && phys_pending) {
+				vgic_dist_irq_set_pending(vcpu, irq_num);
+				continue;
+			}
+
+			vgic_dist_irq_clear_pending(vcpu, irq_num);
+			irq_set_irqchip_state(map->irq,
+					      IRQCHIP_STATE_ACTIVE,
+					      false);
+		}
+
 		/* Ignore writes to SGIs */
 		if (offset < 2) {
 			*reg &= ~0xffff;
-- 
1.9.1
