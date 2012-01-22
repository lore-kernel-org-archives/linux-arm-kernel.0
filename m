From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 22 Jan 2012 16:09:39 -0500
Subject: [PATCH] arm: fix build failure in code for mach-bcmring/dma.c
Message-ID: <1327266579-21951-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Upstream commit 99d1717dd7fecf2b10195b0d864323b952b4eba0

       "ARM: Add init_consistent_dma_size()"

essentially did this:

-#define CONSISTENT_BASE                (CONSISTENT_END - CONSISTENT_DMA_SIZE)
+unsigned long consistent_base = CONSISTENT_END - DEFAULT_CONSISTENT_DMA_SIZE;

but the bcmring code was still using the old CONSISTENT_BASE
macro.  Update it to now use the dynamic variable that reflects
the ability to resize early at boot.  To do so involves putting
the variable alongside of init_consistent_dma_size in dma-mapping.h

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
CC: Jon Medhurst <tixy@yxit.co.uk>
CC: Nicolas Pitre <nicolas.pitre@linaro.org>

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index cb3b7c9..b495f95 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -212,6 +212,7 @@ int dma_mmap_writecombine(struct device *, struct vm_area_struct *,
  */
 extern void __init init_consistent_dma_size(unsigned long size);
 
+extern unsigned long consistent_base;
 
 #ifdef CONFIG_DMABOUNCE
 /*
diff --git a/arch/arm/mach-bcmring/dma.c b/arch/arm/mach-bcmring/dma.c
index 1a1a27d..4e47e20 100644
--- a/arch/arm/mach-bcmring/dma.c
+++ b/arch/arm/mach-bcmring/dma.c
@@ -1615,7 +1615,7 @@ DMA_MemType_t dma_mem_type(void *addr)
 {
 	unsigned long addrVal = (unsigned long)addr;
 
-	if (addrVal >= CONSISTENT_BASE) {
+	if (addrVal >= consistent_base) {
 		/* NOTE: DMA virtual memory space starts at 0xFFxxxxxx */
 
 		/* dma_alloc_xxx pages are physically and virtually contiguous */
-- 
1.7.7.2
