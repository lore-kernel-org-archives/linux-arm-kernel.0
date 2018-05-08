From: mine260309@gmail.com (Lei YU)
Date: Tue,  8 May 2018 17:39:27 +0800
Subject: [PATCH] hwmon: (aspeed-pwm-tacho) Use 24MHz clock
Message-ID: <1525772367-20627-1-git-send-email-mine260309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock source for aspeed pwm is set to 24MHz, so use the hard-coded
clock frequency instead of the one in device tree.

Otherwise, in case of the clock specified in device tree is not 24MHz,
the fan speed will be incorrect.

Signed-off-by: Lei YU <mine260309@gmail.com>
---
 drivers/hwmon/aspeed-pwm-tacho.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 693a3d5..e83b8df 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -922,7 +922,6 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
 	void __iomem *regs;
 	struct resource *res;
 	struct device *hwmon;
-	struct clk *clk;
 	int ret;
 
 	np = dev->of_node;
@@ -956,12 +955,10 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
 	regmap_write(priv->regmap, ASPEED_PTCR_TACH_SOURCE, 0);
 	regmap_write(priv->regmap, ASPEED_PTCR_TACH_SOURCE_EXT, 0);
 
-	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk))
-		return -ENODEV;
-	priv->clk_freq = clk_get_rate(clk);
 	aspeed_set_clock_enable(priv->regmap, true);
+	// The clock source is set to 24MHz
 	aspeed_set_clock_source(priv->regmap, 0);
+	priv->clk_freq = 24000000;
 
 	aspeed_create_type(priv);
 
-- 
2.7.4
