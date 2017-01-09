From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:29 -0500
Subject: [RFC 33/55] KVM: arm/arm64: Remove unused params in mmu functions
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-34-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

stage2_flush_xxx functions take a pointer to the kvm struct as the first
parameter but they are never used. Clean this up before modifying mmu
code for nested virtualization support.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm/kvm/mmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index a5265ed..57cb671 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -300,7 +300,7 @@ static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
 	} while (pgd++, addr = next, addr != end);
 }
 
-static void stage2_flush_ptes(struct kvm *kvm, pmd_t *pmd,
+static void stage2_flush_ptes(pmd_t *pmd,
 			      phys_addr_t addr, phys_addr_t end)
 {
 	pte_t *pte;
@@ -312,7 +312,7 @@ static void stage2_flush_ptes(struct kvm *kvm, pmd_t *pmd,
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 }
 
-static void stage2_flush_pmds(struct kvm *kvm, pud_t *pud,
+static void stage2_flush_pmds(pud_t *pud,
 			      phys_addr_t addr, phys_addr_t end)
 {
 	pmd_t *pmd;
@@ -325,12 +325,12 @@ static void stage2_flush_pmds(struct kvm *kvm, pud_t *pud,
 			if (pmd_thp_or_huge(*pmd))
 				kvm_flush_dcache_pmd(*pmd);
 			else
-				stage2_flush_ptes(kvm, pmd, addr, next);
+				stage2_flush_ptes(pmd, addr, next);
 		}
 	} while (pmd++, addr = next, addr != end);
 }
 
-static void stage2_flush_puds(struct kvm *kvm, pgd_t *pgd,
+static void stage2_flush_puds(pgd_t *pgd,
 			      phys_addr_t addr, phys_addr_t end)
 {
 	pud_t *pud;
@@ -343,7 +343,7 @@ static void stage2_flush_puds(struct kvm *kvm, pgd_t *pgd,
 			if (stage2_pud_huge(*pud))
 				kvm_flush_dcache_pud(*pud);
 			else
-				stage2_flush_pmds(kvm, pud, addr, next);
+				stage2_flush_pmds(pud, addr, next);
 		}
 	} while (pud++, addr = next, addr != end);
 }
@@ -359,7 +359,7 @@ static void stage2_flush_memslot(struct kvm *kvm,
 	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
 	do {
 		next = stage2_pgd_addr_end(addr, end);
-		stage2_flush_puds(kvm, pgd, addr, next);
+		stage2_flush_puds(pgd, addr, next);
 	} while (pgd++, addr = next, addr != end);
 }
 
-- 
1.9.1
