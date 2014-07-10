From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 10 Jul 2014 07:39:55 -0700
Subject: [PATCH 5/6] arm/arm64: KVM: vgic: Fix SGI writes to GICD_I{CS}PENDR0
In-Reply-To: <1405003196-12403-1-git-send-email-christoffer.dall@linaro.org>
References: <1405003196-12403-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1405003196-12403-6-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Writes to GICD_ISPENDR0 and GICD_ICPENDR0 ignore all settings of the
pending state for SGIs.  Make sure the implementation handles this
correctly.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 7b0ab7f..2c13384 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -449,7 +449,7 @@ static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
 					struct kvm_exit_mmio *mmio,
 					phys_addr_t offset)
 {
-	u32 *reg;
+	u32 *reg, orig;
 	u32 level_mask;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 
@@ -458,6 +458,7 @@ static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
 
 	/* Mark both level and edge triggered irqs as pending */
 	reg = vgic_bitmap_get_reg(&dist->irq_pending, vcpu->vcpu_id, offset);
+	orig = *reg;
 	vgic_reg_access(mmio, reg, offset,
 			ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
 
@@ -469,6 +470,12 @@ static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
 				ACCESS_READ_VALUE | ACCESS_WRITE_SETBIT);
 		*reg &= level_mask;
 
+		/* Ignore writes to SGIs */
+		if (offset < 2) {
+			*reg &= ~0xffff;
+			*reg |= orig & 0xffff;
+		}
+
 		vgic_update_state(vcpu->kvm);
 		return true;
 	}
@@ -481,10 +488,11 @@ static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
 					  phys_addr_t offset)
 {
 	u32 *level_active;
-	u32 *reg;
+	u32 *reg, orig;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 
 	reg = vgic_bitmap_get_reg(&dist->irq_pending, vcpu->vcpu_id, offset);
+	orig = *reg;
 	vgic_reg_access(mmio, reg, offset,
 			ACCESS_READ_VALUE | ACCESS_WRITE_CLEARBIT);
 	if (mmio->is_write) {
@@ -495,6 +503,12 @@ static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
 					  vcpu->vcpu_id, offset);
 		*reg |= *level_active;
 
+		/* Ignore writes to SGIs */
+		if (offset < 2) {
+			*reg &= ~0xffff;
+			*reg |= orig & 0xffff;
+		}
+
 		/* Clear soft-pending flags */
 		reg = vgic_bitmap_get_reg(&dist->irq_soft_pend,
 					  vcpu->vcpu_id, offset);
-- 
2.0.0
