From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 24 Oct 2009 14:11:59 +0100
Subject: [RFC 01/11] ARM: Reduce __flush_dcache_page() visibility
In-Reply-To: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <6ec348a08a49454de6a8b801795c373f93ba6c76.1256683230.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/cacheflush.h |    2 --
 arch/arm/mm/fault-armv.c          |    2 ++
 arch/arm/mm/mm.h                  |    2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index fd03fb6..3147f75 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -410,8 +410,6 @@ extern void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
  */
 extern void flush_dcache_page(struct page *);
 
-extern void __flush_dcache_page(struct address_space *mapping, struct page *page);
-
 static inline void __flush_icache_all(void)
 {
 	asm("mcr	p15, 0, %0, c7, c5, 0	@ invalidate I-cache\n"
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index d0d17b6..830cf17 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -23,6 +23,8 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 
+#include "mm.h"
+
 static unsigned long shared_pte_mask = L_PTE_MT_BUFFERABLE;
 
 /*
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index c4f6f05..a888363 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -24,6 +24,8 @@ struct mem_type {
 
 const struct mem_type *get_mem_type(unsigned int type);
 
+extern void __flush_dcache_page(struct address_space *mapping, struct page *page);
+
 #endif
 
 struct map_desc;
-- 
1.6.2.5
