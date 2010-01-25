From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 25 Jan 2010 06:26:34 -0500
Subject: [PATCH] mfd: update i2c driver for max8925
Message-ID: <mailman.167.1264417637.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update I2C driver in order to fit all of three I2C components in max8925.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/max8925-i2c.c |  111 ++++++++++++++++++++++++++++++---------------
 1 files changed, 74 insertions(+), 37 deletions(-)

diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
index 942068e..0e22921 100644
--- a/drivers/mfd/max8925-i2c.c
+++ b/drivers/mfd/max8925-i2c.c
@@ -14,27 +14,23 @@
 #include <linux/i2c.h>
 #include <linux/mfd/max8925.h>

+#define RTC_I2C_ADDR		0x68
+#define ADC_I2C_ADDR		0x47
+
 static inline int max8925_read_device(struct i2c_client *i2c,
 				      int reg, int bytes, void *dest)
 {
-	unsigned char data;
-	unsigned char *buf;
 	int ret;

-	buf = kzalloc(bytes + 1, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	data = (unsigned char)reg;
-	ret = i2c_master_send(i2c, &data, 1);
-	if (ret < 0)
-		return ret;
-
-	ret = i2c_master_recv(i2c, buf, bytes + 1);
-	if (ret < 0)
-		return ret;
-	memcpy(dest, buf, bytes);
-	return 0;
+	if (bytes > 1)
+		ret = i2c_smbus_read_i2c_block_data(i2c, reg, bytes, dest);
+	else {
+		ret = i2c_smbus_read_byte_data(i2c, reg);
+		if (ret < 0)
+			return ret;
+		*(unsigned char *)dest = (unsigned char)ret;
+	}
+	return ret;
 }

 static inline int max8925_write_device(struct i2c_client *i2c,
@@ -55,7 +51,7 @@ static inline int max8925_write_device(struct i2c_client *i2c,
 int max8925_reg_read(struct i2c_client *i2c, int reg)
 {
 	struct max8925_chip *chip = i2c_get_clientdata(i2c);
-	unsigned char data;
+	unsigned char data = 0;
 	int ret;

 	mutex_lock(&chip->io_lock);
@@ -134,7 +130,7 @@ EXPORT_SYMBOL(max8925_set_bits);

 static const struct i2c_device_id max8925_id_table[] = {
 	{ "max8925", 0 },
-	{}
+	{ },
 };
 MODULE_DEVICE_TABLE(i2c, max8925_id_table);

@@ -142,28 +138,56 @@ static int __devinit max8925_probe(struct
i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	struct max8925_platform_data *pdata = client->dev.platform_data;
-	struct max8925_chip *chip;
+	struct i2c_board_info rtc_info, adc_info;
+	const unsigned short addr_rtc[] = {
+		RTC_I2C_ADDR,
+		I2C_CLIENT_END,
+	};
+	const unsigned short addr_adc[] = {
+		ADC_I2C_ADDR,
+		I2C_CLIENT_END,
+	};
+	static struct max8925_chip *chip;
+	static int init_gpm = 0, init_adc = 0, init_rtc = 0, count = 0;

 	if (!pdata) {
 		pr_info("%s: platform data is missing\n", __func__);
 		return -EINVAL;
 	}
-	if ((pdata->chip_id <= MAX8925_INVALID)
-		|| (pdata->chip_id >= MAX8925_MAX)) {
-		pr_info("#%s: wrong chip identification\n", __func__);
-		return -EINVAL;
-	}

-	chip = kzalloc(sizeof(struct max8925_chip), GFP_KERNEL);
-	if (chip == NULL)
-		return -ENOMEM;
-	chip->i2c = client;
-	chip->chip_id = pdata->chip_id;
-	i2c_set_clientdata(client, chip);
-	chip->dev = &client->dev;
-	mutex_init(&chip->io_lock);
-	dev_set_drvdata(chip->dev, chip);
-	max8925_device_init(chip, pdata);
+	if (!init_gpm) {
+		init_gpm = 1;
+		chip = kzalloc(sizeof(struct max8925_chip), GFP_KERNEL);
+		if (chip == NULL)
+			return -ENOMEM;
+		chip->i2c = client;
+		chip->dev = &client->dev;
+		i2c_set_clientdata(client, chip);
+		dev_set_drvdata(chip->dev, chip);
+		mutex_init(&chip->io_lock);
+	}
+	if (!init_rtc) {
+		init_rtc = 1;
+		memset(&rtc_info, 0, sizeof(struct i2c_board_info));
+		strlcpy(rtc_info.type, "max8925", I2C_NAME_SIZE);
+		rtc_info.platform_data = chip->i2c->dev.platform_data;
+		chip->rtc = i2c_new_probed_device(chip->i2c->adapter,
+						&rtc_info, addr_rtc);
+		i2c_set_clientdata(chip->rtc, chip);
+	} else if (!init_adc) {
+		init_adc = 1;
+		memset(&adc_info, 0, sizeof(struct i2c_board_info));
+		strlcpy(adc_info.type, "max8925", I2C_NAME_SIZE);
+		adc_info.platform_data = chip->i2c->dev.platform_data;
+		if (pdata->tsc_irq > 0)
+			adc_info.irq = pdata->tsc_irq;
+		chip->adc = i2c_new_probed_device(chip->i2c->adapter,
+						&adc_info, addr_adc);
+		i2c_set_clientdata(chip->adc, chip);
+	}
+	/* Initialize max8925 until all of three I2C clients are ready */
+	if (++count == 3)
+		max8925_device_init(chip, pdata);

 	return 0;
 }
@@ -171,10 +195,23 @@ static int __devinit max8925_probe(struct
i2c_client *client,
 static int __devexit max8925_remove(struct i2c_client *client)
 {
 	struct max8925_chip *chip = i2c_get_clientdata(client);
+	static int init_gpm = 1, init_adc = 1, init_rtc = 1;

-	max8925_device_exit(chip);
-	i2c_set_clientdata(client, NULL);
-	kfree(chip);
+	if (client->addr == ADC_I2C_ADDR)
+		init_adc = 0;
+	else if (client->addr == RTC_I2C_ADDR)
+		init_rtc = 0;
+	else
+		init_gpm = 0;
+	if (!init_gpm && !init_rtc && !init_adc) {
+		max8925_device_exit(chip);
+		i2c_unregister_device(chip->adc);
+		i2c_unregister_device(chip->rtc);
+		i2c_set_clientdata(chip->adc, NULL);
+		i2c_set_clientdata(chip->rtc, NULL);
+		i2c_set_clientdata(chip->i2c, NULL);
+		kfree(chip);
+	}
 	return 0;
 }

-- 
1.5.6.5
