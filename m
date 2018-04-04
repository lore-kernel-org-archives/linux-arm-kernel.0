From: wangxidong_97@163.com (Xidong Wang)
Date: Wed,  4 Apr 2018 11:05:51 +0800
Subject: [PATCH 1/1] mtd:nand:fix memory leak
Message-ID: <1522811151-18853-1-git-send-email-wangxidong_97@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In function tango_nand_probe(), the memory allocated by
clk_get() is not released on the normal path and
the error path that IS_ERR(nfc->chan) returns true.
This will result in a memory leak bug.

Signed-off-by: Xidong Wang <wangxidong_97@163.com>
---
 drivers/mtd/nand/tango_nand.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/tango_nand.c b/drivers/mtd/nand/tango_nand.c
index c5bee00b..8083459 100644
--- a/drivers/mtd/nand/tango_nand.c
+++ b/drivers/mtd/nand/tango_nand.c
@@ -648,12 +648,15 @@ static int tango_nand_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 
 	nfc->chan = dma_request_chan(&pdev->dev, "rxtx");
-	if (IS_ERR(nfc->chan))
+	if (IS_ERR(nfc->chan)) {
+		clk_put(clk);
 		return PTR_ERR(nfc->chan);
+	}
 
 	platform_set_drvdata(pdev, nfc);
 	nand_hw_control_init(&nfc->hw);
 	nfc->freq_kHz = clk_get_rate(clk) / 1000;
+	clk_put(clk);
 
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		err = chip_init(&pdev->dev, np);
-- 
2.7.4
