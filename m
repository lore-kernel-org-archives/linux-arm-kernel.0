From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 31 Jul 2017 13:51:08 +0900
Subject: [PATCH 2/2] i2c: uniphier-f: add PM suspend / resume support
In-Reply-To: <1501476668-18432-1-git-send-email-yamada.masahiro@socionext.com>
References: <1501476668-18432-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1501476668-18432-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When resuming, set up registers that have been lost in the sleep state.
Also, add clock handling in the resume / suspend hooks.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 46 +++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index beee31892295..74cf0752bbd0 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -97,6 +97,7 @@ struct uniphier_fi2c_priv {
 	int error;
 	unsigned int flags;
 	unsigned int busy_cnt;
+	unsigned int clk_cycle;
 };
 
 static void uniphier_fi2c_fill_txfifo(struct uniphier_fi2c_priv *priv,
@@ -461,9 +462,9 @@ static struct i2c_bus_recovery_info uniphier_fi2c_bus_recovery_info = {
 	.unprepare_recovery = uniphier_fi2c_unprepare_recovery,
 };
 
-static void uniphier_fi2c_hw_init(struct uniphier_fi2c_priv *priv,
-				  u32 bus_speed, unsigned long clk_rate)
+static void uniphier_fi2c_hw_init(struct uniphier_fi2c_priv *priv)
 {
+	unsigned int cyc = priv->clk_cycle;
 	u32 tmp;
 
 	tmp = readl(priv->membase + UNIPHIER_FI2C_CR);
@@ -472,12 +473,10 @@ static void uniphier_fi2c_hw_init(struct uniphier_fi2c_priv *priv,
 
 	uniphier_fi2c_reset(priv);
 
-	tmp = clk_rate / bus_speed;
-
-	writel(tmp, priv->membase + UNIPHIER_FI2C_CYC);
-	writel(tmp / 2, priv->membase + UNIPHIER_FI2C_LCTL);
-	writel(tmp / 2, priv->membase + UNIPHIER_FI2C_SSUT);
-	writel(tmp / 16, priv->membase + UNIPHIER_FI2C_DSUT);
+	writel(cyc, priv->membase + UNIPHIER_FI2C_CYC);
+	writel(cyc / 2, priv->membase + UNIPHIER_FI2C_LCTL);
+	writel(cyc / 2, priv->membase + UNIPHIER_FI2C_SSUT);
+	writel(cyc / 16, priv->membase + UNIPHIER_FI2C_DSUT);
 
 	uniphier_fi2c_prepare_operation(priv);
 }
@@ -531,6 +530,7 @@ static int uniphier_fi2c_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
+	priv->clk_cycle = clk_rate / bus_speed;
 	init_completion(&priv->comp);
 	priv->adap.owner = THIS_MODULE;
 	priv->adap.algo = &uniphier_fi2c_algo;
@@ -541,7 +541,7 @@ static int uniphier_fi2c_probe(struct platform_device *pdev)
 	i2c_set_adapdata(&priv->adap, priv);
 	platform_set_drvdata(pdev, priv);
 
-	uniphier_fi2c_hw_init(priv, bus_speed, clk_rate);
+	uniphier_fi2c_hw_init(priv);
 
 	ret = devm_request_irq(dev, irq, uniphier_fi2c_interrupt, 0,
 			       pdev->name, priv);
@@ -568,6 +568,33 @@ static int uniphier_fi2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int uniphier_fi2c_suspend(struct device *dev)
+{
+	struct uniphier_fi2c_priv *priv = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int uniphier_fi2c_resume(struct device *dev)
+{
+	struct uniphier_fi2c_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	uniphier_fi2c_hw_init(priv);
+
+	return 0;
+}
+
+static const struct dev_pm_ops uniphier_fi2c_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(uniphier_fi2c_suspend, uniphier_fi2c_resume)
+};
+
 static const struct of_device_id uniphier_fi2c_match[] = {
 	{ .compatible = "socionext,uniphier-fi2c" },
 	{ /* sentinel */ }
@@ -580,6 +607,7 @@ static struct platform_driver uniphier_fi2c_drv = {
 	.driver = {
 		.name  = "uniphier-fi2c",
 		.of_match_table = uniphier_fi2c_match,
+		.pm = &uniphier_fi2c_pm_ops,
 	},
 };
 module_platform_driver(uniphier_fi2c_drv);
-- 
2.7.4
