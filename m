From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue,  1 Aug 2017 17:10:11 +0530
Subject: [PATCH 5/6] mtd: nand: lpc32xx_mlc: Handle return value of
 clk_prepare_enable.
Message-ID: <1501587611-21289-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mtd/nand/lpc32xx_mlc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index 846a66c..91ee3696 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -705,7 +705,9 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 		res = -ENOENT;
 		goto err_exit1;
 	}
-	clk_prepare_enable(host->clk);
+	res = clk_prepare_enable(host->clk);
+	if (res)
+		goto err_exit1;
 
 	nand_chip->cmd_ctrl = lpc32xx_nand_cmd_ctrl;
 	nand_chip->dev_ready = lpc32xx_nand_device_ready;
@@ -846,9 +848,12 @@ static int lpc32xx_nand_remove(struct platform_device *pdev)
 static int lpc32xx_nand_resume(struct platform_device *pdev)
 {
 	struct lpc32xx_nand_host *host = platform_get_drvdata(pdev);
+	int ret;
 
 	/* Re-enable NAND clock */
-	clk_prepare_enable(host->clk);
+	ret = clk_prepare_enable(host->clk);
+	if (ret)
+		return ret;
 
 	/* Fresh init of NAND controller */
 	lpc32xx_nand_setup(host);
-- 
1.9.1
