From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 12:57:55 -0500
Subject: [PATCH v6 05/15] KVM: ARM: Memory virtualization setup
In-Reply-To: <20130116175716.29147.15348.stgit@ubuntu>
References: <20130116175716.29147.15348.stgit@ubuntu>
Message-ID: <20130116175754.29147.30011.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit introduces the framework for guest memory management
through the use of 2nd stage translation. Each VM has a pointer
to a level-1 table (the pgd field in struct kvm_arch) which is
used for the 2nd stage translations. Entries are added when handling
guest faults (later patch) and the table itself can be allocated and
freed through the following functions implemented in
arch/arm/kvm/arm_mmu.c:
 - kvm_alloc_stage2_pgd(struct kvm *kvm);
 - kvm_free_stage2_pgd(struct kvm *kvm);

Each entry in TLBs and caches are tagged with a VMID identifier in
addition to ASIDs. The VMIDs are assigned consecutively to VMs in the
order that VMs are executed, and caches and tlbs are invalidated when
the VMID space has been used to allow for more than 255 simultaenously
running guests.

The 2nd stage pgd is allocated in kvm_arch_init_vm(). The table is
freed in kvm_arch_destroy_vm(). Both functions are called from the main
KVM code.

We pre-allocate page table memory to be able to synchronize using a
spinlock and be called under rcu_read_lock from the MMU notifiers.  We
steal the mmu_memory_cache implementation from x86 and adapt for our
specific usage.

We support MMU notifiers (thanks to Marc Zyngier) through
kvm_unmap_hva and kvm_set_spte_hva.

Finally, define kvm_phys_addr_ioremap() to map a device at a guest IPA,
which is used by VGIC support to map the virtual CPU interface registers
to the guest. This support is added by Marc Zyngier.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_asm.h  |    2 
 arch/arm/include/asm/kvm_host.h |   18 ++
 arch/arm/include/asm/kvm_mmu.h  |    9 +
 arch/arm/kvm/Kconfig            |    1 
 arch/arm/kvm/arm.c              |   37 ++++
 arch/arm/kvm/interrupts.S       |    7 +
 arch/arm/kvm/mmu.c              |  370 +++++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/trace.h            |   46 +++++
 8 files changed, 488 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 81324e2..f6652f6 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -57,6 +57,7 @@
 #define ARM_EXCEPTION_HVC	  7
 
 #ifndef __ASSEMBLY__
+struct kvm;
 struct kvm_vcpu;
 
 extern char __kvm_hyp_init[];
@@ -71,6 +72,7 @@ extern char __kvm_hyp_code_start[];
 extern char __kvm_hyp_code_end[];
 
 extern void __kvm_flush_vm_context(void);
+extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
 
 extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
 #endif
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 067ef28..3636c7e 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -112,4 +112,22 @@ struct kvm_one_reg;
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 u64 kvm_call_hyp(void *hypfn, ...);
+
+#define KVM_ARCH_WANT_MMU_NOTIFIER
+struct kvm;
+int kvm_unmap_hva(struct kvm *kvm, unsigned long hva);
+int kvm_unmap_hva_range(struct kvm *kvm,
+			unsigned long start, unsigned long end);
+void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+
+/* We do not have shadow page tables, hence the empty hooks */
+static inline int kvm_age_hva(struct kvm *kvm, unsigned long hva)
+{
+	return 0;
+}
+
+static inline int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
+{
+	return 0;
+}
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index e8679b3..499e7b0 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -23,6 +23,15 @@ int create_hyp_mappings(void *from, void *to);
 int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
 void free_hyp_pmds(void);
 
+int kvm_alloc_stage2_pgd(struct kvm *kvm);
+void kvm_free_stage2_pgd(struct kvm *kvm);
+int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
+			  phys_addr_t pa, unsigned long size);
+
+int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run);
+
+void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
+
 phys_addr_t kvm_mmu_get_httbr(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 4a01b6f..05227cb 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -36,6 +36,7 @@ config KVM_ARM_HOST
 	bool "KVM host support for ARM cpus."
 	depends on KVM
 	depends on MMU
+	select	MMU_NOTIFIER
 	---help---
 	  Provides host support for ARM processors.
 
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 2c6b780..d810afb 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -81,12 +81,33 @@ void kvm_arch_sync_events(struct kvm *kvm)
 {
 }
 
+/**
+ * kvm_arch_init_vm - initializes a VM data structure
+ * @kvm:	pointer to the KVM struct
+ */
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
+	int ret = 0;
+
 	if (type)
 		return -EINVAL;
 
-	return 0;
+	ret = kvm_alloc_stage2_pgd(kvm);
+	if (ret)
+		goto out_fail_alloc;
+
+	ret = create_hyp_mappings(kvm, kvm + 1);
+	if (ret)
+		goto out_free_stage2_pgd;
+
+	/* Mark the initial VMID generation invalid */
+	kvm->arch.vmid_gen = 0;
+
+	return ret;
+out_free_stage2_pgd:
+	kvm_free_stage2_pgd(kvm);
+out_fail_alloc:
+	return ret;
 }
 
 int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
@@ -104,10 +125,16 @@ int kvm_arch_create_memslot(struct kvm_memory_slot *slot, unsigned long npages)
 	return 0;
 }
 
+/**
+ * kvm_arch_destroy_vm - destroy the VM data structure
+ * @kvm:	pointer to the KVM struct
+ */
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	int i;
 
+	kvm_free_stage2_pgd(kvm);
+
 	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
 		if (kvm->vcpus[i]) {
 			kvm_arch_vcpu_free(kvm->vcpus[i]);
@@ -196,7 +223,13 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	if (err)
 		goto free_vcpu;
 
+	err = create_hyp_mappings(vcpu, vcpu + 1);
+	if (err)
+		goto vcpu_uninit;
+
 	return vcpu;
+vcpu_uninit:
+	kvm_vcpu_uninit(vcpu);
 free_vcpu:
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 out:
@@ -210,6 +243,8 @@ int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 {
+	kvm_mmu_free_memory_caches(vcpu);
+	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index db288a7..99fbf6a 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -32,6 +32,13 @@ __kvm_hyp_code_start:
 /********************************************************************
  * Flush per-VMID TLBs
  */
+ENTRY(__kvm_tlb_flush_vmid)
+	bx	lr
+ENDPROC(__kvm_tlb_flush_vmid)
+
+/********************************************************************
+ * Flush TLBs and instruction caches of current CPU for all VMIDs
+ */
 ENTRY(__kvm_flush_vm_context)
 	bx	lr
 ENDPROC(__kvm_flush_vm_context)
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 4decdb6..4347d68 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -23,12 +23,21 @@
 #include <asm/pgalloc.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_asm.h>
 #include <asm/mach/map.h>
+#include <trace/events/kvm.h>
+
+#include "trace.h"
 
 extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 
 static DEFINE_MUTEX(kvm_hyp_pgd_mutex);
 
+static void kvm_tlb_flush_vmid(struct kvm *kvm)
+{
+	kvm_call_hyp(__kvm_tlb_flush_vmid, kvm);
+}
+
 static void kvm_set_pte(pte_t *pte, pte_t new_pte)
 {
 	pte_val(*pte) = new_pte;
@@ -39,6 +48,38 @@ static void kvm_set_pte(pte_t *pte, pte_t new_pte)
 	flush_pmd_entry(pte);
 }
 
+static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
+				  int min, int max)
+{
+	void *page;
+
+	BUG_ON(max > KVM_NR_MEM_OBJS);
+	if (cache->nobjs >= min)
+		return 0;
+	while (cache->nobjs < max) {
+		page = (void *)__get_free_page(PGALLOC_GFP);
+		if (!page)
+			return -ENOMEM;
+		cache->objects[cache->nobjs++] = page;
+	}
+	return 0;
+}
+
+static void mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
+{
+	while (mc->nobjs)
+		free_page((unsigned long)mc->objects[--mc->nobjs]);
+}
+
+static void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
+{
+	void *p;
+
+	BUG_ON(!mc || !mc->nobjs);
+	p = mc->objects[--mc->nobjs];
+	return p;
+}
+
 static void free_ptes(pmd_t *pmd, unsigned long addr)
 {
 	pte_t *pte;
@@ -217,11 +258,333 @@ int create_hyp_io_mappings(void *from, void *to, phys_addr_t addr)
 	return __create_hyp_mappings(from, to, &pfn);
 }
 
+/**
+ * kvm_alloc_stage2_pgd - allocate level-1 table for stage-2 translation.
+ * @kvm:	The KVM struct pointer for the VM.
+ *
+ * Allocates the 1st level table only of size defined by S2_PGD_ORDER (can
+ * support either full 40-bit input addresses or limited to 32-bit input
+ * addresses). Clears the allocated pages.
+ *
+ * Note we don't need locking here as this is only called when the VM is
+ * created, which can only be done once.
+ */
+int kvm_alloc_stage2_pgd(struct kvm *kvm)
+{
+	pgd_t *pgd;
+
+	if (kvm->arch.pgd != NULL) {
+		kvm_err("kvm_arch already initialized?\n");
+		return -EINVAL;
+	}
+
+	pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, S2_PGD_ORDER);
+	if (!pgd)
+		return -ENOMEM;
+
+	/* stage-2 pgd must be aligned to its size */
+	VM_BUG_ON((unsigned long)pgd & (S2_PGD_SIZE - 1));
+
+	memset(pgd, 0, PTRS_PER_S2_PGD * sizeof(pgd_t));
+	clean_dcache_area(pgd, PTRS_PER_S2_PGD * sizeof(pgd_t));
+	kvm->arch.pgd = pgd;
+
+	return 0;
+}
+
+static void clear_pud_entry(pud_t *pud)
+{
+	pmd_t *pmd_table = pmd_offset(pud, 0);
+	pud_clear(pud);
+	pmd_free(NULL, pmd_table);
+	put_page(virt_to_page(pud));
+}
+
+static void clear_pmd_entry(pmd_t *pmd)
+{
+	pte_t *pte_table = pte_offset_kernel(pmd, 0);
+	pmd_clear(pmd);
+	pte_free_kernel(NULL, pte_table);
+	put_page(virt_to_page(pmd));
+}
+
+static bool pmd_empty(pmd_t *pmd)
+{
+	struct page *pmd_page = virt_to_page(pmd);
+	return page_count(pmd_page) == 1;
+}
+
+static void clear_pte_entry(pte_t *pte)
+{
+	if (pte_present(*pte)) {
+		kvm_set_pte(pte, __pte(0));
+		put_page(virt_to_page(pte));
+	}
+}
+
+static bool pte_empty(pte_t *pte)
+{
+	struct page *pte_page = virt_to_page(pte);
+	return page_count(pte_page) == 1;
+}
+
+/**
+ * unmap_stage2_range -- Clear stage2 page table entries to unmap a range
+ * @kvm:   The VM pointer
+ * @start: The intermediate physical base address of the range to unmap
+ * @size:  The size of the area to unmap
+ *
+ * Clear a range of stage-2 mappings, lowering the various ref-counts.  Must
+ * be called while holding mmu_lock (unless for freeing the stage2 pgd before
+ * destroying the VM), otherwise another faulting VCPU may come in and mess
+ * with things behind our backs.
+ */
+static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	phys_addr_t addr = start, end = start + size;
+	u64 range;
+
+	while (addr < end) {
+		pgd = kvm->arch.pgd + pgd_index(addr);
+		pud = pud_offset(pgd, addr);
+		if (pud_none(*pud)) {
+			addr += PUD_SIZE;
+			continue;
+		}
+
+		pmd = pmd_offset(pud, addr);
+		if (pmd_none(*pmd)) {
+			addr += PMD_SIZE;
+			continue;
+		}
+
+		pte = pte_offset_kernel(pmd, addr);
+		clear_pte_entry(pte);
+		range = PAGE_SIZE;
+
+		/* If we emptied the pte, walk back up the ladder */
+		if (pte_empty(pte)) {
+			clear_pmd_entry(pmd);
+			range = PMD_SIZE;
+			if (pmd_empty(pmd)) {
+				clear_pud_entry(pud);
+				range = PUD_SIZE;
+			}
+		}
+
+		addr += range;
+	}
+}
+
+/**
+ * kvm_free_stage2_pgd - free all stage-2 tables
+ * @kvm:	The KVM struct pointer for the VM.
+ *
+ * Walks the level-1 page table pointed to by kvm->arch.pgd and frees all
+ * underlying level-2 and level-3 tables before freeing the actual level-1 table
+ * and setting the struct pointer to NULL.
+ *
+ * Note we don't need locking here as this is only called when the VM is
+ * destroyed, which can only be done once.
+ */
+void kvm_free_stage2_pgd(struct kvm *kvm)
+{
+	if (kvm->arch.pgd == NULL)
+		return;
+
+	unmap_stage2_range(kvm, 0, KVM_PHYS_SIZE);
+	free_pages((unsigned long)kvm->arch.pgd, S2_PGD_ORDER);
+	kvm->arch.pgd = NULL;
+}
+
+
+static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
+			  phys_addr_t addr, const pte_t *new_pte, bool iomap)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte, old_pte;
+
+	/* Create 2nd stage page table mapping - Level 1 */
+	pgd = kvm->arch.pgd + pgd_index(addr);
+	pud = pud_offset(pgd, addr);
+	if (pud_none(*pud)) {
+		if (!cache)
+			return 0; /* ignore calls from kvm_set_spte_hva */
+		pmd = mmu_memory_cache_alloc(cache);
+		pud_populate(NULL, pud, pmd);
+		pmd += pmd_index(addr);
+		get_page(virt_to_page(pud));
+	} else
+		pmd = pmd_offset(pud, addr);
+
+	/* Create 2nd stage page table mapping - Level 2 */
+	if (pmd_none(*pmd)) {
+		if (!cache)
+			return 0; /* ignore calls from kvm_set_spte_hva */
+		pte = mmu_memory_cache_alloc(cache);
+		clean_pte_table(pte);
+		pmd_populate_kernel(NULL, pmd, pte);
+		pte += pte_index(addr);
+		get_page(virt_to_page(pmd));
+	} else
+		pte = pte_offset_kernel(pmd, addr);
+
+	if (iomap && pte_present(*pte))
+		return -EFAULT;
+
+	/* Create 2nd stage page table mapping - Level 3 */
+	old_pte = *pte;
+	kvm_set_pte(pte, *new_pte);
+	if (pte_present(old_pte))
+		kvm_tlb_flush_vmid(kvm);
+	else
+		get_page(virt_to_page(pte));
+
+	return 0;
+}
+
+/**
+ * kvm_phys_addr_ioremap - map a device range to guest IPA
+ *
+ * @kvm:	The KVM pointer
+ * @guest_ipa:	The IPA at which to insert the mapping
+ * @pa:		The physical address of the device
+ * @size:	The size of the mapping
+ */
+int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
+			  phys_addr_t pa, unsigned long size)
+{
+	phys_addr_t addr, end;
+	int ret = 0;
+	unsigned long pfn;
+	struct kvm_mmu_memory_cache cache = { 0, };
+
+	end = (guest_ipa + size + PAGE_SIZE - 1) & PAGE_MASK;
+	pfn = __phys_to_pfn(pa);
+
+	for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
+		pte_t pte = pfn_pte(pfn, PAGE_S2_DEVICE | L_PTE_S2_RDWR);
+
+		ret = mmu_topup_memory_cache(&cache, 2, 2);
+		if (ret)
+			goto out;
+		spin_lock(&kvm->mmu_lock);
+		ret = stage2_set_pte(kvm, &cache, addr, &pte, true);
+		spin_unlock(&kvm->mmu_lock);
+		if (ret)
+			goto out;
+
+		pfn++;
+	}
+
+out:
+	mmu_free_memory_cache(&cache);
+	return ret;
+}
+
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	return -EINVAL;
 }
 
+static void handle_hva_to_gpa(struct kvm *kvm,
+			      unsigned long start,
+			      unsigned long end,
+			      void (*handler)(struct kvm *kvm,
+					      gpa_t gpa, void *data),
+			      void *data)
+{
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *memslot;
+
+	slots = kvm_memslots(kvm);
+
+	/* we only care about the pages that the guest sees */
+	kvm_for_each_memslot(memslot, slots) {
+		unsigned long hva_start, hva_end;
+		gfn_t gfn, gfn_end;
+
+		hva_start = max(start, memslot->userspace_addr);
+		hva_end = min(end, memslot->userspace_addr +
+					(memslot->npages << PAGE_SHIFT));
+		if (hva_start >= hva_end)
+			continue;
+
+		/*
+		 * {gfn(page) | page intersects with [hva_start, hva_end)} =
+		 * {gfn_start, gfn_start+1, ..., gfn_end-1}.
+		 */
+		gfn = hva_to_gfn_memslot(hva_start, memslot);
+		gfn_end = hva_to_gfn_memslot(hva_end + PAGE_SIZE - 1, memslot);
+
+		for (; gfn < gfn_end; ++gfn) {
+			gpa_t gpa = gfn << PAGE_SHIFT;
+			handler(kvm, gpa, data);
+		}
+	}
+}
+
+static void kvm_unmap_hva_handler(struct kvm *kvm, gpa_t gpa, void *data)
+{
+	unmap_stage2_range(kvm, gpa, PAGE_SIZE);
+	kvm_tlb_flush_vmid(kvm);
+}
+
+int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
+{
+	unsigned long end = hva + PAGE_SIZE;
+
+	if (!kvm->arch.pgd)
+		return 0;
+
+	trace_kvm_unmap_hva(hva);
+	handle_hva_to_gpa(kvm, hva, end, &kvm_unmap_hva_handler, NULL);
+	return 0;
+}
+
+int kvm_unmap_hva_range(struct kvm *kvm,
+			unsigned long start, unsigned long end)
+{
+	if (!kvm->arch.pgd)
+		return 0;
+
+	trace_kvm_unmap_hva_range(start, end);
+	handle_hva_to_gpa(kvm, start, end, &kvm_unmap_hva_handler, NULL);
+	return 0;
+}
+
+static void kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, void *data)
+{
+	pte_t *pte = (pte_t *)data;
+
+	stage2_set_pte(kvm, NULL, gpa, pte, false);
+}
+
+
+void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+{
+	unsigned long end = hva + PAGE_SIZE;
+	pte_t stage2_pte;
+
+	if (!kvm->arch.pgd)
+		return;
+
+	trace_kvm_set_spte_hva(hva);
+	stage2_pte = pfn_pte(pte_pfn(pte), PAGE_S2);
+	handle_hva_to_gpa(kvm, hva, end, &kvm_set_spte_handler, &stage2_pte);
+}
+
+void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu)
+{
+	mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
+}
+
 phys_addr_t kvm_mmu_get_httbr(void)
 {
 	VM_BUG_ON(!virt_addr_valid(hyp_pgd));
@@ -230,7 +593,12 @@ phys_addr_t kvm_mmu_get_httbr(void)
 
 int kvm_mmu_init(void)
 {
-	return hyp_pgd ? 0 : -ENOMEM;
+	if (!hyp_pgd) {
+		kvm_err("Hyp mode PGD not allocated\n");
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 /**
diff --git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h
index f8869c1..862b2cc 100644
--- a/arch/arm/kvm/trace.h
+++ b/arch/arm/kvm/trace.h
@@ -39,7 +39,53 @@ TRACE_EVENT(kvm_exit,
 	TP_printk("PC: 0x%08lx", __entry->vcpu_pc)
 );
 
+TRACE_EVENT(kvm_unmap_hva,
+	TP_PROTO(unsigned long hva),
+	TP_ARGS(hva),
 
+	TP_STRUCT__entry(
+		__field(	unsigned long,	hva		)
+	),
+
+	TP_fast_assign(
+		__entry->hva		= hva;
+	),
+
+	TP_printk("mmu notifier unmap hva: %#08lx", __entry->hva)
+);
+
+TRACE_EVENT(kvm_unmap_hva_range,
+	TP_PROTO(unsigned long start, unsigned long end),
+	TP_ARGS(start, end),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	start		)
+		__field(	unsigned long,	end		)
+	),
+
+	TP_fast_assign(
+		__entry->start		= start;
+		__entry->end		= end;
+	),
+
+	TP_printk("mmu notifier unmap range: %#08lx -- %#08lx",
+		  __entry->start, __entry->end)
+);
+
+TRACE_EVENT(kvm_set_spte_hva,
+	TP_PROTO(unsigned long hva),
+	TP_ARGS(hva),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	hva		)
+	),
+
+	TP_fast_assign(
+		__entry->hva		= hva;
+	),
+
+	TP_printk("mmu notifier set pte hva: %#08lx", __entry->hva)
+);
 
 #endif /* _TRACE_KVM_H */
 
