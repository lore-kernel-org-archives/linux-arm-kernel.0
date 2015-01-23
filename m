From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:38 +0100
Subject: [GIT PULL 09/36] KVM: arm: Add initial dirty page locking support
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-10-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mario Smarduch <m.smarduch@samsung.com>

Add support for initial write protection of VM memslots. This patch
series assumes that huge PUDs will not be used in 2nd stage tables, which is
always valid on ARMv7

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/include/asm/kvm_host.h       |   2 +
 arch/arm/include/asm/kvm_mmu.h        |  21 ++++++
 arch/arm/include/asm/pgtable-3level.h |   1 +
 arch/arm/kvm/mmu.c                    | 135 ++++++++++++++++++++++++++++++++++
 4 files changed, 159 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index acfced3..38931d4 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -246,6 +246,8 @@ static inline void vgic_arch_setup(const struct vgic_params *vgic)
 int kvm_perf_init(void);
 int kvm_perf_teardown(void);
 
+void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
+
 static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 63e0ecc..2672cf8 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -114,6 +114,27 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
 	pmd_val(*pmd) |= L_PMD_S2_RDWR;
 }
 
+static inline void kvm_set_s2pte_readonly(pte_t *pte)
+{
+	pte_val(*pte) = (pte_val(*pte) & ~L_PTE_S2_RDWR) | L_PTE_S2_RDONLY;
+}
+
+static inline bool kvm_s2pte_readonly(pte_t *pte)
+{
+	return (pte_val(*pte) & L_PTE_S2_RDWR) == L_PTE_S2_RDONLY;
+}
+
+static inline void kvm_set_s2pmd_readonly(pmd_t *pmd)
+{
+	pmd_val(*pmd) = (pmd_val(*pmd) & ~L_PMD_S2_RDWR) | L_PMD_S2_RDONLY;
+}
+
+static inline bool kvm_s2pmd_readonly(pmd_t *pmd)
+{
+	return (pmd_val(*pmd) & L_PMD_S2_RDWR) == L_PMD_S2_RDONLY;
+}
+
+
 /* Open coded p*d_addr_end that can deal with 64bit addresses */
 #define kvm_pgd_addr_end(addr, end)					\
 ({	u64 __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;		\
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index a31ecdad..ae1d30a1 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -130,6 +130,7 @@
 #define L_PTE_S2_RDONLY			(_AT(pteval_t, 1) << 6)   /* HAP[1]   */
 #define L_PTE_S2_RDWR			(_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
 
+#define L_PMD_S2_RDONLY			(_AT(pmdval_t, 1) << 6)   /* HAP[1]   */
 #define L_PMD_S2_RDWR			(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
 
 /*
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 1dc9778..c9e5f38 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -45,6 +45,7 @@ static phys_addr_t hyp_idmap_vector;
 #define hyp_pgd_order get_order(PTRS_PER_PGD * sizeof(pgd_t))
 
 #define kvm_pmd_huge(_x)	(pmd_huge(_x) || pmd_trans_huge(_x))
+#define kvm_pud_huge(_x)	pud_huge(_x)
 
 static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 {
@@ -905,6 +906,131 @@ static bool kvm_is_device_pfn(unsigned long pfn)
 	return !pfn_valid(pfn);
 }
 
+#ifdef CONFIG_ARM
+/**
+ * stage2_wp_ptes - write protect PMD range
+ * @pmd:	pointer to pmd entry
+ * @addr:	range start address
+ * @end:	range end address
+ */
+static void stage2_wp_ptes(pmd_t *pmd, phys_addr_t addr, phys_addr_t end)
+{
+	pte_t *pte;
+
+	pte = pte_offset_kernel(pmd, addr);
+	do {
+		if (!pte_none(*pte)) {
+			if (!kvm_s2pte_readonly(pte))
+				kvm_set_s2pte_readonly(pte);
+		}
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+}
+
+/**
+ * stage2_wp_pmds - write protect PUD range
+ * @pud:	pointer to pud entry
+ * @addr:	range start address
+ * @end:	range end address
+ */
+static void stage2_wp_pmds(pud_t *pud, phys_addr_t addr, phys_addr_t end)
+{
+	pmd_t *pmd;
+	phys_addr_t next;
+
+	pmd = pmd_offset(pud, addr);
+
+	do {
+		next = kvm_pmd_addr_end(addr, end);
+		if (!pmd_none(*pmd)) {
+			if (kvm_pmd_huge(*pmd)) {
+				if (!kvm_s2pmd_readonly(pmd))
+					kvm_set_s2pmd_readonly(pmd);
+			} else {
+				stage2_wp_ptes(pmd, addr, next);
+			}
+		}
+	} while (pmd++, addr = next, addr != end);
+}
+
+/**
+  * stage2_wp_puds - write protect PGD range
+  * @pgd:	pointer to pgd entry
+  * @addr:	range start address
+  * @end:	range end address
+  *
+  * Process PUD entries, for a huge PUD we cause a panic.
+  */
+static void  stage2_wp_puds(pgd_t *pgd, phys_addr_t addr, phys_addr_t end)
+{
+	pud_t *pud;
+	phys_addr_t next;
+
+	pud = pud_offset(pgd, addr);
+	do {
+		next = kvm_pud_addr_end(addr, end);
+		if (!pud_none(*pud)) {
+			/* TODO:PUD not supported, revisit later if supported */
+			BUG_ON(kvm_pud_huge(*pud));
+			stage2_wp_pmds(pud, addr, next);
+		}
+	} while (pud++, addr = next, addr != end);
+}
+
+/**
+ * stage2_wp_range() - write protect stage2 memory region range
+ * @kvm:	The KVM pointer
+ * @addr:	Start address of range
+ * @end:	End address of range
+ */
+static void stage2_wp_range(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
+{
+	pgd_t *pgd;
+	phys_addr_t next;
+
+	pgd = kvm->arch.pgd + pgd_index(addr);
+	do {
+		/*
+		 * Release kvm_mmu_lock periodically if the memory region is
+		 * large. Otherwise, we may see kernel panics with
+		 * CONFIG_DETECT_HUNG_TASK, CONFIG_LOCK_DETECTOR,
+		 * CONFIG_LOCK_DEP. Additionally, holding the lock too long
+		 * will also starve other vCPUs.
+		 */
+		if (need_resched() || spin_needbreak(&kvm->mmu_lock))
+			cond_resched_lock(&kvm->mmu_lock);
+
+		next = kvm_pgd_addr_end(addr, end);
+		if (pgd_present(*pgd))
+			stage2_wp_puds(pgd, addr, next);
+	} while (pgd++, addr = next, addr != end);
+}
+
+/**
+ * kvm_mmu_wp_memory_region() - write protect stage 2 entries for memory slot
+ * @kvm:	The KVM pointer
+ * @slot:	The memory slot to write protect
+ *
+ * Called to start logging dirty pages after memory region
+ * KVM_MEM_LOG_DIRTY_PAGES operation is called. After this function returns
+ * all present PMD and PTEs are write protected in the memory region.
+ * Afterwards read of dirty page log can be called.
+ *
+ * Acquires kvm_mmu_lock. Called with kvm->slots_lock mutex acquired,
+ * serializing operations for VM memory regions.
+ */
+void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
+{
+	struct kvm_memory_slot *memslot = id_to_memslot(kvm->memslots, slot);
+	phys_addr_t start = memslot->base_gfn << PAGE_SHIFT;
+	phys_addr_t end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
+
+	spin_lock(&kvm->mmu_lock);
+	stage2_wp_range(kvm, start, end);
+	spin_unlock(&kvm->mmu_lock);
+	kvm_flush_remote_tlbs(kvm);
+}
+#endif
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  unsigned long fault_status)
@@ -1292,6 +1418,15 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				   const struct kvm_memory_slot *old,
 				   enum kvm_mr_change change)
 {
+#ifdef CONFIG_ARM
+	/*
+	 * At this point memslot has been committed and there is an
+	 * allocated dirty_bitmap[], dirty pages will be be tracked while the
+	 * memory slot is write protected.
+	 */
+	if (change != KVM_MR_DELETE && mem->flags & KVM_MEM_LOG_DIRTY_PAGES)
+		kvm_mmu_wp_memory_region(kvm, mem->slot);
+#endif
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
-- 
2.1.2.330.g565301e.dirty
