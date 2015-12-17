From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 17 Dec 2015 17:48:44 +0100
Subject: [PATCH 13/24] crypto: atmel-aes: reduce latency of DMA completion
In-Reply-To: <cover.1450366831.git.cyrille.pitchen@atmel.com>
References: <cover.1450366831.git.cyrille.pitchen@atmel.com>
Message-ID: <a8f43f97c34da143330a883cac79ac5f83f5b859.1450366831.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

atmel_aes_dma_callback() now directly calls the 'resume' callback instead
of scheduling the done task, which in turn only calls the very same
'resume' callback.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/crypto/atmel-aes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 25dc7bd73532..8a2b3e81c087 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -337,8 +337,8 @@ static void atmel_aes_dma_callback(void *data)
 {
 	struct atmel_aes_dev *dd = data;
 
-	/* dma_lch_out - completed */
-	tasklet_schedule(&dd->done_task);
+	dd->is_async = true;
+	(void)dd->resume(dd);
 }
 
 static int atmel_aes_crypt_dma(struct atmel_aes_dev *dd,
-- 
1.8.2.2
