From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 Jun 2018 13:20:58 +0100
Subject: [PATCH v3 6/6] KVM: arm/arm64: Remove unnecessary CMOs when creating
 HYP page tables
In-Reply-To: <20180627122058.8210-1-marc.zyngier@arm.com>
References: <20180627122058.8210-1-marc.zyngier@arm.com>
Message-ID: <20180627122058.8210-7-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to perform cache maintenance operations when
creating the HYP page tables if we have the multiprocessing
extensions. ARMv7 mandates them with the virtualization support,
and ARMv8 just mandates them unconditionally.

Let's remove these operations.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/mmu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index eade30caaa3c..97d27cd9c654 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -609,7 +609,6 @@ static void create_hyp_pte_mappings(pmd_t *pmd, unsigned long start,
 		pte = pte_offset_kernel(pmd, addr);
 		kvm_set_pte(pte, pfn_pte(pfn, prot));
 		get_page(virt_to_page(pte));
-		kvm_flush_dcache_to_poc(pte, sizeof(*pte));
 		pfn++;
 	} while (addr += PAGE_SIZE, addr != end);
 }
@@ -636,7 +635,6 @@ static int create_hyp_pmd_mappings(pud_t *pud, unsigned long start,
 			}
 			kvm_pmd_populate(pmd, pte);
 			get_page(virt_to_page(pmd));
-			kvm_flush_dcache_to_poc(pmd, sizeof(*pmd));
 		}
 
 		next = pmd_addr_end(addr, end);
@@ -669,7 +667,6 @@ static int create_hyp_pud_mappings(pgd_t *pgd, unsigned long start,
 			}
 			kvm_pud_populate(pud, pmd);
 			get_page(virt_to_page(pud));
-			kvm_flush_dcache_to_poc(pud, sizeof(*pud));
 		}
 
 		next = pud_addr_end(addr, end);
@@ -706,7 +703,6 @@ static int __create_hyp_mappings(pgd_t *pgdp, unsigned long ptrs_per_pgd,
 			}
 			kvm_pgd_populate(pgd, pud);
 			get_page(virt_to_page(pgd));
-			kvm_flush_dcache_to_poc(pgd, sizeof(*pgd));
 		}
 
 		next = pgd_addr_end(addr, end);
-- 
2.17.1
