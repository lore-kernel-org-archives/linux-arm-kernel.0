From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 12 Dec 2011 23:15:56 +0800
Subject: [PATCH v3 1/3] mfd: mc13xxx: add device tree probe support
In-Reply-To: <1323702958-4831-1-git-send-email-shawn.guo@linaro.org>
References: <1323702958-4831-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1323702958-4831-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds device tree probe support for mc13xxx mfd driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 Documentation/devicetree/bindings/mfd/mc13xxx.txt |   53 ++++++++++
 drivers/mfd/mc13xxx-core.c                        |  106 +++++++++++++++------
 2 files changed, 128 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mc13xxx.txt

diff --git a/Documentation/devicetree/bindings/mfd/mc13xxx.txt b/Documentation/devicetree/bindings/mfd/mc13xxx.txt
new file mode 100644
index 0000000..4ed46a61
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mc13xxx.txt
@@ -0,0 +1,53 @@
+* Freescale MC13783/MC13892 Power Management Integrated Circuit (PMIC)
+
+Required properties:
+- compatible : Should be "fsl,mc13783" or "fsl,mc13892"
+
+Optional properties:
+- fsl,mc13xxx-uses-adc : Indicate the ADC is being used
+- fsl,mc13xxx-uses-codec : Indicate the Audio Codec is being used
+- fsl,mc13xxx-uses-rtc : Indicate the RTC is being used
+- fsl,mc13xxx-uses-touch : Indicate the touchscreen controller is being used
+
+Sub-nodes:
+- regulators : Contain the regulator nodes.  The name of regulator node
+  is being used by mc13xxx regulator driver to find the correct relator
+  device.
+
+  The bindings details of individual regulator device can be found in:
+  Documentation/devicetree/bindings/regulator/regulator.txt
+
+Examples:
+
+ecspi at 70010000 { /* ECSPI1 */
+	fsl,spi-num-chipselects = <2>;
+	cs-gpios = <&gpio3 24 0>, /* GPIO4_24 */
+		   <&gpio3 25 0>; /* GPIO4_25 */
+	status = "okay";
+
+	pmic: mc13892 at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,mc13892";
+		spi-max-frequency = <6000000>;
+		reg = <0>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <8>;
+
+		regulators {
+			sw1_reg: mc13892__sw1 {
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1375000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw2_reg: mc13892__sw2 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index e9619ac..51b2dcc 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -18,11 +18,15 @@
 #include <linux/spi/spi.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/mc13xxx.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
 
 struct mc13xxx {
 	struct spi_device *spidev;
 	struct mutex lock;
 	int irq;
+	int flags;
 
 	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
 	void *irqdata[MC13XXX_NUM_IRQ];
@@ -550,10 +554,7 @@ static const char *mc13xxx_get_chipname(struct mc13xxx *mc13xxx)
 
 int mc13xxx_get_flags(struct mc13xxx *mc13xxx)
 {
-	struct mc13xxx_platform_data *pdata =
-		dev_get_platdata(&mc13xxx->spidev->dev);
-
-	return pdata->flags;
+	return mc13xxx->flags;
 }
 EXPORT_SYMBOL(mc13xxx_get_flags);
 
@@ -696,17 +697,67 @@ static int mc13xxx_add_subdevice(struct mc13xxx *mc13xxx, const char *format)
 	return mc13xxx_add_subdevice_pdata(mc13xxx, format, NULL, 0);
 }
 
+#ifdef CONFIG_OF
+static int mc13xxx_probe_flags_dt(struct mc13xxx *mc13xxx)
+{
+	struct device_node *np = mc13xxx->spidev->dev.of_node;
+
+	if (!np)
+		return -ENODEV;
+
+	if (of_get_property(np, "fsl,mc13xxx-uses-adc", NULL))
+		mc13xxx->flags |= MC13XXX_USE_ADC;
+
+	if (of_get_property(np, "fsl,mc13xxx-uses-codec", NULL))
+		mc13xxx->flags |= MC13XXX_USE_CODEC;
+
+	if (of_get_property(np, "fsl,mc13xxx-uses-rtc", NULL))
+		mc13xxx->flags |= MC13XXX_USE_RTC;
+
+	if (of_get_property(np, "fsl,mc13xxx-uses-touch", NULL))
+		mc13xxx->flags |= MC13XXX_USE_TOUCHSCREEN;
+
+	return 0;
+}
+#else
+static inline int mc13xxx_probe_flags_dt(struct mc13xxx *mc13xxx)
+{
+	return -ENODEV;
+}
+#endif
+
+static const struct spi_device_id mc13xxx_device_id[] = {
+	{
+		.name = "mc13783",
+		.driver_data = MC13XXX_ID_MC13783,
+	}, {
+		.name = "mc13892",
+		.driver_data = MC13XXX_ID_MC13892,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(spi, mc13xxx_device_id);
+
+static const struct of_device_id mc13xxx_dt_ids[] = {
+	{ .compatible = "fsl,mc13783", .data = (void *) MC13XXX_ID_MC13783, },
+	{ .compatible = "fsl,mc13892", .data = (void *) MC13XXX_ID_MC13892, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mc13xxx_dt_ids);
+
 static int mc13xxx_probe(struct spi_device *spi)
 {
+	const struct of_device_id *of_id;
+	struct spi_driver *sdrv = to_spi_driver(spi->dev.driver);
 	struct mc13xxx *mc13xxx;
 	struct mc13xxx_platform_data *pdata = dev_get_platdata(&spi->dev);
 	enum mc13xxx_id id;
 	int ret;
 
-	if (!pdata) {
-		dev_err(&spi->dev, "invalid platform data\n");
-		return -EINVAL;
-	}
+	of_id = of_match_device(mc13xxx_dt_ids, &spi->dev);
+	if (of_id)
+		sdrv->id_table = &mc13xxx_device_id[(enum mc13xxx_id) of_id->data];
 
 	mc13xxx = kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
 	if (!mc13xxx)
@@ -749,28 +800,33 @@ err_revision:
 
 	mc13xxx_unlock(mc13xxx);
 
-	if (pdata->flags & MC13XXX_USE_ADC)
+	if (mc13xxx_probe_flags_dt(mc13xxx) < 0 && pdata)
+		mc13xxx->flags = pdata->flags;
+
+	if (mc13xxx->flags & MC13XXX_USE_ADC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-adc");
 
-	if (pdata->flags & MC13XXX_USE_CODEC)
+	if (mc13xxx->flags & MC13XXX_USE_CODEC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-codec");
 
-	mc13xxx_add_subdevice_pdata(mc13xxx, "%s-regulator",
-		&pdata->regulators, sizeof(pdata->regulators));
-
-	if (pdata->flags & MC13XXX_USE_RTC)
+	if (mc13xxx->flags & MC13XXX_USE_RTC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-rtc");
 
-	if (pdata->flags & MC13XXX_USE_TOUCHSCREEN)
+	if (mc13xxx->flags & MC13XXX_USE_TOUCHSCREEN)
 		mc13xxx_add_subdevice(mc13xxx, "%s-ts");
 
-	if (pdata->leds)
+	if (pdata) {
+		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-regulator",
+			&pdata->regulators, sizeof(pdata->regulators));
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
 				pdata->leds, sizeof(*pdata->leds));
-
-	if (pdata->buttons)
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-pwrbutton",
 				pdata->buttons, sizeof(*pdata->buttons));
+	} else {
+		mc13xxx_add_subdevice(mc13xxx, "%s-regulator");
+		mc13xxx_add_subdevice(mc13xxx, "%s-led");
+		mc13xxx_add_subdevice(mc13xxx, "%s-pwrbutton");
+	}
 
 	return 0;
 }
@@ -788,25 +844,13 @@ static int __devexit mc13xxx_remove(struct spi_device *spi)
 	return 0;
 }
 
-static const struct spi_device_id mc13xxx_device_id[] = {
-	{
-		.name = "mc13783",
-		.driver_data = MC13XXX_ID_MC13783,
-	}, {
-		.name = "mc13892",
-		.driver_data = MC13XXX_ID_MC13892,
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(spi, mc13xxx_device_id);
-
 static struct spi_driver mc13xxx_driver = {
 	.id_table = mc13xxx_device_id,
 	.driver = {
 		.name = "mc13xxx",
 		.bus = &spi_bus_type,
 		.owner = THIS_MODULE,
+		.of_match_table = mc13xxx_dt_ids,
 	},
 	.probe = mc13xxx_probe,
 	.remove = __devexit_p(mc13xxx_remove),
-- 
1.7.4.1
