From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Mar 2010 14:53:24 +0000
Subject: [PATCH] ARM: Fix virtual kernel memory printing for sparsemem
Message-ID: <20100325145324.12837.85927.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit db9ef1a introduced information printing for the virtual kernel
memory map but page/end calculation using the pfn goes wrong and
page_count() generates a data abort or alignment fault (possibly because
it gets to an uninitialised page structure that looks like a compound
page).

This patch adds page/end calculation using pfn_to_page().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <Will.Deacon@arm.com>
Cc: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 arch/arm/mm/init.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index b69ac3a..8a48634 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -600,9 +600,6 @@ void __init mem_init(void)
 	reserved_pages = free_pages = 0;
 
 	for_each_online_node(node) {
-		pg_data_t *n = NODE_DATA(node);
-		struct page *map = pgdat_page_nr(n, 0) - n->node_start_pfn;
-
 		for_each_nodebank(i, &meminfo, node) {
 			struct membank *bank = &meminfo.bank[i];
 			unsigned int pfn1, pfn2;
@@ -611,8 +608,8 @@ void __init mem_init(void)
 			pfn1 = bank_pfn_start(bank);
 			pfn2 = bank_pfn_end(bank);
 
-			page = map + pfn1;
-			end  = map + pfn2;
+			page = pfn_to_page(pfn1);
+			end  = pfn_to_page(pfn2 - 1) + 1;
 
 			do {
 				if (PageReserved(page))
