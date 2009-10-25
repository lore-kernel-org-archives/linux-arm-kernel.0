From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 25 Oct 2009 10:59:08 +0000
Subject: [RFC 07/11] ARM: Allocate ZERO_PAGE from highmem
In-Reply-To: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <551619d0fd5153ca4a5e1821aea8d867d9581c9a.1256683230.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zero page does not need to be in low memory, so allocate it from
high memory.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/init.c |    9 +++++++++
 arch/arm/mm/mmu.c  |   10 ----------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 40940d7..101e100 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -609,6 +609,15 @@ void __init mem_init(void)
 		 */
 		sysctl_overcommit_memory = OVERCOMMIT_ALWAYS;
 	}
+
+	/*
+	 * Allocate the zero page, trying to get it from highmem if
+	 * available.  Note that this must always succeed and returns
+	 * a zeroed page.
+	 */
+	empty_zero_page = alloc_pages(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO, 0);
+	BUG_ON(!empty_zero_page);
+	__flush_dcache_page(NULL, empty_zero_page);
 }
 
 void free_initmem(void)
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 2a7cc61..2bff0c2 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1012,8 +1012,6 @@ static void __init kmap_init(void)
  */
 void __init paging_init(struct machine_desc *mdesc)
 {
-	void *zero_page;
-
 	build_mem_type_table();
 	sanity_check_meminfo();
 	prepare_page_table();
@@ -1022,14 +1020,6 @@ void __init paging_init(struct machine_desc *mdesc)
 	kmap_init();
 
 	top_pmd = pmd_off_k(0xffff0000);
-
-	/*
-	 * allocate the zero page.  Note that this always succeeds and
-	 * returns a zeroed result.
-	 */
-	zero_page = alloc_bootmem_low_pages(PAGE_SIZE);
-	empty_zero_page = virt_to_page(zero_page);
-	__flush_dcache_page(NULL, empty_zero_page);
 }
 
 /*
-- 
1.6.2.5
