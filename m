From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 28 Jul 2011 14:41:33 +0800
Subject: [PATCH v2 7/7] i2c: pxa: support to parse property
In-Reply-To: <1311835293-18125-7-git-send-email-haojian.zhuang@marvell.com>
References: <1311835293-18125-1-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-2-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-3-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-4-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-5-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-6-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-7-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1311835293-18125-8-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support to parse some optional properties. These three properties are
mrvl,use-polling, mrvl,i2c-frequency, mrvl,i2c-class.

After supporting these property, i2c-pxa driver can avoid to use platform
data except for slave mode.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 .../devicetree/bindings/i2c/pxa255-i2c.txt         |   38 ++++++++++++++++++++
 drivers/i2c/busses/i2c-pxa.c                       |   20 +++++++---
 2 files changed, 52 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/pxa255-i2c.txt

diff --git a/Documentation/devicetree/bindings/i2c/pxa255-i2c.txt b/Documentation/devicetree/bindings/i2c/pxa255-i2c.txt
new file mode 100644
index 0000000..4b5afae
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/pxa255-i2c.txt
@@ -0,0 +1,38 @@
+PXA255 I2C
+
+The I2C-Controller is first used in PXA255. It's widely used in Intel/Marvell
+silicons.
+
+Optional Property:
+	- mrvl,use-polling: Specifies whether I2C-Controller is used in polling
+	  mode or interrupt mode. The type of property should be <empty>.
+
+	- mrvl,i2c-frequency: Specifies the frequency that the I2C-Controller
+	  is working. It indicates I2C-Controller running in standard(100Kb/s)
+	  or fast(400Kb/s) speed.
+	  The type of property should be <string>. The value should be "fast".
+
+	- mrvl,i2c-class: Specifies the adaptor class of I2C-Controller, such as
+	  hwmon or ddc bus. The type of property should be <u32>.
+
+Example:
+	i2c0: i2c at d4011000 {
+		compatible = "pxa2xx-i2c";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0xd4011000 0x60>;
+		/* I2C-Controller works in polling mode. */
+		mrvl,use-polling;
+		/* I2C-Controller's frequency is FAST. */
+		mrvl,i2c-frequency = "fast";
+		/* interrupt of I2C-Controller */
+		interrupts = <7>;
+		interrupt-parent = <&mmp_intc>;
+
+		pm860x: pmic at 34 {
+			interrupt-controller;
+			/* interrupt of pm860x */
+			interrupts = <4>;
+			interrupt-parent = <&mmp_intc>;
+		};
+	};
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 8c27733..cebcd26 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1061,6 +1061,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	enum pxa_i2c_types i2c_type;
 	struct resource *res;
 	int irq, ret;
+	char *p = NULL;
 	static int idx = 0;
 
 	if (np) {
@@ -1093,11 +1094,24 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 
 	if (np) {
+		if (of_get_property(np, "mrvl,use-polling", NULL))
+			i2c->use_pio = 1;
+		of_property_read_string(np, "mrvl,i2c-frequency", &p);
+		if (p && !strncmp(p, "fast", 4))
+			i2c->fast_mode = 1;
+		of_property_read_u32(np, "mrvl,i2c-class", &i2c->adap.class);
+
 		i2c->adap.nr = idx++;
 		snprintf(i2c->adap.name, sizeof(i2c->adap.name),
 			"pxa2xx-i2c.%u", i2c->adap.nr);
 		i2c->clk = clk_get_sys(i2c->adap.name, NULL);
 	} else {
+		if (plat) {
+			i2c->adap.class = plat->class;
+			i2c->use_pio = plat->use_pio;
+			i2c->fast_mode = plat->fast_mode;
+		}
+
 		/*
 		 * If "dev->id" is negative we consider it as zero.
 		 * The reason to do so is to avoid sysfs names that only make
@@ -1142,12 +1156,6 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	clk_enable(i2c->clk);
 
-	if (plat) {
-		i2c->adap.class = plat->class;
-		i2c->use_pio = plat->use_pio;
-		i2c->fast_mode = plat->fast_mode;
-	}
-
 	if (i2c->use_pio) {
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
 	} else {
-- 
1.5.6.5
