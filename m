From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 20 Feb 2016 15:37:59 +0100
Subject: [PATCH 4/4] ASoC: pxa: add pxa2xx-ac97 devicetree support
In-Reply-To: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1455979079-9030-4-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the devicetree support, so that the driver can be used in a
devicetree platform.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/arm/pxa2xx-ac97-lib.c | 11 +++++++++++
 sound/soc/pxa/pxa2xx-ac97.c | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 39c3969ac1c7..37fe7e0cbcf1 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 
 #include <sound/ac97_codec.h>
 #include <sound/pxa2xx-lib.h>
@@ -332,6 +333,16 @@ int pxa2xx_ac97_hw_probe(struct platform_device *dev)
 			dev_err(&dev->dev, "Invalid reset GPIO %d\n",
 				pdata->reset_gpio);
 		}
+	} else if (!pdata && dev->dev.of_node) {
+		pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+		pdata->reset_gpio = of_get_named_gpio(dev->dev.of_node,
+						      "reset-gpio", 0);
+		if (pdata->reset_gpio == -ENOENT)
+			pdata->reset_gpio = -1;
+		else if (pdata->reset_gpio < 0)
+			return pdata->reset_gpio;
 	} else {
 		if (cpu_is_pxa27x())
 			reset_gpio = 113;
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index f3de615aacd7..13e3ab9224b9 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -221,6 +221,15 @@ static const struct snd_soc_component_driver pxa_ac97_component = {
 	.name		= "pxa-ac97",
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id pxa2xx_ac97_dt_ids[] = {
+	{ .compatible = "marvell,pxa2xx-ac97", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pxa2xx_ac97_dt_ids);
+
+#endif
+
 static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -279,6 +288,7 @@ static struct platform_driver pxa2xx_ac97_driver = {
 #ifdef CONFIG_PM_SLEEP
 		.pm	= &pxa2xx_ac97_pm_ops,
 #endif
+		.of_match_table = of_match_ptr(pxa2xx_ac97_dt_ids),
 	},
 };
 
-- 
2.1.4
