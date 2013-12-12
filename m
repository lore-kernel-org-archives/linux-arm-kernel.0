From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Thu, 12 Dec 2013 23:11:55 +0200
Subject: [PATCH] dma: mv_xor: fix kernel crash on probe error
Message-ID: <1386882715-16433-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the non-DT channel add path fails, the kernel will crash as the
channel is not set to NULL and it will try to release the channel using
the error value. Fix that.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/dma/mv_xor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 7807f0ef4e20..2cb35a62c7f0 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1227,6 +1227,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 						   cd->cap_mask, irq);
 			if (IS_ERR(xordev->channels[i])) {
 				ret = PTR_ERR(xordev->channels[i]);
+				xordev->channels[i] = NULL;
 				goto err_channel_add;
 			}
 		}
-- 
1.8.5.1
