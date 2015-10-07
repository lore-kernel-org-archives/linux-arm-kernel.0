From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 07 Oct 2015 09:30:06 +0900
Subject: [RFT 2/3] usb: misc: usb3503: Allow usage of device through phy
 interface
In-Reply-To: <1444177807-15524-1-git-send-email-k.kozlowski@samsung.com>
References: <1444177807-15524-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1444177807-15524-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB3503 hub controller can be connected through I2C interface (e.g.
on Odroid-U3 board) or directly by phy (e.g. on Arndale board). Thus the
usb3503 driver can act as a i2c or platform device.

In the second configuration (phy) the driver did not get a reference to
necessary phy to use it. This lead to probe failure if PHY driver was
probed after usb3503 probe.

The patch adds support for generic phy framework so the driver will the
phy reference (if provided) and use it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reported-by: Kevin Hilman <khilman@kernel.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: riku.voipio at linaro.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/misc/usb3503.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
index 64ff5b91752d..e9423fc28105 100644
--- a/drivers/usb/misc/usb3503.c
+++ b/drivers/usb/misc/usb3503.c
@@ -27,6 +27,7 @@
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/usb3503.h>
+#include <linux/phy/phy.h>
 #include <linux/regmap.h>
 
 #define USB3503_VIDL		0x00
@@ -59,6 +60,7 @@ struct usb3503 {
 	struct regmap		*regmap;
 	struct device		*dev;
 	struct clk		*clk;
+	struct phy		*phy;
 	u8	port_off_mask;
 	int	gpio_intn;
 	int	gpio_reset;
@@ -66,6 +68,29 @@ struct usb3503 {
 	bool	secondary_ref_clk;
 };
 
+static int usb3503_phy_on(struct usb3503 *hub)
+{
+	int err;
+
+	err = phy_power_on(hub->phy);
+	if (err)
+		return err;
+
+	err = phy_init(hub->phy);
+	if (err) {
+		phy_power_off(hub->phy);
+		return err;
+	}
+
+	return 0;
+}
+
+static void usb3503_phy_off(struct usb3503 *hub)
+{
+	phy_exit(hub->phy);
+	phy_power_off(hub->phy);
+}
+
 static int usb3503_reset(struct usb3503 *hub, int state)
 {
 	if (!state && gpio_is_valid(hub->gpio_connect))
@@ -189,6 +214,13 @@ static int usb3503_probe(struct usb3503 *hub)
 		u32 rate = 0;
 		hub->port_off_mask = 0;
 
+		hub->phy = devm_phy_optional_get(dev, "usb2-phy");
+		if (IS_ERR(hub->phy)) {
+			err = PTR_ERR(hub->phy);
+			if (err != -EPROBE_DEFER)
+				dev_err(dev, "unable to get phy: %d\n", err);
+			return err;
+		}
 		if (!of_property_read_u32(np, "refclk-frequency", &rate)) {
 			switch (rate) {
 			case 38400000:
@@ -300,6 +332,10 @@ static int usb3503_probe(struct usb3503 *hub)
 		}
 	}
 
+	err = usb3503_phy_on(hub);
+	if (err)
+		return err;
+
 	usb3503_switch_mode(hub, hub->mode);
 
 	dev_info(dev, "%s: probed in %s mode\n", __func__,
@@ -339,9 +375,29 @@ static int usb3503_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	hub->dev = &pdev->dev;
 
+	platform_set_drvdata(pdev, hub);
+
 	return usb3503_probe(hub);
 }
 
+static int usb3503_i2c_remove(struct i2c_client *i2c)
+{
+	struct usb3503 *hub = i2c_get_clientdata(i2c);
+
+	usb3503_phy_off(hub);
+
+	return 0;
+}
+
+static int usb3503_platform_remove(struct platform_device *pdev)
+{
+	struct usb3503 *hub = platform_get_drvdata(pdev);
+
+	usb3503_phy_off(hub);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int usb3503_i2c_suspend(struct device *dev)
 {
@@ -350,6 +406,8 @@ static int usb3503_i2c_suspend(struct device *dev)
 
 	usb3503_switch_mode(hub, USB3503_MODE_STANDBY);
 
+	usb3503_phy_off(hub);
+
 	if (hub->clk)
 		clk_disable_unprepare(hub->clk);
 
@@ -360,10 +418,15 @@ static int usb3503_i2c_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct usb3503 *hub = i2c_get_clientdata(client);
+	int err;
 
 	if (hub->clk)
 		clk_prepare_enable(hub->clk);
 
+	err = usb3503_phy_on(hub);
+	if (err)
+		return err;
+
 	usb3503_switch_mode(hub, hub->mode);
 
 	return 0;
@@ -395,6 +458,7 @@ static struct i2c_driver usb3503_i2c_driver = {
 		.of_match_table = of_match_ptr(usb3503_of_match),
 	},
 	.probe		= usb3503_i2c_probe,
+	.remove		= usb3503_i2c_remove,
 	.id_table	= usb3503_id,
 };
 
@@ -404,6 +468,7 @@ static struct platform_driver usb3503_platform_driver = {
 		.of_match_table = of_match_ptr(usb3503_of_match),
 	},
 	.probe		= usb3503_platform_probe,
+	.remove		= usb3503_platform_remove,
 };
 
 static int __init usb3503_init(void)
-- 
1.9.1
