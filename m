From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Sat, 16 Apr 2016 21:14:52 -0400
Subject: [PATCH v2 1/2] i2c: exynos5: Check clk_prepare_enable() return value
Message-ID: <1460855693-28225-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_prepare_enable() function can fail so check the return value
and propagate the error to the caller in case of a failure.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

Changes in v2: None

 drivers/i2c/busses/i2c-exynos5.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index b29c7500461a..ebbcba3de20a 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -671,7 +671,9 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
 		return -EIO;
 	}
 
-	clk_prepare_enable(i2c->clk);
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < num; i++, msgs++) {
 		stop = (i == num - 1);
@@ -747,7 +749,9 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	clk_prepare_enable(i2c->clk);
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret)
+		return ret;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i2c->regs = devm_ioremap_resource(&pdev->dev, mem);
@@ -830,7 +834,9 @@ static int exynos5_i2c_resume_noirq(struct device *dev)
 	struct exynos5_i2c *i2c = platform_get_drvdata(pdev);
 	int ret = 0;
 
-	clk_prepare_enable(i2c->clk);
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret)
+		return ret;
 
 	ret = exynos5_hsi2c_clock_setup(i2c);
 	if (ret) {
-- 
2.5.5
