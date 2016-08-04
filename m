From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 04 Aug 2016 15:38:41 +0200
Subject: [PATCH 1/8] ASoC: L3 bus: Add default gpio ops
In-Reply-To: <1470317928-25365-1-git-send-email-s.nawrocki@samsung.com>
References: <1470317928-25365-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1470317928-25365-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds aptional GPIO bit-bang based callback implementations
for setting CLK, DATA and MODE L3 bus lines.  It is added here
to avoid possible duplicate implementations across users of
the bus.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 include/sound/l3.h    | 15 ++++++++---
 sound/soc/codecs/l3.c | 71 ++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 71 insertions(+), 15 deletions(-)

diff --git a/include/sound/l3.h b/include/sound/l3.h
index 423a08f..1471da2 100644
--- a/include/sound/l3.h
+++ b/include/sound/l3.h
@@ -2,9 +2,15 @@
 #define _L3_H_ 1
 
 struct l3_pins {
-	void (*setdat)(int);
-	void (*setclk)(int);
-	void (*setmode)(int);
+	void (*setdat)(struct l3_pins *, int);
+	void (*setclk)(struct l3_pins *, int);
+	void (*setmode)(struct l3_pins *, int);
+
+	int gpio_data;
+	int gpio_clk;
+	int gpio_mode;
+	int use_gpios;
+
 	int data_hold;
 	int data_setup;
 	int clock_high;
@@ -13,6 +19,9 @@ struct l3_pins {
 	int mode_setup;
 };
 
+struct device;
+
 int l3_write(struct l3_pins *adap, u8 addr, u8 *data, int len);
+int l3_set_gpio_ops(struct device *dev, struct l3_pins *adap);
 
 #endif
diff --git a/sound/soc/codecs/l3.c b/sound/soc/codecs/l3.c
index 5353af5..a10ea3c 100644
--- a/sound/soc/codecs/l3.c
+++ b/sound/soc/codecs/l3.c
@@ -20,6 +20,8 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio.h>
 
 #include <sound/l3.h>
 
@@ -32,11 +34,11 @@ static void sendbyte(struct l3_pins *adap, unsigned int byte)
 	int i;
 
 	for (i = 0; i < 8; i++) {
-		adap->setclk(0);
+		adap->setclk(adap, 0);
 		udelay(adap->data_hold);
-		adap->setdat(byte & 1);
+		adap->setdat(adap, byte & 1);
 		udelay(adap->data_setup);
-		adap->setclk(1);
+		adap->setclk(adap, 1);
 		udelay(adap->clock_high);
 		byte >>= 1;
 	}
@@ -55,10 +57,10 @@ static void sendbytes(struct l3_pins *adap, const u8 *buf,
 	for (i = 0; i < len; i++) {
 		if (i) {
 			udelay(adap->mode_hold);
-			adap->setmode(0);
+			adap->setmode(adap, 0);
 			udelay(adap->mode);
 		}
-		adap->setmode(1);
+		adap->setmode(adap, 1);
 		udelay(adap->mode_setup);
 		sendbyte(adap, buf[i]);
 	}
@@ -66,26 +68,71 @@ static void sendbytes(struct l3_pins *adap, const u8 *buf,
 
 int l3_write(struct l3_pins *adap, u8 addr, u8 *data, int len)
 {
-	adap->setclk(1);
-	adap->setdat(1);
-	adap->setmode(1);
+	adap->setclk(adap, 1);
+	adap->setdat(adap, 1);
+	adap->setmode(adap, 1);
 	udelay(adap->mode);
 
-	adap->setmode(0);
+	adap->setmode(adap, 0);
 	udelay(adap->mode_setup);
 	sendbyte(adap, addr);
 	udelay(adap->mode_hold);
 
 	sendbytes(adap, data, len);
 
-	adap->setclk(1);
-	adap->setdat(1);
-	adap->setmode(0);
+	adap->setclk(adap, 1);
+	adap->setdat(adap, 1);
+	adap->setmode(adap, 0);
 
 	return len;
 }
 EXPORT_SYMBOL_GPL(l3_write);
 
+
+static void l3_set_clk(struct l3_pins *adap, int val)
+{
+	gpio_set_value(adap->gpio_clk, val);
+}
+
+static void l3_set_data(struct l3_pins *adap, int val)
+{
+	gpio_set_value(adap->gpio_data, val);
+}
+
+static void l3_set_mode(struct l3_pins *adap, int val)
+{
+	gpio_set_value(adap->gpio_mode, val);
+}
+
+int l3_set_gpio_ops(struct device *dev, struct l3_pins *adap)
+{
+	int ret;
+
+	if (!adap->use_gpios)
+		return -EINVAL;
+
+	ret = devm_gpio_request_one(dev, adap->gpio_data,
+				GPIOF_OUT_INIT_LOW, "l3_data");
+	if (ret < 0)
+		return ret;
+	adap->setdat = l3_set_data;
+
+	ret = devm_gpio_request_one(dev, adap->gpio_clk,
+				GPIOF_OUT_INIT_LOW, "l3_clk");
+	if (ret < 0)
+		return ret;
+	adap->setclk = l3_set_clk;
+
+	ret = devm_gpio_request_one(dev, adap->gpio_mode,
+				GPIOF_OUT_INIT_LOW, "l3_mode");
+	if (ret < 0)
+		return ret;
+	adap->setmode = l3_set_mode;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(l3_set_gpio_ops);
+
 MODULE_DESCRIPTION("L3 bit-banging driver");
 MODULE_AUTHOR("Christian Pellegrin <chripell@evolware.org>");
 MODULE_LICENSE("GPL");
-- 
1.9.1
