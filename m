From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 18 Feb 2014 15:27:26 +0000
Subject: [PATCH v4 05/12] arm64: KVM: flush VM pages before letting the guest
 enable caches
In-Reply-To: <1392737253-10480-1-git-send-email-marc.zyngier@arm.com>
References: <1392737253-10480-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1392737253-10480-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the guest runs with caches disabled (like in an early boot
sequence, for example), all the writes are diectly going to RAM,
bypassing the caches altogether.

Once the MMU and caches are enabled, whatever sits in the cache
becomes suddenly visible, which isn't what the guest expects.

A way to avoid this potential disaster is to invalidate the cache
when the MMU is being turned on. For this, we hook into the SCTLR_EL1
trapping code, and scan the stage-2 page tables, invalidating the
pages/sections that have already been mapped in.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_mmu.h   |  2 +
 arch/arm/kvm/mmu.c               | 93 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/kvm_mmu.h |  1 +
 arch/arm64/kvm/sys_regs.c        |  5 ++-
 4 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 88bba33..e2a8df4 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -154,6 +154,8 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
 
 #define kvm_flush_dcache_to_poc(a,l)	__cpuc_flush_dcache_area((a), (l))
 
+void stage2_flush_vm(struct kvm *kvm);
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* __ARM_KVM_MMU_H__ */
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 7f84116..209f20f 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -187,6 +187,99 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
 	}
 }
 
+static void stage2_flush_ptes(struct kvm *kvm, pmd_t *pmd,
+			      phys_addr_t addr, phys_addr_t end)
+{
+	pte_t *pte;
+
+	pte = pte_offset_kernel(pmd, addr);
+	do {
+		if (!pte_none(*pte)) {
+			hva_t hva = gfn_to_hva(kvm, addr >> PAGE_SHIFT);
+			kvm_flush_dcache_to_poc((void*)hva, PAGE_SIZE);
+		}
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+}
+
+static void stage2_flush_pmds(struct kvm *kvm, pud_t *pud,
+			      phys_addr_t addr, phys_addr_t end)
+{
+	pmd_t *pmd;
+	phys_addr_t next;
+
+	pmd = pmd_offset(pud, addr);
+	do {
+		next = kvm_pmd_addr_end(addr, end);
+		if (!pmd_none(*pmd)) {
+			if (kvm_pmd_huge(*pmd)) {
+				hva_t hva = gfn_to_hva(kvm, addr >> PAGE_SHIFT);
+				kvm_flush_dcache_to_poc((void*)hva, PMD_SIZE);
+			} else {
+				stage2_flush_ptes(kvm, pmd, addr, next);
+			}
+		}
+	} while (pmd++, addr = next, addr != end);
+}
+
+static void stage2_flush_puds(struct kvm *kvm, pgd_t *pgd,
+			      phys_addr_t addr, phys_addr_t end)
+{
+	pud_t *pud;
+	phys_addr_t next;
+
+	pud = pud_offset(pgd, addr);
+	do {
+		next = kvm_pud_addr_end(addr, end);
+		if (!pud_none(*pud)) {
+			if (pud_huge(*pud)) {
+				hva_t hva = gfn_to_hva(kvm, addr >> PAGE_SHIFT);
+				kvm_flush_dcache_to_poc((void*)hva, PUD_SIZE);
+			} else {
+				stage2_flush_pmds(kvm, pud, addr, next);
+			}
+		}
+	} while (pud++, addr = next, addr != end);
+}
+
+static void stage2_flush_memslot(struct kvm *kvm,
+				 struct kvm_memory_slot *memslot)
+{
+	phys_addr_t addr = memslot->base_gfn << PAGE_SHIFT;
+	phys_addr_t end = addr + PAGE_SIZE * memslot->npages;
+	phys_addr_t next;
+	pgd_t *pgd;
+
+	pgd = kvm->arch.pgd + pgd_index(addr);
+	do {
+		next = kvm_pgd_addr_end(addr, end);
+		stage2_flush_puds(kvm, pgd, addr, next);
+	} while (pgd++, addr = next, addr != end);
+}
+
+/**
+ * stage2_flush_vm - Invalidate cache for pages mapped in stage 2
+ * @kvm: The struct kvm pointer
+ *
+ * Go through the stage 2 page tables and invalidate any cache lines
+ * backing memory already mapped to the VM.
+ */
+void stage2_flush_vm(struct kvm *kvm)
+{
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *memslot;
+	int idx;
+
+	idx = srcu_read_lock(&kvm->srcu);
+	spin_lock(&kvm->mmu_lock);
+
+	slots = kvm_memslots(kvm);
+	kvm_for_each_memslot(memslot, slots)
+		stage2_flush_memslot(kvm, memslot);
+
+	spin_unlock(&kvm->mmu_lock);
+	srcu_read_unlock(&kvm->srcu, idx);
+}
+
 /**
  * free_boot_hyp_pgd - free HYP boot page tables
  *
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 19cb328..da0ee56 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -148,6 +148,7 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
 	}
 }
 
+void stage2_flush_vm(struct kvm *kvm);
 
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2097e5e..0324458 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -27,6 +27,7 @@
 #include <asm/kvm_host.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
+#include <asm/kvm_mmu.h>
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
 #include <trace/events/kvm.h>
@@ -154,8 +155,10 @@ static bool access_sctlr(struct kvm_vcpu *vcpu,
 {
 	access_vm_reg(vcpu, p, r);
 
-	if (vcpu_has_cache_enabled(vcpu))	/* MMU+Caches enabled? */
+	if (vcpu_has_cache_enabled(vcpu)) {	/* MMU+Caches enabled? */
 		vcpu->arch.hcr_el2 &= ~HCR_TVM;
+		stage2_flush_vm(vcpu->kvm);
+	}
 
 	return true;
 }
-- 
1.8.3.4
