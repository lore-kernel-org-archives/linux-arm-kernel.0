From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 29 Apr 2016 12:59:49 +0200
Subject: [RFT PATCH 1/3] usb: misc: usb3503: Fix HUB mode after bootloader
 initialization
In-Reply-To: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
References: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1461927591-7864-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Odroid U3 (Exynos4412-based) board if USB was initialized by
bootloader (in U-Boot "usb start" before tftpboot), the HUB after after
successful probing was not visible in the system ("lsusb"). Connected
devices were not visible neither.

In such case the USB3503 has to be fully reset before configuring to HUB
mode. Reset by GPIO (called RESET_N pin) and by RESET field in STCD
register are not sufficient. Instead full reset has to be done by
disabling and enabling regulator.

The USB3503 can work with different regulator configurations, however
toggling of only one is relevant in mentioned case: the VDD 3.3V.

The patch adds:
1. New binding for optional regulator (VDD33),
2. Code for toggling the regulator on/off before doing reset by GPIO,
3. Initial reset during probing before configuring HUB mode.

Patch is very loosely based on Tobias Jakobi's similar work for usb3503.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Tested on Odroid U3 so far. Please kindly test on X2 or other
configurations and bootloaders.
---
 Documentation/devicetree/bindings/usb/usb3503.txt |  1 +
 drivers/usb/misc/usb3503.c                        | 81 +++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb3503.txt b/Documentation/devicetree/bindings/usb/usb3503.txt
index c1a0a9191d26..36516ade9467 100644
--- a/Documentation/devicetree/bindings/usb/usb3503.txt
+++ b/Documentation/devicetree/bindings/usb/usb3503.txt
@@ -24,6 +24,7 @@ Optional properties:
 	pins (optional, if not provided, driver will not set rate of the
 	REFCLK signal and assume that a value from the primary reference
 	clock frequencies table is used)
+- vdd33-supply: Optional supply for VDD 3.3 V power source.
 
 Examples:
 	usb3503 at 08 {
diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
index b45cb77c0744..8905e8b2439d 100644
--- a/drivers/usb/misc/usb3503.c
+++ b/drivers/usb/misc/usb3503.c
@@ -28,6 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/usb3503.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #define USB3503_VIDL		0x00
 #define USB3503_VIDM		0x01
@@ -59,6 +60,7 @@ struct usb3503 {
 	struct regmap		*regmap;
 	struct device		*dev;
 	struct clk		*clk;
+	struct regulator	*vdd_reg;
 	u8	port_off_mask;
 	int	gpio_intn;
 	int	gpio_reset;
@@ -66,8 +68,31 @@ struct usb3503 {
 	bool	secondary_ref_clk;
 };
 
+static int usb3503_regulator(struct usb3503 *hub, int state)
+{
+	int ret;
+
+	if (!hub->vdd_reg)
+		return 0;
+
+	if (state)
+		ret = regulator_enable(hub->vdd_reg);
+	else
+		ret = regulator_disable(hub->vdd_reg);
+
+	return ret;
+}
+
 static int usb3503_reset(struct usb3503 *hub, int state)
 {
+	int err;
+
+	err = usb3503_regulator(hub, state);
+	if (err) {
+		dev_err(hub->dev, "unable to %s VDD33 regulator to (%d)\n",
+			(state ? "enable" : "disable"), err);
+	}
+
 	if (!state && gpio_is_valid(hub->gpio_connect))
 		gpio_set_value_cansleep(hub->gpio_connect, 0);
 
@@ -260,6 +285,15 @@ static int usb3503_probe(struct usb3503 *hub)
 			return -EPROBE_DEFER;
 		of_property_read_u32(np, "initial-mode", &mode);
 		hub->mode = mode;
+
+		hub->vdd_reg = devm_regulator_get_optional(dev, "vdd33");
+		if (IS_ERR(hub->vdd_reg)) {
+			if (PTR_ERR(hub->vdd_reg) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			hub->vdd_reg = NULL;
+		} else {
+			dev_dbg(dev, "Using VDD33 regulator for full reset\n");
+		}
 	}
 
 	if (hub->port_off_mask && !hub->regmap)
@@ -299,6 +333,21 @@ static int usb3503_probe(struct usb3503 *hub)
 			return err;
 		}
 	}
+	err = usb3503_regulator(hub, true);
+	if (err) {
+		dev_err(dev, "unable to enable VDD33 regulator (%d)\n", err);
+		return err;
+	}
+
+	/*
+	 * Perform real full reset before configuring.
+	 * On some boards (e.g. on Odroid U3 board with LAN9730/SMSC95xx)
+	 * after enabling the USB by bootloader it has to be fully reset
+	 * here to be visible.
+	 */
+	usb3503_reset(hub, 0);
+	/* Settle down before powering on again */
+	usleep_range(4000, 10000);
 
 	usb3503_switch_mode(hub, hub->mode);
 
@@ -330,6 +379,21 @@ static int usb3503_i2c_probe(struct i2c_client *i2c,
 	return usb3503_probe(hub);
 }
 
+static int usb3503_i2c_remove(struct i2c_client *i2c)
+{
+	struct usb3503 *hub;
+
+	hub = i2c_get_clientdata(i2c);
+	if (hub) {
+		if (hub->clk)
+			clk_disable_unprepare(hub->clk);
+
+		usb3503_regulator(hub, false);
+	}
+
+	return 0;
+}
+
 static int usb3503_platform_probe(struct platform_device *pdev)
 {
 	struct usb3503 *hub;
@@ -342,6 +406,21 @@ static int usb3503_platform_probe(struct platform_device *pdev)
 	return usb3503_probe(hub);
 }
 
+static int usb3503_platform_remove(struct platform_device *pdev)
+{
+	struct usb3503 *hub;
+
+	hub = platform_get_drvdata(pdev);
+	if (hub) {
+		if (hub->clk)
+			clk_disable_unprepare(hub->clk);
+
+		usb3503_regulator(hub, false);
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int usb3503_i2c_suspend(struct device *dev)
 {
@@ -395,6 +474,7 @@ static struct i2c_driver usb3503_i2c_driver = {
 		.of_match_table = of_match_ptr(usb3503_of_match),
 	},
 	.probe		= usb3503_i2c_probe,
+	.remove		= usb3503_i2c_remove,
 	.id_table	= usb3503_id,
 };
 
@@ -404,6 +484,7 @@ static struct platform_driver usb3503_platform_driver = {
 		.of_match_table = of_match_ptr(usb3503_of_match),
 	},
 	.probe		= usb3503_platform_probe,
+	.remove		= usb3503_platform_remove,
 };
 
 static int __init usb3503_init(void)
-- 
1.9.1
