From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 18 Sep 2012 17:02:29 +0800
Subject: [PATCH] i2c: i2c-gpio: fix issue when DT node greater than 1
Message-ID: <1347958949-5598-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When i2c-gpio node number is greater than 1, the second can not sucessfully
regiter

Using alias method to get the pdev->id, or else the second device will use
the same id which will cause fail to register

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 Documentation/devicetree/bindings/i2c/gpio-i2c.txt |   46 +++++++++++++++++++-
 drivers/i2c/busses/i2c-gpio.c                      |    1 +
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/gpio-i2c.txt b/Documentation/devicetree/bindings/i2c/gpio-i2c.txt
index 4f8ec94..e76dd00 100644
--- a/Documentation/devicetree/bindings/i2c/gpio-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/gpio-i2c.txt
@@ -1,4 +1,7 @@
-Device-Tree bindings for i2c gpio driver
+* Device-Tree bindings for i2c gpio driver
+
+Optional alias:
+	- i2c-gpio: used to get id, when more than one i2c-gpio in dts file
 
 Required properties:
 	- compatible = "i2c-gpio";
@@ -30,3 +33,44 @@ i2c at 0 {
 		reg = <0x56>;
 	};
 };
+
+
+Example nodes with alias:
+
+aliases {
+	i2c-gpio0 = &i2c0;
+	i2c-gpio1 = &i2c1;
+};
+
+i2c0: i2c at 0 {
+	compatible = "i2c-gpio";
+	gpios = <&pioA 23 0 /* sda */
+		 &pioA 24 0 /* scl */
+		>;
+	i2c-gpio,sda-open-drain;
+	i2c-gpio,scl-open-drain;
+	i2c-gpio,delay-us = <2>;	/* ~100 kHz */
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	rv3029c2 at 56 {
+		compatible = "rv3029c2";
+		reg = <0x56>;
+	};
+};
+
+i2c1: i2c at 0 {
+	compatible = "i2c-gpio";
+	gpios = <&pioA 30 0 /* sda */
+		 &pioA 31 0 /* scl */
+		>;
+	i2c-gpio,sda-open-drain;
+	i2c-gpio,scl-open-drain;
+	i2c-gpio,delay-us = <2>;	/* ~100 kHz */
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	rv3029c2 at 56 {
+		compatible = "rv3029c2";
+		reg = <0x56>;
+	};
diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index e62d2d9..051fbb3 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -136,6 +136,7 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
 		ret = of_i2c_gpio_probe(pdev->dev.of_node, pdata);
 		if (ret)
 			return ret;
+		pdev->id = of_alias_get_id(pdev->dev.of_node, "i2c-gpio");
 	} else {
 		if (!pdev->dev.platform_data)
 			return -ENXIO;
-- 
1.7.9.5
