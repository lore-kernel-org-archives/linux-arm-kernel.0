From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:46 +0100
Subject: [PATCH 08/30] dma: mv_xor: remove sub-driver 'mv_xor'
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that XOR channels are directly registered by the main
'mv_xor_shared' device ->probe() function and all users of the
'mv_xor' device have been removed, we can get rid of the latter.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c                     |   49 +-----------------------------
 include/linux/platform_data/dma-mv_xor.h |    1 -
 2 files changed, 1 insertion(+), 49 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 6ed3162..be3907b 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1219,35 +1219,6 @@ mv_xor_channel_add(struct mv_xor_shared_private *msp,
 	return ERR_PTR(ret);
 }
 
-static int __devexit mv_xor_remove(struct platform_device *pdev)
-{
-	struct mv_xor_device *device = platform_get_drvdata(pdev);
-	return mv_xor_channel_remove(device);
-}
-
-static int __devinit mv_xor_probe(struct platform_device *pdev)
-{
-	struct mv_xor_platform_data *plat_data = pdev->dev.platform_data;
-	struct mv_xor_shared_private *msp =
-		platform_get_drvdata(plat_data->shared);
-	struct mv_xor_device *mv_xor_device;
-	int irq;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	mv_xor_device = mv_xor_channel_add(msp, pdev, plat_data->hw_id,
-					   plat_data->cap_mask,
-					   plat_data->pool_size, irq);
-	if (IS_ERR(mv_xor_device))
-		return PTR_ERR(mv_xor_device);
-
-	platform_set_drvdata(pdev, mv_xor_device);
-
-	return 0;
-}
-
 static void
 mv_xor_conf_mbus_windows(struct mv_xor_shared_private *msp,
 			 const struct mbus_dram_target_info *dram)
@@ -1279,15 +1250,6 @@ mv_xor_conf_mbus_windows(struct mv_xor_shared_private *msp,
 	writel(win_enable, base + WINDOW_BAR_ENABLE(1));
 }
 
-static struct platform_driver mv_xor_driver = {
-	.probe		= mv_xor_probe,
-	.remove		= __devexit_p(mv_xor_remove),
-	.driver		= {
-		.owner	= THIS_MODULE,
-		.name	= MV_XOR_NAME,
-	},
-};
-
 static int mv_xor_shared_probe(struct platform_device *pdev)
 {
 	const struct mbus_dram_target_info *dram;
@@ -1406,15 +1368,7 @@ static struct platform_driver mv_xor_shared_driver = {
 
 static int __init mv_xor_init(void)
 {
-	int rc;
-
-	rc = platform_driver_register(&mv_xor_shared_driver);
-	if (!rc) {
-		rc = platform_driver_register(&mv_xor_driver);
-		if (rc)
-			platform_driver_unregister(&mv_xor_shared_driver);
-	}
-	return rc;
+	return platform_driver_register(&mv_xor_shared_driver);
 }
 module_init(mv_xor_init);
 
@@ -1422,7 +1376,6 @@ module_init(mv_xor_init);
 #if 0
 static void __exit mv_xor_exit(void)
 {
-	platform_driver_unregister(&mv_xor_driver);
 	platform_driver_unregister(&mv_xor_shared_driver);
 	return;
 }
diff --git a/include/linux/platform_data/dma-mv_xor.h b/include/linux/platform_data/dma-mv_xor.h
index f2aed97..6abe5f9 100644
--- a/include/linux/platform_data/dma-mv_xor.h
+++ b/include/linux/platform_data/dma-mv_xor.h
@@ -11,7 +11,6 @@
 #include <linux/mbus.h>
 
 #define MV_XOR_SHARED_NAME	"mv_xor_shared"
-#define MV_XOR_NAME		"mv_xor"
 
 struct mv_xor_platform_data {
 	struct platform_device		*shared;
-- 
1.7.9.5
