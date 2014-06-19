From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 18 Jun 2014 18:31:38 -0700
Subject: [PATCH v8 2/4] arm: dirty page logging inital mem region write protect
 (w/no huge PUD support)
In-Reply-To: <1403141500-31010-1-git-send-email-m.smarduch@samsung.com>
References: <1403141500-31010-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1403141500-31010-3-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch adds  support for initial write protection VM memlsot. This patch series 
assumes that huge PUDs will not be used in 2nd stage tables. For ARMv8 nothing
happens here.


Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/include/asm/kvm_host.h       |    1 +
 arch/arm/include/asm/kvm_mmu.h        |   20 ++++++
 arch/arm/include/asm/pgtable-3level.h |    1 +
 arch/arm/kvm/arm.c                    |    9 +++
 arch/arm/kvm/mmu.c                    |  128 +++++++++++++++++++++++++++++++++
 5 files changed, 159 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index ac3bb65..586c467 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -232,5 +232,6 @@ u64 kvm_arm_timer_get_reg(struct kvm_vcpu *, u64 regid);
 int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
 
 void kvm_tlb_flush_vmid(struct kvm *kvm);
+void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 5cc0b0f..08ab5e8 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -114,6 +114,26 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
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
 /* Open coded p*d_addr_end that can deal with 64bit addresses */
 #define kvm_pgd_addr_end(addr, end)					\
 ({	u64 __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;		\
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 85c60ad..d8bb40b 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -129,6 +129,7 @@
 #define L_PTE_S2_RDONLY			(_AT(pteval_t, 1) << 6)   /* HAP[1]   */
 #define L_PTE_S2_RDWR			(_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
 
+#define L_PMD_S2_RDONLY			(_AT(pteval_t, 1) << 6)   /* HAP[1]   */
 #define L_PMD_S2_RDWR			(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
 
 /*
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 3c82b37..e11c2dd 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -242,6 +242,15 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				   const struct kvm_memory_slot *old,
 				   enum kvm_mr_change change)
 {
+#ifdef CONFIG_ARM
+	/*
+	 * At this point memslot has been committed and there is an
+	 * allocated dirty_bitmap[], dirty pages will be be tracked while the
+	 * memory slot is write protected.
+	 */
+	if ((change != KVM_MR_DELETE) && (mem->flags & KVM_MEM_LOG_DIRTY_PAGES))
+		kvm_mmu_wp_memory_region(kvm, mem->slot);
+#endif
 }
 
 void kvm_arch_flush_shadow_all(struct kvm *kvm)
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index e90b9e4..37edcbe 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -762,6 +762,134 @@ static bool transparent_hugepage_adjust(pfn_t *pfnp, phys_addr_t *ipap)
 	return false;
 }
 
+#ifdef CONFIG_ARM
+/**
+ * stage2_wp_pte_range - write protect PTE range
+ * @pmd:	pointer to pmd entry
+ * @addr:	range start address
+ * @end:	range end address
+ */
+static void stage2_wp_pte_range(pmd_t *pmd, phys_addr_t addr, phys_addr_t end)
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
+ * stage2_wp_pmd_range - write protect PMD range
+ * @pud:	pointer to pud entry
+ * @addr:	range start address
+ * @end:	range end address
+ */
+static void stage2_wp_pmd_range(pud_t *pud, phys_addr_t addr, phys_addr_t end)
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
+			} else
+				stage2_wp_pte_range(pmd, addr, next);
+
+		}
+	} while (pmd++, addr = next, addr != end);
+}
+
+/**
+ * stage2_wp_pud_range - write protect PUD range
+ * @kvm:	pointer to kvm structure
+ * @pud:	pointer to pgd entry
+ * @addr:	range start address
+ * @end:	range end address
+ *
+ * While walking the PUD range huge PUD pages are ignored, in the future this
+ * may need to be revisited. Determine how to handle huge PUDs when logging
+ * of dirty pages is enabled.
+ */
+static void  stage2_wp_pud_range(struct kvm *kvm, pgd_t *pgd,
+				phys_addr_t addr, phys_addr_t end)
+{
+	pud_t *pud;
+	phys_addr_t next;
+
+	pud = pud_offset(pgd, addr);
+	do {
+
+		next = kvm_pud_addr_end(addr, end);
+		/* TODO: huge PUD not supported, revisit later */
+		BUG_ON(pud_huge(*pud));
+		if (!pud_none(*pud))
+			stage2_wp_pmd_range(pud, addr, next);
+	} while (pud++, addr = next, addr != end);
+}
+
+/**
+ * stage2_wp_range() - write protect stage2 memory region range
+ * @kvm:	The KVM pointer
+ * @start:	Start address of range
+ * &end:	End address of range
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
+		 * large features like detect hung task, lock detector or lock
+		 * dep  may panic. In addition holding the lock this long will
+		 * also starve other vCPUs. Applies to huge VM memory regions.
+		 */
+		if (need_resched() || spin_needbreak(&kvm->mmu_lock))
+			cond_resched_lock(&kvm->mmu_lock);
+
+		next = kvm_pgd_addr_end(addr, end);
+		if (pgd_present(*pgd))
+			stage2_wp_pud_range(kvm, pgd, addr, next);
+	} while (pgd++, addr = next, addr != end);
+
+}
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
+	kvm_tlb_flush_vmid(kvm);
+	spin_unlock(&kvm->mmu_lock);
+}
+#endif
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot,
 			  unsigned long fault_status)
-- 
1.7.9.5
