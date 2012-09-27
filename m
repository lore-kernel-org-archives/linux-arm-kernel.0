From: stigge@antcom.de (Roland Stigge)
Date: Thu, 27 Sep 2012 23:22:03 +0200
Subject: [PATCH RFC 2/2] gpio-max730x: Add block GPIO API
In-Reply-To: <1348780923-27428-1-git-send-email-stigge@antcom.de>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
Message-ID: <1348780923-27428-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds block GPIO API support to the MAX730x driver.

Due to hardware constraints in this chip, simultaneous access to GPIO lines can
only be done in groups of 8: GPIOs 0-7, 8-15, 16-23, 24-27. However, setting
and clearing will be done at once.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 drivers/gpio/gpio-max730x.c |   53 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

--- linux-2.6.orig/drivers/gpio/gpio-max730x.c
+++ linux-2.6/drivers/gpio/gpio-max730x.c
@@ -146,6 +146,37 @@ static int max7301_get(struct gpio_chip
 	return level;
 }
 
+static void max7301_get_block(struct gpio_chip *chip, u8 *values, size_t size)
+{
+	struct max7301 *ts = container_of(chip, struct max7301, chip);
+	int i, j;
+
+	for (i = 0; i < size; i++) {
+		u8 in_level = ts->read(ts->dev, 0x44 + i * 8);
+		u8 in_mask = 0;
+		u8 out_level = (ts->out_level >> (i * 8 + 4)) & 0xFF;
+		u8 out_mask = 0;
+
+		for (j = 0; j < 8; j++) {
+			int offset = 4 + i * 8 + j;
+			int config = (ts->port_config[offset >> 2] >>
+				      ((offset & 3) << 1)) &
+				     PIN_CONFIG_MASK;
+
+			switch (config) {
+			case PIN_CONFIG_OUT:
+				out_mask |= BIT(j);
+				break;
+			case PIN_CONFIG_IN_WO_PULLUP:
+			case PIN_CONFIG_IN_PULLUP:
+				in_mask |= BIT(j);
+			}
+		}
+
+		values[i] = (in_level & in_mask) | (out_level & out_mask);
+	}
+}
+
 static void max7301_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct max7301 *ts = container_of(chip, struct max7301, chip);
@@ -160,6 +191,26 @@ static void max7301_set(struct gpio_chip
 	mutex_unlock(&ts->lock);
 }
 
+static
+void max7301_set_block(struct gpio_chip *chip, u8 *set, u8 *clr, size_t size)
+{
+	struct max7301 *ts = container_of(chip, struct max7301, chip);
+	int i;
+
+	mutex_lock(&ts->lock);
+
+	for (i = 0; i < size; i++) {
+		if (set[i] | clr[i]) { /* only on change */
+			ts->out_level |= (u32)set[i] << (i * 8 + 4);
+			ts->out_level &= ~((u32)clr[i] << (i * 8 + 4));
+			ts->write(ts->dev, 0x44 + i * 8,
+				  (ts->out_level >> (i * 8 + 4)) & 0xFF);
+		}
+	}
+
+	mutex_unlock(&ts->lock);
+}
+
 int __devinit __max730x_probe(struct max7301 *ts)
 {
 	struct device *dev = ts->dev;
@@ -183,8 +234,10 @@ int __devinit __max730x_probe(struct max
 
 	ts->chip.direction_input = max7301_direction_input;
 	ts->chip.get = max7301_get;
+	ts->chip.get_block = max7301_get_block;
 	ts->chip.direction_output = max7301_direction_output;
 	ts->chip.set = max7301_set;
+	ts->chip.set_block = max7301_set_block;
 
 	ts->chip.base = pdata->base;
 	ts->chip.ngpio = PIN_NUMBER;
