From: b42378@freescale.com (Nicolin Chen)
Date: Fri, 1 Nov 2013 19:48:16 +0800
Subject: [PATCH][RESEND 3/8] dma: mmp_tdma: use gen_pool_dma_alloc() to
 allocate descriptor
In-Reply-To: <cover.1383306365.git.b42378@freescale.com>
References: <cover.1383306365.git.b42378@freescale.com>
Message-ID: <b7d5dce9fcc118a60261824196c820de6fb434a2.1383306365.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since gen_pool_dma_alloc() is introduced, we implement it to simplify code.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 drivers/dma/mmp_tdma.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 2b4026d..3ddacc1 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -378,12 +378,7 @@ struct mmp_tdma_desc *mmp_tdma_alloc_descriptor(struct mmp_tdma_chan *tdmac)
 	if (!gpool)
 		return NULL;
 
-	tdmac->desc_arr = (void *)gen_pool_alloc(gpool, size);
-	if (!tdmac->desc_arr)
-		return NULL;
-
-	tdmac->desc_arr_phys = gen_pool_virt_to_phys(gpool,
-			(unsigned long)tdmac->desc_arr);
+	tdmac->desc_arr = gen_pool_dma_alloc(gpool, size, &tdmac->desc_arr_phys);
 
 	return tdmac->desc_arr;
 }
-- 
1.8.4
