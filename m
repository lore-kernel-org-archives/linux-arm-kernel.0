From: b42378@freescale.com (Nicolin Chen)
Date: Fri, 1 Nov 2013 19:36:00 +0800
Subject: [PATCH 2/8] ARM: davinci: use gen_pool_dma_alloc() to sram.c
In-Reply-To: <cover.1383303752.git.b42378@freescale.com>
References: <cover.1383303752.git.b42378@freescale.com>
Message-ID: <9536ee2bbb1a8463ebb21068a750b61fa59900df.1383303752.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since gen_pool_dma_alloc() is introduced, we implement it to simplify code.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 arch/arm/mach-davinci/sram.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/sram.c b/arch/arm/mach-davinci/sram.c
index f18928b..8540ddd 100644
--- a/arch/arm/mach-davinci/sram.c
+++ b/arch/arm/mach-davinci/sram.c
@@ -25,7 +25,6 @@ struct gen_pool *sram_get_gen_pool(void)
 
 void *sram_alloc(size_t len, dma_addr_t *dma)
 {
-	unsigned long vaddr;
 	dma_addr_t dma_base = davinci_soc_info.sram_dma;
 
 	if (dma)
@@ -33,13 +32,7 @@ void *sram_alloc(size_t len, dma_addr_t *dma)
 	if (!sram_pool || (dma && !dma_base))
 		return NULL;
 
-	vaddr = gen_pool_alloc(sram_pool, len);
-	if (!vaddr)
-		return NULL;
-
-	if (dma)
-		*dma = gen_pool_virt_to_phys(sram_pool, vaddr);
-	return (void *)vaddr;
+	return gen_pool_dma_alloc(sram_pool, len, dma);
 
 }
 EXPORT_SYMBOL(sram_alloc);
-- 
1.8.4
