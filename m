From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 21 Sep 2016 13:26:34 +0300
Subject: [PATCH v2 6/9] dmaengine: ti-dma-crossbar: Use enum for crossbar type
In-Reply-To: <20160921102637.24845-1-peter.ujfalusi@ti.com>
References: <20160921102637.24845-1-peter.ujfalusi@ti.com>
Message-ID: <20160921102637.24845-7-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes compiler warnings on 64bit architectures:

drivers/dma/ti-dma-crossbar.c: In function ?ti_dra7_xbar_probe?:
drivers/dma/ti-dma-crossbar.c:398:21: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  xbar->dma_offset = (u32)match->data;
                     ^
drivers/dma/ti-dma-crossbar.c: In function ?ti_dma_xbar_probe?:
drivers/dma/ti-dma-crossbar.c:431:10: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  switch ((u32)match->data) {
          ^

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti-dma-crossbar.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index e4f3bd1ae264..876e4ccaf033 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -16,8 +16,10 @@
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 
-#define TI_XBAR_DRA7		0
-#define TI_XBAR_AM335X		1
+enum ti_xbar_type {
+	TI_XBAR_DRA7 = 0,
+	TI_XBAR_AM335X,
+};
 
 static const struct of_device_id ti_dma_xbar_match[] = {
 	{
@@ -395,7 +397,7 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
 
 	xbar->dmarouter.dev = &pdev->dev;
 	xbar->dmarouter.route_free = ti_dra7_xbar_free;
-	xbar->dma_offset = (u32)match->data;
+	xbar->dma_offset = (enum ti_xbar_type)match->data;
 
 	mutex_init(&xbar->mutex);
 	platform_set_drvdata(pdev, xbar);
@@ -428,7 +430,7 @@ static int ti_dma_xbar_probe(struct platform_device *pdev)
 	if (unlikely(!match))
 		return -EINVAL;
 
-	switch ((u32)match->data) {
+	switch ((enum ti_xbar_type)match->data) {
 	case TI_XBAR_DRA7:
 		ret = ti_dra7_xbar_probe(pdev);
 		break;
-- 
2.10.0
