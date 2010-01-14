From: andreas.fenkart@streamunlimited.com (Andreas Fenkart)
Date: Thu, 14 Jan 2010 11:36:07 +0100
Subject: [PATCH 2/5] Make delimiters of DMA area globally visibly.
In-Reply-To: <1263465370-4192-2-git-send-email-andreas.fenkart@streamunlimited.com>
References: <20090810213905.GA4046@n2100.arm.linux.org.uk>
	<1263465370-4192-1-git-send-email-andreas.fenkart@streamunlimited.com>
	<1263465370-4192-2-git-send-email-andreas.fenkart@streamunlimited.com>
Message-ID: <1263465370-4192-3-git-send-email-andreas.fenkart@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds DMA area to 'virtual memory map' startup message

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 arch/arm/include/asm/memory.h |   19 +++++++++++--------
 arch/arm/mm/dma-mapping.c     |    3 ---
 arch/arm/mm/init.c            |    6 ++++++
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 5421d82..f5e693b 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -76,6 +76,17 @@
  */
 #define IOREMAP_MAX_ORDER	24
 
+/*
+ * Size of DMA-consistent memory region.  Must be multiple of 2M,
+ * between 2MB and 14MB inclusive.
+ */
+#ifndef CONSISTENT_DMA_SIZE
+#define CONSISTENT_DMA_SIZE 	SZ_2M
+#endif
+
+#define CONSISTENT_END		(0xffe00000UL)
+#define CONSISTENT_BASE		(CONSISTENT_END - CONSISTENT_DMA_SIZE)
+
 #else /* CONFIG_MMU */
 
 /*
@@ -113,14 +124,6 @@
 #endif /* !CONFIG_MMU */
 
 /*
- * Size of DMA-consistent memory region.  Must be multiple of 2M,
- * between 2MB and 14MB inclusive.
- */
-#ifndef CONSISTENT_DMA_SIZE
-#define CONSISTENT_DMA_SIZE SZ_2M
-#endif
-
-/*
  * Physical vs virtual RAM address space conversion.  These are
  * private definitions which should NOT be used outside memory.h
  * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 26325cb..48eedab 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -29,9 +29,6 @@
 #error "CONSISTENT_DMA_SIZE must be multiple of 2MiB"
 #endif
 
-#define CONSISTENT_END	(0xffe00000)
-#define CONSISTENT_BASE	(CONSISTENT_END - CONSISTENT_DMA_SIZE)
-
 #define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
 #define CONSISTENT_PTE_INDEX(x) (((unsigned long)(x) - CONSISTENT_BASE) >> PGDIR_SHIFT)
 #define NUM_CONSISTENT_PTES (CONSISTENT_DMA_SIZE >> PGDIR_SHIFT)
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 29d5866..c06edd3 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -649,6 +649,9 @@ void __init mem_init(void)
 	printk(KERN_NOTICE "virtual kernel memory layout:\n"
 			"    vector  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
 			"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+#ifdef CONFIG_MMU
+			"    DMA     : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+#endif
 			"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
 			"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
 #ifdef CONFIG_HIGHMEM
@@ -662,6 +665,9 @@ void __init mem_init(void)
 			MLK(UL(CONFIG_VECTORS_BASE), UL(CONFIG_VECTORS_BASE) +
 				(PAGE_SIZE)),
 			MLK(FIXADDR_START, FIXADDR_TOP),
+#ifdef CONFIG_MMU
+			MLM(CONSISTENT_BASE, CONSISTENT_END),
+#endif
 			MLM(VMALLOC_START, (unsigned long)VMALLOC_END),
 			MLM(PAGE_SIZE, (unsigned long)high_memory),
 #ifdef CONFIG_HIGHMEM
-- 
1.6.6
