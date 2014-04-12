From: alexanders83@web.de (Alexander Stein)
Date: Sat, 12 Apr 2014 11:08:26 +0200
Subject: [PATCH 3/4] ALSA: sound/atmel/ac97c.c: Add device tree support
In-Reply-To: <1397293707-26890-1-git-send-email-alexanders83@web.de>
References: <1397293707-26890-1-git-send-email-alexanders83@web.de>
Message-ID: <1397293707-26890-4-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
 .../devicetree/bindings/sound/atmel_ac97c.txt      | 20 +++++++++
 sound/atmel/ac97c.c                                | 52 ++++++++++++++++++++--
 2 files changed, 69 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel_ac97c.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel_ac97c.txt b/Documentation/devicetree/bindings/sound/atmel_ac97c.txt
new file mode 100644
index 0000000..9839403
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel_ac97c.txt
@@ -0,0 +1,20 @@
+* Atmel AC97 controller
+
+Required properties:
+  - compatible: "atmel,atmel_ac97c"
+  - reg: Address and length of the register set for the device
+  - interrupts: Should contain AC97 interrupt
+  - atmel,reset-pin: GPIO for resetting the codec
+Optional properties:
+  - pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
+
+Example:
+sound at fffa0000 {
+	compatible = "atmel,atmel_ac97c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ac97>;
+	reg = <0xfffa0000 0x4000>;
+	interrupts = <18 IRQ_TYPE_LEVEL_HIGH 5>;
+
+	atmel,reset-pin = <&pioC 29 GPIO_ACTIVE_LOW>;
+};
diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 9a13875..b84432b 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -22,6 +22,9 @@
 #include <linux/gpio.h>
 #include <linux/types.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_device.h>
 
 #include <sound/core.h>
 #include <sound/initval.h>
@@ -901,6 +904,47 @@ static void atmel_ac97c_reset(struct atmel_ac97c *chip)
 	}
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id atmel_ac97c_dt_ids[] = {
+	{ .compatible = "atmel,atmel_ac97c", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, atmel_ac97c_dt_ids);
+
+static struct ac97c_platform_data *atmel_ac97c_probe_dt(struct device *dev)
+{
+	struct ac97c_platform_data *pdata;
+	struct device_node *node = dev->of_node;
+	const struct of_device_id *match;
+
+	if (!node) {
+		dev_err(dev, "Device does not have associated DT data\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	match = of_match_device(atmel_ac97c_dt_ids, dev);
+	if (!match) {
+		dev_err(dev, "Unknown device model\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->reset_pin = of_get_named_gpio(dev->of_node,
+					     "atmel,reset-pin", 0);
+
+	return pdata;
+}
+#else
+static struct ac97c_platform_data *atmel_ac97c_probe_dt(struct device *dev)
+{
+	dev_err(dev, "no platform data defined\n");
+	return ERR_PTR(-ENXIO);
+}
+#endif
+
 static int atmel_ac97c_probe(struct platform_device *pdev)
 {
 	struct snd_card			*card;
@@ -921,10 +965,11 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
-		dev_dbg(&pdev->dev, "no platform data\n");
-		return -ENXIO;
+		pdata = atmel_ac97c_probe_dt(&pdev->dev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -1208,6 +1253,7 @@ static struct platform_driver atmel_ac97c_driver = {
 		.name	= "atmel_ac97c",
 		.owner	= THIS_MODULE,
 		.pm	= ATMEL_AC97C_PM_OPS,
+		.of_match_table = of_match_ptr(atmel_ac97c_dt_ids),
 	},
 };
 module_platform_driver(atmel_ac97c_driver);
-- 
1.9.2
