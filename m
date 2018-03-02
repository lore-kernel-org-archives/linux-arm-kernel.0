From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:16 +0100
Subject: [PATCH 08/52] mtd: rawnand: davinci: fix probe function error path
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-9-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An error after nand_scan_tail() should trigger a nand_release().
The helper mtd_device_register() returns an error code that should
be checked and nand_release() called accordingly.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/davinci_nand.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index ccc8c43abcff..b5c107f8dc53 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -826,7 +826,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	else
 		ret = mtd_device_register(mtd, NULL, 0);
 	if (ret < 0)
-		goto err;
+		goto release_nand;
 
 	val = davinci_nand_readl(info, NRCSR_OFFSET);
 	dev_info(&pdev->dev, "controller rev. %d.%d\n",
@@ -834,14 +834,16 @@ static int nand_davinci_probe(struct platform_device *pdev)
 
 	return 0;
 
+release_nand:
+	nand_release(mtd);
 err:
 	clk_disable_unprepare(info->clk);
-
 err_clk_enable:
 	spin_lock_irq(&davinci_nand_lock);
 	if (info->chip.ecc.mode == NAND_ECC_HW_SYNDROME)
 		ecc4_busy = false;
 	spin_unlock_irq(&davinci_nand_lock);
+
 	return ret;
 }
 
-- 
2.14.1
