From: avinashphilip@ti.com (Philip Avinash)
Date: Thu, 7 Feb 2013 18:06:58 +0530
Subject: [PATCH v2 4/4] mtd: nand: omap2: Low power transition support
In-Reply-To: <1360240618-11094-1-git-send-email-avinashphilip@ti.com>
References: <1360240618-11094-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1360240618-11094-5-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Low power transition support in nand driver. Also
ensures the current transaction finishes before going to low power mode
with _suspend support in mtd layer.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
 drivers/mtd/nand/omap2.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 8e820dd..790215b 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -2103,9 +2103,28 @@ static int omap_nand_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int omap_nand_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct mtd_info *mtd = platform_get_drvdata(pdev);
+
+	mtd->_suspend(mtd);
+	return 0;
+}
+
+static int omap_nand_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
 static struct platform_driver omap_nand_driver = {
 	.probe		= omap_nand_probe,
 	.remove		= omap_nand_remove,
+#ifdef CONFIG_PM
+	.suspend	= omap_nand_suspend,
+	.resume		= omap_nand_resume,
+#endif
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
-- 
1.7.9.5
