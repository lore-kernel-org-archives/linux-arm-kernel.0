From: yalin.wang2010@gmail.com (yalin wang)
Date: Thu, 27 Aug 2015 16:21:00 +0800
Subject: [PATCH] arm64: ioremap: change ioremap prototype and add
 ioremap_cache macro
Message-ID: <1440663660-24244-1-git-send-email-yalin.wang2010@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch change ioremap_*() first parameter type to resource_size_t to
be the same as other platforms, and add ioremap_cache macro,
because some code will test if this macro is defined or not, and
will generate a generric version if not defined, for example,
memremap.c do like this.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 arch/arm64/include/asm/io.h | 5 +++--
 arch/arm64/mm/ioremap.c     | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 44be1e0..500e09f 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -163,15 +163,16 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
 /*
  * I/O memory mapping functions.
  */
-extern void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot);
+extern void __iomem *__ioremap(resource_size_t phys_addr, size_t size, pgprot_t prot);
 extern void __iounmap(volatile void __iomem *addr);
-extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
+extern void __iomem *ioremap_cache(resource_size_t phys_addr, size_t size);
 
 #define ioremap(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
 #define ioremap_nocache(addr, size)	__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
 #define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
 #define ioremap_wt(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
 #define iounmap				__iounmap
+#define ioremap_cache			ioremap_cache
 
 /*
  * io{read,write}{16,32}be() macros
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 01e88c8..082e963 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -29,7 +29,7 @@
 #include <asm/tlbflush.h>
 #include <asm/pgalloc.h>
 
-static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
+static void __iomem *__ioremap_caller(resource_size_t phys_addr, size_t size,
 				      pgprot_t prot, void *caller)
 {
 	unsigned long last_addr;
@@ -73,7 +73,7 @@ static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
 	return (void __iomem *)(offset + addr);
 }
 
-void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot)
+void __iomem *__ioremap(resource_size_t phys_addr, size_t size, pgprot_t prot)
 {
 	return __ioremap_caller(phys_addr, size, prot,
 				__builtin_return_address(0));
@@ -93,7 +93,7 @@ void __iounmap(volatile void __iomem *io_addr)
 }
 EXPORT_SYMBOL(__iounmap);
 
-void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
+void __iomem *ioremap_cache(resource_size_t phys_addr, size_t size)
 {
 	/* For normal memory we already have a cacheable mapping. */
 	if (pfn_valid(__phys_to_pfn(phys_addr)))
-- 
1.9.1
