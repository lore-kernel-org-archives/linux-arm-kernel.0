From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 2 Dec 2013 21:27:37 -0500
Subject: [PATCH v2 22/23] mm/ARM: mm: Use memblock apis for early memory
 allocations
In-Reply-To: <1386037658-3161-1-git-send-email-santosh.shilimkar@ti.com>
References: <1386037658-3161-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1386037658-3161-23-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to memblock interfaces for early memory allocator instead of
bootmem allocator. No functional change in beahvior than what it is
in current code from bootmem users points of view.

Archs already converted to NO_BOOTMEM now directly use memblock
interfaces instead of bootmem wrappers build on top of memblock. And the
archs which still uses bootmem, these new apis just fallback to exiting
bootmem APIs.

Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mm/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 3e8f106..bee6d2c 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -461,7 +461,7 @@ free_memmap(unsigned long start_pfn, unsigned long end_pfn)
 	 * free the section of the memmap array.
 	 */
 	if (pg < pgend)
-		free_bootmem(pg, pgend - pg);
+		memblock_free_early(pg, pgend - pg);
 }
 
 /*
-- 
1.7.9.5
