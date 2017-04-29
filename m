From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 29 Apr 2017 10:52:36 +0200
Subject: [PATCH v2 3/3] mtd: nand: fsmc: remove default timings
In-Reply-To: <1493455956-18362-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1493455956-18362-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1493455956-18362-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When timings are no longer provided by the Device Tree, we now use the
SDR timings specified by the NAND flash, and such SDR timings are always
provided. Therefore, it is no longer necessary to keep "default" timings
in the fmsc driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/mtd/nand/fsmc_nand.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 442e4df..f58c912 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -303,26 +303,12 @@ static void fsmc_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
  * FSMC registers
  */
 static void fsmc_nand_setup(struct fsmc_nand_data *host,
-			    struct fsmc_nand_timings *timings)
+			    struct fsmc_nand_timings *tims)
 {
 	uint32_t value = FSMC_DEVTYPE_NAND | FSMC_ENABLE | FSMC_WAITON;
 	uint32_t tclr, tar, thiz, thold, twait, tset;
 	unsigned int bank = host->bank;
 	void __iomem *regs = host->regs_va;
-	struct fsmc_nand_timings *tims;
-	struct fsmc_nand_timings default_timings = {
-		.tclr	= FSMC_TCLR_1,
-		.tar	= FSMC_TAR_1,
-		.thiz	= FSMC_THIZ_1,
-		.thold	= FSMC_THOLD_4,
-		.twait	= FSMC_TWAIT_6,
-		.tset	= FSMC_TSET_0,
-	};
-
-	if (timings)
-		tims = host->dev_timings;
-	else
-		tims = &default_timings;
 
 	tclr = (tims->tclr & FSMC_TCLR_MASK) << FSMC_TCLR_SHIFT;
 	tar = (tims->tar & FSMC_TAR_MASK) << FSMC_TAR_SHIFT;
-- 
2.7.4
