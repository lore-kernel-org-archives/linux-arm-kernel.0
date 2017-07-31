From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 31 Jul 2017 13:51:07 +0900
Subject: [PATCH 1/2] i2c: uniphier: add PM suspend / resume support
Message-ID: <1501476668-18432-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When resuming, set up registers that have been lost in the sleep state.
Also, add clock handling in the resume / suspend hooks.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier.c | 40 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index 777c0fe93653..f41a09d9927a 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -53,6 +53,7 @@ struct uniphier_i2c_priv {
 	void __iomem *membase;
 	struct clk *clk;
 	unsigned int busy_cnt;
+	unsigned int clk_cycle;
 };
 
 static irqreturn_t uniphier_i2c_interrupt(int irq, void *dev_id)
@@ -316,13 +317,13 @@ static struct i2c_bus_recovery_info uniphier_i2c_bus_recovery_info = {
 	.unprepare_recovery = uniphier_i2c_unprepare_recovery,
 };
 
-static void uniphier_i2c_hw_init(struct uniphier_i2c_priv *priv,
-				 u32 bus_speed, unsigned long clk_rate)
+static void uniphier_i2c_hw_init(struct uniphier_i2c_priv *priv)
 {
+	unsigned int cyc = priv->clk_cycle;
+
 	uniphier_i2c_reset(priv, true);
 
-	writel((clk_rate / bus_speed / 2 << 16) | (clk_rate / bus_speed),
-	       priv->membase + UNIPHIER_I2C_CLK);
+	writel((cyc / 2 << 16) | cyc, priv->membase + UNIPHIER_I2C_CLK);
 
 	uniphier_i2c_reset(priv, false);
 }
@@ -376,6 +377,7 @@ static int uniphier_i2c_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
+	priv->clk_cycle = clk_rate / bus_speed;
 	init_completion(&priv->comp);
 	priv->adap.owner = THIS_MODULE;
 	priv->adap.algo = &uniphier_i2c_algo;
@@ -386,7 +388,7 @@ static int uniphier_i2c_probe(struct platform_device *pdev)
 	i2c_set_adapdata(&priv->adap, priv);
 	platform_set_drvdata(pdev, priv);
 
-	uniphier_i2c_hw_init(priv, bus_speed, clk_rate);
+	uniphier_i2c_hw_init(priv);
 
 	ret = devm_request_irq(dev, irq, uniphier_i2c_interrupt, 0, pdev->name,
 			       priv);
@@ -413,6 +415,33 @@ static int uniphier_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int uniphier_i2c_suspend(struct device *dev)
+{
+	struct uniphier_i2c_priv *priv = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int uniphier_i2c_resume(struct device *dev)
+{
+	struct uniphier_i2c_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	uniphier_i2c_hw_init(priv);
+
+	return 0;
+}
+
+static const struct dev_pm_ops uniphier_i2c_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(uniphier_i2c_suspend, uniphier_i2c_resume)
+};
+
 static const struct of_device_id uniphier_i2c_match[] = {
 	{ .compatible = "socionext,uniphier-i2c" },
 	{ /* sentinel */ }
@@ -425,6 +454,7 @@ static struct platform_driver uniphier_i2c_drv = {
 	.driver = {
 		.name  = "uniphier-i2c",
 		.of_match_table = uniphier_i2c_match,
+		.pm = &uniphier_i2c_pm_ops,
 	},
 };
 module_platform_driver(uniphier_i2c_drv);
-- 
2.7.4
