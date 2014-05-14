From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 May 2014 17:50:36 +0200
Subject: [RFC PATCHv1 2/7] ARM: mm: implement the usage of the machine_desc
 flags
In-Reply-To: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400082641-23871-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit implements the necessary changes in arch/arm/mm/mmu.c for
the two new flags of the machine_desc structure,
MACHINE_NEEDS_CPOLICY_WRITEALLOC and MACHINE_NEEDS_SHAREABLE_PAGES.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mm/mmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index b68c6b2..ad6557e 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -391,7 +391,7 @@ SET_MEMORY_FN(nx, pte_set_nx)
 /*
  * Adjust the PMD section entries according to the CPU in use.
  */
-static void __init build_mem_type_table(void)
+static void __init build_mem_type_table(const struct machine_desc *mdesc)
 {
 	struct cachepolicy *cp;
 	unsigned int cr = get_cr();
@@ -414,7 +414,7 @@ static void __init build_mem_type_table(void)
 			cachepolicy = CPOLICY_WRITEBACK;
 		ecc_mask = 0;
 	}
-	if (is_smp())
+	if (is_smp() || (mdesc->flags & MACHINE_NEEDS_CPOLICY_WRITEALLOC))
 		cachepolicy = CPOLICY_WRITEALLOC;
 
 	/*
@@ -539,7 +539,7 @@ static void __init build_mem_type_table(void)
 		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 #endif
 
-		if (is_smp()) {
+		if (is_smp() || (mdesc->flags & MACHINE_NEEDS_SHAREABLE_PAGES)) {
 			/*
 			 * Mark memory with the "shared" attribute
 			 * for SMP systems
@@ -1504,7 +1504,7 @@ void __init paging_init(const struct machine_desc *mdesc)
 {
 	void *zero_page;
 
-	build_mem_type_table();
+	build_mem_type_table(mdesc);
 	prepare_page_table();
 	map_lowmem();
 	dma_contiguous_remap();
-- 
1.9.3
