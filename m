From: s-anna@ti.com (Suman Anna)
Date: Tue, 1 Aug 2017 10:48:44 -0500
Subject: [PATCH v2 4/4] remoteproc/davinci: Add device tree support for
 OMAP-L138 DSP
In-Reply-To: <20170801154844.24662-1-s-anna@ti.com>
References: <20170801154844.24662-1-s-anna@ti.com>
Message-ID: <20170801154844.24662-5-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Davinci remoteproc driver currently supports the DSP remoteproc
device created in legacy-style on OMAP-L13x SoCs. The driver has been
enhanced to support the DSP remoteproc device created through Device
Tree now. The current DT support handles the C674x DSP processor
subsystem on OMAP-L138 SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
v2:
 - Add __maybe_unused and of_match_ptr to deal with non-OF builds
 - Rebased patch after dropping the interrupt management patch from
   the cleanup series, https://patchwork.kernel.org/patch/9735321/
v1: https://patchwork.kernel.org/patch/9751277/

 drivers/remoteproc/da8xx_remoteproc.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index c1cff78de67b..bf3b9034c319 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -16,6 +16,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
 
@@ -261,10 +262,21 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 		return PTR_ERR(dsp_clk);
 	}
 
+	if (dev->of_node) {
+		ret = of_reserved_mem_device_init(dev);
+		if (ret) {
+			dev_err(dev, "device does not have specific CMA pool: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	rproc = rproc_alloc(dev, "dsp", &da8xx_rproc_ops, da8xx_fw_name,
 		sizeof(*drproc));
-	if (!rproc)
-		return -ENOMEM;
+	if (!rproc) {
+		ret = -ENOMEM;
+		goto free_mem;
+	}
 
 	drproc = rproc->priv;
 	drproc->rproc = rproc;
@@ -311,7 +323,9 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 
 free_rproc:
 	rproc_free(rproc);
-
+free_mem:
+	if (dev->of_node)
+		of_reserved_mem_device_release(dev);
 	return ret;
 }
 
@@ -319,6 +333,7 @@ static int da8xx_rproc_remove(struct platform_device *pdev)
 {
 	struct rproc *rproc = platform_get_drvdata(pdev);
 	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
+	struct device *dev = &pdev->dev;
 
 	/*
 	 * The devm subsystem might end up releasing things before
@@ -329,15 +344,24 @@ static int da8xx_rproc_remove(struct platform_device *pdev)
 
 	rproc_del(rproc);
 	rproc_free(rproc);
+	if (dev->of_node)
+		of_reserved_mem_device_release(dev);
 
 	return 0;
 }
 
+static const struct of_device_id davinci_rproc_of_match[] __maybe_unused = {
+	{ .compatible = "ti,da850-dsp", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, davinci_rproc_of_match);
+
 static struct platform_driver da8xx_rproc_driver = {
 	.probe = da8xx_rproc_probe,
 	.remove = da8xx_rproc_remove,
 	.driver = {
 		.name = "davinci-rproc",
+		.of_match_table = of_match_ptr(davinci_rproc_of_match),
 	},
 };
 
-- 
2.13.1
