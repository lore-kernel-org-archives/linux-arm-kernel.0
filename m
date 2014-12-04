From: 21cnbao@gmail.com (Barry Song)
Date: Thu,  4 Dec 2014 20:12:09 +0800
Subject: [PATCH 2/3] gpio: sx150x: add support for sx1506 gpio expander device
In-Reply-To: <1417695130-5712-1-git-send-email-21cnbao@gmail.com>
References: <1417695130-5712-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1417695130-5712-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Chen <Wei.Chen@csr.com>

semtech has two series of sx150x gpio expanders: sx150x-456 and
sx150x-789.

The current gpio-150x driver in linux only support sx1508 and
sx1509.

We added sx1506 support code into this driver.

Signed-off-by: Wei Chen <Wei.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/gpio/gpio-sx150x.c | 157 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 112 insertions(+), 45 deletions(-)

diff --git a/drivers/gpio/gpio-sx150x.c b/drivers/gpio/gpio-sx150x.c
index 0bc61c2..b32fb38 100644
--- a/drivers/gpio/gpio-sx150x.c
+++ b/drivers/gpio/gpio-sx150x.c
@@ -26,20 +26,43 @@
 
 #define NO_UPDATE_PENDING	-1
 
+/* The chip models of sx150x */
+#define SX150X_456 0
+#define SX150X_789 1
+
+struct sx150x_456_pri {
+	u8 reg_pld_mode;
+	u8 reg_pld_table0;
+	u8 reg_pld_table1;
+	u8 reg_pld_table2;
+	u8 reg_pld_table3;
+	u8 reg_pld_table4;
+	u8 reg_advance;
+};
+
+struct sx150x_789_pri {
+	u8 reg_drain;
+	u8 reg_polarity;
+	u8 reg_clock;
+	u8 reg_misc;
+	u8 reg_reset;
+	u8 ngpios;
+};
+
 struct sx150x_device_data {
+	u8 model;
 	u8 reg_pullup;
 	u8 reg_pulldn;
-	u8 reg_drain;
-	u8 reg_polarity;
 	u8 reg_dir;
 	u8 reg_data;
 	u8 reg_irq_mask;
 	u8 reg_irq_src;
 	u8 reg_sense;
-	u8 reg_clock;
-	u8 reg_misc;
-	u8 reg_reset;
 	u8 ngpios;
+	union {
+		struct sx150x_456_pri x456;
+		struct sx150x_789_pri x789;
+	} pri;
 };
 
 struct sx150x_chip {
@@ -59,40 +82,67 @@ struct sx150x_chip {
 
 static const struct sx150x_device_data sx150x_devices[] = {
 	[0] = { /* sx1508q */
-		.reg_pullup   = 0x03,
-		.reg_pulldn   = 0x04,
-		.reg_drain    = 0x05,
-		.reg_polarity = 0x06,
-		.reg_dir      = 0x07,
-		.reg_data     = 0x08,
-		.reg_irq_mask = 0x09,
-		.reg_irq_src  = 0x0c,
-		.reg_sense    = 0x0b,
-		.reg_clock    = 0x0f,
-		.reg_misc     = 0x10,
-		.reg_reset    = 0x7d,
-		.ngpios       = 8
+		.model = SX150X_789,
+		.reg_pullup	= 0x03,
+		.reg_pulldn	= 0x04,
+		.reg_dir	= 0x07,
+		.reg_data	= 0x08,
+		.reg_irq_mask	= 0x09,
+		.reg_irq_src	= 0x0c,
+		.reg_sense	= 0x0b,
+		.pri.x789 = {
+			.reg_drain	= 0x05,
+			.reg_polarity	= 0x06,
+			.reg_clock	= 0x0f,
+			.reg_misc	= 0x10,
+			.reg_reset	= 0x7d,
+		},
+		.ngpios = 8,
 	},
 	[1] = { /* sx1509q */
-		.reg_pullup   = 0x07,
-		.reg_pulldn   = 0x09,
-		.reg_drain    = 0x0b,
-		.reg_polarity = 0x0d,
-		.reg_dir      = 0x0f,
-		.reg_data     = 0x11,
-		.reg_irq_mask = 0x13,
-		.reg_irq_src  = 0x19,
-		.reg_sense    = 0x17,
-		.reg_clock    = 0x1e,
-		.reg_misc     = 0x1f,
-		.reg_reset    = 0x7d,
-		.ngpios       = 16
+		.model = SX150X_789,
+		.reg_pullup	= 0x07,
+		.reg_pulldn	= 0x09,
+		.reg_dir	= 0x0f,
+		.reg_data	= 0x11,
+		.reg_irq_mask	= 0x13,
+		.reg_irq_src	= 0x19,
+		.reg_sense	= 0x17,
+		.pri.x789 = {
+			.reg_drain	= 0x0b,
+			.reg_polarity	= 0x0d,
+			.reg_clock	= 0x1e,
+			.reg_misc	= 0x1f,
+			.reg_reset	= 0x7d,
+		},
+		.ngpios	= 16
+	},
+	[2] = { /* sx1506q */
+		.model = SX150X_456,
+		.reg_pullup	= 0x05,
+		.reg_pulldn	= 0x07,
+		.reg_dir	= 0x03,
+		.reg_data	= 0x01,
+		.reg_irq_mask	= 0x09,
+		.reg_irq_src	= 0x0f,
+		.reg_sense	= 0x0d,
+		.pri.x456 = {
+			.reg_pld_mode	= 0x21,
+			.reg_pld_table0	= 0x23,
+			.reg_pld_table1	= 0x25,
+			.reg_pld_table2	= 0x27,
+			.reg_pld_table3	= 0x29,
+			.reg_pld_table4	= 0x2b,
+			.reg_advance	= 0xad,
+		},
+		.ngpios	= 16
 	},
 };
 
 static const struct i2c_device_id sx150x_id[] = {
 	{"sx1508q", 0},
 	{"sx1509q", 1},
+	{"sx1506q", 2},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, sx150x_id);
@@ -191,7 +241,7 @@ static int sx150x_get_io(struct sx150x_chip *chip, unsigned offset)
 static void sx150x_set_oscio(struct sx150x_chip *chip, int val)
 {
 	sx150x_i2c_write(chip->client,
-			chip->dev_cfg->reg_clock,
+			chip->dev_cfg->pri.x789.reg_clock,
 			(val ? 0x1f : 0x10));
 }
 
@@ -455,13 +505,13 @@ static int sx150x_reset(struct sx150x_chip *chip)
 	int err;
 
 	err = i2c_smbus_write_byte_data(chip->client,
-					chip->dev_cfg->reg_reset,
+					chip->dev_cfg->pri.x789.reg_reset,
 					0x12);
 	if (err < 0)
 		return err;
 
 	err = i2c_smbus_write_byte_data(chip->client,
-					chip->dev_cfg->reg_reset,
+					chip->dev_cfg->pri.x789.reg_reset,
 					0x34);
 	return err;
 }
@@ -477,9 +527,14 @@ static int sx150x_init_hw(struct sx150x_chip *chip,
 			return err;
 	}
 
-	err = sx150x_i2c_write(chip->client,
-			chip->dev_cfg->reg_misc,
-			0x01);
+	if (chip->dev_cfg->model == SX150X_789)
+		err = sx150x_i2c_write(chip->client,
+				chip->dev_cfg->pri.x789.reg_misc,
+				0x01);
+	else
+		err = sx150x_i2c_write(chip->client,
+				chip->dev_cfg->pri.x456.reg_advance,
+				0x04);
 	if (err < 0)
 		return err;
 
@@ -493,15 +548,27 @@ static int sx150x_init_hw(struct sx150x_chip *chip,
 	if (err < 0)
 		return err;
 
-	err = sx150x_init_io(chip, chip->dev_cfg->reg_drain,
-			pdata->io_open_drain_ena);
-	if (err < 0)
-		return err;
+	if (chip->dev_cfg->model == SX150X_789) {
+		err = sx150x_init_io(chip,
+				chip->dev_cfg->pri.x789.reg_drain,
+				pdata->io_open_drain_ena);
+		if (err < 0)
+			return err;
+
+		err = sx150x_init_io(chip,
+				chip->dev_cfg->pri.x789.reg_polarity,
+				pdata->io_polarity);
+		if (err < 0)
+			return err;
+	} else {
+		/* Set all pins to work in normal mode */
+		err = sx150x_init_io(chip,
+				chip->dev_cfg->pri.x456.reg_pld_mode,
+				0);
+		if (err < 0)
+			return err;
+	}
 
-	err = sx150x_init_io(chip, chip->dev_cfg->reg_polarity,
-			pdata->io_polarity);
-	if (err < 0)
-		return err;
 
 	if (pdata->oscio_is_gpo)
 		sx150x_set_oscio(chip, 0);
-- 
2.2.0
