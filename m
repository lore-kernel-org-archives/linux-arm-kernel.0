From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Jun 2016 17:07:19 +0200
Subject: [PATCH 01/10] i2c: designware-platdrv: Return error in ->probe() when
 clk ungate fails
In-Reply-To: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1465916848-8207-2-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The error code received from clk_prepare_enable() becomes ignored when
i2c_dw_plat_prepare_clk() is called in ->probe().

Fix this by invoking clk_prepare_enable() in ->probe() instead of
i2c_dw_plat_prepare_clk(), as it allows the error code to be properly
propagated.

A side-effect from this change, makes the i2c_dw_plat_prepare_clk() used
only when CONFIG_PM is set. Avoid the compiler warning by moving the
function within the corresponding #ifdef.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 30 ++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index d656657..e39962b 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -136,18 +136,6 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 }
 #endif
 
-static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
-{
-	if (IS_ERR(i_dev->clk))
-		return PTR_ERR(i_dev->clk);
-
-	if (prepare)
-		return clk_prepare_enable(i_dev->clk);
-
-	clk_disable_unprepare(i_dev->clk);
-	return 0;
-}
-
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -220,7 +208,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
-	if (!i2c_dw_plat_prepare_clk(dev, true)) {
+	if (!IS_ERR(dev->clk)) {
+		r = clk_prepare_enable(dev->clk);
+		if (r)
+			return r;
+
 		dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
 
 		if (!dev->sda_hold_time && ht)
@@ -302,6 +294,18 @@ static void dw_i2c_plat_complete(struct device *dev)
 #endif
 
 #ifdef CONFIG_PM
+static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
+{
+	if (IS_ERR(i_dev->clk))
+		return PTR_ERR(i_dev->clk);
+
+	if (prepare)
+		return clk_prepare_enable(i_dev->clk);
+
+	clk_disable_unprepare(i_dev->clk);
+	return 0;
+}
+
 static int dw_i2c_plat_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-- 
1.9.1
