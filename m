From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 28 Jul 2017 01:16:24 +0900
Subject: [PATCH] i2c: use dev_get_drvdata() to get private data in
 suspend/resume hooks
Message-ID: <1501172184-17102-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several drivers call to_platform_device() to get platform_device
and pass it to platform_get_drvdata().  In platform_get_drvdata(),
the platform_device is converted back to struct device again.

Use dev_get_drvdata() to avoid platform_device/device dance.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-bcm-iproc.c          | 6 ++----
 drivers/i2c/busses/i2c-cadence.c            | 6 ++----
 drivers/i2c/busses/i2c-davinci.c            | 6 ++----
 drivers/i2c/busses/i2c-designware-platdrv.c | 6 ++----
 drivers/i2c/busses/i2c-exynos5.c            | 6 ++----
 drivers/i2c/busses/i2c-hix5hd2.c            | 6 ++----
 drivers/i2c/busses/i2c-lpc2k.c              | 6 ++----
 drivers/i2c/busses/i2c-mv64xxx.c            | 3 +--
 drivers/i2c/busses/i2c-pxa.c                | 6 ++----
 drivers/i2c/busses/i2c-s3c2410.c            | 6 ++----
 drivers/i2c/busses/i2c-sirf.c               | 6 ++----
 drivers/i2c/busses/i2c-st.c                 | 3 +--
 drivers/i2c/busses/i2c-xiic.c               | 6 ++----
 13 files changed, 24 insertions(+), 48 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 318df559adc5..4c8c3bc4669c 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -510,8 +510,7 @@ static int bcm_iproc_i2c_remove(struct platform_device *pdev)
 
 static int bcm_iproc_i2c_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct bcm_iproc_i2c_dev *iproc_i2c = platform_get_drvdata(pdev);
+	struct bcm_iproc_i2c_dev *iproc_i2c = dev_get_drvdata(dev);
 
 	/* make sure there's no pending interrupt when we go into suspend */
 	writel(0, iproc_i2c->base + IE_OFFSET);
@@ -526,8 +525,7 @@ static int bcm_iproc_i2c_suspend(struct device *dev)
 
 static int bcm_iproc_i2c_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct bcm_iproc_i2c_dev *iproc_i2c = platform_get_drvdata(pdev);
+	struct bcm_iproc_i2c_dev *iproc_i2c = dev_get_drvdata(dev);
 	int ret;
 	u32 val;
 
diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 75d80161931f..b13605718291 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -826,8 +826,7 @@ static int cdns_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
  */
 static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct cdns_i2c *xi2c = platform_get_drvdata(pdev);
+	struct cdns_i2c *xi2c = dev_get_drvdata(dev);
 
 	clk_disable(xi2c->clk);
 
@@ -844,8 +843,7 @@ static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
  */
 static int __maybe_unused cdns_i2c_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct cdns_i2c *xi2c = platform_get_drvdata(pdev);
+	struct cdns_i2c *xi2c = dev_get_drvdata(dev);
 	int ret;
 
 	ret = clk_enable(xi2c->clk);
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 9e7ef5cf5d49..9163a1c9bddc 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -876,8 +876,7 @@ static int davinci_i2c_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int davinci_i2c_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct davinci_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
+	struct davinci_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 
 	/* put I2C into reset */
 	davinci_i2c_reset_ctrl(i2c_dev, 0);
@@ -888,8 +887,7 @@ static int davinci_i2c_suspend(struct device *dev)
 
 static int davinci_i2c_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct davinci_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
+	struct davinci_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 
 	clk_prepare_enable(i2c_dev->clk);
 	/* take I2C out of reset */
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 2ea6d0d25a01..abe1eca8d689 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -428,8 +428,7 @@ static void dw_i2c_plat_complete(struct device *dev)
 #ifdef CONFIG_PM
 static int dw_i2c_plat_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
 	i_dev->disable(i_dev);
 	i2c_dw_plat_prepare_clk(i_dev, false);
@@ -439,8 +438,7 @@ static int dw_i2c_plat_suspend(struct device *dev)
 
 static int dw_i2c_plat_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
 	i2c_dw_plat_prepare_clk(i_dev, true);
 	i_dev->init(i_dev);
diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index 23ed4d67ecad..3855e0b11877 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -803,8 +803,7 @@ static int exynos5_i2c_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int exynos5_i2c_suspend_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct exynos5_i2c *i2c = platform_get_drvdata(pdev);
+	struct exynos5_i2c *i2c = dev_get_drvdata(dev);
 
 	i2c->suspended = 1;
 
@@ -815,8 +814,7 @@ static int exynos5_i2c_suspend_noirq(struct device *dev)
 
 static int exynos5_i2c_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct exynos5_i2c *i2c = platform_get_drvdata(pdev);
+	struct exynos5_i2c *i2c = dev_get_drvdata(dev);
 	int ret = 0;
 
 	ret = clk_prepare_enable(i2c->clk);
diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index ae7f3180f7e8..bb68957d3da5 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -505,8 +505,7 @@ static int hix5hd2_i2c_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int hix5hd2_i2c_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct hix5hd2_i2c_priv *priv = platform_get_drvdata(pdev);
+	struct hix5hd2_i2c_priv *priv = dev_get_drvdata(dev);
 
 	clk_disable_unprepare(priv->clk);
 
@@ -515,8 +514,7 @@ static int hix5hd2_i2c_runtime_suspend(struct device *dev)
 
 static int hix5hd2_i2c_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct hix5hd2_i2c_priv *priv = platform_get_drvdata(pdev);
+	struct hix5hd2_i2c_priv *priv = dev_get_drvdata(dev);
 
 	clk_prepare_enable(priv->clk);
 	hix5hd2_i2c_init(priv);
diff --git a/drivers/i2c/busses/i2c-lpc2k.c b/drivers/i2c/busses/i2c-lpc2k.c
index 9b1fef455a89..59167c018ae7 100644
--- a/drivers/i2c/busses/i2c-lpc2k.c
+++ b/drivers/i2c/busses/i2c-lpc2k.c
@@ -457,8 +457,7 @@ static int i2c_lpc2k_remove(struct platform_device *dev)
 #ifdef CONFIG_PM
 static int i2c_lpc2k_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct lpc2k_i2c *i2c = platform_get_drvdata(pdev);
+	struct lpc2k_i2c *i2c = dev_get_drvdata(dev);
 
 	clk_disable(i2c->clk);
 
@@ -467,8 +466,7 @@ static int i2c_lpc2k_suspend(struct device *dev)
 
 static int i2c_lpc2k_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct lpc2k_i2c *i2c = platform_get_drvdata(pdev);
+	struct lpc2k_i2c *i2c = dev_get_drvdata(dev);
 
 	clk_enable(i2c->clk);
 	i2c_lpc2k_reset(i2c);
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 5c4db65c5019..b2ef32b188e1 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -975,8 +975,7 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 #ifdef CONFIG_PM
 static int mv64xxx_i2c_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct mv64xxx_i2c_data *drv_data = platform_get_drvdata(pdev);
+	struct mv64xxx_i2c_data *drv_data = dev_get_drvdata(dev);
 
 	mv64xxx_i2c_hw_init(drv_data);
 
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 6cf333ecc8b8..600d264e080c 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1346,8 +1346,7 @@ static int i2c_pxa_remove(struct platform_device *dev)
 #ifdef CONFIG_PM
 static int i2c_pxa_suspend_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
+	struct pxa_i2c *i2c = dev_get_drvdata(dev);
 
 	clk_disable(i2c->clk);
 
@@ -1356,8 +1355,7 @@ static int i2c_pxa_suspend_noirq(struct device *dev)
 
 static int i2c_pxa_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
+	struct pxa_i2c *i2c = dev_get_drvdata(dev);
 
 	clk_enable(i2c->clk);
 	i2c_pxa_reset(i2c);
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 499af26e736e..5d97510ee48b 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -1246,8 +1246,7 @@ static int s3c24xx_i2c_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int s3c24xx_i2c_suspend_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
+	struct s3c24xx_i2c *i2c = dev_get_drvdata(dev);
 
 	i2c->suspended = 1;
 
@@ -1259,8 +1258,7 @@ static int s3c24xx_i2c_suspend_noirq(struct device *dev)
 
 static int s3c24xx_i2c_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
+	struct s3c24xx_i2c *i2c = dev_get_drvdata(dev);
 	int ret;
 
 	if (!IS_ERR(i2c->sysreg))
diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 95e81d0f72b4..2fd8b6d00391 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -421,8 +421,7 @@ static int i2c_sirfsoc_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int i2c_sirfsoc_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
+	struct i2c_adapter *adapter = dev_get_drvdata(dev);
 	struct sirfsoc_i2c *siic = adapter->algo_data;
 
 	clk_enable(siic->clk);
@@ -434,8 +433,7 @@ static int i2c_sirfsoc_suspend(struct device *dev)
 
 static int i2c_sirfsoc_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
+	struct i2c_adapter *adapter = dev_get_drvdata(dev);
 	struct sirfsoc_i2c *siic = adapter->algo_data;
 
 	clk_enable(siic->clk);
diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 1eb9fa82dcfd..9e62f893958a 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -745,8 +745,7 @@ static int st_i2c_xfer(struct i2c_adapter *i2c_adap,
 #ifdef CONFIG_PM_SLEEP
 static int st_i2c_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct st_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
+	struct st_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 
 	if (i2c_dev->busy)
 		return -EBUSY;
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 66bce3b311a1..34b27bfe72ba 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -853,8 +853,7 @@ MODULE_DEVICE_TABLE(of, xiic_of_match);
 
 static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct xiic_i2c *i2c = platform_get_drvdata(pdev);
+	struct xiic_i2c *i2c = dev_get_drvdata(dev);
 
 	clk_disable(i2c->clk);
 
@@ -863,8 +862,7 @@ static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
 
 static int __maybe_unused cdns_i2c_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct xiic_i2c *i2c = platform_get_drvdata(pdev);
+	struct xiic_i2c *i2c = dev_get_drvdata(dev);
 	int ret;
 
 	ret = clk_enable(i2c->clk);
-- 
2.7.4
