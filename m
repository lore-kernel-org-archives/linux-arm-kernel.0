From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 27 Oct 2013 17:20:52 +0000
Subject: [PATCH RESEND v2 7/8] KVM: arm-vgic: Add  GICD_SPENDSGIR and
 GICD_CPENDSGIR handlers
In-Reply-To: <775b0df085e5a39ab9006e20d72f1bb7@www.loen.fr>
References: <1382432923-61267-1-git-send-email-christoffer.dall@linaro.org>
 <1382432923-61267-8-git-send-email-christoffer.dall@linaro.org>
 <775b0df085e5a39ab9006e20d72f1bb7@www.loen.fr>
Message-ID: <20131027172052.GD21180@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 05:00:43PM +0100, Marc Zyngier wrote:
> On 2013-10-22 10:08, Christoffer Dall wrote:
> >Handle MMIO accesses to the two registers which should support
> >both the
> >case where the VMs want to read/write either of these registers
> >and the
> >case where user space reads/writes these registers to do
> >save/restore of
> >the VGIC state.
> >
> >Note that the added complexity compared to simple set/clear enable
> >registers stems from the bookkeping of source cpu ids.  It may be
> >possible to change the underlying data structure to simplify the
> >complexity, but since this is not in the critical path, at all,
> >this is
> >left as an interesting excercise to the reader.
> >
> >Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> >Reviewed-by: Alexander Graf <agraf@suse.de>
> >
> >---
> >Changelog[v2]:
> > - Use struct kvm_exit_mmio accessors for ->data field.
> >---
> > virt/kvm/arm/vgic.c |  114
> >++++++++++++++++++++++++++++++++++++++++++++++++++-
> > 1 file changed, 112 insertions(+), 2 deletions(-)
> >
> >diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> >index f2dc72a..4e8c3ab 100644
> >--- a/virt/kvm/arm/vgic.c
> >+++ b/virt/kvm/arm/vgic.c
> >@@ -589,18 +589,128 @@ static bool handle_mmio_sgi_reg(struct
> >kvm_vcpu *vcpu,
> > 	return false;
> > }
> >
> >+static void read_sgi_set_clear(struct kvm_vcpu *vcpu,
> >+			       struct kvm_exit_mmio *mmio,
> >+			       phys_addr_t offset)
> 
> set_clear is a bit unclear. How about reset?
> 

it's not a reset, it handles reads of the clear/set pending registers:

/* Handle reads of GICD_CPENDSGIRn and GICD_SPENDSGIRn */
static void read_set_clear_sgi_pend_reg(...)

Does that work?

> >+{
> >+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> >+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> >+	int i, sgi, cpu;
> >+	int min_sgi = (offset & ~0x3) * 4;
> >+	int max_sgi = min_sgi + 3;
> >+	int vcpu_id = vcpu->vcpu_id;
> >+	u32 lr, reg = 0;
> >+
> >+	/* Copy source SGIs from distributor side */
> >+	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
> >+		int shift = 8 * (sgi - min_sgi);
> >+		reg |= (u32)dist->irq_sgi_sources[vcpu_id][sgi] << shift;
> >+	}
> >+
> >+	/* Copy source SGIs already on LRs */
> >+	for_each_set_bit(i, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
> >+		lr = vgic_cpu->vgic_lr[i];
> >+		sgi = lr & GICH_LR_VIRTUALID;
> >+		cpu = (lr & GICH_LR_PHYSID_CPUID) >> GICH_LR_PHYSID_CPUID_SHIFT;
> 
> Please wrap these  lr accesses into separate functions. There is
> quite a bit of duplication in this patch and I wonder if we could
> factor things a bit.
> 
> At least, please isolate what is emulation related from what is
> actually what the underlying HW provides. It will help mitigating my
> headache in the future... ;-)
> 

hmmm, yeah, this actually quite sucks, and the problems repeats itself
for other pending registers as well.

Making defines for the loop logic will be too ugly macro-mess and having
a looping function with an ops fn pointer will also suck, so I actually
think the solution is quite a different one:

Before accessing any of the register state, make sure everything is
stopped (which is probably something we should have done anyway) and
move all state from the LRs to the distributor.

I will add a separate patch for this in v3.

> >+		if (sgi >= min_sgi && sgi <= max_sgi) {
> >+			if (lr & GICH_LR_STATE)
> >+				reg |= (1 << cpu) << (8 * (sgi - min_sgi));
> >+		}
> >+	}
> >+
> >+	mmio_data_write(mmio, ~0, reg);
> >+}
> >+
> > static bool handle_mmio_sgi_clear(struct kvm_vcpu *vcpu,
> > 				  struct kvm_exit_mmio *mmio,
> > 				  phys_addr_t offset)
> > {
> >-	return false;
> >+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> >+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> >+	int i, sgi, cpu;
> >+	int min_sgi = (offset & ~0x3) * 4;
> >+	int max_sgi = min_sgi + 3;
> >+	int vcpu_id = vcpu->vcpu_id;
> >+	u32 *lr, reg;
> >+	bool updated = false;
> >+
> >+	if (!mmio->is_write) {
> >+		read_sgi_set_clear(vcpu, mmio, offset);
> >+		return false;
> >+	}
> >+
> >+	reg = mmio_data_read(mmio, ~0);
> >+
> >+	/* Clear pending SGIs on distributor side */
> >+	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
> >+		u8 mask = reg >> (8 * (sgi - min_sgi));
> >+		if (dist->irq_sgi_sources[vcpu_id][sgi] & mask)
> >+			updated = true;
> >+		dist->irq_sgi_sources[vcpu_id][sgi] &= ~mask;
> >+	}
> >+
> >+	/* Clear SGIs already on LRs */
> >+	for_each_set_bit(i, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
> >+		lr = &vgic_cpu->vgic_lr[i];
> >+		sgi = *lr & GICH_LR_VIRTUALID;
> >+		cpu = (*lr & GICH_LR_PHYSID_CPUID) >> GICH_LR_PHYSID_CPUID_SHIFT;
> >+
> >+		if (sgi >= min_sgi && sgi <= max_sgi) {
> >+			if (reg & ((1 << cpu) << (8 * (sgi - min_sgi)))) {
> >+				if (*lr & GICH_LR_PENDING_BIT)
> >+					updated = true;
> >+				*lr &= GICH_LR_PENDING_BIT;
> >+			}
> >+		}
> >+	}
> >+
> >+	return updated;
> > }
> >
> > static bool handle_mmio_sgi_set(struct kvm_vcpu *vcpu,
> > 				struct kvm_exit_mmio *mmio,
> > 				phys_addr_t offset)
> > {
> >-	return false;
> >+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> >+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> >+	int i, sgi, cpu;
> >+	int min_sgi = (offset & ~0x3) * 4;
> >+	int max_sgi = min_sgi + 3;
> >+	int vcpu_id = vcpu->vcpu_id;
> >+	u32 *lr, reg;
> >+	bool updated = false;
> >+
> >+	if (!mmio->is_write) {
> >+		read_sgi_set_clear(vcpu, mmio, offset);
> >+		return false;
> >+	}
> >+
> >+	reg = mmio_data_read(mmio, ~0);
> >+
> >+	/* Set pending SGIs on distributor side */
> >+	for (sgi = min_sgi; sgi <= max_sgi; sgi++) {
> >+		u8 mask = reg >> (8 * (sgi - min_sgi));
> >+		if ((dist->irq_sgi_sources[vcpu_id][sgi] & mask) != mask)
> >+			updated = true;
> >+		dist->irq_sgi_sources[vcpu_id][sgi] |= mask;
> >+	}
> >+
> >+	/* Set active SGIs already on LRs to pending and active */
> >+	for_each_set_bit(i, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
> >+		lr = &vgic_cpu->vgic_lr[i];
> >+		sgi = *lr & GICH_LR_VIRTUALID;
> >+		cpu = (*lr & GICH_LR_PHYSID_CPUID) >> GICH_LR_PHYSID_CPUID_SHIFT;
> >+
> >+		if (sgi >= min_sgi && sgi <= max_sgi) {
> >+			if (reg & ((1 << cpu) << (8 * (sgi - min_sgi)))) {
> >+				if (!(*lr & GICH_LR_PENDING_BIT))
> >+					updated = true;
> >+				*lr |= GICH_LR_PENDING_BIT;
> >+			}
> >+		}
> >+	}
> >+
> >+	return updated;
> > }
> >
> > /*
> 
> Overall, I feel like I've read the same function three times. Hint,
> hint... ;-)
> 

Yeah yeah yeah, you're right, this was broken :)

-- 
Christoffer
