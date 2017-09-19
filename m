From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 19 Sep 2017 20:44:47 +0200
Subject: [PATCH] dmaengine: sun6i: sun4i-gpadc: use of_device_get_match_data
Message-ID: <20170919184447.4479-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usage of of_device_get_match_data reduce the code size a bit.
Furthermore, it prevents an improbable dereference when
of_match_device() return NULL.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/dma/sun6i-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index bcd496edc70f..584f4e82a9be 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1064,7 +1064,6 @@ MODULE_DEVICE_TABLE(of, sun6i_dma_match);
 
 static int sun6i_dma_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *device;
 	struct sun6i_dma_dev *sdc;
 	struct resource *res;
 	int ret, i;
@@ -1073,10 +1072,9 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	if (!sdc)
 		return -ENOMEM;
 
-	device = of_match_device(sun6i_dma_match, &pdev->dev);
-	if (!device)
+	sdc->cfg = of_device_get_match_data(&pdev->dev);
+	if (!sdc->cfg)
 		return -ENODEV;
-	sdc->cfg = device->data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sdc->base = devm_ioremap_resource(&pdev->dev, res);
-- 
2.13.5
