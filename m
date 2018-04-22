From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Sun, 22 Apr 2018 11:14:10 +0200
Subject: [PATCH 2/6] dmaengine: at_xdmac: simplify getting .drvdata
In-Reply-To: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
References: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
Message-ID: <20180422091415.7587-3-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply to your tree directly.

 drivers/dma/at_xdmac.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 94236ec9d410..4bf72561667c 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1833,8 +1833,7 @@ static void at_xdmac_free_chan_resources(struct dma_chan *chan)
 #ifdef CONFIG_PM
 static int atmel_xdmac_prepare(struct device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct at_xdmac		*atxdmac = platform_get_drvdata(pdev);
+	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
 	struct dma_chan		*chan, *_chan;
 
 	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
@@ -1853,8 +1852,7 @@ static int atmel_xdmac_prepare(struct device *dev)
 #ifdef CONFIG_PM_SLEEP
 static int atmel_xdmac_suspend(struct device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct at_xdmac		*atxdmac = platform_get_drvdata(pdev);
+	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
 	struct dma_chan		*chan, *_chan;
 
 	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
@@ -1878,8 +1876,7 @@ static int atmel_xdmac_suspend(struct device *dev)
 
 static int atmel_xdmac_resume(struct device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct at_xdmac		*atxdmac = platform_get_drvdata(pdev);
+	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
 	struct at_xdmac_chan	*atchan;
 	struct dma_chan		*chan, *_chan;
 	int			i;
-- 
2.11.0
