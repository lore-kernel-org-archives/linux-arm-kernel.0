From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:18:20 +0100
Subject: [PATCH 03/16] mtd: nand: sunxi: fix EDO mode selection
In-Reply-To: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457367513-26069-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ONFI spec says that EDO should be enabled if the host drives tRC less
than 30ns, but the code just tests for the tRC_min value extracted from
the timings exposed by the NAND chip not the timings actually configured
in the NAND controller.
Fix that by first rounding down the requested clk_rate with
clk_round_rate() and then checking if tRC is actually smaller than 30ns.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index ab66d8d..a270720 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1101,6 +1101,7 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
 	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->nand.controller);
 	u32 min_clk_period = 0;
 	s32 tWB, tADL, tWHR, tRHW, tCAD;
+	long real_clk_rate;
 
 	/* T1 <=> tCLS */
 	if (timings->tCLS_min > min_clk_period)
@@ -1198,17 +1199,20 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
 	/* TODO: A83 has some more bits for CDQSS, CS, CLHZ, CCS, WC */
 	chip->timing_cfg = NFC_TIMING_CFG(tWB, tADL, tWHR, tRHW, tCAD);
 
+	/* Convert min_clk_period from picoseconds to nanoseconds */
+	min_clk_period = DIV_ROUND_UP(min_clk_period, 1000);
+
+	chip->clk_rate = NSEC_PER_SEC / min_clk_period;
+	real_clk_rate = clk_round_rate(nfc->mod_clk, chip->clk_rate);
+
 	/*
 	 * ONFI specification 3.1, paragraph 4.15.2 dictates that EDO data
 	 * output cycle timings shall be used if the host drives tRC less than
 	 * 30 ns.
 	 */
-	chip->timing_ctl = (timings->tRC_min < 30000) ? NFC_TIMING_CTL_EDO : 0;
-
-	/* Convert min_clk_period from picoseconds to nanoseconds */
-	min_clk_period = DIV_ROUND_UP(min_clk_period, 1000);
-
-	chip->clk_rate = NSEC_PER_SEC / min_clk_period;
+	min_clk_period = NSEC_PER_SEC / real_clk_rate;
+	chip->timing_ctl = ((min_clk_period * 2) < 30) ?
+			   NFC_TIMING_CTL_EDO : 0;
 
 	return 0;
 }
-- 
2.1.4
