From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 17 Jun 2018 12:50:01 +0200
Subject: [PATCH v2 2/2] ASoC: pxa: add devicetree support
In-Reply-To: <20180617105001.17784-1-robert.jarzmik@free.fr>
References: <20180617105001.17784-1-robert.jarzmik@free.fr>
Message-ID: <20180617105001.17784-2-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the devicetree support, so that the driver can be used in a
devictree platform.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: changed compatible string to pxa250-ac97, pxa270-ac97...
---
 sound/arm/pxa2xx-ac97-lib.c | 12 ++++++++++++
 sound/soc/pxa/pxa2xx-ac97.c | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 5950a9e218d9..8eafd3d3dff6 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 
 #include <sound/pxa2xx-lib.h>
 
@@ -337,6 +338,17 @@ int pxa2xx_ac97_hw_probe(struct platform_device *dev)
 			dev_err(&dev->dev, "Invalid reset GPIO %d\n",
 				pdata->reset_gpio);
 		}
+	} else if (!pdata && dev->dev.of_node) {
+		pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+		pdata->reset_gpio = of_get_named_gpio(dev->dev.of_node,
+						      "reset-gpios", 0);
+		if (pdata->reset_gpio == -ENOENT)
+			pdata->reset_gpio = -1;
+		else if (pdata->reset_gpio < 0)
+			return pdata->reset_gpio;
+		reset_gpio = pdata->reset_gpio;
 	} else {
 		if (cpu_is_pxa27x())
 			reset_gpio = 113;
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index bd36578ceb86..d6be323a13ec 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -231,6 +231,17 @@ static const struct snd_soc_component_driver pxa_ac97_component = {
 	.name		= "pxa-ac97",
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id pxa2xx_ac97_dt_ids[] = {
+	{ .compatible = "marvell,pxa250-ac97", },
+	{ .compatible = "marvell,pxa270-ac97", },
+	{ .compatible = "marvell,pxa300-ac97", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pxa2xx_ac97_dt_ids);
+
+#endif
+
 static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -298,6 +309,7 @@ static struct platform_driver pxa2xx_ac97_driver = {
 #ifdef CONFIG_PM_SLEEP
 		.pm	= &pxa2xx_ac97_pm_ops,
 #endif
+		.of_match_table = of_match_ptr(pxa2xx_ac97_dt_ids),
 	},
 };
 
-- 
2.11.0
