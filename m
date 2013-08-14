From: joelf@ti.com (Joel Fernandes)
Date: Wed, 14 Aug 2013 18:12:44 -0500
Subject: [PATCH 05/10] crypto: omap-aes: Sync SG before DMA operation
In-Reply-To: <1376521969-16807-1-git-send-email-joelf@ti.com>
References: <1376521969-16807-1-git-send-email-joelf@ti.com>
Message-ID: <1376521969-16807-6-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Earlier functions that did a similar sync are replaced by
the dma_sync_sg_* which can operate on entire SG list.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/crypto/omap-aes.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index 9104a7f..df2f867 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -499,6 +499,8 @@ static int omap_aes_crypt_dma(struct crypto_tfm *tfm,
 	struct dma_slave_config cfg;
 	int ret;
 
+	dma_sync_sg_for_device(dd->dev, dd->in_sg, in_sg_len, DMA_TO_DEVICE);
+
 	memset(&cfg, 0, sizeof(cfg));
 
 	cfg.src_addr = dd->phys_base + AES_REG_DATA_N(dd, 0);
@@ -686,6 +688,8 @@ static void omap_aes_done_task(unsigned long data)
 
 	pr_debug("enter done_task\n");
 
+	dma_sync_sg_for_cpu(dd->dev, dd->in_sg, dd->in_sg_len, DMA_FROM_DEVICE);
+
 	omap_aes_crypt_dma_stop(dd);
 	omap_aes_finish_req(dd, 0);
 	omap_aes_handle_queue(dd, NULL);
-- 
1.7.9.5
