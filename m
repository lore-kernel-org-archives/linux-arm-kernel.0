From: gerg@snapgear.com (Greg Ungerer)
Date: Wed, 10 Mar 2010 15:46:44 +1000
Subject: [PATCH] ARM: pgprot_dmacoherent() for non-mmu builds
Message-ID: <201003100546.o2A5kiXV009192@goober.internal.moreton.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: pgprot_dmacoherent() for non-mmu builds

Commit 26a26d329688ab018e068b412b03d43d7c299f0a ("dma-mapping: switch
ARMv7 DMA mappings to retain 'memory' attribute") added a new macro,
pgprot_dmacoherent(), to correctly map DMA memory. The non-mmu pgtable
support code also needs to implement this macro, otherwise when
compiling you get:

  CC      arch/arm/mm/dma-mapping.o
arch/arm/mm/dma-mapping.c: In function 'dma_alloc_coherent':
arch/arm/mm/dma-mapping.c:320: error: implicit declaration of function 'pgprot_dmacoherent'
arch/arm/mm/dma-mapping.c:320: error: 'pgprot_kernel' undeclared (first use in this function)
arch/arm/mm/dma-mapping.c:320: error: (Each undeclared identifier is reported only once
arch/arm/mm/dma-mapping.c:320: error: for each function it appears in.)

This patch generated against 2.6.33.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>


--- a/arch/arm/include/asm/pgtable-nommu.h	2010-02-25 04:52:17.000000000 +1000
+++ b/arch/arm/include/asm/pgtable-nommu.h	2010-03-10 14:56:21.453032693 +1000
@@ -67,6 +67,7 @@ static inline int pte_file(pte_t pte) { 
  */
 #define pgprot_noncached(prot)	__pgprot(0)
 #define pgprot_writecombine(prot) __pgprot(0)
+#define pgprot_dmacoherent(prot) __pgprot(0)
 
 
 /*
