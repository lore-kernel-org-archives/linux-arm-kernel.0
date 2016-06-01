From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 1 Jun 2016 11:56:05 +0300
Subject: [PATCH 04/28] crypto: omap: do not call dmaengine_terminate_all
In-Reply-To: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
References: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
Message-ID: <1464771389-10640-5-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lokesh Vutla <lokeshvutla@ti.com>

The extra call to dmaengine_terminate_all is not needed, as the DMA
is not running at this point. This improves performance slightly.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/crypto/omap-aes.c  | 2 --
 drivers/crypto/omap-sham.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index 4a0e6a5..8178632 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -528,8 +528,6 @@ static int omap_aes_crypt_dma_stop(struct omap_aes_dev *dd)
 
 	omap_aes_dma_stop(dd);
 
-	dmaengine_terminate_all(dd->dma_lch_in);
-	dmaengine_terminate_all(dd->dma_lch_out);
 
 	return 0;
 }
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 71eac5c..287bc43 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -805,7 +805,6 @@ static int omap_sham_update_dma_stop(struct omap_sham_dev *dd)
 {
 	struct omap_sham_reqctx *ctx = ahash_request_ctx(dd->req);
 
-	dmaengine_terminate_all(dd->dma_lch);
 
 	if (ctx->flags & BIT(FLAGS_SG)) {
 		dma_unmap_sg(dd->dev, ctx->sg, 1, DMA_TO_DEVICE);
-- 
1.9.1
