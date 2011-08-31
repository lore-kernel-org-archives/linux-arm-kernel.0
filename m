From: msalter@redhat.com (Mark Salter)
Date: Wed, 31 Aug 2011 17:26:37 -0400
Subject: [PATCH 02/24] fixed generic page.h for non-zero PAGE_OFFSET
In-Reply-To: <1314826019-22330-1-git-send-email-msalter@redhat.com>
References: <1314826019-22330-1-git-send-email-msalter@redhat.com>
Message-ID: <1314826019-22330-3-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

asm-generic/page.h had several problems when used with a non-zero PAGE_OFFSET.
This patch adds a default ARCH_PFN_OFFSET and fixes the __va, __pa, and
pfn_valid macros to work with non-zero PAGE_OFFSETs.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 include/asm-generic/page.h |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
index 75fec18..f376db2 100644
--- a/include/asm-generic/page.h
+++ b/include/asm-generic/page.h
@@ -71,10 +71,14 @@ extern unsigned long memory_end;
 #define PAGE_OFFSET		(0)
 #endif
 
+#ifndef ARCH_PFN_OFFSET
+#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
+#endif
+
 #ifndef __ASSEMBLY__
 
-#define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET))
-#define __pa(x) ((unsigned long) (x) - PAGE_OFFSET)
+#define __va(x) ((void *)((unsigned long) (x)))
+#define __pa(x) ((unsigned long) (x))
 
 #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
 #define pfn_to_virt(pfn)	__va((pfn) << PAGE_SHIFT)
@@ -86,7 +90,7 @@ extern unsigned long memory_end;
 #define page_to_phys(page)      ((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
 #endif
 
-#define pfn_valid(pfn)		((pfn) < max_mapnr)
+#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
 
 #define	virt_addr_valid(kaddr)	(((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
 				((void *)(kaddr) < (void *)memory_end))
-- 
1.7.6
