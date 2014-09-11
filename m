From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 11 Sep 2014 16:43:37 +0200
Subject: [PATCH] mtd: nand: atmel_nand: retrieve NFC clock
Message-ID: <1410446617-29572-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/atmel_nand.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 9c5f717bda54..ba64b1c91314 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -27,6 +27,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -96,6 +97,8 @@ struct atmel_nfc {
 	bool			use_nfc_sram;
 	bool			write_by_sram;
 
+	struct clk		*clk;
+
 	bool			is_initialized;
 	struct completion	comp_ready;
 	struct completion	comp_cmd_done;
@@ -2248,6 +2251,7 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
 {
 	struct atmel_nfc *nfc = &nand_nfc;
 	struct resource *nfc_cmd_regs, *nfc_hsmc_regs, *nfc_sram;
+	int ret;
 
 	nfc_cmd_regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	nfc->base_cmd_regs = devm_ioremap_resource(&pdev->dev, nfc_cmd_regs);
@@ -2276,6 +2280,16 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
 		}
 	}
 
+	nfc->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(nfc->clk)) {
+		dev_warn(&pdev->dev, "NFC clock is missing");
+		return 0;
+	}
+
+	ret = clk_prepare_enable(nfc->clk);
+	if (ret)
+		return ret;
+
 	nfc_writel(nfc->hsmc_regs, IDR, 0xffffffff);
 	nfc_readl(nfc->hsmc_regs, SR);	/* clear the NFC_SR */
 
@@ -2284,6 +2298,16 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int atmel_nand_nfc_remove(struct platform_device *pdev)
+{
+	struct atmel_nfc *nfc = &nand_nfc;
+
+	if (!IS_ERR(nfc->clk))
+		clk_disable_unprepare(nfc->clk);
+
+	return 0;
+}
+
 static const struct of_device_id atmel_nand_nfc_match[] = {
 	{ .compatible = "atmel,sama5d3-nfc" },
 	{ /* sentinel */ }
@@ -2297,6 +2321,7 @@ static struct platform_driver atmel_nand_nfc_driver = {
 		.of_match_table = of_match_ptr(atmel_nand_nfc_match),
 	},
 	.probe = atmel_nand_nfc_probe,
+	.remove = atmel_nand_nfc_remove,
 };
 
 static struct platform_driver atmel_nand_driver = {
-- 
1.9.1
