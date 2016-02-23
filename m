From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 23 Feb 2016 14:00:20 +0800
Subject: [PATCH v3] mtd: atmel_nand: move the hsmc_clk from nfc node to nand
 node
Message-ID: <1456207220-7757-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Wu <josh.wu@atmel.com>

For SAMA5D3, SAMA5D4 SoC family, PMECC becomes a part of HSMC, they
need the HSMC clock enabled to work.
The NFC is a sub feature for current nand driver, it can be disabled.
But if HSMC clock is controlled by NFC, so disable NFC will also disable
the HSMC clock. then, it will make the PMECC fail to work.

So the solution is move the HSMC clock out of NFC to nand node. When
nand driver probed, it will check whether the chip has HSMC, if yes then
it will require a HSMC clock.

Add a new "atmel,sama5d3-nand" compatiable string for SAMA5D3's nand.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v3:
 - add "atmel,sama5d3-nand" compatiable string for SAMA5D3's nand.
 - revert the mail address of Josh's Signed-off to the original.

Changes in v2:
 - add missing .has_hsmc_clk assignment for sama5d2_caps.

 .../devicetree/bindings/mtd/atmel-nand.txt         |    4 +-
 drivers/mtd/nand/atmel_nand.c                      |   51 +++++++++++---------
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index d53aba9..29bee7c 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -15,6 +15,7 @@ Required properties:
 - atmel,nand-cmd-offset : offset for the command latch.
 - #address-cells, #size-cells : Must be present if the device has sub-nodes
   representing partitions.
+- clocks: phandle to the peripheral clock
 
 - gpios : specifies the gpio pins to control the NAND device. detect is an
   optional gpio and may be set to 0 if not present.
@@ -43,7 +44,6 @@ Required properties:
 - reg : should specify the address and size used for NFC command registers,
         NFC registers and NFC SRAM. NFC SRAM address and size can be absent
         if don't want to use it.
-- clocks: phandle to the peripheral clock
 Optional properties:
 - atmel,write-by-sram: boolean to enable NFC write by SRAM.
 
@@ -100,13 +100,13 @@ nand0: nand at 40000000 {
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
index 20cbaab..482251c 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -66,6 +66,7 @@ module_param(on_flash_bbt, int, 0);
 struct atmel_nand_caps {
 	bool pmecc_correct_erase_page;
 	uint8_t pmecc_max_correction;
+	bool has_hsmc_clk;
 };
 
 struct atmel_nand_nfc_caps {
@@ -106,8 +107,6 @@ struct atmel_nfc {
 	bool			use_nfc_sram;
 	bool			write_by_sram;
 
-	struct clk		*clk;
-
 	bool			is_initialized;
 	struct completion	comp_ready;
 	struct completion	comp_cmd_done;
@@ -132,6 +131,7 @@ struct atmel_nand_host {
 	struct dma_chan		*dma_chan;
 
 	struct atmel_nfc	*nfc;
+	struct clk		*clk;
 
 	const struct atmel_nand_caps	*caps;
 	bool			has_pmecc;
@@ -2157,6 +2157,19 @@ static int atmel_nand_probe(struct platform_device *pdev)
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
@@ -2321,6 +2334,9 @@ static int atmel_nand_remove(struct platform_device *pdev)
 	if (host->dma_chan)
 		dma_release_channel(host->dma_chan);
 
+	if (!IS_ERR(host->clk))
+		clk_disable_unprepare(host->clk);
+
 	platform_driver_unregister(&atmel_nand_nfc_driver);
 
 	return 0;
@@ -2334,11 +2350,19 @@ static int atmel_nand_remove(struct platform_device *pdev)
 static const struct atmel_nand_caps at91rm9200_caps = {
 	.pmecc_correct_erase_page = false,
 	.pmecc_max_correction = 24,
+	.has_hsmc_clk = false,
+};
+
+static struct atmel_nand_caps sama5d3_caps = {
+	.pmecc_correct_erase_page = false,
+	.pmecc_max_correction = 24,
+	.has_hsmc_clk = true,
 };
 
 static const struct atmel_nand_caps sama5d4_caps = {
 	.pmecc_correct_erase_page = true,
 	.pmecc_max_correction = 24,
+	.has_hsmc_clk = true,
 };
 
 /*
@@ -2348,11 +2372,13 @@ static const struct atmel_nand_caps sama5d4_caps = {
 static const struct atmel_nand_caps sama5d2_caps = {
 	.pmecc_correct_erase_page = true,
 	.pmecc_max_correction = 32,
+	.has_hsmc_clk = true,
 };
 
 static const struct of_device_id atmel_nand_dt_ids[] = {
 	{ .compatible = "atmel,at91rm9200-nand", .data = &at91rm9200_caps },
 	{ .compatible = "atmel,sama5d4-nand", .data = &sama5d4_caps },
+	{ .compatible = "atmel,sama5d3-nand", .data = &sama5d3_caps },
 	{ .compatible = "atmel,sama5d2-nand", .data = &sama5d2_caps },
 	{ /* sentinel */ }
 };
@@ -2363,7 +2389,6 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
 {
 	struct atmel_nfc *nfc = &nand_nfc;
 	struct resource *nfc_cmd_regs, *nfc_hsmc_regs, *nfc_sram;
-	int ret;
 
 	nfc_cmd_regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	nfc->base_cmd_regs = devm_ioremap_resource(&pdev->dev, nfc_cmd_regs);
@@ -2401,31 +2426,12 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
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
 static const struct atmel_nand_nfc_caps sama5d3_nfc_caps = {
 	.rb_mask = NFC_SR_RB_EDGE0,
 };
@@ -2447,7 +2453,6 @@ static struct platform_driver atmel_nand_nfc_driver = {
 		.of_match_table = of_match_ptr(atmel_nand_nfc_match),
 	},
 	.probe = atmel_nand_nfc_probe,
-	.remove = atmel_nand_nfc_remove,
 };
 
 static struct platform_driver atmel_nand_driver = {
-- 
1.7.9.5
