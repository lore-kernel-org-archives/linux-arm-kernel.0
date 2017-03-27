From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 27 Mar 2017 20:02:08 +0200
Subject: [PATCH v2 2/2] mtd: nand: orion: improve handling of optional clock
In-Reply-To: <20170327180208.13414-1-gmbnomis@gmail.com>
References: <20170327180208.13414-1-gmbnomis@gmail.com>
Message-ID: <20170327180208.13414-2-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock gate used by orion_nand is not available on all platforms.
When getting this optional clock gate, the code masked all errors.
Let's be more precise here and actually only allow ENOENT.

EPROBE_DEFER is handled like any other error code since probe deferral
is not supported by drivers using module_platform_driver_probe().

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---

Changes in v2:
* added patch

 drivers/mtd/nand/orion_nand.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index 3acdc20485f1..f8e463a97b9e 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -156,8 +156,17 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 	/* Not all platforms can gate the clock, so it is not
 	   an error if the clock does not exists. */
 	info->clk = devm_clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(info->clk))
-		clk_prepare_enable(info->clk);
+	if (IS_ERR(info->clk)) {
+		ret = PTR_ERR(info->clk);
+		if (ret == -ENOENT) {
+			info->clk = NULL;
+		} else {
+			dev_err(&pdev->dev, "failed to get clock!\n");
+			return ret;
+		}
+	}
+
+	clk_prepare_enable(info->clk);
 
 	ret = nand_scan(mtd, 1);
 	if (ret)
@@ -173,9 +182,7 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 	return 0;
 
 no_dev:
-	if (!IS_ERR(info->clk))
-		clk_disable_unprepare(info->clk);
-
+	clk_disable_unprepare(info->clk);
 	return ret;
 }
 
@@ -187,8 +194,7 @@ static int orion_nand_remove(struct platform_device *pdev)
 
 	nand_release(mtd);
 
-	if (!IS_ERR(info->clk))
-		clk_disable_unprepare(info->clk);
+	clk_disable_unprepare(info->clk);
 
 	return 0;
 }
-- 
2.9.3
