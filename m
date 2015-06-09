From: r.spliet@ultimaker.com (Roy Spliet)
Date: Tue,  9 Jun 2015 13:27:24 +0200
Subject: [PATCH] mtd: nand: Sunxi calculate timing cfg
Message-ID: <1433849244-2917-1-git-send-email-r.spliet@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Values derived from the A83 user manual

Signed-off-by: Roy Spliet <r.spliet@ultimaker.com>
---
 drivers/mtd/nand/sunxi_nand.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 6f93b29..ec99502 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -194,7 +194,7 @@ struct sunxi_nand_chip_sel {
  *
  * @mode:	the sunxi ECC mode field deduced from ECC requirements
  * @layout:	the OOB layout depending on the ECC requirements and the
- *		selected ECC mode
+ *		ed ECC mode
  */
 struct sunxi_nand_hw_ecc {
 	int mode;
@@ -217,6 +217,7 @@ struct sunxi_nand_chip {
 	struct nand_chip nand;
 	struct mtd_info mtd;
 	unsigned long clk_rate;
+	u32 timing_cfg;
 	int selected;
 	int nsels;
 	struct sunxi_nand_chip_sel sels[0];
@@ -403,6 +404,7 @@ static void sunxi_nfc_select_chip(struct mtd_info *mtd, int chip)
 		}
 	}
 
+	writel(sunxi_nand->timing_cfg, nfc->regs + NFC_REG_TIMING_CFG);
 	writel(ctl, nfc->regs + NFC_REG_CTL);
 
 	sunxi_nand->selected = chip;
@@ -807,10 +809,28 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 	return 0;
 }
 
+static const s32 tWB_lut[]  = {6, 12, 16, 20, -1};
+static const s32 tRHW_lut[] = {4,  8, 12, 20, -1};
+
+static s32 sunxi_nand_lookup_timing(const s32 *lut, u32 period, u32 clk_period)
+{
+	u32 clks = (period + clk_period - 1) / clk_period;
+	int i;
+
+	for (i = 0; lut[i] != -1; i++) {
+		if (clks <= lut[i])
+			return i;
+	}
+
+	/* Return max value */
+	return i - 1;
+}
+
 static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
 				       const struct nand_sdr_timings *timings)
 {
 	u32 min_clk_period = 0;
+	u32 tWB, tADL, tWHR, tRHW, tCAD;
 
 	/* T1 <=> tCLS */
 	if (timings->tCLS_min > min_clk_period)
@@ -872,6 +892,20 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
 	if (timings->tWC_min > (min_clk_period * 2))
 		min_clk_period = DIV_ROUND_UP(timings->tWC_min, 2);
 
+	/* T16 - T19 + tCAD */
+	tWB  = sunxi_nand_lookup_timing(tWB_lut, timings->tWB_max,
+			min_clk_period);
+	tADL = DIV_ROUND_UP(timings->tADL_min, min_clk_period) >> 3;
+	tWHR = DIV_ROUND_UP(timings->tWHR_min, min_clk_period) >> 3;
+	tRHW = sunxi_nand_lookup_timing(tRHW_lut, timings->tRHW_min,
+			min_clk_period);
+	tCAD = 0x7;
+	chip->timing_cfg = (tWB & 0x3) |
+			   (tADL & 0x3) << 2 |
+			   (tWHR & 0x3) << 4 |
+			   (tRHW & 0x3) << 6 |
+			   (tCAD & 0x7) << 8;
+	/* \todo A83 has some more bits for CDQSS, CS, CLHZ, CCS, WC */
 
 	/* Convert min_clk_period from picoseconds to nanoseconds */
 	min_clk_period = DIV_ROUND_UP(min_clk_period, 1000);
@@ -884,8 +918,6 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
 	 */
 	chip->clk_rate = (2 * NSEC_PER_SEC) / min_clk_period;
 
-	/* TODO: configure T16-T19 */
-
 	return 0;
 }
 
@@ -1168,6 +1200,7 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 
 	chip->nsels = nsels;
 	chip->selected = -1;
+	chip->timing_cfg = 0x7ff;
 
 	for (i = 0; i < nsels; i++) {
 		ret = of_property_read_u32_index(np, "reg", i, &tmp);
@@ -1377,11 +1410,9 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, nfc);
 
 	/*
-	 * TODO: replace these magic values with proper flags as soon as we
-	 * know what they are encoding.
+	 * TODO: replace this magic values with EDO flag
 	 */
 	writel(0x100, nfc->regs + NFC_REG_TIMING_CTL);
-	writel(0x7ff, nfc->regs + NFC_REG_TIMING_CFG);
 
 	ret = sunxi_nand_chips_init(dev, nfc);
 	if (ret) {
-- 
2.4.2


-- 


IMAGINE IT >> MAKE IT

Meet us online at Twitter <http://twitter.com/ultimaker>, Facebook 
<http://facebook.com/ultimaker>, Google+ <http://google.com/+Ultimaker>

www.ultimaker.com
