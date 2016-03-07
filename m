From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:18:19 +0100
Subject: [PATCH 02/16] mtd: nand: sunxi: fix clk rate calculation
In-Reply-To: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457367513-26069-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unlike what is specified in the Allwinner datasheets, the NAND clock rate
is not equal to 2/T but 1/T. Fix the clock rate selection accordingly.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 4d01e65..ab66d8d 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1208,13 +1208,7 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
 	/* Convert min_clk_period from picoseconds to nanoseconds */
 	min_clk_period = DIV_ROUND_UP(min_clk_period, 1000);
 
-	/*
-	 * Convert min_clk_period into a clk frequency, then get the
-	 * appropriate rate for the NAND controller IP given this formula
-	 * (specified in the datasheet):
-	 * nand clk_rate = 2 * min_clk_rate
-	 */
-	chip->clk_rate = (2 * NSEC_PER_SEC) / min_clk_period;
+	chip->clk_rate = NSEC_PER_SEC / min_clk_period;
 
 	return 0;
 }
-- 
2.1.4
