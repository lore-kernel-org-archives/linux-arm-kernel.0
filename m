From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 19 Jun 2014 10:45:48 +0100
Subject: [PATCH 10/14] arm/arm64: KVM: add opaque private pointer to MMIO
 accessors
In-Reply-To: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
References: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1403171152-24067-11-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For a GICv2 there is always only one (v)CPU involved: the one that
does the access. On a GICv3 the access to a CPU redistributor is
memory-mapped, but not banked, so the (v)CPU affected is determined by
looking at the MMIO address region being accessed.
To allow passing the affected CPU into the accessors, extend them to
take an opaque private pointer parameter.
For the current GICv2 emulation we ignore it and simply pass NULL
on the call.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic-v2-emul.c |   41 ++++++++++++++++++++++++-----------------
 virt/kvm/arm/vgic.c         |   16 +++++++++-------
 virt/kvm/arm/vgic.h         |    7 ++++---
 3 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/virt/kvm/arm/vgic-v2-emul.c b/virt/kvm/arm/vgic-v2-emul.c
index ba5f873..30d5c4c 100644
--- a/virt/kvm/arm/vgic-v2-emul.c
+++ b/virt/kvm/arm/vgic-v2-emul.c
@@ -41,7 +41,8 @@ static u8 *vgic_get_sgi_sources(struct vgic_dist *dist, int vcpu_id, int sgi)
 }
 
 static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
-			     struct kvm_exit_mmio *mmio, phys_addr_t offset)
+			     struct kvm_exit_mmio *mmio, phys_addr_t offset,
+			     void *private)
 {
 	u32 reg;
 	u32 word_offset = offset & 3;
@@ -77,7 +78,7 @@ static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
 
 static bool handle_mmio_set_enable_reg(struct kvm_vcpu *vcpu,
 				       struct kvm_exit_mmio *mmio,
-				       phys_addr_t offset)
+				       phys_addr_t offset, void *private)
 {
 	return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
 				      vcpu->vcpu_id, ACCESS_WRITE_SETBIT);
@@ -85,7 +86,7 @@ static bool handle_mmio_set_enable_reg(struct kvm_vcpu *vcpu,
 
 static bool handle_mmio_clear_enable_reg(struct kvm_vcpu *vcpu,
 					 struct kvm_exit_mmio *mmio,
-					 phys_addr_t offset)
+					 phys_addr_t offset, void *private)
 {
 	return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
 				      vcpu->vcpu_id, ACCESS_WRITE_CLEARBIT);
@@ -93,7 +94,7 @@ static bool handle_mmio_clear_enable_reg(struct kvm_vcpu *vcpu,
 
 static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
 					struct kvm_exit_mmio *mmio,
-					phys_addr_t offset)
+					phys_addr_t offset, void *private)
 {
 	return vgic_handle_pending_reg(vcpu->kvm, mmio, offset,
 				       vcpu->vcpu_id, ACCESS_WRITE_SETBIT);
@@ -101,7 +102,7 @@ static bool handle_mmio_set_pending_reg(struct kvm_vcpu *vcpu,
 
 static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
 					  struct kvm_exit_mmio *mmio,
-					  phys_addr_t offset)
+					  phys_addr_t offset, void *private)
 {
 	return vgic_handle_pending_reg(vcpu->kvm, mmio, offset,
 				       vcpu->vcpu_id, ACCESS_WRITE_CLEARBIT);
@@ -109,7 +110,7 @@ static bool handle_mmio_clear_pending_reg(struct kvm_vcpu *vcpu,
 
 static bool handle_mmio_priority_reg(struct kvm_vcpu *vcpu,
 				     struct kvm_exit_mmio *mmio,
-				     phys_addr_t offset)
+				     phys_addr_t offset, void *private)
 {
 	u32 *reg;
 
@@ -169,7 +170,7 @@ static void vgic_set_target_reg(struct kvm *kvm, u32 val, int irq)
 
 static bool handle_mmio_target_reg(struct kvm_vcpu *vcpu,
 				   struct kvm_exit_mmio *mmio,
-				   phys_addr_t offset)
+				   phys_addr_t offset, void *private)
 {
 	u32 reg;
 
@@ -197,7 +198,8 @@ static bool handle_mmio_target_reg(struct kvm_vcpu *vcpu,
 }
 
 static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
-				struct kvm_exit_mmio *mmio, phys_addr_t offset)
+				struct kvm_exit_mmio *mmio, phys_addr_t offset,
+				void *private)
 {
 	u32 *reg;
 
@@ -208,7 +210,8 @@ static bool handle_mmio_cfg_reg(struct kvm_vcpu *vcpu,
 }
 
 static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
-				struct kvm_exit_mmio *mmio, phys_addr_t offset)
+				struct kvm_exit_mmio *mmio, phys_addr_t offset,
+				void *private)
 {
 	u32 reg;
 	vgic_reg_access(mmio, &reg, offset,
@@ -281,7 +284,7 @@ static bool write_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
 
 static bool handle_mmio_sgi_set(struct kvm_vcpu *vcpu,
 				struct kvm_exit_mmio *mmio,
-				phys_addr_t offset)
+				phys_addr_t offset, void *private)
 {
 	if (!mmio->is_write)
 		return read_set_clear_sgi_pend_reg(vcpu, mmio, offset);
@@ -291,7 +294,7 @@ static bool handle_mmio_sgi_set(struct kvm_vcpu *vcpu,
 
 static bool handle_mmio_sgi_clear(struct kvm_vcpu *vcpu,
 				  struct kvm_exit_mmio *mmio,
-				  phys_addr_t offset)
+				  phys_addr_t offset, void *private)
 {
 	if (!mmio->is_write)
 		return read_set_clear_sgi_pend_reg(vcpu, mmio, offset);
@@ -405,7 +408,8 @@ static bool vgic_v2_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		return true;
 	}
 
-	return vgic_handle_mmio_range(vcpu, run, mmio, vgic_dist_ranges, base);
+	return vgic_handle_mmio_range(vcpu, run, mmio,
+				      vgic_dist_ranges, base, NULL);
 }
 
 static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg)
@@ -537,7 +541,8 @@ bool vgic_v2_init_emulation_ops(struct kvm *kvm, int type)
 }
 
 static bool handle_cpu_mmio_misc(struct kvm_vcpu *vcpu,
-				 struct kvm_exit_mmio *mmio, phys_addr_t offset)
+				 struct kvm_exit_mmio *mmio, phys_addr_t offset,
+				 void *private)
 {
 	bool updated = false;
 	struct vgic_vmcr vmcr;
@@ -578,14 +583,16 @@ static bool handle_cpu_mmio_misc(struct kvm_vcpu *vcpu,
 }
 
 static bool handle_mmio_abpr(struct kvm_vcpu *vcpu,
-			     struct kvm_exit_mmio *mmio, phys_addr_t offset)
+			     struct kvm_exit_mmio *mmio, phys_addr_t offset,
+			     void *private)
 {
-	return handle_cpu_mmio_misc(vcpu, mmio, GIC_CPU_ALIAS_BINPOINT);
+	return handle_cpu_mmio_misc(vcpu, mmio, GIC_CPU_ALIAS_BINPOINT,
+				    private);
 }
 
 static bool handle_cpu_mmio_ident(struct kvm_vcpu *vcpu,
 				  struct kvm_exit_mmio *mmio,
-				  phys_addr_t offset)
+				  phys_addr_t offset, void *private)
 {
 	u32 reg;
 
@@ -701,7 +708,7 @@ static int vgic_attr_regs_access(struct kvm_device *dev,
 		vgic_unqueue_irqs(tmp_vcpu);
 
 	offset -= r->base;
-	r->handle_mmio(vcpu, &mmio, offset);
+	r->handle_mmio(vcpu, &mmio, offset, NULL);
 
 	if (!is_write)
 		*reg = mmio_data_read(&mmio, ~0);
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 0140505..4c1a129 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -327,7 +327,8 @@ void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
 }
 
 bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu,
-			       struct kvm_exit_mmio *mmio, phys_addr_t offset)
+			       struct kvm_exit_mmio *mmio, phys_addr_t offset,
+			       void *private)
 {
 	vgic_reg_access(mmio, NULL, offset,
 			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
@@ -536,7 +537,7 @@ static bool vgic_validate_access(const struct vgic_dist *dist,
  */
 static bool call_range_handler(struct kvm_vcpu *vcpu,
 			       struct kvm_exit_mmio *mmio,
-			       unsigned long offset,
+			       unsigned long offset, void *private,
 			       const struct mmio_range *range)
 {
 	u32 *data32 = (void *)mmio->data;
@@ -544,7 +545,7 @@ static bool call_range_handler(struct kvm_vcpu *vcpu,
 	bool ret;
 
 	if (likely(mmio->len <= 4))
-		return range->handle_mmio(vcpu, mmio, offset);
+		return range->handle_mmio(vcpu, mmio, offset, private);
 
 	/*
 	 * We assume that any access greater than 4 bytes is actually
@@ -557,14 +558,14 @@ static bool call_range_handler(struct kvm_vcpu *vcpu,
 	mmio32.phys_addr = mmio->phys_addr + 4;
 	if (mmio->is_write)
 		*(u32 *)mmio32.data = data32[1];
-	ret = range->handle_mmio(vcpu, &mmio32, offset + 4);
+	ret = range->handle_mmio(vcpu, &mmio32, offset + 4, private);
 	if (!mmio->is_write)
 		data32[1] = *(u32 *)mmio32.data;
 
 	mmio32.phys_addr = mmio->phys_addr;
 	if (mmio->is_write)
 		*(u32 *)mmio32.data = data32[0];
-	ret |= range->handle_mmio(vcpu, &mmio32, offset);
+	ret |= range->handle_mmio(vcpu, &mmio32, offset, private);
 	if (!mmio->is_write)
 		data32[0] = *(u32 *)mmio32.data;
 
@@ -584,7 +585,7 @@ static bool call_range_handler(struct kvm_vcpu *vcpu,
 bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			    struct kvm_exit_mmio *mmio,
 			    const struct mmio_range *ranges,
-			    unsigned long mmio_base)
+			    unsigned long mmio_base, void *private)
 {
 	const struct mmio_range *range;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
@@ -602,7 +603,8 @@ bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	spin_lock(&vcpu->kvm->arch.vgic.lock);
 	offset -= range->base;
 	if (vgic_validate_access(dist, range, offset)) {
-		updated_state = call_range_handler(vcpu, mmio, offset, range);
+		updated_state = call_range_handler(vcpu, mmio, offset, private,
+						   range);
 	} else {
 		if (!mmio->is_write)
 			memset(mmio->data, 0, mmio->len);
diff --git a/virt/kvm/arm/vgic.h b/virt/kvm/arm/vgic.h
index e900aeb..9078e2a 100644
--- a/virt/kvm/arm/vgic.h
+++ b/virt/kvm/arm/vgic.h
@@ -57,7 +57,7 @@ void vgic_unqueue_irqs(struct kvm_vcpu *vcpu);
 void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
 		     phys_addr_t offset, int mode);
 bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
-			phys_addr_t offset);
+			phys_addr_t offset, void *private);
 
 static inline
 u32 mmio_data_read(struct kvm_exit_mmio *mmio, u32 mask)
@@ -76,7 +76,7 @@ struct mmio_range {
 	unsigned long len;
 	int bits_per_irq;
 	bool (*handle_mmio)(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
-			    phys_addr_t offset);
+			    phys_addr_t offset, void *private);
 };
 
 #define IS_IN_RANGE(addr, alen, base, len) \
@@ -90,7 +90,8 @@ struct mmio_range *vgic_find_matching_range(const struct mmio_range *ranges,
 bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			    struct kvm_exit_mmio *mmio,
 			    const struct mmio_range *ranges,
-			    unsigned long mmio_base);
+			    unsigned long mmio_base,
+			    void *private);
 
 bool vgic_handle_enable_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
 			    phys_addr_t offset, int vcpu_id, int access);
-- 
1.7.9.5
