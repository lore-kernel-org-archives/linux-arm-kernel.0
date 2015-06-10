From: r.spliet@ultimaker.com (Roy Spliet)
Date: Wed, 10 Jun 2015 10:29:08 +0200
Subject: [PATCH v3 2/2] mtd: nand: sunxi: Set serial access mode correctly
In-Reply-To: <1433924948-19288-1-git-send-email-r.spliet@ultimaker.com>
References: <1433924948-19288-1-git-send-email-r.spliet@ultimaker.com>
Message-ID: <1433924948-19288-2-git-send-email-r.spliet@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replaces the hard coded "always use EDO" policy with that prescribed
by the ONFI 3.1 specification that EDO mode should always be used if tRC
is below 30ns.

Signed-off-by: Roy Spliet <r.spliet@ultimaker.com>
---
 drivers/mtd/nand/sunxi_nand.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 68090b7..d98e98c 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -99,6 +99,9 @@
 				 NFC_CMD_INT_ENABLE | \
 				 NFC_DMA_INT_ENABLE)
 
+/* define bit use in NFC_TIMING_CTL */
+#define NFC_TIMING_CTL_EDO	BIT(8)
+
 /* define bit use in NFC_TIMING_CFG */
 #define NFC_TIMING_CFG(tWB, tADL, tWHR, tRHW, tCAD)		\
 	((tWB) & 0x3) | (((tADL) & 0x3) << 2) |			\
@@ -226,6 +229,7 @@ struct sunxi_nand_chip {
 	struct mtd_info mtd;
 	unsigned long clk_rate;
 	u32 timing_cfg;
+	int serial_mode_edo;
 	int selected;
 	int nsels;
 	struct sunxi_nand_chip_sel sels[0];
@@ -380,7 +384,7 @@ static void sunxi_nfc_select_chip(struct mtd_info *mtd, int chip)
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct sunxi_nand_chip_sel *sel;
-	u32 ctl;
+	u32 ctl, timing_ctl;
 
 	if (chip > 0 && chip >= sunxi_nand->nsels)
 		return;
@@ -412,6 +416,9 @@ static void sunxi_nfc_select_chip(struct mtd_info *mtd, int chip)
 		}
 	}
 
+	timing_ctl = sunxi_nand->serial_mode_edo ? NFC_TIMING_CTL_EDO : 0;
+
+	writel(timing_ctl, nfc->regs + NFC_REG_TIMING_CTL);
 	writel(sunxi_nand->timing_cfg, nfc->regs + NFC_REG_TIMING_CFG);
 	writel(ctl, nfc->regs + NFC_REG_CTL);
 
@@ -937,6 +944,13 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
 	/* TODO: A83 has some more bits for CDQSS, CS, CLHZ, CCS, WC */
 	chip->timing_cfg = NFC_TIMING_CFG(tWB, tADL, tWHR, tRHW, tCAD);
 
+	/*
+	 * ONFI specification 3.1, paragraph 4.15.2 dictates that EDO data
+	 * output cycle timings shall be used if the host drives tRC less than
+	 * 30 ns.
+	 */
+	chip->serial_mode_edo = (timings->tRC_min < 30000);
+
 	/* Convert min_clk_period from picoseconds to nanoseconds */
 	min_clk_period = DIV_ROUND_UP(min_clk_period, 1000);
 
@@ -1439,11 +1453,6 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, nfc);
 
-	/*
-	 * TODO: replace this magic value with EDO flag
-	 */
-	writel(0x100, nfc->regs + NFC_REG_TIMING_CTL);
-
 	ret = sunxi_nand_chips_init(dev, nfc);
 	if (ret) {
 		dev_err(dev, "failed to init nand chips\n");
-- 
2.4.2


-- 


IMAGINE IT >> MAKE IT

Meet us online at Twitter <http://twitter.com/ultimaker>, Facebook 
<http://facebook.com/ultimaker>, Google+ <http://google.com/+Ultimaker>

www.ultimaker.com
