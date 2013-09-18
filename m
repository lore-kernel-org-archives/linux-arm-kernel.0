From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 18 Sep 2013 11:31:19 +0800
Subject: [PATCH v2 1/2] mtd: atmel_nand: remove #if defined(CONFIG_OF) around
 OF-specific code
Message-ID: <1379475080-14984-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the of specific code are declared in <linux/of_mtd.h> regardless
of CONFIG_OF. Remove the #if defined(CONFIG_OF) guard and use an
IS_ENABLED(CONFIG_OF) instead.

Thanks to Ezequiel Garcia's for this protype.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
v1 --> v2:
  add an IS_ENABLED(CONFIG_OF) to guard the code for dt node parsing.

 drivers/mtd/nand/atmel_nand.c |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 060feea..72c2611 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -1449,7 +1449,6 @@ static void atmel_nand_hwctl(struct mtd_info *mtd, int mode)
 		ecc_writel(host->ecc, CR, ATMEL_ECC_RST);
 }
 
-#if defined(CONFIG_OF)
 static int atmel_of_init_port(struct atmel_nand_host *host,
 			      struct device_node *np)
 {
@@ -1457,7 +1456,7 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
 	u32 offset[2];
 	int ecc_mode;
 	struct atmel_nand_data *board = &host->board;
-	enum of_gpio_flags flags;
+	enum of_gpio_flags flags = 0;
 
 	if (of_property_read_u32(np, "atmel,nand-addr-offset", &val) == 0) {
 		if (val >= 32) {
@@ -1540,13 +1539,6 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
 
 	return 0;
 }
-#else
-static int atmel_of_init_port(struct atmel_nand_host *host,
-			      struct device_node *np)
-{
-	return -EINVAL;
-}
-#endif
 
 static int __init atmel_hw_nand_init_params(struct platform_device *pdev,
 					 struct atmel_nand_host *host)
@@ -2019,7 +2011,8 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	mtd = &host->mtd;
 	nand_chip = &host->nand_chip;
 	host->dev = &pdev->dev;
-	if (pdev->dev.of_node) {
+	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
+		/* Only when CONFIG_OF is enabled of_node can be parsed */
 		res = atmel_of_init_port(host, pdev->dev.of_node);
 		if (res)
 			goto err_nand_ioremap;
@@ -2207,14 +2200,12 @@ static int __exit atmel_nand_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#if defined(CONFIG_OF)
 static const struct of_device_id atmel_nand_dt_ids[] = {
 	{ .compatible = "atmel,at91rm9200-nand" },
 	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(of, atmel_nand_dt_ids);
-#endif
 
 static int atmel_nand_nfc_probe(struct platform_device *pdev)
 {
@@ -2253,12 +2244,10 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#if defined(CONFIG_OF)
 static struct of_device_id atmel_nand_nfc_match[] = {
 	{ .compatible = "atmel,sama5d3-nfc" },
 	{ /* sentinel */ }
 };
-#endif
 
 static struct platform_driver atmel_nand_nfc_driver = {
 	.driver = {
-- 
1.7.9.5
