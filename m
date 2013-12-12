From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 15:50:11 -0600
Subject: [PATCH] usb: dwc3: omap: remove DEV_PM_OPS trickery
Message-ID: <1386885011-13792-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

it's best to just remove all ifdefs and always
define our dev_pm_ops structure.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

one more patch

 drivers/usb/dwc3/dwc3-omap.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index a9090a1..14a53ba 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -598,7 +598,6 @@ static const struct of_device_id of_dwc3_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_dwc3_match);
 
-#ifdef CONFIG_PM_SLEEP
 static int dwc3_omap_prepare(struct device *dev)
 {
 	struct dwc3_omap	*omap = dev_get_drvdata(dev);
@@ -675,18 +674,13 @@ static const struct dev_pm_ops dwc3_omap_dev_pm_ops = {
 			NULL)
 };
 
-#define DEV_PM_OPS	(&dwc3_omap_dev_pm_ops)
-#else
-#define DEV_PM_OPS	NULL
-#endif /* CONFIG_PM_SLEEP */
-
 static struct platform_driver dwc3_omap_driver = {
 	.probe		= dwc3_omap_probe,
 	.remove		= dwc3_omap_remove,
 	.driver		= {
 		.name	= "omap-dwc3",
 		.of_match_table	= of_dwc3_match,
-		.pm	= DEV_PM_OPS,
+		.pm	= &dwc3_omap_dev_pm_ops,
 	},
 };
 
-- 
1.8.4.GIT
