From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Oct 2013 08:05:47 +0100
Subject: [PATCH] ARM: dma-mapping: don't allow DMA mappings to be marked
 executable
Message-ID: <20131024070547.GA16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While looking at some features which Kees talked about on Tuesday, I
discovered that our DMA mappings were incorrectly marked executable,
which means that they can be subject to speculative instruction
prefetches.  This turns off executable permission for these mappings.
I'm intending to push this for v3.12 as a fix.

8<====
From: Russell King <rmk+kernel@arm.linux.org.uk>
ARM: dma-mapping: don't allow DMA mappings to be marked executable

DMA mapping permissions were being derived from pgprot_kernel directly
without using PAGE_KERNEL.  This causes them to be marked with executable
permission, which is not what we want.  Fix this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/dma-mapping.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7f9b179..838e871 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -688,7 +688,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		    gfp_t gfp, struct dma_attrs *attrs)
 {
-	pgprot_t prot = __get_dma_pgprot(attrs, pgprot_kernel);
+	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	void *memory;
 
 	if (dma_alloc_from_coherent(dev, size, handle, &memory))
@@ -701,7 +701,7 @@ void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
 	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
 {
-	pgprot_t prot = __get_dma_pgprot(attrs, pgprot_kernel);
+	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	void *memory;
 
 	if (dma_alloc_from_coherent(dev, size, handle, &memory))
-- 
1.7.4.4
