From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:39 -0500
Subject: [RFC 43/55] KVM: arm/arm64: Handle shadow stage 2 page faults
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-44-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

If we are faulting on a shadow stage 2 translation, we have to take
extra care in faulting in a page, because we have to collapse the two
levels of stage 2 paging by walking the L2-to-L1 stage 2 page tables in
software.

This approach tries to integrate as much as possible with the existing
code.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm/include/asm/kvm_emulate.h   |  7 ++++
 arch/arm/kvm/mmio.c                  | 12 +++---
 arch/arm/kvm/mmu.c                   | 75 ++++++++++++++++++++++++++++--------
 arch/arm64/include/asm/kvm_emulate.h |  9 +++++
 4 files changed, 82 insertions(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 6285f4f..dfc53ce 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -309,4 +309,11 @@ static inline struct kvm_s2_vmid *vcpu_get_active_vmid(struct kvm_vcpu *vcpu)
 {
 	return &vcpu->kvm->arch.mmu.vmid;
 }
+
+/* arm architecture doesn't support the nesting */
+static inline bool kvm_is_shadow_s2_fault(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
 #endif /* __ARM_KVM_EMULATE_H__ */
diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index b6e715f..a1009c2 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -153,7 +153,7 @@ static int decode_hsr(struct kvm_vcpu *vcpu, bool *is_write, int *len)
 }
 
 int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
-		 phys_addr_t fault_ipa)
+		 phys_addr_t ipa)
 {
 	unsigned long data;
 	unsigned long rt;
@@ -182,22 +182,22 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		data = vcpu_data_guest_to_host(vcpu, vcpu_get_reg(vcpu, rt),
 					       len);
 
-		trace_kvm_mmio(KVM_TRACE_MMIO_WRITE, len, fault_ipa, data);
+		trace_kvm_mmio(KVM_TRACE_MMIO_WRITE, len, ipa, data);
 		kvm_mmio_write_buf(data_buf, len, data);
 
-		ret = kvm_io_bus_write(vcpu, KVM_MMIO_BUS, fault_ipa, len,
+		ret = kvm_io_bus_write(vcpu, KVM_MMIO_BUS, ipa, len,
 				       data_buf);
 	} else {
 		trace_kvm_mmio(KVM_TRACE_MMIO_READ_UNSATISFIED, len,
-			       fault_ipa, 0);
+			       ipa, 0);
 
-		ret = kvm_io_bus_read(vcpu, KVM_MMIO_BUS, fault_ipa, len,
+		ret = kvm_io_bus_read(vcpu, KVM_MMIO_BUS, ipa, len,
 				      data_buf);
 	}
 
 	/* Now prepare kvm_run for the potential return to userland. */
 	run->mmio.is_write	= is_write;
-	run->mmio.phys_addr	= fault_ipa;
+	run->mmio.phys_addr	= ipa;
 	run->mmio.len		= len;
 
 	if (!ret) {
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 1677a87..710ae60 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1072,10 +1072,10 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 	return ret;
 }
 
-static bool transparent_hugepage_adjust(kvm_pfn_t *pfnp, phys_addr_t *ipap)
+static bool transparent_hugepage_adjust(kvm_pfn_t *pfnp, gfn_t gfn,
+					phys_addr_t *ipap)
 {
 	kvm_pfn_t pfn = *pfnp;
-	gfn_t gfn = *ipap >> PAGE_SHIFT;
 
 	if (PageTransCompoundMap(pfn_to_page(pfn))) {
 		unsigned long mask;
@@ -1291,13 +1291,15 @@ static void coherent_cache_guest_page(struct kvm_vcpu *vcpu, kvm_pfn_t pfn,
 }
 
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
-			  struct kvm_memory_slot *memslot, unsigned long hva,
-			  unsigned long fault_status)
+			  struct kvm_s2_trans *nested,
+			  struct kvm_memory_slot *memslot,
+			  unsigned long hva, unsigned long fault_status)
 {
 	int ret;
 	bool write_fault, writable, hugetlb = false, force_pte = false;
 	unsigned long mmu_seq;
-	gfn_t gfn = fault_ipa >> PAGE_SHIFT;
+	phys_addr_t ipa = fault_ipa;
+	gfn_t gfn;
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
 	struct vm_area_struct *vma;
@@ -1323,9 +1325,23 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
-	if (is_vm_hugetlb_page(vma) && !logging_active) {
+	if (kvm_is_shadow_s2_fault(vcpu)) {
+		ipa = nested->output;
+
+		/*
+		 * If we're about to create a shadow stage 2 entry, then we
+		 * can only create huge mapings if the guest hypervior also
+		 * uses a huge mapping.
+		 */
+		if (nested->block_size != PMD_SIZE)
+			force_pte = true;
+	}
+	gfn = ipa >> PAGE_SHIFT;
+
+
+	if (!force_pte && is_vm_hugetlb_page(vma) && !logging_active) {
 		hugetlb = true;
-		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
+		gfn = (ipa & PMD_MASK) >> PAGE_SHIFT;
 	} else {
 		/*
 		 * Pages belonging to memslots that don't have the same
@@ -1389,7 +1405,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		goto out_unlock;
 
 	if (!hugetlb && !force_pte)
-		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
+		hugetlb = transparent_hugepage_adjust(&pfn, gfn, &fault_ipa);
 
 	fault_ipa_uncached = memslot->flags & KVM_MEMSLOT_INCOHERENT;
 
@@ -1435,6 +1451,12 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 	kvm_pfn_t pfn;
 	bool pfn_valid = false;
 
+	/*
+	 * TODO: Lookup nested S2 pgtable entry and if the access flag is set,
+	 * then inject an access fault to the guest and invalidate the shadow
+	 * entry.
+	 */
+
 	trace_kvm_access_fault(fault_ipa);
 
 	spin_lock(&vcpu->kvm->mmu_lock);
@@ -1478,8 +1500,10 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	unsigned long fault_status;
-	phys_addr_t fault_ipa;
+	phys_addr_t fault_ipa; /* The address we faulted on */
+	phys_addr_t ipa; /* Always the IPA in the L1 guest phys space */
 	struct kvm_memory_slot *memslot;
+	struct kvm_s2_trans nested_trans;
 	unsigned long hva;
 	bool is_iabt, write_fault, writable;
 	gfn_t gfn;
@@ -1491,7 +1515,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		return 1;
 	}
 
-	fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
+	ipa = fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
 
 	trace_kvm_guest_fault(*vcpu_pc(vcpu), kvm_vcpu_get_hsr(vcpu),
 			      kvm_vcpu_get_hfar(vcpu), fault_ipa);
@@ -1500,6 +1524,10 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	fault_status = kvm_vcpu_trap_get_fault_type(vcpu);
 	if (fault_status != FSC_FAULT && fault_status != FSC_PERM &&
 	    fault_status != FSC_ACCESS) {
+		/*
+		 * TODO: Report address size faults from an L2 IPA which
+		 * exceeds KVM_PHYS_SIZE to the L1 hypervisor.
+		 */
 		kvm_err("Unsupported FSC: EC=%#x xFSC=%#lx ESR_EL2=%#lx\n",
 			kvm_vcpu_trap_get_class(vcpu),
 			(unsigned long)kvm_vcpu_trap_get_fault(vcpu),
@@ -1509,7 +1537,23 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 
-	gfn = fault_ipa >> PAGE_SHIFT;
+	/*
+	 * We may have faulted on a shadow stage 2 page table if we are
+	 * running a nested guest.  In this case, we have to resovle the L2
+	 * IPA to the L1 IPA first, before knowing what kind of memory should
+	 * back the L1 IPA.
+	 *
+	 * If the shadow stage 2 page table walk faults, then we simply inject
+	 * this to the guest and carry on.
+	 */
+	if (kvm_is_shadow_s2_fault(vcpu)) {
+		ret = kvm_walk_nested_s2(vcpu, fault_ipa, &nested_trans);
+		if (ret)
+			goto out_unlock;
+		ipa = nested_trans.output;
+	}
+
+	gfn = ipa >> PAGE_SHIFT;
 	memslot = gfn_to_memslot(vcpu->kvm, gfn);
 	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
 	write_fault = kvm_is_write_fault(vcpu);
@@ -1543,13 +1587,13 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * faulting VA. This is always 12 bits, irrespective
 		 * of the page size.
 		 */
-		fault_ipa |= kvm_vcpu_get_hfar(vcpu) & ((1 << 12) - 1);
-		ret = io_mem_abort(vcpu, run, fault_ipa);
+		ipa |= kvm_vcpu_get_hfar(vcpu) & ((1 << 12) - 1);
+		ret = io_mem_abort(vcpu, run, ipa);
 		goto out_unlock;
 	}
 
 	/* Userspace should not be able to register out-of-bounds IPAs */
-	VM_BUG_ON(fault_ipa >= KVM_PHYS_SIZE);
+	VM_BUG_ON(ipa >= KVM_PHYS_SIZE);
 
 	if (fault_status == FSC_ACCESS) {
 		handle_access_fault(vcpu, fault_ipa);
@@ -1557,7 +1601,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		goto out_unlock;
 	}
 
-	ret = user_mem_abort(vcpu, fault_ipa, memslot, hva, fault_status);
+	ret = user_mem_abort(vcpu, fault_ipa, &nested_trans,
+			     memslot, hva, fault_status);
 	if (ret == 0)
 		ret = 1;
 out_unlock:
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index abad676..2994410 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -368,4 +368,13 @@ static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
 	return data;		/* Leave LE untouched */
 }
 
+static inline bool kvm_is_shadow_s2_fault(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_KVM_ARM_NESTED_HYP
+	return (!vcpu_mode_el2(vcpu)) && vcpu_nested_stage2_enabled(vcpu);
+#else
+	return false;
+#endif
+}
+
 #endif /* __ARM64_KVM_EMULATE_H__ */
-- 
1.9.1
