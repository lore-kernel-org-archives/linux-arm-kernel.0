From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 06 Mar 2013 17:25:51 +0530
Subject: [PATCH] ASoC: samsung: let device core setup the default pin
 configuration
Message-ID: <1362570951-14403-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With device core now able to setup the default pin configuration,
the pin configuration code based on the deprecated Samsung specific
gpio bindings in i2s driver is removed.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 .../devicetree/bindings/sound/samsung-i2s.txt      |   30 +--------
 sound/soc/samsung/i2s.c                            |   67 +------------------
 2 files changed, 8 insertions(+), 89 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
index 3070046..1db65e5 100644
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
@@ -20,23 +20,11 @@ Optional SoC Specific Properties:
   then this flag is enabled.
 - samsung,idma-addr: Internal DMA register base address of the audio
   sub system(used in secondary sound source).
-
-Required Board Specific Properties:
-
-- gpios: The gpio specifier for data out,data in, LRCLK, CDCLK and SCLK
-  interface lines. The format of the gpio specifier depends on the gpio
-  controller.
-  The syntax of samsung gpio specifier is
-	<[phandle of the gpio controller node]
-	 [pin number within the gpio controller]
-	 [mux function]
-	 [flags and pull up/down]
-	 [drive strength]>
+- pinctrl-0: Should specify pin control groups used for this controller.
+- pinctrl-names: Should contain only one value - "default".
 
 Example:
 
-- SoC Specific Portion:
-
 i2s at 03830000 {
 	compatible = "samsung,i2s-v5";
 	reg = <0x03830000 0x100>;
@@ -48,16 +36,6 @@ i2s at 03830000 {
 	samsung,supports-rstclr;
 	samsung,supports-secdai;
 	samsung,idma-addr = <0x03000000>;
-};
-
-- Board Specific Portion:
-
-i2s at 03830000 {
-	gpios = <&gpz 0 2 0 0>, /* I2S_0_SCLK */
-		<&gpz 1 2 0 0>, /* I2S_0_CDCLK */
-		<&gpz 2 2 0 0>, /* I2S_0_LRCK */
-		<&gpz 3 2 0 0>, /* I2S_0_SDI */
-		<&gpz 4 2 0 0>, /* I2S_0_SDO[1] */
-		<&gpz 5 2 0 0>, /* I2S_0_SDO[2] */
-		<&gpz 6 2 0 0>; /* I2S_0_SDO[3] */
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s0_bus>;
 };
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index d7231e3..f982a83 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -16,7 +16,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 
 #include <sound/soc.h>
@@ -79,7 +78,6 @@ struct i2s_dai {
 	u32	suspend_i2smod;
 	u32	suspend_i2scon;
 	u32	suspend_i2spsr;
-	unsigned long gpios[7];	/* i2s gpio line numbers */
 };
 
 /* Lock for cross i/f checks */
@@ -1009,52 +1007,6 @@ static struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 	return i2s;
 }
 
-#ifdef CONFIG_OF
-static int samsung_i2s_parse_dt_gpio(struct i2s_dai *i2s)
-{
-	struct device *dev = &i2s->pdev->dev;
-	int index, gpio, ret;
-
-	for (index = 0; index < 7; index++) {
-		gpio = of_get_gpio(dev->of_node, index);
-		if (!gpio_is_valid(gpio)) {
-			dev_err(dev, "invalid gpio[%d]: %d\n", index, gpio);
-			goto free_gpio;
-		}
-
-		ret = gpio_request(gpio, dev_name(dev));
-		if (ret) {
-			dev_err(dev, "gpio [%d] request failed\n", gpio);
-			goto free_gpio;
-		}
-		i2s->gpios[index] = gpio;
-	}
-	return 0;
-
-free_gpio:
-	while (--index >= 0)
-		gpio_free(i2s->gpios[index]);
-	return -EINVAL;
-}
-
-static void samsung_i2s_dt_gpio_free(struct i2s_dai *i2s)
-{
-	unsigned int index;
-	for (index = 0; index < 7; index++)
-		gpio_free(i2s->gpios[index]);
-}
-#else
-static int samsung_i2s_parse_dt_gpio(struct i2s_dai *dai)
-{
-	return -EINVAL;
-}
-
-static void samsung_i2s_dt_gpio_free(struct i2s_dai *dai)
-{
-}
-
-#endif
-
 static const struct of_device_id exynos_i2s_match[];
 
 static inline int samsung_i2s_get_driver_data(struct platform_device *pdev)
@@ -1223,18 +1175,10 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		pri_dai->sec_dai = sec_dai;
 	}
 
-	if (np) {
-		if (samsung_i2s_parse_dt_gpio(pri_dai)) {
-			dev_err(&pdev->dev, "Unable to configure gpio\n");
-			ret = -EINVAL;
-			goto err;
-		}
-	} else {
-		if (i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
-			dev_err(&pdev->dev, "Unable to configure gpio\n");
-			ret = -EINVAL;
-			goto err;
-		}
+	if (i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
+		dev_err(&pdev->dev, "Unable to configure gpio\n");
+		ret = -EINVAL;
+		goto err;
 	}
 
 	snd_soc_register_dai(&pri_dai->pdev->dev, &pri_dai->i2s_dai_drv);
@@ -1259,9 +1203,6 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	i2s = dev_get_drvdata(&pdev->dev);
 	other = i2s->pri_dai ? : i2s->sec_dai;
 
-	if (!i2s_pdata->cfg_gpio && pdev->dev.of_node)
-		samsung_i2s_dt_gpio_free(i2s->pri_dai);
-
 	if (other) {
 		other->pri_dai = NULL;
 		other->sec_dai = NULL;
-- 
1.6.6.rc2
