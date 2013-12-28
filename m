From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 28 Dec 2013 11:15:43 +0000
Subject: [PATCH 11/15] KVM: arm-vgic: Add GICD_SPENDSGIR and GICD_CPENDSGIR
 handlers
In-Reply-To: <1388229347-24185-1-git-send-email-marc.zyngier@arm.com>
References: <1388229347-24185-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1388229347-24185-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Handle MMIO accesses to the two registers which should support both the
case where the VMs want to read/write either of these registers and the
case where user space reads/writes these registers to do save/restore of
the VGIC state.

Note that the added complexity compared to simple set/clear enable
registers stems from the bookkeping of source cpu ids.  It may be
possible to change the underlying data structure to simplify the
complexity, but since this is not in the critical path at all, this will
do.

Also note that reading this register from a live guest will not be
accurate compared to on hardware, because some state may be living on
the CPU LRs and the only way to give a consistent read would be to force
stop all the VCPUs and request them to unqueu the LR state onto the
distributor.  Until we have an actual user of live reading this
register, we can live with the difference.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index d08ba28..e59aaa4 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -663,18 +663,80 @@ static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
 	}
 }
 
-static bool handle_mmio_sgi_clear(struct kvm_vcpu *vcpu,
-				  struct kvm_exit_mmio *mmio,
-				  phys_addr_t offset)
+/* Handle reads of GICD_CPENDSGIRn and GICD_SPENDSGIRn */
+static bool read_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
+					struct kvm_exit_mmio *mmio,
+					phys_addr_t offset)
 {
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	int sgi;
+	int min_sgi = (offset & ~0x3) * 4;
+	int max_sgi = min_sgi + 3;
+	int vcpu_id = vcpu->vcpu_id;
+	u32 reg = 0;
+
+	/* Copy source SGIs from distributor side */
+	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
+		int shift = 8 * (sgi - min_sgi);
+		reg |= (u32)dist->irq_sgi_sources[vcpu_id][sgi] << shift;
+	}
+
+	mmio_data_write(mmio, ~0, reg);
 	return false;
 }
 
+static bool write_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
+					 struct kvm_exit_mmio *mmio,
+					 phys_addr_t offset, bool set)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	int sgi;
+	int min_sgi = (offset & ~0x3) * 4;
+	int max_sgi = min_sgi + 3;
+	int vcpu_id = vcpu->vcpu_id;
+	u32 reg;
+	bool updated = false;
+
+	reg = mmio_data_read(mmio, ~0);
+
+	/* Clear pending SGIs on the distributor */
+	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
+		u8 mask = reg >> (8 * (sgi - min_sgi));
+		if (set) {
+			if ((dist->irq_sgi_sources[vcpu_id][sgi] & mask) != mask)
+				updated = true;
+			dist->irq_sgi_sources[vcpu_id][sgi] |= mask;
+		} else {
+			if (dist->irq_sgi_sources[vcpu_id][sgi] & mask)
+				updated = true;
+			dist->irq_sgi_sources[vcpu_id][sgi] &= ~mask;
+		}
+	}
+
+	if (updated)
+		vgic_update_state(vcpu->kvm);
+
+	return updated;
+}
+
 static bool handle_mmio_sgi_set(struct kvm_vcpu *vcpu,
 				struct kvm_exit_mmio *mmio,
 				phys_addr_t offset)
 {
-	return false;
+	if (!mmio->is_write)
+		return read_set_clear_sgi_pend_reg(vcpu, mmio, offset);
+	else
+		return write_set_clear_sgi_pend_reg(vcpu, mmio, offset, true);
+}
+
+static bool handle_mmio_sgi_clear(struct kvm_vcpu *vcpu,
+				  struct kvm_exit_mmio *mmio,
+				  phys_addr_t offset)
+{
+	if (!mmio->is_write)
+		return read_set_clear_sgi_pend_reg(vcpu, mmio, offset);
+	else
+		return write_set_clear_sgi_pend_reg(vcpu, mmio, offset, false);
 }
 
 /*
-- 
1.8.5.1
