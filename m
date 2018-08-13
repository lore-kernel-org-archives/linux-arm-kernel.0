From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Aug 2018 15:57:23 +0100
Subject: [PATCH 05/37] KVM: arm/arm64: Stop using the kernel's {pmd, pud,
 pgd}_populate helpers
In-Reply-To: <20180813145755.16566-1-marc.zyngier@arm.com>
References: <20180813145755.16566-1-marc.zyngier@arm.com>
Message-ID: <20180813145755.16566-6-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The {pmd,pud,pgd}_populate accessors usage have always been a bit weird
in KVM. We don't have a struct mm to pass (and neither does the kernel
most of the time, but still...), and the 32bit code has all kind of
cache maintenance that doesn't make sense on ARMv7+ when MP extensions
are mandatory (which is the case when the VEs are present).

Let's bite the bullet and provide our own implementations. The only bit
of architectural code left has to do with building the table entry
itself (arm64 having up to 52bit PA, arm lacking PUD level).

Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h   |  4 ++++
 arch/arm64/include/asm/kvm_mmu.h |  7 +++++++
 virt/kvm/arm/mmu.c               | 25 +++++++++++++++++++++----
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index b2feaea1434c..265ea9cf7df7 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -75,6 +75,10 @@ phys_addr_t kvm_get_idmap_vector(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
+#define kvm_mk_pmd(ptep)	__pmd(__pa(ptep) | PMD_TYPE_TABLE)
+#define kvm_mk_pud(pmdp)	__pud(__pa(pmdp) | PMD_TYPE_TABLE)
+#define kvm_mk_pgd(pudp)	({ BUILD_BUG(); 0; })
+
 static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
 {
 	pte_val(pte) |= L_PTE_S2_RDWR;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index ea000fb47ec0..d6fff7de5539 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -169,6 +169,13 @@ phys_addr_t kvm_get_idmap_vector(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
+#define kvm_mk_pmd(ptep)					\
+	__pmd(__phys_to_pmd_val(__pa(ptep)) | PMD_TYPE_TABLE)
+#define kvm_mk_pud(pmdp)					\
+	__pud(__phys_to_pud_val(__pa(pmdp)) | PMD_TYPE_TABLE)
+#define kvm_mk_pgd(pudp)					\
+	__pgd(__phys_to_pgd_val(__pa(pudp)) | PUD_TYPE_TABLE)
+
 static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
 {
 	pte_val(pte) |= PTE_S2_RDWR;
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index a6bdbed1903a..eade30caaa3c 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -189,6 +189,23 @@ static inline void kvm_set_pmd(pmd_t *pmdp, pmd_t new_pmd)
 	dsb(ishst);
 }
 
+static inline void kvm_pmd_populate(pmd_t *pmdp, pte_t *ptep)
+{
+	kvm_set_pmd(pmdp, kvm_mk_pmd(ptep));
+}
+
+static inline void kvm_pud_populate(pud_t *pudp, pmd_t *pmdp)
+{
+	WRITE_ONCE(*pudp, kvm_mk_pud(pmdp));
+	dsb(ishst);
+}
+
+static inline void kvm_pgd_populate(pgd_t *pgdp, pud_t *pudp)
+{
+	WRITE_ONCE(*pgdp, kvm_mk_pgd(pudp));
+	dsb(ishst);
+}
+
 /*
  * Unmapping vs dcache management:
  *
@@ -617,7 +634,7 @@ static int create_hyp_pmd_mappings(pud_t *pud, unsigned long start,
 				kvm_err("Cannot allocate Hyp pte\n");
 				return -ENOMEM;
 			}
-			pmd_populate_kernel(NULL, pmd, pte);
+			kvm_pmd_populate(pmd, pte);
 			get_page(virt_to_page(pmd));
 			kvm_flush_dcache_to_poc(pmd, sizeof(*pmd));
 		}
@@ -650,7 +667,7 @@ static int create_hyp_pud_mappings(pgd_t *pgd, unsigned long start,
 				kvm_err("Cannot allocate Hyp pmd\n");
 				return -ENOMEM;
 			}
-			pud_populate(NULL, pud, pmd);
+			kvm_pud_populate(pud, pmd);
 			get_page(virt_to_page(pud));
 			kvm_flush_dcache_to_poc(pud, sizeof(*pud));
 		}
@@ -687,7 +704,7 @@ static int __create_hyp_mappings(pgd_t *pgdp, unsigned long ptrs_per_pgd,
 				err = -ENOMEM;
 				goto out;
 			}
-			pgd_populate(NULL, pgd, pud);
+			kvm_pgd_populate(pgd, pud);
 			get_page(virt_to_page(pgd));
 			kvm_flush_dcache_to_poc(pgd, sizeof(*pgd));
 		}
@@ -1106,7 +1123,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 		if (!cache)
 			return 0; /* ignore calls from kvm_set_spte_hva */
 		pte = mmu_memory_cache_alloc(cache);
-		pmd_populate_kernel(NULL, pmd, pte);
+		kvm_pmd_populate(pmd, pte);
 		get_page(virt_to_page(pmd));
 	}
 
-- 
2.18.0
