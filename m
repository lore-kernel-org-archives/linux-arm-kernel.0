From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  4 Dec 2014 23:30:11 +0100
Subject: [PATCH 1/4] mtd: nand: atmel: Rework driver to separate nfc and nand
 nodes
In-Reply-To: <1417732214-3292-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1417732214-3292-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1417732214-3292-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtd: nand: atmel: Update DT documentation after splitting NFC and NAND

The NAND and NFC (NAND Flash Controller) were linked together with a
parent <-> child relationship.

This model has several drawbacks:
- it does not allow for multiple NAND chip handling while the controller
  support multi-chip (even though the driver is not ready yet)
- it mixes NAND partitions and NFC nodes at the same level (which is a bit
  disturbing)
- the introduction of the EBI bus implies defining NAND chips under the
  EBI node, and the ranges available under the EBI node should be
  restricted to EBI address space, while the NFC references several
  registers outside of these EBI ranges.

Move the NFC node outside of the NAND node, to get a more future-proof
DT representation.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/atmel_nand.c | 76 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 19d1e9d..0239fe6 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -123,6 +123,7 @@ struct atmel_nand_host {
 	struct dma_chan		*dma_chan;
 
 	struct atmel_nfc	*nfc;
+	bool			wait_for_nfc;
 
 	bool			has_pmecc;
 	u8			pmecc_corr_cap;
@@ -1423,6 +1424,12 @@ static void atmel_nand_hwctl(struct mtd_info *mtd, int mode)
 		ecc_writel(host->ecc, CR, ATMEL_ECC_RST);
 }
 
+static const struct of_device_id atmel_nand_nfc_match[] = {
+	{ .compatible = "atmel,sama5d3-nfc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, atmel_nand_nfc_match);
+
 static int atmel_of_init_port(struct atmel_nand_host *host,
 			      struct device_node *np)
 {
@@ -1431,6 +1438,7 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
 	int ecc_mode;
 	struct atmel_nand_data *board = &host->board;
 	enum of_gpio_flags flags = 0;
+	struct device_node *child;
 
 	if (of_property_read_u32(np, "atmel,nand-addr-offset", &val) == 0) {
 		if (val >= 32) {
@@ -1467,8 +1475,30 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
 
 	host->has_pmecc = of_property_read_bool(np, "atmel,has-pmecc");
 
-	/* load the nfc driver if there is */
-	of_platform_populate(np, NULL, NULL, host->dev);
+	/*
+	 * Backward compatibility with DTs defining the NFC node as their
+	 * child.
+	 * The new model reference the NFC so that we can define several
+	 * chip controlled by the same controller.
+	 */
+	for_each_available_child_of_node(np, child) {
+		/*
+		 * If we find an NFC node under the NAND node, then populate
+		 * the device so that it can be probed, and wait for it.
+		 */
+		if (of_match_node(atmel_nand_nfc_match, child)) {
+			of_platform_populate(np, NULL, NULL, host->dev);
+			host->wait_for_nfc = true;
+			break;
+		}
+	}
+
+	/*
+	 * If there's an atmel,nfc property we should access the NAND
+	 * through the NFC.
+	 */
+	if (of_property_read_bool(np, "atmel,nfc"))
+		host->wait_for_nfc = true;
 
 	if (!(board->ecc_mode == NAND_ECC_HW) || !host->has_pmecc)
 		return 0;	/* Not using PMECC */
@@ -2032,10 +2062,6 @@ static int atmel_nand_probe(struct platform_device *pdev)
 	if (!host)
 		return -ENOMEM;
 
-	res = platform_driver_register(&atmel_nand_nfc_driver);
-	if (res)
-		dev_err(&pdev->dev, "atmel_nand: can't register NFC driver\n");
-
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->io_base = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(host->io_base)) {
@@ -2089,6 +2115,13 @@ static int atmel_nand_probe(struct platform_device *pdev)
 			goto err_nand_ioremap;
 		}
 	} else {
+		/*
+		 * If the NFC is not initialized (or not probed) and the device
+		 * is asking to be accessed through the NFC then defer the
+		 * probe.
+		 */
+		if (host->wait_for_nfc)
+			return -EPROBE_DEFER;
 		res = atmel_nand_set_enable_ready_pins(mtd);
 		if (res)
 			goto err_nand_ioremap;
@@ -2230,8 +2263,6 @@ static int atmel_nand_remove(struct platform_device *pdev)
 	if (host->dma_chan)
 		dma_release_channel(host->dma_chan);
 
-	platform_driver_unregister(&atmel_nand_nfc_driver);
-
 	return 0;
 }
 
@@ -2303,12 +2334,6 @@ static int atmel_nand_nfc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id atmel_nand_nfc_match[] = {
-	{ .compatible = "atmel,sama5d3-nfc" },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, atmel_nand_nfc_match);
-
 static struct platform_driver atmel_nand_nfc_driver = {
 	.driver = {
 		.name = "atmel_nand_nfc",
@@ -2329,7 +2354,28 @@ static struct platform_driver atmel_nand_driver = {
 	},
 };
 
-module_platform_driver(atmel_nand_driver);
+static int __init atmel_nand_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&atmel_nand_nfc_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&atmel_nand_driver);
+	if (ret)
+		platform_driver_unregister(&atmel_nand_nfc_driver);
+
+	return ret;
+}
+module_init(atmel_nand_init);
+
+static void __exit atmel_nand_exit(void)
+{
+	platform_driver_unregister(&atmel_nand_driver);
+	platform_driver_unregister(&atmel_nand_nfc_driver);
+}
+module_exit(atmel_nand_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Rick Bronson");
-- 
1.9.1
