From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Apr 2013 15:17:25 +0100
Subject: [PATCH 3/4] ARM: KVM: relax cache maintainance when building page
 pables
In-Reply-To: <1367331446-28030-1-git-send-email-marc.zyngier@arm.com>
References: <1367331446-28030-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1367331446-28030-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 5a677ce044f1 (ARM: KVM: switch to a dual-step HYP init code)
introduced code that flushes page tables to the point of coherency.
This is overkill (point of unification is enough), and actually
not required if running on a SMP capable platform.

Change this code to use clean_dcache_area(), which is updated by
ae8a8b9553bd (ARM: 7691/1: mm: kill unused TLB_CAN_READ_FROM_L1_CACHE
and use ALT_SMP instead) to behave as a no-op on SMP ARMv7.

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h | 1 +
 arch/arm/kvm/mmu.c             | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 472ac70..2459821 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -129,6 +129,7 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
 }
 
 #define kvm_flush_dcache_to_poc(a,l)	__cpuc_flush_dcache_area((a), (l))
+#define kvm_clean_dcache_to_pou(a,l)	clean_dcache_area((a), (l))
 
 #endif	/* !__ASSEMBLY__ */
 
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 71f2a57..b978ebe 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -228,7 +228,7 @@ static void create_hyp_pte_mappings(pmd_t *pmd, unsigned long start,
 		pte = pte_offset_kernel(pmd, addr);
 		kvm_set_pte(pte, pfn_pte(pfn, prot));
 		get_page(virt_to_page(pte));
-		kvm_flush_dcache_to_poc(pte, sizeof(*pte));
+		kvm_clean_dcache_to_pou(pte, sizeof(*pte));
 		pfn++;
 	} while (addr += PAGE_SIZE, addr != end);
 }
@@ -255,7 +255,7 @@ static int create_hyp_pmd_mappings(pud_t *pud, unsigned long start,
 			}
 			pmd_populate_kernel(NULL, pmd, pte);
 			get_page(virt_to_page(pmd));
-			kvm_flush_dcache_to_poc(pmd, sizeof(*pmd));
+			kvm_clean_dcache_to_pou(pmd, sizeof(*pmd));
 		}
 
 		next = pmd_addr_end(addr, end);
@@ -293,7 +293,7 @@ static int __create_hyp_mappings(pgd_t *pgdp,
 			}
 			pud_populate(NULL, pud, pmd);
 			get_page(virt_to_page(pud));
-			kvm_flush_dcache_to_poc(pud, sizeof(*pud));
+			kvm_clean_dcache_to_pou(pud, sizeof(*pud));
 		}
 
 		next = pgd_addr_end(addr, end);
-- 
1.8.2.1
