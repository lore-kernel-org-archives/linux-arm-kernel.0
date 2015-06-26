From: r.spliet@ultimaker.com (Roy Spliet)
Date: Fri, 26 Jun 2015 11:00:10 +0200
Subject: [PATCH v5 1/2] mtd: nand: sunxi: Replace failsafe timing cfg with
 calculated value
Message-ID: <1435309211-15236-1-git-send-email-r.spliet@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TIMING_CFG register was previously statically set to a magic value
(extracted from Allwinner's BSP) when initializing the NAND controller.
Now that we have more details about the TIMING_CFG register layout
(extracted from the A83 user manual) we can dynamically calculate the
appropriate value for each NAND chip and set it when selecting the
chip.

Signed-off-by: Roy Spliet <r.spliet@ultimaker.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

---
V2:
- Fix crippled comments

V3:
- Warn for invalid timings
- Style

V4:
- Make better use of return types
- Style and comments
- Remove superfluous initialisation

V5:
- Tidy up macros
---
 drivers/mtd/nand/sunxi_nand.c | 73 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 6f93b29..663e331 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -99,6 +99,12 @@
 				 NFC_CMD_INT_ENABLE | \
 				 NFC_DMA_INT_ENABLE)
 
+/* define NFC_TIMING_CFG register layout */
+#define NFC_TIMING_CFG(tWB, tADL, tWHR, tRHW, tCAD)		\
+	(((tWB) & 0x3) | (((tADL) & 0x3) << 2) |		\
+	(((tWHR) & 0x3) << 4) | (((tRHW) & 0x3) << 6) |		\
+	(((tCAD) & 0x7) << 8))
+
 /* define bit use in NFC_CMD */
 #define NFC_CMD_LOW_BYTE	GENMASK(7, 0)
 #define NFC_CMD_HIGH_BYTE	GENMASK(15, 8)
@@ -208,6 +214,7 @@ struct sunxi_nand_hw_ecc {
  * @nand:		base NAND chip structure
  * @mtd:		base MTD structure
  * @clk_rate:		clk_rate required for this NAND chip
+ * @timing_cfg		TIMING_CFG register value for this NAND chip
  * @selected:		current active CS
  * @nsels:		number of CS lines required by the NAND chip
  * @sels:		array of CS lines descriptions
@@ -217,6 +224,7 @@ struct sunxi_nand_chip {
 	struct nand_chip nand;
 	struct mtd_info mtd;
 	unsigned long clk_rate;
+	u32 timing_cfg;
 	int selected;
 	int nsels;
 	struct sunxi_nand_chip_sel sels[0];
@@ -403,6 +411,7 @@ static void sunxi_nfc_select_chip(struct mtd_info *mtd, int chip)
 		}
 	}
 
+	writel(sunxi_nand->timing_cfg, nfc->regs + NFC_REG_TIMING_CFG);
 	writel(ctl, nfc->regs + NFC_REG_CTL);
 
 	sunxi_nand->selected = chip;
@@ -807,10 +816,33 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
 	return 0;
 }
 
+static const s32 tWB_lut[] = {6, 12, 16, 20};
+static const s32 tRHW_lut[] = {4, 8, 12, 20};
+
+static int _sunxi_nand_lookup_timing(const s32 *lut, int lut_size, u32 duration,
+		u32 clk_period)
+{
+	u32 clk_cycles = DIV_ROUND_UP(duration, clk_period);
+	int i;
+
+	for (i = 0; i < lut_size; i++) {
+		if (clk_cycles <= lut[i])
+			return i;
+	}
+
+	/* Doesn't fit */
+	return -EINVAL;
+}
+
+#define sunxi_nand_lookup_timing(l, p, c) \
+			_sunxi_nand_lookup_timing(l, ARRAY_SIZE(l), p, c)
+
 static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
 				       const struct nand_sdr_timings *timings)
 {
+	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->nand.controller);
 	u32 min_clk_period = 0;
+	s32 tWB, tADL, tWHR, tRHW, tCAD;
 
 	/* T1 <=> tCLS */
 	if (timings->tCLS_min > min_clk_period)
@@ -872,6 +904,41 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
 	if (timings->tWC_min > (min_clk_period * 2))
 		min_clk_period = DIV_ROUND_UP(timings->tWC_min, 2);
 
+	/* T16 - T19 + tCAD */
+	tWB  = sunxi_nand_lookup_timing(tWB_lut, timings->tWB_max,
+					min_clk_period);
+	if (tWB < 0) {
+		dev_err(nfc->dev, "unsupported tWB\n");
+		return tWB;
+	}
+
+	tADL = DIV_ROUND_UP(timings->tADL_min, min_clk_period) >> 3;
+	if (tADL > 3) {
+		dev_err(nfc->dev, "unsupported tADL\n");
+		return -EINVAL;
+	}
+
+	tWHR = DIV_ROUND_UP(timings->tWHR_min, min_clk_period) >> 3;
+	if (tWHR > 3) {
+		dev_err(nfc->dev, "unsupported tWHR\n");
+		return -EINVAL;
+	}
+
+	tRHW = sunxi_nand_lookup_timing(tRHW_lut, timings->tRHW_min,
+					min_clk_period);
+	if (tRHW < 0) {
+		dev_err(nfc->dev, "unsupported tRHW\n");
+		return tRHW;
+	}
+
+	/*
+	 * TODO: according to ONFI specs this value only applies for DDR NAND,
+	 * but Allwinner seems to set this to 0x7. Mimic them for now.
+	 */
+	tCAD = 0x7;
+
+	/* TODO: A83 has some more bits for CDQSS, CS, CLHZ, CCS, WC */
+	chip->timing_cfg = NFC_TIMING_CFG(tWB, tADL, tWHR, tRHW, tCAD);
 
 	/* Convert min_clk_period from picoseconds to nanoseconds */
 	min_clk_period = DIV_ROUND_UP(min_clk_period, 1000);
@@ -884,8 +951,6 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
 	 */
 	chip->clk_rate = (2 * NSEC_PER_SEC) / min_clk_period;
 
-	/* TODO: configure T16-T19 */
-
 	return 0;
 }
 
@@ -1377,11 +1442,9 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, nfc);
 
 	/*
-	 * TODO: replace these magic values with proper flags as soon as we
-	 * know what they are encoding.
+	 * TODO: replace this magic value with EDO flag
 	 */
 	writel(0x100, nfc->regs + NFC_REG_TIMING_CTL);
-	writel(0x7ff, nfc->regs + NFC_REG_TIMING_CFG);
 
 	ret = sunxi_nand_chips_init(dev, nfc);
 	if (ret) {
-- 
2.4.3


-- 


IMAGINE IT >> MAKE IT

Meet us online at Twitter <http://twitter.com/ultimaker>, Facebook 
<http://facebook.com/ultimaker>, Google+ <http://google.com/+Ultimaker>

www.ultimaker.com
