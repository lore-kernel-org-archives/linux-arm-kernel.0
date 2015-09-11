From: b54642@freescale.com (Gao Pan)
Date: Fri, 11 Sep 2015 18:42:34 +0800
Subject: [Patch V5] i2c: imx: implement bus recovery
Message-ID: <1441968155-10918-1-git-send-email-b54642@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement bus recovery methods for i2c-imx so we can recover from
situations where SCL/SDA are stuck low.

Once i2c bus SCL/SDA are stuck low during transfer, config the i2c
pinctrl to gpio mode by calling pinctrl sleep set function, and then
use GPIO to emulate the i2c protocol to send nine dummy clock to recover
i2c device. After recovery, set i2c pinctrl to default group setting.

Signed-off-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Gao Pan <b54642@freescale.com>
---
V2:
As Uwe Kleine-K?nig's suggestion, the version do below changes:
 -replace of_get_named_gpio() with devm_gpiod_get_optional()
 -move gpio_direction_input() and gpio_direction_output() call to the
  prepare callback
 -use 0 and 1 as return value for the get_scl and get_sda callbacks

V3:
 -replace "...-gpio" with "...-gpios" in i2c binding doc
 -document the requirement of using sleep state to configure
  the pins as gpio in i2c binding doc
 -remove i2c_recover_bus() in i2c_imx_trx_complete()
 -use GPIOD_OUT_HIGH as the parameter of devm_gpiod_get_optional to
  config the gpios as output high
 -add error disposal as devm_gpiod_get_optional meets error

V4:
 -remove include <linux/of_gpio.h>
 -call i2c_recover_bus under the condition of the existing of
  both sda and scl. Drop the sda and scl check in i2c_imx_get_scl,
  i2c_imx_get_sda, i2c_imx_set_scl, i2c_imx_prepare_recovery and
  i2c_imx_prepare_recovery
 -use GPIOD_OUT_IN as the parameter of devm_gpiod_get_optional
 -remove documenting the requirement of using sleep state to configure
  the pins as gpio in i2c binding doc

V5:
 -introduce a dedicated gpio state for bus recovery.
 -assign adapter.bus_recovery_info after the two gpios were aquired successfully.

 Documentation/devicetree/bindings/i2c/i2c-imx.txt |   9 ++
 drivers/i2c/busses/i2c-imx.c                      | 121 ++++++++++++++++++++--
 2 files changed, 123 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
index ce4311d..eab5836 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
@@ -14,6 +14,10 @@ Optional properties:
   The absence of the propoerty indicates the default frequency 100 kHz.
 - dmas: A list of two dma specifiers, one for each entry in dma-names.
 - dma-names: should contain "tx" and "rx".
+- scl-gpios: specify the gpio related to SCL pin
+- sda-gpios: specify the gpio related to SDA pin
+- pinctrl: add extra pinctrl to configure i2c pins to gpio function for i2c
+  bus recovery, call it "gpio" state
 
 Examples:
 
@@ -37,4 +41,9 @@ i2c0: i2c at 40066000 { /* i2c0 on vf610 */
 	dmas = <&edma0 0 50>,
 		<&edma0 0 51>;
 	dma-names = "rx","tx";
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;
 };
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index d7c823b..90c0e0f 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -40,6 +40,7 @@
 #include <linux/dmapool.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -64,6 +65,8 @@
 /* Default value */
 #define IMX_I2C_BIT_RATE	100000	/* 100kHz */
 
+#define I2C_PINCTRL_STATE_GPIO	"gpio"
+
 /*
  * Enable DMA if transfer byte size is bigger than this threshold.
  * As the hardware request, it must bigger than 4 bytes.\
@@ -178,6 +181,11 @@ enum imx_i2c_type {
 	VF610_I2C,
 };
 
+struct imx_i2c_pinctrl {
+	struct gpio_desc *sda;
+	struct gpio_desc *scl;
+};
+
 struct imx_i2c_hwdata {
 	enum imx_i2c_type	devtype;
 	unsigned		regshift;
@@ -209,8 +217,13 @@ struct imx_i2c_struct {
 	unsigned int		ifdr; /* IMX_I2C_IFDR */
 	unsigned int		cur_clk;
 	unsigned int		bitrate;
+	struct imx_i2c_pinctrl	pins;
 	const struct imx_i2c_hwdata	*hwdata;
 
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_pins_default;
+	struct pinctrl_state *pinctrl_pins_gpio;
+
 	struct imx_i2c_dma	*dma;
 };
 
@@ -439,7 +452,10 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> I2C bus is busy\n", __func__);
-			return -ETIMEDOUT;
+			if (i2c_imx->adapter.bus_recovery_info)
+				return i2c_recover_bus(&i2c_imx->adapter);
+			else
+				return -ETIMEDOUT;
 		}
 		schedule();
 	}
@@ -963,6 +979,62 @@ out:
 	return (result < 0) ? result : num;
 }
 
+static int i2c_imx_get_scl(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx = container_of(adap, struct imx_i2c_struct, adapter);
+
+	return gpiod_get_value(i2c_imx->pins.scl);
+}
+
+static int i2c_imx_get_sda(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx = container_of(adap, struct imx_i2c_struct, adapter);
+
+	return gpiod_get_value(i2c_imx->pins.sda);
+}
+
+static void i2c_imx_set_scl(struct i2c_adapter *adap, int val)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx = container_of(adap, struct imx_i2c_struct, adapter);
+
+	gpiod_set_value(i2c_imx->pins.scl, val);
+}
+
+static void i2c_imx_prepare_recovery(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx = container_of(adap, struct imx_i2c_struct, adapter);
+
+	pinctrl_select_state(i2c_imx->pinctrl, i2c_imx->pinctrl_pins_gpio);
+	gpiod_direction_input(i2c_imx->pins.sda);
+	gpiod_direction_output(i2c_imx->pins.scl, 1);
+}
+
+static void i2c_imx_unprepare_recovery(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx = container_of(adap, struct imx_i2c_struct, adapter);
+
+	pinctrl_select_state(i2c_imx->pinctrl, i2c_imx->pinctrl_pins_default);
+}
+
+static struct i2c_bus_recovery_info i2c_imx_bus_recovery_info = {
+	.get_scl = i2c_imx_get_scl,
+	.get_sda = i2c_imx_get_sda,
+	.set_scl = i2c_imx_set_scl,
+	.prepare_recovery = i2c_imx_prepare_recovery,
+	.unprepare_recovery = i2c_imx_unprepare_recovery,
+	.recover_bus = i2c_generic_scl_recovery,
+};
+
 static u32 i2c_imx_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
@@ -1011,12 +1083,12 @@ static int i2c_imx_probe(struct platform_device *pdev)
 
 	/* Setup i2c_imx driver structure */
 	strlcpy(i2c_imx->adapter.name, pdev->name, sizeof(i2c_imx->adapter.name));
-	i2c_imx->adapter.owner		= THIS_MODULE;
-	i2c_imx->adapter.algo		= &i2c_imx_algo;
-	i2c_imx->adapter.dev.parent	= &pdev->dev;
-	i2c_imx->adapter.nr		= pdev->id;
-	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
-	i2c_imx->base			= base;
+	i2c_imx->adapter.owner = THIS_MODULE;
+	i2c_imx->adapter.algo = &i2c_imx_algo;
+	i2c_imx->adapter.dev.parent = &pdev->dev;
+	i2c_imx->adapter.nr = pdev->id;
+	i2c_imx->adapter.dev.of_node = pdev->dev.of_node;
+	i2c_imx->base = base;
 
 	/* Get I2C clock */
 	i2c_imx->clk = devm_clk_get(&pdev->dev, NULL);
@@ -1031,6 +1103,23 @@ static int i2c_imx_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(i2c_imx->pinctrl)) {
+		ret = PTR_ERR(i2c_imx->pinctrl);
+		goto clk_disable;
+	}
+
+	i2c_imx->pinctrl_pins_default = pinctrl_lookup_state(i2c_imx->pinctrl,
+						PINCTRL_STATE_DEFAULT);
+	if (IS_ERR(i2c_imx->pinctrl_pins_default))
+		dev_warn(&pdev->dev, "could not get default state\n");
+	else {
+		i2c_imx->pinctrl_pins_gpio = pinctrl_lookup_state(i2c_imx->pinctrl,
+						I2C_PINCTRL_STATE_GPIO);
+		if (IS_ERR(i2c_imx->pinctrl_pins_gpio))
+			dev_warn(&pdev->dev, "could not get gpio state\n");
+	}
+
 	/* Request IRQ */
 	ret = devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
 				pdev->name, i2c_imx);
@@ -1057,6 +1146,24 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto rpm_disable;
 
+	/* Init recover pins */
+	i2c_imx->pins.sda =
+		devm_gpiod_get_optional(&pdev->dev, "sda-gpios", GPIOD_IN);
+	i2c_imx->pins.scl =
+		devm_gpiod_get_optional(&pdev->dev, "scl-gpios", GPIOD_IN);
+
+	if (IS_ERR(i2c_imx->pins.sda)) {
+		ret = PTR_ERR(i2c_imx->pins.sda);
+		goto clk_disable;
+	}
+
+	if (IS_ERR(i2c_imx->pins.scl)) {
+		ret = PTR_ERR(i2c_imx->pins.scl);
+		goto clk_disable;
+	}
+
+	i2c_imx->adapter.bus_recovery_info = &i2c_imx_bus_recovery_info;
+
 	/* Set up clock divider */
 	i2c_imx->bitrate = IMX_I2C_BIT_RATE;
 	ret = of_property_read_u32(pdev->dev.of_node,
-- 
1.9.1
