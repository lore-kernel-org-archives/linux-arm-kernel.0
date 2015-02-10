From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 10 Feb 2015 14:14:43 +0800
Subject: [PATCH 1/3] mtd: atmel_nand: move the hsmc_clk from nfc node to nand
 node
Message-ID: <1423548885-27589-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also add a new sama5d3_nand compatiable string for sama5d3 nand.

For sama5d3, sama5d4 chip, the pmecc became part of HSMC, they need the
HSMC clock enabled to work.
The NFC is a sub feature for current nand driver, it can be disabled.
But if HSMC clock is controlled by NFC, so disable NFC will also disable
the HSMC clock. then, it will make the PMECC fail to work.

So the solution is move the HSMC clock out of NFC to nand node. When
nand driver probed, it will check whether the chip has HSMC, if yes then
it will require a HSMC clock.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

 .../devicetree/bindings/mtd/atmel-nand.txt         |  4 +-
 drivers/mtd/nand/atmel_nand.c                      | 49 ++++++++++++----------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index 7d4c8eb..955a793 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -12,6 +12,7 @@ Required properties:
 - atmel,nand-cmd-offset : offset for the command latch.
 - #address-cells, #size-cells : Must be present if the device has sub-nodes
   representing partitions.
+- clocks: phandle to the peripheral clock
 
 - gpios : specifies the gpio pins to control the NAND device. detect is an
   optional gpio and may be set to 0 if not present.
@@ -38,7 +39,6 @@ Optional properties:
     - reg : should specify the address and size used for NFC command registers,
             NFC registers and NFC Sram. NFC Sram address and size can be absent
             if don't want to use it.
-    - clocks: phandle to the peripheral clock
   - Optional properties:
     - atmel,write-by-sram: boolean to enable NFC write by sram.
 
@@ -95,13 +95,13 @@ nand0: nand at 40000000 {
 	compatible = "atmel,at91rm9200-nand";
 	#address-cells = <1>;
 	#size-cells = <1>;
+	clocks = <&hsmc_clk>
 	ranges;
         ...
         nfc at 70000000 {
 		compatible = "atmel,sama5d3-nfc";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		clocks = <&hsmc_clk>
 		reg = <
 			0x70000000 0x10000000	/* NFC Command Registers */
 			0xffffc000 0x00000070	/* NFC HSMC regs */
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 336cc2d..9de9952 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -65,6 +65,7 @@ module_param(on_flash_bbt, int, 0);
 
 struct atmel_nand_caps {
 	bool pmecc_correct_erase_page;
+	bool has_hsmc_clk;
 };
 
 /* oob layout for large page size
@@ -101,8 +102,6 @@ struct atmel_nfc {
 	bool			use_nfc_sram;
 	bool			write_by_sram;
 
-	struct clk		*clk;
-
 	bool			is_initialized;
 	struct completion	comp_ready;
 	struct completion	comp_cmd_done;
@@ -127,6 +126,7 @@ struct atmel_nand_host {
 	struct dma_chan		*dma_chan;
 
 	struct atmel_nfc	*nfc;
+	struct clk		*clk;
 
 	struct atmel_nand_caps	*caps;
 	bool			has_pmecc;
@@ -2131,6 +2131,19 @@ static int atmel_nand_probe(struct platform_device *pdev)
 	nand_chip->IO_ADDR_R = host->io_base;
 	nand_chip->IO_ADDR_W = host->io_base;
 
+	if (host->caps->has_hsmc_clk) {
+		host->clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(host->clk)) {
+			dev_err(&pdev->dev, "HSMC clock is missing, update your Device Tree");
+			res = PTR_ERR(host->clk);
+			goto err_nand_ioremap;
+		}
+
+		res = clk_prepare_enable(host->clk);
+		if (res)
+			goto err_nand_ioremap;
+	}
+
 	if (nand_nfc.is_initialized) {
 		/* NFC driver is probed and initialized */
 		host->nfc = &nand_nfc;
@@ -2296,6 +2309,9 @@ static int atmel_nand_remove(struct platform_device *pdev)
 	if (host->dma_chan)
 		dma_release_channel(host->dma_chan);
 
+	if (!IS_ERR(host->clk))
+		clk_disable_unprepare(host->clk);
+
 	platform_driver_unregister(&atmel_nand_nfc_driver);
 
 	return 0;
@@ -2303,14 +2319,22 @@ static int atmel_nand_remove(struct platform_device *pdev)
 
 static struct atmel_nand_caps at91rm9200_caps = {
 	.pmecc_correct_erase_page = false,
+	.has_hsmc_clk = false,
+};
+
+static struct atmel_nand_caps sama5d3_caps = {
+	.pmecc_correct_erase_page = false,
+	.has_hsmc_clk = true,
 };
 
 static struct atmel_nand_caps sama5d4_caps = {
 	.pmecc_correct_erase_page = true,
+	.has_hsmc_clk = true,
 };
 
 static const struct of_device_id atmel_nand_dt_ids[] = {
 	{ .compatible = "atmel,at91rm9200-nand", .data = &at91rm9200_caps },
+	{ .compatible = "atmel,sama5d3-nand", .data = &sama5d3_caps },
 	{ .compatible = "atmel,sama5d4-nand", .data = &sama5d4_caps },
 	{ /* sentinel */ }
 };
@@ -2321,7 +2345,6 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
 {
 	struct atmel_nfc *nfc = &nand_nfc;
 	struct resource *nfc_cmd_regs, *nfc_hsmc_regs, *nfc_sram;
-	int ret;
 
 	nfc_cmd_regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	nfc->base_cmd_regs = devm_ioremap_resource(&pdev->dev, nfc_cmd_regs);
@@ -2354,31 +2377,12 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
 	nfc_writel(nfc->hsmc_regs, IDR, 0xffffffff);
 	nfc_readl(nfc->hsmc_regs, SR);	/* clear the NFC_SR */
 
-	nfc->clk = devm_clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(nfc->clk)) {
-		ret = clk_prepare_enable(nfc->clk);
-		if (ret)
-			return ret;
-	} else {
-		dev_warn(&pdev->dev, "NFC clock missing, update your Device Tree");
-	}
-
 	nfc->is_initialized = true;
 	dev_info(&pdev->dev, "NFC is probed.\n");
 
 	return 0;
 }
 
-static int atmel_nand_nfc_remove(struct platform_device *pdev)
-{
-	struct atmel_nfc *nfc = &nand_nfc;
-
-	if (!IS_ERR(nfc->clk))
-		clk_disable_unprepare(nfc->clk);
-
-	return 0;
-}
-
 static const struct of_device_id atmel_nand_nfc_match[] = {
 	{ .compatible = "atmel,sama5d3-nfc" },
 	{ /* sentinel */ }
@@ -2391,7 +2395,6 @@ static struct platform_driver atmel_nand_nfc_driver = {
 		.of_match_table = of_match_ptr(atmel_nand_nfc_match),
 	},
 	.probe = atmel_nand_nfc_probe,
-	.remove = atmel_nand_nfc_remove,
 };
 
 static struct platform_driver atmel_nand_driver = {
-- 
1.9.1
