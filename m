From: s-anna@ti.com (Suman Anna)
Date: Fri, 26 May 2017 15:21:40 -0500
Subject: [PATCH 4/4] remoteproc/davinci: Add device tree support for OMAP-L138
 DSP
In-Reply-To: <20170526202140.10472-1-s-anna@ti.com>
References: <20170526202140.10472-1-s-anna@ti.com>
Message-ID: <20170526202140.10472-5-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Davinci remoteproc driver currently supports the DSP remoteproc
device created in legacy-style on OMAP-L13x SoCs. The driver has been
enhanced to support the DSP remoteproc device created through Device
Tree now. The current DT support handles the C674x DSP processor
subsystem on OMAP-L138 SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index 5250cc494775..02a4920d1af2 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -16,6 +16,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
 
@@ -272,10 +273,21 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
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
@@ -313,25 +325,37 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 
 free_rproc:
 	rproc_free(rproc);
-
+free_mem:
+	if (dev->of_node)
+		of_reserved_mem_device_release(dev);
 	return ret;
 }
 
 static int da8xx_rproc_remove(struct platform_device *pdev)
 {
 	struct rproc *rproc = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
 
 	rproc_del(rproc);
 	rproc_free(rproc);
+	if (dev->of_node)
+		of_reserved_mem_device_release(dev);
 
 	return 0;
 }
 
+static const struct of_device_id davinci_rproc_of_match[] = {
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
+		.of_match_table = davinci_rproc_of_match,
 	},
 };
 
-- 
2.12.0
