From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 15:35:14 +0200
Subject: [RFC 17/17] Revert
 "i2c: s3c2410: fix ABBA deadlock by keeping clock prepared"
In-Reply-To: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1471354514-24224-18-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 34e81ad5f0b60007c95995eb7803da7e00c6c611.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Conflicts:
	drivers/i2c/busses/i2c-s3c2410.c
---
 drivers/i2c/busses/i2c-s3c2410.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 38dc1cacfd8b..571250415617 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -771,16 +771,14 @@ static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
 	int retry;
 	int ret;
 
-	ret = clk_enable(i2c->clk);
-	if (ret)
-		return ret;
+	clk_prepare_enable(i2c->clk);
 
 	for (retry = 0; retry < adap->retries; retry++) {
 
 		ret = s3c24xx_i2c_doxfer(i2c, msgs, num);
 
 		if (ret != -EAGAIN) {
-			clk_disable(i2c->clk);
+			clk_disable_unprepare(i2c->clk);
 			return ret;
 		}
 
@@ -789,7 +787,7 @@ static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
 		udelay(100);
 	}
 
-	clk_disable(i2c->clk);
+	clk_disable_unprepare(i2c->clk);
 	return -EREMOTEIO;
 }
 
@@ -1165,7 +1163,7 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	}
 
 	ret = s3c24xx_i2c_init(i2c);
-	clk_disable(i2c->clk);
+	clk_disable_unprepare(i2c->clk);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "I2C controller init failed\n");
 		clk_unprepare(i2c->clk);
@@ -1180,7 +1178,6 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 		i2c->irq = ret = platform_get_irq(pdev, 0);
 		if (ret <= 0) {
 			dev_err(&pdev->dev, "cannot find IRQ\n");
-			clk_unprepare(i2c->clk);
 			return ret;
 		}
 
@@ -1188,7 +1185,6 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 				       0, dev_name(&pdev->dev), i2c);
 		if (ret != 0) {
 			dev_err(&pdev->dev, "cannot claim IRQ %d\n", i2c->irq);
-			clk_unprepare(i2c->clk);
 			return ret;
 		}
 	}
@@ -1196,7 +1192,6 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	ret = s3c24xx_i2c_register_cpufreq(i2c);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register cpufreq notifier\n");
-		clk_unprepare(i2c->clk);
 		return ret;
 	}
 
@@ -1218,7 +1213,6 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to add bus to i2c core\n");
 		pm_runtime_disable(&pdev->dev);
 		s3c24xx_i2c_deregister_cpufreq(i2c);
-		clk_unprepare(i2c->clk);
 		return ret;
 	}
 
@@ -1230,8 +1224,6 @@ static int s3c24xx_i2c_remove(struct platform_device *pdev)
 {
 	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
 
-	clk_unprepare(i2c->clk);
-
 	pm_runtime_disable(&pdev->dev);
 
 	s3c24xx_i2c_deregister_cpufreq(i2c);
@@ -1262,16 +1254,13 @@ static int s3c24xx_i2c_resume_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
-	int ret;
 
 	if (!IS_ERR(i2c->sysreg))
 		regmap_write(i2c->sysreg, EXYNOS5_SYS_I2C_CFG, i2c->sys_i2c_cfg);
 
-	ret = clk_enable(i2c->clk);
-	if (ret)
-		return ret;
+	clk_prepare_enable(i2c->clk);
 	s3c24xx_i2c_init(i2c);
-	clk_disable(i2c->clk);
+	clk_disable_unprepare(i2c->clk);
 	i2c->suspended = 0;
 
 	return 0;
-- 
1.9.1
