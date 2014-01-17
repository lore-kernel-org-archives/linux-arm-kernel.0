From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Jan 2014 15:03:13 +0000
Subject: [RFC PATCH 3/3] arm64: KVM: flush VM pages before letting the guest
 enable caches
In-Reply-To: <1389970993-19371-1-git-send-email-marc.zyngier@arm.com>
References: <1389970993-19371-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1389970993-19371-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the guest runs with caches disabled (like in an early boot
sequence, for example), all the writes are diectly going to RAM,
bypassing the caches altogether.

Once the MMU and caches are enabled, whatever sits in the cache
becomes suddently visible, which isn't what the guest expects.

A way to avoid this potential disaster is to invalidate the cache
when the MMU is being turned on. For this, we hook into the SCTLR_EL1
trapping code, and scan the stage-2 page tables, invalidating the
pages/sections that have already been mapped in.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kvm/mmu.c               | 72 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/kvm_mmu.h |  1 +
 arch/arm64/kvm/sys_regs.c        |  5 ++-
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 415fd63..704c939 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -187,6 +187,78 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
 	}
 }
 
+void stage2_flush_ptes(struct kvm *kvm, pmd_t *pmd,
+		       unsigned long addr, unsigned long end)
+{
+	pte_t *pte;
+
+	pte = pte_offset_kernel(pmd, addr);
+	do {
+		if (!pte_none(*pte)) {
+			hva_t hva = gfn_to_hva(kvm, addr >> PAGE_SHIFT);
+			kvm_flush_dcache_to_poc((void*)hva, PAGE_SIZE);
+		}
+	} while(pte++, addr += PAGE_SIZE, addr != end);
+}
+
+void stage2_flush_pmds(struct kvm *kvm, pud_t *pud,
+		       unsigned long addr, unsigned long end)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (!pmd_none(*pmd)) {
+			if (kvm_pmd_huge(*pmd)) {
+				hva_t hva = gfn_to_hva(kvm, addr >> PAGE_SHIFT);
+				kvm_flush_dcache_to_poc((void*)hva, PMD_SIZE);
+			} else {
+				stage2_flush_ptes(kvm, pmd, addr, next);
+			}
+		}
+	} while(pmd++, addr = next, addr != end);
+}
+
+void stage2_flush_puds(struct kvm *kvm, pgd_t *pgd,
+		       unsigned long addr, unsigned long end)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (!pud_none(*pud)) {
+			if (pud_huge(*pud)) {
+				hva_t hva = gfn_to_hva(kvm, addr >> PAGE_SHIFT);
+				kvm_flush_dcache_to_poc((void*)hva, PUD_SIZE);
+			} else {
+				stage2_flush_pmds(kvm, pud, addr, next);
+			}
+		}
+	} while(pud++, addr = next, addr != end);
+}
+
+void stage2_flush_vm(struct kvm *kvm)
+{
+	unsigned long long addr = 0;
+	unsigned long end = KVM_PHYS_SIZE;
+	unsigned long next;
+	pgd_t *pgd;
+
+	spin_lock(&kvm->mmu_lock);
+
+	pgd = kvm->arch.pgd + pgd_index(addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		stage2_flush_puds(kvm, pgd, addr, next);
+	} while(pgd++, addr = next, addr != end);
+
+	spin_unlock(&kvm->mmu_lock);
+}
+
 /**
  * free_boot_hyp_pgd - free HYP boot page tables
  *
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 2232dd0..b7b2ca3 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -139,6 +139,7 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
 	}
 }
 
+void stage2_flush_vm(struct kvm *kvm);
 
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 5e92b9e..32e440f 100644
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
@@ -150,8 +151,10 @@ static bool access_sctlr_el1(struct kvm_vcpu *vcpu,
 	val = *vcpu_reg(vcpu, p->Rt);
 	vcpu_sys_reg(vcpu, r->reg) = val;
 
-	if ((val & (0b101)) == 0b101)	/* MMU+Caches enabled? */
+	if ((val & (0b101)) == 0b101) {	/* MMU+Caches enabled? */
 		vcpu->arch.hcr_el2 &= ~HCR_TVM;
+		stage2_flush_vm(vcpu->kvm);
+	}
 
 	return true;
 }
-- 
1.8.3.4
