From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun, 12 Mar 2017 22:34:06 +0100
Subject: [PATCH] mtd: nand: orion: fix clk handling
Message-ID: <20170312213406.20987-1-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk handling in orion_nand.c had two problems:

- In the probe function, clk_put() was called for an enabled clock,
  which violates the API (see documentation for clk_put() in
  include/linux/clk.h)

- In the error path of the probe function, clk_put() could be called
  twice for the same clock.

In order to clean this up, use the managed function devm_clk_get() and
store the pointer to the clk in the driver data.

Fixes: baffab28b13120694fa3ebab08d3e99667a851d2 ('ARM: Orion: fix driver probe error handling with respect to clk')
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 drivers/mtd/nand/orion_nand.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index 4a91c5d000be..b355aa738fae 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -23,6 +23,11 @@
 #include <asm/sizes.h>
 #include <linux/platform_data/mtd-orion_nand.h>
 
+struct orion_nand_info {
+	struct nand_chip chip;
+	struct clk       *clk;
+};
+
 static void orion_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
 	struct nand_chip *nc = mtd_to_nand(mtd);
@@ -75,20 +80,21 @@ static void orion_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 
 static int __init orion_nand_probe(struct platform_device *pdev)
 {
+	struct orion_nand_info *info;
 	struct mtd_info *mtd;
 	struct nand_chip *nc;
 	struct orion_nand_data *board;
 	struct resource *res;
-	struct clk *clk;
 	void __iomem *io_base;
 	int ret = 0;
 	u32 val = 0;
 
-	nc = devm_kzalloc(&pdev->dev,
-			sizeof(struct nand_chip),
+	info = devm_kzalloc(&pdev->dev,
+			sizeof(struct orion_nand_info),
 			GFP_KERNEL);
-	if (!nc)
+	if (!info)
 		return -ENOMEM;
+	nc = &info->chip;
 	mtd = nand_to_mtd(nc);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -145,15 +151,13 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 	if (board->dev_ready)
 		nc->dev_ready = board->dev_ready;
 
-	platform_set_drvdata(pdev, mtd);
+	platform_set_drvdata(pdev, info);
 
 	/* Not all platforms can gate the clock, so it is not
 	   an error if the clock does not exists. */
-	clk = clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(clk)) {
-		clk_prepare_enable(clk);
-		clk_put(clk);
-	}
+	info->clk = devm_clk_get(&pdev->dev, NULL);
+	if (!IS_ERR(info->clk))
+		clk_prepare_enable(info->clk);
 
 	ret = nand_scan(mtd, 1);
 	if (ret)
@@ -169,26 +173,22 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 	return 0;
 
 no_dev:
-	if (!IS_ERR(clk)) {
-		clk_disable_unprepare(clk);
-		clk_put(clk);
-	}
+	if (!IS_ERR(info->clk))
+		clk_disable_unprepare(info->clk);
 
 	return ret;
 }
 
 static int orion_nand_remove(struct platform_device *pdev)
 {
-	struct mtd_info *mtd = platform_get_drvdata(pdev);
-	struct clk *clk;
+	struct orion_nand_info *info = platform_get_drvdata(pdev);
+	struct nand_chip *chip = &info->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	nand_release(mtd);
 
-	clk = clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(clk)) {
-		clk_disable_unprepare(clk);
-		clk_put(clk);
-	}
+	if (!IS_ERR(info->clk))
+		clk_disable_unprepare(info->clk);
 
 	return 0;
 }
-- 
2.9.3
