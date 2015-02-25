From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Feb 2015 16:55:39 +0000
Subject: [PATCH 2/3] arm64: KVM: Do not use pgd_index to index stage-2 pgd
In-Reply-To: <1424883340-29940-1-git-send-email-marc.zyngier@arm.com>
References: <1424883340-29940-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1424883340-29940-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel's pgd_index macro is designed to index a normal, page
sized array. KVM is a bit diffferent, as we can use concatenated
pages to have a bigger address space (for example 40bit IPA with
4kB pages gives us an 8kB PGD.

In the above case, the use of pgd_index will always return an index
inside the first 4kB, which makes a guest that has memory above
0x8000000000 rather unhappy, as it spins forever in a page fault,
whist the host happilly corrupts the lower pgd.

The obvious fix is to get our own kvm_pgd_index that does the right
thing(tm).

Tested on X-Gene with a hacked kvmtool that put memory at a stupidly
high address.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h   | 3 ++-
 arch/arm/kvm/mmu.c               | 8 ++++----
 arch/arm64/include/asm/kvm_mmu.h | 2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 1cac89b..ec669a6 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -149,13 +149,14 @@ static inline bool kvm_s2pmd_readonly(pmd_t *pmd)
 	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
 })
 
+#define kvm_pgd_index(addr)			pgd_index(addr)
+
 static inline bool kvm_page_empty(void *ptr)
 {
 	struct page *ptr_page = virt_to_page(ptr);
 	return page_count(ptr_page) == 1;
 }
 
-
 #define kvm_pte_table_empty(kvm, ptep) kvm_page_empty(ptep)
 #define kvm_pmd_table_empty(kvm, pmdp) kvm_page_empty(pmdp)
 #define kvm_pud_table_empty(kvm, pudp) (0)
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index a6a8252..39a0903 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -290,7 +290,7 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
 	phys_addr_t addr = start, end = start + size;
 	phys_addr_t next;
 
-	pgd = pgdp + pgd_index(addr);
+	pgd = pgdp + kvm_pgd_index(addr);
 	do {
 		next = kvm_pgd_addr_end(addr, end);
 		if (!pgd_none(*pgd))
@@ -355,7 +355,7 @@ static void stage2_flush_memslot(struct kvm *kvm,
 	phys_addr_t next;
 	pgd_t *pgd;
 
-	pgd = kvm->arch.pgd + pgd_index(addr);
+	pgd = kvm->arch.pgd + kvm_pgd_index(addr);
 	do {
 		next = kvm_pgd_addr_end(addr, end);
 		stage2_flush_puds(kvm, pgd, addr, next);
@@ -799,7 +799,7 @@ static pud_t *stage2_get_pud(struct kvm *kvm, struct kvm_mmu_memory_cache *cache
 	pgd_t *pgd;
 	pud_t *pud;
 
-	pgd = kvm->arch.pgd + pgd_index(addr);
+	pgd = kvm->arch.pgd + kvm_pgd_index(addr);
 	if (WARN_ON(pgd_none(*pgd))) {
 		if (!cache)
 			return NULL;
@@ -1089,7 +1089,7 @@ static void stage2_wp_range(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
 	pgd_t *pgd;
 	phys_addr_t next;
 
-	pgd = kvm->arch.pgd + pgd_index(addr);
+	pgd = kvm->arch.pgd + kvm_pgd_index(addr);
 	do {
 		/*
 		 * Release kvm_mmu_lock periodically if the memory region is
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 06c733a..c6300fd 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -158,6 +158,8 @@ static inline bool kvm_s2pmd_readonly(pmd_t *pmd)
 #define PTRS_PER_S2_PGD		(1 << PTRS_PER_S2_PGD_SHIFT)
 #define S2_PGD_ORDER		get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
 
+#define kvm_pgd_index(addr)	(((addr) >> PGDIR_SHIFT) & (PTRS_PER_S2_PGD - 1))
+
 /*
  * If we are concatenating first level stage-2 page tables, we would have less
  * than or equal to 16 pointers in the fake PGD, because that's what the
-- 
2.1.4
