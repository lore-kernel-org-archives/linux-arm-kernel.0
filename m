From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Jun 2018 12:59:42 +0100
Subject: Applied "ASoC: pxa: add devicetree support" to the asoc tree
In-Reply-To: <20180617105001.17784-2-robert.jarzmik@free.fr>
Message-ID: <E1fUsow-0008N6-3J@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: pxa: add devicetree support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a4519526ebbd261e36425fa1c269515ee0648ab2 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sun, 17 Jun 2018 12:50:01 +0200
Subject: [PATCH] ASoC: pxa: add devicetree support

Add the devicetree support, so that the driver can be used in a
devictree platform.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index 803818aabee9..5738a0abcd6a 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -238,6 +238,17 @@ static const struct snd_soc_component_driver pxa_ac97_component = {
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
@@ -296,6 +307,7 @@ static struct platform_driver pxa2xx_ac97_driver = {
 #ifdef CONFIG_PM_SLEEP
 		.pm	= &pxa2xx_ac97_pm_ops,
 #endif
+		.of_match_table = of_match_ptr(pxa2xx_ac97_dt_ids),
 	},
 };
 
-- 
2.17.1
