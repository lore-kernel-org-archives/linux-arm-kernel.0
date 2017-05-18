From: s-anna@ti.com (Suman Anna)
Date: Thu, 18 May 2017 17:09:00 -0500
Subject: [PATCH 2/4] remoteproc/davinci: simplify the reset function
In-Reply-To: <20170518220902.2846-1-s-anna@ti.com>
References: <20170518220902.2846-1-s-anna@ti.com>
Message-ID: <20170518220902.2846-3-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reset_assert() function is used to make sure the DSP remote
processor is in a reset state regardless of its previous state.
The driver relies on davinci_clk_reset_{assert,deassert}()
functions for reset management which take in a clock parameter.
The assert_reset() performs a clk_get()/clk_put() cycle to
acquire the clock handle to use with this function. This is
totally unnecessary and the code can be simplified to use
the clock acquired during probe and directly use the reset
functions, so simplify this logic.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index 3814de28599c..fcd3cecb4967 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -157,22 +157,6 @@ static const struct rproc_ops da8xx_rproc_ops = {
 	.kick = da8xx_rproc_kick,
 };
 
-static int reset_assert(struct device *dev)
-{
-	struct clk *dsp_clk;
-
-	dsp_clk = clk_get(dev, NULL);
-	if (IS_ERR(dsp_clk)) {
-		dev_err(dev, "clk_get error: %ld\n", PTR_ERR(dsp_clk));
-		return PTR_ERR(dsp_clk);
-	}
-
-	davinci_clk_reset_assert(dsp_clk);
-	clk_put(dsp_clk);
-
-	return 0;
-}
-
 static int da8xx_rproc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -223,6 +207,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 
 	drproc = rproc->priv;
 	drproc->rproc = rproc;
+	drproc->dsp_clk = dsp_clk;
 	rproc->has_iommu = false;
 
 	platform_set_drvdata(pdev, rproc);
@@ -241,7 +226,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	 * *not* in reset, but da8xx_rproc_start() needs the DSP to be
 	 * held in reset at the time it is called.
 	 */
-	ret = reset_assert(dev);
+	ret = davinci_clk_reset_assert(drproc->dsp_clk);
 	if (ret)
 		goto free_rproc;
 
@@ -250,7 +235,6 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	drproc->ack_fxn = irq_data->chip->irq_ack;
 	drproc->irq_data = irq_data;
 	drproc->irq = irq;
-	drproc->dsp_clk = dsp_clk;
 
 	ret = rproc_add(rproc);
 	if (ret) {
@@ -268,7 +252,6 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 
 static int da8xx_rproc_remove(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
 	struct rproc *rproc = platform_get_drvdata(pdev);
 	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
 
@@ -280,7 +263,7 @@ static int da8xx_rproc_remove(struct platform_device *pdev)
 	 * Without the reset, the DSP can lockup permanently when it
 	 * begins executing garbage.
 	 */
-	reset_assert(dev);
+	davinci_clk_reset_assert(drproc->dsp_clk);
 
 	/*
 	 * The devm subsystem might end up releasing things before
-- 
2.12.0
