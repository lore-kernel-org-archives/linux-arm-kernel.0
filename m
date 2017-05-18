From: s-anna@ti.com (Suman Anna)
Date: Thu, 18 May 2017 17:09:02 -0500
Subject: [PATCH 4/4] remoteproc/davinci: streamline the interrupt management
In-Reply-To: <20170518220902.2846-1-s-anna@ti.com>
References: <20170518220902.2846-1-s-anna@ti.com>
Message-ID: <20170518220902.2846-5-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci remoteproc driver is currently requesting its interrupt
that deals with the virtio kicks in probe, and that too before all
the associated variables used by the handler are initialized. This
is a lot in advance before the DSP remote processor is even loaded
and booted and is not essential. Streamline the interrupt request
and freeing operations instead alongside the boot and shutdown of
the remote processor.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index 99539cec1329..c7ad818f7a48 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -117,6 +117,7 @@ static int da8xx_rproc_start(struct rproc *rproc)
 	struct device *dev = rproc->dev.parent;
 	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
 	struct clk *dsp_clk = drproc->dsp_clk;
+	int ret;
 
 	/* hw requires the start (boot) address be on 1KB boundary */
 	if (rproc->bootaddr & 0x3ff) {
@@ -125,6 +126,14 @@ static int da8xx_rproc_start(struct rproc *rproc)
 		return -EINVAL;
 	}
 
+	/* everything the ISR needs is now setup, so hook it up */
+	ret = request_threaded_irq(drproc->irq, da8xx_rproc_callback,
+				   handle_event, 0, "da8xx-remoteproc", rproc);
+	if (ret) {
+		dev_err(dev, "request_threaded_irq error: %d\n", ret);
+		return ret;
+	}
+
 	writel(rproc->bootaddr, drproc->bootreg);
 
 	clk_enable(dsp_clk);
@@ -140,6 +149,8 @@ static int da8xx_rproc_stop(struct rproc *rproc)
 	davinci_clk_reset_assert(drproc->dsp_clk);
 	clk_disable(drproc->dsp_clk);
 
+	free_irq(drproc->irq, rproc);
+
 	return 0;
 }
 
@@ -213,15 +224,6 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rproc);
 
-	/* everything the ISR needs is now setup, so hook it up */
-	ret = devm_request_threaded_irq(dev, irq, da8xx_rproc_callback,
-					handle_event, 0, "da8xx-remoteproc",
-					rproc);
-	if (ret) {
-		dev_err(dev, "devm_request_threaded_irq error: %d\n", ret);
-		goto free_rproc;
-	}
-
 	/*
 	 * rproc_add() can end up enabling the DSP's clk with the DSP
 	 * *not* in reset, but da8xx_rproc_start() needs the DSP to be
@@ -254,14 +256,6 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 static int da8xx_rproc_remove(struct platform_device *pdev)
 {
 	struct rproc *rproc = platform_get_drvdata(pdev);
-	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
-
-	/*
-	 * The devm subsystem might end up releasing things before
-	 * freeing the irq, thus allowing an interrupt to sneak in while
-	 * the device is being removed.  This should prevent that.
-	 */
-	disable_irq(drproc->irq);
 
 	rproc_del(rproc);
 	rproc_free(rproc);
-- 
2.12.0
