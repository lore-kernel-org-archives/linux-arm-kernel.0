From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 07 Jun 2011 09:12:25 +0200
Subject: [PATCH] ARM: fix ioremap to allow mapping some specific RAM areas
Message-ID: <1307430745-17329-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Creating more than one mapping on ARMv6+ might cause unspecified behavior,
so ioremap() should fail if it was called with area that matches low memory.
However if the board code removes the specific area from low memory
mapping on boot (for example by calling memblock_remove()), then creating
a mapping with ioremap might be desired.

This patch enables creating mapping for RAM by ioremap call, but only if
the target area has no low memory mapping yet. This enables board code to
reserve particular memory areas with memblock_remove() and provide them to
device drivers with a declare_coherent_memory() call.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mm/ioremap.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ab50627..d3fcc05 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -25,6 +25,7 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/io.h>
+#include <linux/memblock.h>
 
 #include <asm/cputype.h>
 #include <asm/cacheflush.h>
@@ -202,9 +203,10 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 		return NULL;
 
 	/*
-	 * Don't allow RAM to be mapped - this causes problems with ARMv6+
+	 * Don't allow low memory to be mapped again - this causes problems
+	 * with ARMv6+
 	 */
-	if (WARN_ON(pfn_valid(pfn)))
+	if (WARN_ON(memblock_is_memory(pfn << PAGE_SHIFT)))
 		return NULL;
 
 	type = get_mem_type(mtype);
-- 
1.7.1.569.g6f426
