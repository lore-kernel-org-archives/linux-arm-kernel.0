From: romain.izard.pro@gmail.com (Romain Izard)
Date: Thu, 19 Oct 2017 18:44:43 +0200
Subject: [PATCH v5] atmel_flexcom: Support backup mode
Message-ID: <20171019164443.487-1-romain.izard.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The controller used by a flexcom module is configured at boot, and left
alone after this. As the configuration will be lost after backup mode,
restore the state of the flexcom driver on resume.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Changes in v5:
* extract from the patch series, and send as a standalone patch

 drivers/mfd/atmel-flexcom.c | 65 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
index 064bde9cff5a..ef1235c4a179 100644
--- a/drivers/mfd/atmel-flexcom.c
+++ b/drivers/mfd/atmel-flexcom.c
@@ -39,34 +39,44 @@
 #define FLEX_MR_OPMODE(opmode)	(((opmode) << FLEX_MR_OPMODE_OFFSET) &	\
 				 FLEX_MR_OPMODE_MASK)
 
+struct atmel_flexcom {
+	void __iomem *base;
+	u32 opmode;
+	struct clk *clk;
+};
 
 static int atmel_flexcom_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct clk *clk;
 	struct resource *res;
-	void __iomem *base;
-	u32 opmode;
+	struct atmel_flexcom *afc;
 	int err;
+	u32 val;
+
+	afc = devm_kzalloc(&pdev->dev, sizeof(*afc), GFP_KERNEL);
+	if (!afc)
+		return -ENOMEM;
 
-	err = of_property_read_u32(np, "atmel,flexcom-mode", &opmode);
+	platform_set_drvdata(pdev, afc);
+
+	err = of_property_read_u32(np, "atmel,flexcom-mode", &afc->opmode);
 	if (err)
 		return err;
 
-	if (opmode < ATMEL_FLEXCOM_MODE_USART ||
-	    opmode > ATMEL_FLEXCOM_MODE_TWI)
+	if (afc->opmode < ATMEL_FLEXCOM_MODE_USART ||
+	    afc->opmode > ATMEL_FLEXCOM_MODE_TWI)
 		return -EINVAL;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	afc->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(afc->base))
+		return PTR_ERR(afc->base);
 
-	clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	afc->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(afc->clk))
+		return PTR_ERR(afc->clk);
 
-	err = clk_prepare_enable(clk);
+	err = clk_prepare_enable(afc->clk);
 	if (err)
 		return err;
 
@@ -76,9 +86,10 @@ static int atmel_flexcom_probe(struct platform_device *pdev)
 	 * inaccessible and are read as zero. Also the external I/O lines of the
 	 * Flexcom are muxed to reach the selected device.
 	 */
-	writel(FLEX_MR_OPMODE(opmode), base + FLEX_MR);
+	val = FLEX_MR_OPMODE(afc->opmode);
+	writel(val, afc->base + FLEX_MR);
 
-	clk_disable_unprepare(clk);
+	clk_disable_unprepare(afc->clk);
 
 	return devm_of_platform_populate(&pdev->dev);
 }
@@ -89,10 +100,34 @@ static const struct of_device_id atmel_flexcom_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
 
+#ifdef CONFIG_PM_SLEEP
+static int atmel_flexcom_resume(struct device *dev)
+{
+	struct atmel_flexcom *afc = dev_get_drvdata(dev);
+	int err;
+	u32 val;
+
+	err = clk_prepare_enable(afc->clk);
+	if (err)
+		return err;
+
+	val = FLEX_MR_OPMODE(afc->opmode),
+	writel(val, afc->base + FLEX_MR);
+
+	clk_disable_unprepare(afc->clk);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(atmel_flexcom_pm_ops, NULL,
+			 atmel_flexcom_resume);
+
 static struct platform_driver atmel_flexcom_driver = {
 	.probe	= atmel_flexcom_probe,
 	.driver	= {
 		.name		= "atmel_flexcom",
+		.pm		= &atmel_flexcom_pm_ops,
 		.of_match_table	= atmel_flexcom_of_match,
 	},
 };
-- 
2.11.0
