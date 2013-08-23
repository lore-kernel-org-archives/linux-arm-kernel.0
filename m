From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Aug 2013 12:20:05 -0700
Subject: [PATCH 7/8] KVM: arm-vgic: Add GICD_SPENDSGIR and GICD_CPENDSGIR
 handlers
In-Reply-To: <1377285606-15692-1-git-send-email-christoffer.dall@linaro.org>
References: <1377285606-15692-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1377285606-15692-8-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handle MMIO accesses to the two registers which should support both the
case where the VMs want to read/write either of these registers and the
case where user space reads/writes these registers to do save/restore of
the VGIC state.

Note that the added complexity compared to simple set/clear enable
registers stems from the bookkeping of source cpu ids.  It may be
possible to change the underlying data structure to simplify the
complexity, but since this is not in the critical path, at all, this is
left as an interesting excercise to the reader.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c |  114 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index e31625c..d44b5a1 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -591,18 +591,128 @@ static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
 	return false;
 }
 
+static void read_sgi_set_clear(struct kvm_vcpu *vcpu,
+			       struct kvm_exit_mmio *mmio,
+			       phys_addr_t offset)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	int i, sgi, cpu;
+	int min_sgi = (offset & ~0x3) * 4;
+	int max_sgi = min_sgi + 3;
+	int vcpu_id = vcpu->vcpu_id;
+	u32 lr, reg = 0;
+
+	/* Copy source SGIs from distributor side */
+	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
+		int shift = 8 * (sgi - min_sgi);
+		reg |= (u32)dist->irq_sgi_sources[vcpu_id][sgi] << shift;
+	}
+
+	/* Copy source SGIs already on LRs */
+	for_each_set_bit(i, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
+		lr = vgic_cpu->vgic_lr[i];
+		sgi = lr & GICH_LR_VIRTUALID;
+		cpu = (lr & GICH_LR_PHYSID_CPUID) >> GICH_LR_PHYSID_CPUID_SHIFT;
+		if (sgi >= min_sgi && sgi <= max_sgi) {
+			if (lr & GICH_LR_STATE)
+				reg |= (1 << cpu) << (8 * (sgi - min_sgi));
+		}
+	}
+
+	memcpy(mmio->data, &reg, sizeof(reg));
+}
+
 static bool handle_mmio_sgi_clear(struct kvm_vcpu *vcpu,
 				  struct kvm_exit_mmio *mmio,
 				  phys_addr_t offset)
 {
-	return false;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	int i, sgi, cpu;
+	int min_sgi = (offset & ~0x3) * 4;
+	int max_sgi = min_sgi + 3;
+	int vcpu_id = vcpu->vcpu_id;
+	u32 *lr, reg;
+	bool updated = false;
+
+	if (!mmio->is_write) {
+		read_sgi_set_clear(vcpu, mmio, offset);
+		return false;
+	}
+
+	memcpy(&reg, mmio->data, sizeof(reg));
+
+	/* Clear pending SGIs on distributor side */
+	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
+		u8 mask = reg >> (8 * (sgi - min_sgi));
+		if (dist->irq_sgi_sources[vcpu_id][sgi] & mask)
+			updated = true;
+		dist->irq_sgi_sources[vcpu_id][sgi] &= ~mask;
+	}
+
+	/* Clear SGIs already on LRs */
+	for_each_set_bit(i, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
+		lr = &vgic_cpu->vgic_lr[i];
+		sgi = *lr & GICH_LR_VIRTUALID;
+		cpu = (*lr & GICH_LR_PHYSID_CPUID) >> GICH_LR_PHYSID_CPUID_SHIFT;
+
+		if (sgi >= min_sgi && sgi <= max_sgi) {
+			if (reg & ((1 << cpu) << (8 * (sgi - min_sgi)))) {
+				if (*lr & GICH_LR_PENDING_BIT)
+					updated = true;
+				*lr &= GICH_LR_PENDING_BIT;
+			}
+		}
+	}
+
+	return updated;
 }
 
 static bool handle_mmio_sgi_set(struct kvm_vcpu *vcpu,
 				struct kvm_exit_mmio *mmio,
 				phys_addr_t offset)
 {
-	return false;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	int i, sgi, cpu;
+	int min_sgi = (offset & ~0x3) * 4;
+	int max_sgi = min_sgi + 3;
+	int vcpu_id = vcpu->vcpu_id;
+	u32 *lr, reg;
+	bool updated = false;
+
+	if (!mmio->is_write) {
+		read_sgi_set_clear(vcpu, mmio, offset);
+		return false;
+	}
+
+	memcpy(&reg, mmio->data, sizeof(reg));
+
+	/* Set pending SGIs on distributor side */
+	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
+		u8 mask = reg >> (8 * (sgi - min_sgi));
+		if ((dist->irq_sgi_sources[vcpu_id][sgi] & mask) != mask)
+			updated = true;
+		dist->irq_sgi_sources[vcpu_id][sgi] |= mask;
+	}
+
+	/* Set active SGIs already on LRs to pending and active */
+	for_each_set_bit(i, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
+		lr = &vgic_cpu->vgic_lr[i];
+		sgi = *lr & GICH_LR_VIRTUALID;
+		cpu = (*lr & GICH_LR_PHYSID_CPUID) >> GICH_LR_PHYSID_CPUID_SHIFT;
+
+		if (sgi >= min_sgi && sgi <= max_sgi) {
+			if (reg & ((1 << cpu) << (8 * (sgi - min_sgi)))) {
+				if (!(*lr & GICH_LR_PENDING_BIT))
+					updated = true;
+				*lr |= GICH_LR_PENDING_BIT;
+			}
+		}
+	}
+
+	return updated;
 }
 
 /*
-- 
1.7.10.4
