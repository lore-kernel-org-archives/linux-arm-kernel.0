From: sjhuang@iluvatar.ai (Huang Shijie)
Date: Mon,  6 Aug 2018 16:52:27 +0800
Subject: [PATCH v2 5/9] dmaengine: ste_dma40: use
 dmaenginem_async_device_register to simplify the code
In-Reply-To: <20180806085231.4597-1-sjhuang@iluvatar.ai>
References: <20180806085231.4597-1-sjhuang@iluvatar.ai>
Message-ID: <20180806085231.4597-6-sjhuang@iluvatar.ai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label unregister_slave, unregister_memcpy

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/ste_dma40.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index f4edfc56f34e..5e328bd10c27 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2839,7 +2839,7 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 
 	d40_ops_init(base, &base->dma_slave);
 
-	err = dma_async_device_register(&base->dma_slave);
+	err = dmaenginem_async_device_register(&base->dma_slave);
 
 	if (err) {
 		d40_err(base->dev, "Failed to register slave channels\n");
@@ -2854,12 +2854,12 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 
 	d40_ops_init(base, &base->dma_memcpy);
 
-	err = dma_async_device_register(&base->dma_memcpy);
+	err = dmaenginem_async_device_register(&base->dma_memcpy);
 
 	if (err) {
 		d40_err(base->dev,
 			"Failed to register memcpy only channels\n");
-		goto unregister_slave;
+		goto exit;
 	}
 
 	d40_chan_init(base, &base->dma_both, base->phy_chans,
@@ -2871,18 +2871,14 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 	dma_cap_set(DMA_CYCLIC, base->dma_slave.cap_mask);
 
 	d40_ops_init(base, &base->dma_both);
-	err = dma_async_device_register(&base->dma_both);
+	err = dmaenginem_async_device_register(&base->dma_both);
 
 	if (err) {
 		d40_err(base->dev,
 			"Failed to register logical and physical capable channels\n");
-		goto unregister_memcpy;
+		goto exit;
 	}
 	return 0;
- unregister_memcpy:
-	dma_async_device_unregister(&base->dma_memcpy);
- unregister_slave:
-	dma_async_device_unregister(&base->dma_slave);
  exit:
 	return err;
 }
-- 
2.17.1
