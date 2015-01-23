From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:46 +0100
Subject: [GIT PULL 17/36] arm/arm64: KVM: refactor vgic_handle_mmio() function
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-18-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

Currently we only need to deal with one MMIO region for the GIC
emulation (the GICv2 distributor), but we soon need to extend this.
Refactor the existing code to allow easier addition of different
ranges without code duplication.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 73 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 283038e..b5aa821 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1034,36 +1034,27 @@ static bool vgic_validate_access(const struct vgic_dist *dist,
 }
 
 /**
- * vgic_handle_mmio - handle an in-kernel MMIO access
+ * vgic_handle_mmio_range - handle an in-kernel MMIO access
  * @vcpu:	pointer to the vcpu performing the access
  * @run:	pointer to the kvm_run structure
  * @mmio:	pointer to the data describing the access
+ * @ranges:	array of MMIO ranges in a given region
+ * @mmio_base:	base address of that region
  *
- * returns true if the MMIO access has been performed in kernel space,
- * and false if it needs to be emulated in user space.
+ * returns true if the MMIO access could be performed
  */
-bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
-		      struct kvm_exit_mmio *mmio)
+static bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
+			    struct kvm_exit_mmio *mmio,
+			    const struct mmio_range *ranges,
+			    unsigned long mmio_base)
 {
 	const struct mmio_range *range;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
-	unsigned long base = dist->vgic_dist_base;
 	bool updated_state;
 	unsigned long offset;
 
-	if (!irqchip_in_kernel(vcpu->kvm) ||
-	    mmio->phys_addr < base ||
-	    (mmio->phys_addr + mmio->len) > (base + KVM_VGIC_V2_DIST_SIZE))
-		return false;
-
-	/* We don't support ldrd / strd or ldm / stm to the emulated vgic */
-	if (mmio->len > 4) {
-		kvm_inject_dabt(vcpu, mmio->phys_addr);
-		return true;
-	}
-
-	offset = mmio->phys_addr - base;
-	range = find_matching_range(vgic_dist_ranges, mmio, offset);
+	offset = mmio->phys_addr - mmio_base;
+	range = find_matching_range(ranges, mmio, offset);
 	if (unlikely(!range || !range->handle_mmio)) {
 		pr_warn("Unhandled access %d %08llx %d\n",
 			mmio->is_write, mmio->phys_addr, mmio->len);
@@ -1071,7 +1062,7 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	}
 
 	spin_lock(&vcpu->kvm->arch.vgic.lock);
-	offset = mmio->phys_addr - range->base - base;
+	offset -= range->base;
 	if (vgic_validate_access(dist, range, offset)) {
 		updated_state = range->handle_mmio(vcpu, mmio, offset);
 	} else {
@@ -1089,6 +1080,48 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	return true;
 }
 
+static inline bool is_in_range(phys_addr_t addr, unsigned long len,
+			       phys_addr_t baseaddr, unsigned long size)
+{
+	return (addr >= baseaddr) && (addr + len <= baseaddr + size);
+}
+
+static bool vgic_v2_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
+				struct kvm_exit_mmio *mmio)
+{
+	unsigned long base = vcpu->kvm->arch.vgic.vgic_dist_base;
+
+	if (!is_in_range(mmio->phys_addr, mmio->len, base,
+			 KVM_VGIC_V2_DIST_SIZE))
+		return false;
+
+	/* GICv2 does not support accesses wider than 32 bits */
+	if (mmio->len > 4) {
+		kvm_inject_dabt(vcpu, mmio->phys_addr);
+		return true;
+	}
+
+	return vgic_handle_mmio_range(vcpu, run, mmio, vgic_dist_ranges, base);
+}
+
+/**
+ * vgic_handle_mmio - handle an in-kernel MMIO access for the GIC emulation
+ * @vcpu:      pointer to the vcpu performing the access
+ * @run:       pointer to the kvm_run structure
+ * @mmio:      pointer to the data describing the access
+ *
+ * returns true if the MMIO access has been performed in kernel space,
+ * and false if it needs to be emulated in user space.
+ */
+bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
+		      struct kvm_exit_mmio *mmio)
+{
+	if (!irqchip_in_kernel(vcpu->kvm))
+		return false;
+
+	return vgic_v2_handle_mmio(vcpu, run, mmio);
+}
+
 static u8 *vgic_get_sgi_sources(struct vgic_dist *dist, int vcpu_id, int sgi)
 {
 	return dist->irq_sgi_sources + vcpu_id * VGIC_NR_SGIS + sgi;
-- 
2.1.2.330.g565301e.dirty
