From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Thu, 19 Apr 2018 16:05:35 +0200
Subject: [PATCH 05/61] clk: samsung: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Message-ID: <20180419140641.27926-6-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/clk/samsung/clk-s3c2410-dclk.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
index 077df3e539a7..f41d89cef0f1 100644
--- a/drivers/clk/samsung/clk-s3c2410-dclk.c
+++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
@@ -219,8 +219,7 @@ static int s3c24xx_dclk1_div_notify(struct notifier_block *nb,
 #ifdef CONFIG_PM_SLEEP
 static int s3c24xx_dclk_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct s3c24xx_dclk *s3c24xx_dclk = platform_get_drvdata(pdev);
+	struct s3c24xx_dclk *s3c24xx_dclk = dev_get_drvdata(dev);
 
 	s3c24xx_dclk->reg_save = readl_relaxed(s3c24xx_dclk->base);
 	return 0;
@@ -228,8 +227,7 @@ static int s3c24xx_dclk_suspend(struct device *dev)
 
 static int s3c24xx_dclk_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct s3c24xx_dclk *s3c24xx_dclk = platform_get_drvdata(pdev);
+	struct s3c24xx_dclk *s3c24xx_dclk = dev_get_drvdata(dev);
 
 	writel_relaxed(s3c24xx_dclk->reg_save, s3c24xx_dclk->base);
 	return 0;
-- 
2.11.0
