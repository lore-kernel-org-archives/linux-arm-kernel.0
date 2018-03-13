From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 13 Mar 2018 11:30:16 +0100
Subject: [PATCH v3] mtd: nand: marvell: Fix clock resource by adding a
 register clock
Message-ID: <20180313103016.7695-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Armada 7K/8K we need to explicitly enable the register clock. This
clock is optional because not all the SoCs using this IP need it but at
least for Armada 7K/8K it is actually mandatory.

The binding documentation is updated accordingly.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
Changelog:
v2 -> v3
 - Updating the kerneldoc
 - Renaming unprepare_clk to unprepare_ecc_clk
 - Adding extra test on the presence of "core" clock to make Boris happy

v1 -> v2

 - Removed the unnecessary IS_ERR() call
 - Skip the reg clock only if it is not present by checking "-ENOENT"
 - Add a label for uninitializing the reg clock.

 .../devicetree/bindings/mtd/marvell-nand.txt       |  6 +++-
 drivers/mtd/nand/marvell_nand.c                    | 34 ++++++++++++++++++----
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/marvell-nand.txt b/Documentation/devicetree/bindings/mtd/marvell-nand.txt
index c08fb477b3c6..4ee9813bf88f 100644
--- a/Documentation/devicetree/bindings/mtd/marvell-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/marvell-nand.txt
@@ -14,7 +14,11 @@ Required properties:
 - #address-cells: shall be set to 1. Encode the NAND CS.
 - #size-cells: shall be set to 0.
 - interrupts: shall define the NAND controller interrupt.
-- clocks: shall reference the NAND controller clock.
+- clocks: shall reference the NAND controller clocks, the second one is
+  optional but needed for the Armada 7K/8K SoCs
+- clock-names: mandatory if there is a second clock, in this case the
+   name must be "core" for the first clock and "reg" for the second
+   one
 - marvell,system-controller: Set to retrieve the syscon node that handles
   NAND controller related registers (only required with the
   "marvell,armada-8k-nand[-controller]" compatibles).
diff --git a/drivers/mtd/nand/marvell_nand.c b/drivers/mtd/nand/marvell_nand.c
index 2196f2a233d6..0e7e8017046a 100644
--- a/drivers/mtd/nand/marvell_nand.c
+++ b/drivers/mtd/nand/marvell_nand.c
@@ -308,6 +308,7 @@ struct marvell_nfc_caps {
  * @dev:		Parent device (used to print error messages)
  * @regs:		NAND controller registers
  * @ecc_clk:		ECC block clock, two times the NAND controller clock
+ * @reg_clk:		Regsiters clock
  * @complete:		Completion object to wait for NAND controller events
  * @assigned_cs:	Bitmask describing already assigned CS lines
  * @chips:		List containing all the NAND chips attached to
@@ -321,6 +322,7 @@ struct marvell_nfc {
 	struct device *dev;
 	void __iomem *regs;
 	struct clk *ecc_clk;
+	struct clk *reg_clk;
 	struct completion complete;
 	unsigned long assigned_cs;
 	struct list_head chips;
@@ -2739,7 +2741,12 @@ static int marvell_nfc_probe(struct platform_device *pdev)
 		return irq;
 	}
 
-	nfc->ecc_clk = devm_clk_get(&pdev->dev, NULL);
+	nfc->ecc_clk = devm_clk_get(&pdev->dev, "core");
+
+	/* Managed the legacy case (when the first clock was not named) */
+	if (nfc->ecc_clk == ERR_PTR(-ENOENT))
+		nfc->ecc_clk = devm_clk_get(&pdev->dev, NULL);
+
 	if (IS_ERR(nfc->ecc_clk))
 		return PTR_ERR(nfc->ecc_clk);
 
@@ -2747,12 +2754,24 @@ static int marvell_nfc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	nfc->reg_clk = devm_clk_get(&pdev->dev, "reg");
+	if (PTR_ERR(nfc->reg_clk) != -ENOENT) {
+		if (!IS_ERR(nfc->reg_clk)) {
+			ret = clk_prepare_enable(nfc->reg_clk);
+			if (ret)
+				goto unprepare_ecc_clk;
+		} else {
+			ret = PTR_ERR(nfc->reg_clk);
+			goto unprepare_ecc_clk;
+		}
+	}
+
 	marvell_nfc_disable_int(nfc, NDCR_ALL_INT);
 	marvell_nfc_clear_int(nfc, NDCR_ALL_INT);
 	ret = devm_request_irq(dev, irq, marvell_nfc_isr,
 			       0, "marvell-nfc", nfc);
 	if (ret)
-		goto unprepare_clk;
+		goto unprepare_reg_clk;
 
 	/* Get NAND controller capabilities */
 	if (pdev->id_entry)
@@ -2763,23 +2782,25 @@ static int marvell_nfc_probe(struct platform_device *pdev)
 	if (!nfc->caps) {
 		dev_err(dev, "Could not retrieve NFC caps\n");
 		ret = -EINVAL;
-		goto unprepare_clk;
+		goto unprepare_reg_clk;
 	}
 
 	/* Init the controller and then probe the chips */
 	ret = marvell_nfc_init(nfc);
 	if (ret)
-		goto unprepare_clk;
+		goto unprepare_reg_clk;
 
 	platform_set_drvdata(pdev, nfc);
 
 	ret = marvell_nand_chips_init(dev, nfc);
 	if (ret)
-		goto unprepare_clk;
+		goto unprepare_reg_clk;
 
 	return 0;
 
-unprepare_clk:
+unprepare_reg_clk:
+	clk_disable_unprepare(nfc->reg_clk);
+unprepare_ecc_clk:
 	clk_disable_unprepare(nfc->ecc_clk);
 
 	return ret;
@@ -2796,6 +2817,7 @@ static int marvell_nfc_remove(struct platform_device *pdev)
 		dma_release_channel(nfc->dma_chan);
 	}
 
+	clk_disable_unprepare(nfc->reg_clk);
 	clk_disable_unprepare(nfc->ecc_clk);
 
 	return 0;
-- 
2.16.1
