From: khoroshilov@ispras.ru (Alexey Khoroshilov)
Date: Sat,  9 Sep 2017 01:00:38 +0300
Subject: [PATCH] mtd: oxnas_nand: Fix error handling in oxnas_nand_probe()
Message-ID: <1504908038-26285-1-git-send-email-khoroshilov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

oxnas_nand_probe() does not disable clock on error paths.
The patch adds disabling using devm interface.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/mtd/nand/oxnas_nand.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/oxnas_nand.c b/drivers/mtd/nand/oxnas_nand.c
index 1b207aac840c..8abc69a285dd 100644
--- a/drivers/mtd/nand/oxnas_nand.c
+++ b/drivers/mtd/nand/oxnas_nand.c
@@ -103,16 +103,26 @@ static int oxnas_nand_probe(struct platform_device *pdev)
 	if (IS_ERR(oxnas->io_base))
 		return PTR_ERR(oxnas->io_base);
 
-	oxnas->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(oxnas->clk))
-		oxnas->clk = NULL;
-
 	/* Only a single chip node is supported */
 	count = of_get_child_count(np);
 	if (count > 1)
 		return -EINVAL;
 
-	clk_prepare_enable(oxnas->clk);
+	oxnas->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(oxnas->clk)) {
+		oxnas->clk = NULL;
+	} else {
+		err = clk_prepare_enable(oxnas->clk);
+		if (err)
+			return err;
+
+		err = devm_add_action_or_reset(&pdev->dev,
+				(void(*)(void *))clk_disable_unprepare,
+				oxnas->clk);
+		if (err)
+			return err;
+	}
+
 	device_reset_optional(&pdev->dev);
 
 	for_each_child_of_node(np, nand_np) {
@@ -167,8 +177,6 @@ static int oxnas_nand_remove(struct platform_device *pdev)
 	if (oxnas->chips[0])
 		nand_release(nand_to_mtd(oxnas->chips[0]));
 
-	clk_disable_unprepare(oxnas->clk);
-
 	return 0;
 }
 
-- 
2.7.4
