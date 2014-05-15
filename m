From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 15 May 2014 11:27:29 -0700
Subject: [PATCH v6 2/4] live migration support for initial write protect of VM
In-Reply-To: <1400178451-4984-1-git-send-email-m.smarduch@samsung.com>
References: <1400178451-4984-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1400178451-4984-3-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch adds memslot support for initial write protection and split up of huge 
pages

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/include/asm/kvm_host.h |    8 +++
 arch/arm/include/asm/kvm_mmu.h  |   10 +++
 arch/arm/kvm/arm.c              |    3 +
 arch/arm/kvm/mmu.c              |  143 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 193ceaf..0e55b17 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -67,6 +67,12 @@ struct kvm_arch {
 
 	/* Interrupt controller */
 	struct vgic_dist	vgic;
+	/*
+	 * Marks start of migration, used to handle 2nd stage page faults
+	 * during migration, prevent installing huge pages and split huge pages
+	 * to small pages.
+	 */
+	int migration_in_progress;
 };
 
 #define KVM_NR_MEM_OBJS     40
@@ -231,4 +237,6 @@ int kvm_perf_teardown(void);
 u64 kvm_arm_timer_get_reg(struct kvm_vcpu *, u64 regid);
 int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
 
+int kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot);
+
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 5c7aa3c..7f9d9d3 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -114,6 +114,16 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
 	pmd_val(*pmd) |= L_PMD_S2_RDWR;
 }
 
+static inline void kvm_set_s2pte_readonly(pte_t *pte)
+{
+	pte_val(*pte) &= ~(L_PTE_S2_RDONLY ^ L_PTE_S2_RDWR);
+}
+
+static inline bool kvm_s2pte_readonly(pte_t *pte)
+{
+	return (pte_val(*pte) & L_PTE_S2_RDWR) == L_PTE_S2_RDONLY;
+}
+
 /* Open coded p*d_addr_end that can deal with 64bit addresses */
 #define kvm_pgd_addr_end(addr, end)					\
 ({	u64 __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;		\
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 3c82b37..1055266 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -234,6 +234,9 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_userspace_memory_region *mem,
 				   enum kvm_mr_change change)
 {
+	/* Request for migration issued by user, write protect memory slot */
+	if ((change != KVM_MR_DELETE) && (mem->flags & KVM_MEM_LOG_DIRTY_PAGES))
+		return kvm_mmu_slot_remove_write_access(kvm, mem->slot);
 	return 0;
 }
 
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index eea3f0a..b71ad27 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -748,6 +748,149 @@ static bool transparent_hugepage_adjust(pfn_t *pfnp, phys_addr_t *ipap)
 	return false;
 }
 
+
+/*
+ * Walks PMD page table range and write protects it. Called with
+ * 'kvm->mmu_lock' * held
+ */
+static void stage2_wp_pmd_range(phys_addr_t addr, phys_addr_t end, pmd_t *pmd)
+{
+	pte_t *pte;
+
+	while (addr < end) {
+		pte = pte_offset_kernel(pmd, addr);
+		addr += PAGE_SIZE;
+		if (!pte_present(*pte))
+			continue;
+		/* skip write protected pages */
+		if (kvm_s2pte_readonly(pte))
+			continue;
+		kvm_set_s2pte_readonly(pte);
+	}
+}
+
+/*
+ * Walks PUD  page table range to write protects it , if necessary spluts up
+ * huge pages to small pages. Called with 'kvm->mmu_lock' held.
+ */
+static void stage2_wp_pud_range(struct kvm *kvm, phys_addr_t addr,
+				phys_addr_t end, pud_t *pud)
+{
+	pmd_t *pmd;
+	phys_addr_t pmd_end;
+
+	while (addr < end) {
+		/* If needed give up CPU during PUD page table walk */
+		if (need_resched() || spin_needbreak(&kvm->mmu_lock))
+			cond_resched_lock(&kvm->mmu_lock);
+
+		pmd = pmd_offset(pud, addr);
+		if (!pmd_present(*pmd)) {
+			addr = kvm_pmd_addr_end(addr, end);
+			continue;
+		}
+
+		if (kvm_pmd_huge(*pmd)) {
+			/*
+			 * Clear pmd entry DABT handler will install smaller
+			 * pages.
+			 */
+			clear_pmd_entry(kvm, pmd, addr);
+			addr = kvm_pmd_addr_end(addr, end);
+			continue;
+		}
+
+		pmd_end = kvm_pmd_addr_end(addr, end);
+		stage2_wp_pmd_range(addr, pmd_end, pmd);
+		addr = pmd_end;
+	}
+}
+
+/*
+ * Walks PGD page table range to write protect it. Called with 'kvm->mmu_lock'
+ * held.
+ */
+static int stage2_wp_pgd_range(struct kvm *kvm, phys_addr_t addr,
+				phys_addr_t end, pgd_t *pgd)
+{
+	phys_addr_t pud_end;
+	pud_t *pud;
+
+	while (addr < end) {
+		/* give up CPU if mmu_lock is needed by other vCPUs */
+		if (need_resched() || spin_needbreak(&kvm->mmu_lock))
+			cond_resched_lock(&kvm->mmu_lock);
+
+		pud = pud_offset(pgd, addr);
+		if (!pud_present(*pud)) {
+			addr = kvm_pud_addr_end(addr, end);
+			continue;
+		}
+
+		/* Fail if PUD is huge, splitting PUDs not supported */
+		if (pud_huge(*pud))
+			return -EFAULT;
+
+		/*
+		 * By default 'nopud' folds third level page tables.
+		 * Implement for future support of 4-level tables
+		 */
+		pud_end = kvm_pud_addr_end(addr, end);
+		stage2_wp_pud_range(kvm, addr, pud_end, pud);
+		addr = pud_end;
+	}
+	return 0;
+}
+
+/**
+ * kvm_mmu_slot_remove_access() - write protects entire memslot address space.
+ *
+ *      Called at start of live migration when KVM_MEM_LOG_DIRTY_PAGES ioctl is
+ *      issued. After this function returns all pages (minus the ones faulted
+ *      in or released when mmu_lock is given up) must be write protected to
+ *	keep track of dirty pages to migrate on subsequent dirty log read.
+ *      mmu_lock is held during write protecting, released on contention.
+ *
+ * @kvm:        The KVM pointer
+ * @slot:       The memory slot the dirty log is retrieved for
+ */
+int kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot)
+{
+	pgd_t *pgd;
+	pgd_t *pgdp = kvm->arch.pgd;
+	struct kvm_memory_slot *memslot = id_to_memslot(kvm->memslots, slot);
+	phys_addr_t addr = memslot->base_gfn << PAGE_SHIFT;
+	phys_addr_t end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
+	phys_addr_t pgdir_end;
+	int ret = -ENOMEM;
+
+	spin_lock(&kvm->mmu_lock);
+	/* set start of migration, sychronize with Data Abort handler */
+	kvm->arch.migration_in_progress = 1;
+
+	/* Walk range, split up huge pages as needed and write protect ptes */
+	while (addr < end) {
+		pgd = pgdp + pgd_index(addr);
+		if (!pgd_present(*pgd)) {
+			addr = kvm_pgd_addr_end(addr, end);
+			continue;
+		}
+
+		pgdir_end = kvm_pgd_addr_end(addr, end);
+		ret = stage2_wp_pgd_range(kvm, addr, pgdir_end, pgd);
+		/* Failed to WP a pgd range abort */
+		if (ret < 0)
+			goto out;
+		addr = pgdir_end;
+	}
+	ret = 0;
+	/* Flush TLBs, >= ARMv7 variant uses hardware broadcast not IPIs */
+	kvm_flush_remote_tlbs(kvm);
+out:
+	spin_unlock(&kvm->mmu_lock);
+	return ret;
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot,
 			  unsigned long fault_status)
-- 
1.7.9.5
