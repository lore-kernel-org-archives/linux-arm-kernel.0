From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 14 Aug 2012 12:18:43 +0800
Subject: How to define gpio irq with device tree
In-Reply-To: <5024FF03.1070805@de.bosch.com>
References: <5024FF03.1070805@de.bosch.com>
Message-ID: <20120814041841.GA30782@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 02:30:59PM +0200, Knut Wohlrab wrote:
> Hello,
> 
> I try the touch screen of a iMX6 SabreLite evaluation board. The
> used eGalax touch controller worked fine with a 3.2.x kernel [1]. As
> mentioned there [2] I merge the basic device tree support to the
> actual driver (see patch [4]) and add the touch definition to
> arch/arm/boot/dts/imx6q-sabrelite.dts [3].
> 
> The driver seems to start but the interrupt never occurs.
> 
> The pinmux and I2C configuration seems correct. I did a simple test
> with polling the interrupt gpio (see "POLLTEST" in patch [4]) and
> got coordinates matching to the movements on the screen.
> 
> How to configure the gpio irq correctly?
> 
> Anybody solved to work with the eGalax touch and iMX6 SabreLite with
> kernel > 3.2?
> 
I'm not interested in reviewing those out-of-tree codes to see what
goes wrong there.  But I just quickly enabled the driver for
imx6q-sabrelite board with the following changes against latest
mainline.  And the interrupt seems working for me.

Regards,
Shawn

--8<---

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 72f30f3..c8511c1 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -115,6 +115,21 @@
 					VDDIO-supply = <&reg_3p3v>;
 				};
 			};
+
+			i2c at 021a8000 { /* I2C3 */
+				status = "okay";
+				clock-frequency = <400000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c3_1>;
+
+				egalax at 04 {
+					compatible = "eeti,egalax";
+					reg = <0x04>;
+					interrupt-parent = <&gpio1>;
+					interrupts = <9 0x8>;
+					wakeup-gpios = <&gpio1 9 0>;
+				};
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 3d3c64b..bbf5196 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -545,6 +545,13 @@
 					};
 				};
 
+				i2c3 {
+					pinctrl_i2c3_1: i2c3grp-1 {
+						fsl,pins = <1013 0x4001b8b1	/* MX6Q_PAD_GPIO_5__I2C3_SCL */
+							    1037 0x4001b8b1>;	/* MX6Q_PAD_GPIO_16__I2C3_SDA */
+					};
+				};
+
 				serial2 {
 					pinctrl_serial2_1: serial2grp-1 {
 						fsl,pins = <183 0x1b0b1		/* MX6Q_PAD_EIM_D26__UART2_TXD */
diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 70524dd..013011d 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -28,6 +28,8 @@
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/input/mt.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
 
 /*
  * Mouse Mode: some panel may configure the controller to mouse mode,
@@ -122,7 +124,7 @@ static irqreturn_t egalax_ts_interrupt(int irq, void *dev_id)
 /* wake up controller by an falling edge of interrupt gpio.  */
 static int egalax_wake_up_device(struct i2c_client *client)
 {
-	int gpio = irq_to_gpio(client->irq);
+	int gpio = of_get_named_gpio(client->dev.of_node, "wakeup-gpios", 0);
 	int ret;
 
 	ret = gpio_request(gpio, "egalax_irq");
@@ -251,6 +253,12 @@ static const struct i2c_device_id egalax_ts_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, egalax_ts_id);
 
+static struct of_device_id egalax_ts_dt_ids[] = {
+	{ .compatible = "eeti,egalax" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, egalax_ts_dt_ids);
+
 #ifdef CONFIG_PM_SLEEP
 static int egalax_ts_suspend(struct device *dev)
 {
@@ -279,6 +287,7 @@ static struct i2c_driver egalax_ts_driver = {
 		.name	= "egalax_ts",
 		.owner	= THIS_MODULE,
 		.pm	= &egalax_ts_pm_ops,
+		.of_match_table	= egalax_ts_dt_ids,
 	},
 	.id_table	= egalax_ts_id,
 	.probe		= egalax_ts_probe,
-- 
1.7.5.4
