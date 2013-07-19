From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Jul 2013 13:35:28 +0900
Subject: [PATCH 3/7] backlight: Add ROHM BD6107 backlight driver
In-Reply-To: <cover.1374207161.git.horms+renesas@verge.net.au>
References: <cover.1374207161.git.horms+renesas@verge.net.au>
Message-ID: <67b43e590415866649e5ba8a6421bb84ecb74f72.1374207161.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The BD6107 is a multi-purpose 10 channels LED driver for the mobile
market. Only the main channel is supported by this driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/video/backlight/Kconfig      |    6 +
 drivers/video/backlight/Makefile     |    1 +
 drivers/video/backlight/bd6107.c     |  213 ++++++++++++++++++++++++++++++++++
 include/linux/platform_data/bd6107.h |   19 +++
 4 files changed, 239 insertions(+)
 create mode 100644 drivers/video/backlight/bd6107.c
 create mode 100644 include/linux/platform_data/bd6107.h

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index b304e07..d4a7a35 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -438,6 +438,12 @@ config BACKLIGHT_LV5207LP
 	help
 	  If you have a Sanyo LV5207LP say Y to enable the backlight driver.
 
+config BACKLIGHT_BD6107
+	tristate "Rohm BD6107 Backlight"
+	depends on I2C
+	help
+	  If you have a Rohm BD6107 say Y to enable the backlight driver.
+
 endif # BACKLIGHT_CLASS_DEVICE
 
 endif # BACKLIGHT_LCD_SUPPORT
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 4e5e811..38e1bab 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_BACKLIGHT_ADP8870)		+= adp8870_bl.o
 obj-$(CONFIG_BACKLIGHT_APPLE)		+= apple_bl.o
 obj-$(CONFIG_BACKLIGHT_AS3711)		+= as3711_bl.o
 obj-$(CONFIG_BACKLIGHT_ATMEL_PWM)	+= atmel-pwm-bl.o
+obj-$(CONFIG_BACKLIGHT_BD6107)		+= bd6107.o
 obj-$(CONFIG_BACKLIGHT_CARILLO_RANCH)	+= cr_bllcd.o
 obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE)	+= backlight.o
 obj-$(CONFIG_BACKLIGHT_DA903X)		+= da903x_bl.o
diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
new file mode 100644
index 0000000..15e3294
--- /dev/null
+++ b/drivers/video/backlight/bd6107.c
@@ -0,0 +1,213 @@
+/*
+ * ROHM Semiconductor BD6107 LED Driver
+ *
+ * Copyright (C) 2013 Ideas on board SPRL
+ *
+ * Contact: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/fb.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/platform_data/bd6107.h>
+#include <linux/slab.h>
+
+#define BD6107_PSCNT1				0x00
+#define BD6107_PSCNT1_PSCNTREG2			(1 << 2)
+#define BD6107_PSCNT1_PSCNTREG1			(1 << 0)
+#define BD6107_REGVSET				0x02
+#define BD6107_REGVSET_REG1VSET_2_85V		(1 << 2)
+#define BD6107_REGVSET_REG1VSET_2_80V		(0 << 2)
+#define BD6107_LEDCNT1				0x03
+#define BD6107_LEDCNT1_LEDONOFF2		(1 << 1)
+#define BD6107_LEDCNT1_LEDONOFF1		(1 << 0)
+#define BD6107_PORTSEL				0x04
+#define BD6107_PORTSEL_LEDM(n)			(1 << (n))
+#define BD6107_RGB1CNT1				0x05
+#define BD6107_RGB1CNT2				0x06
+#define BD6107_RGB1CNT3				0x07
+#define BD6107_RGB1CNT4				0x08
+#define BD6107_RGB1CNT5				0x09
+#define BD6107_RGB1FLM				0x0a
+#define BD6107_RGB2CNT1				0x0b
+#define BD6107_RGB2CNT2				0x0c
+#define BD6107_RGB2CNT3				0x0d
+#define BD6107_RGB2CNT4				0x0e
+#define BD6107_RGB2CNT5				0x0f
+#define BD6107_RGB2FLM				0x10
+#define BD6107_PSCONT3				0x11
+#define BD6107_SMMONCNT				0x12
+#define BD6107_DCDCCNT				0x13
+#define BD6107_IOSEL				0x14
+#define BD6107_OUT1				0x15
+#define BD6107_OUT2				0x16
+#define BD6107_MASK1				0x17
+#define BD6107_MASK2				0x18
+#define BD6107_FACTOR1				0x19
+#define BD6107_FACTOR2				0x1a
+#define BD6107_CLRFACT1				0x1b
+#define BD6107_CLRFACT2				0x1c
+#define BD6107_STATE1				0x1d
+#define BD6107_LSIVER				0x1e
+#define BD6107_GRPSEL				0x1f
+#define BD6107_LEDCNT2				0x20
+#define BD6107_LEDCNT3				0x21
+#define BD6107_MCURRENT				0x22
+#define BD6107_MAINCNT1				0x23
+#define BD6107_MAINCNT2				0x24
+#define BD6107_SLOPECNT				0x25
+#define BD6107_MSLOPE				0x26
+#define BD6107_RGBSLOPE				0x27
+#define BD6107_TEST				0x29
+#define BD6107_SFTRST				0x2a
+#define BD6107_SFTRSTGD				0x2b
+
+struct bd6107 {
+	struct i2c_client *client;
+	struct backlight_device *backlight;
+	struct bd6107_platform_data *pdata;
+};
+
+static int bd6107_write(struct bd6107 *bd, u8 reg, u8 data)
+{
+	return i2c_smbus_write_byte_data(bd->client, reg, data);
+}
+
+static int bd6107_backlight_update_status(struct backlight_device *backlight)
+{
+	struct bd6107 *bd = bl_get_data(backlight);
+	int brightness = backlight->props.brightness;
+
+	if (backlight->props.power != FB_BLANK_UNBLANK ||
+	    backlight->props.fb_blank != FB_BLANK_UNBLANK ||
+	    backlight->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
+		brightness = 0;
+
+	if (brightness) {
+		bd6107_write(bd, BD6107_PORTSEL, BD6107_PORTSEL_LEDM(2) |
+			     BD6107_PORTSEL_LEDM(1) | BD6107_PORTSEL_LEDM(0));
+		bd6107_write(bd, BD6107_MAINCNT1, brightness);
+		bd6107_write(bd, BD6107_LEDCNT1, BD6107_LEDCNT1_LEDONOFF1);
+	} else {
+		gpio_set_value(bd->pdata->reset, 0);
+		msleep(24);
+		gpio_set_value(bd->pdata->reset, 1);
+	}
+
+	return 0;
+}
+
+static int bd6107_backlight_get_brightness(struct backlight_device *backlight)
+{
+	return backlight->props.brightness;
+}
+
+static int bd6107_backlight_check_fb(struct backlight_device *backlight,
+				       struct fb_info *info)
+{
+	struct bd6107 *bd = bl_get_data(backlight);
+
+	return bd->pdata->fbdev == NULL || bd->pdata->fbdev == info->dev;
+}
+
+static const struct backlight_ops bd6107_backlight_ops = {
+	.options	= BL_CORE_SUSPENDRESUME,
+	.update_status	= bd6107_backlight_update_status,
+	.get_brightness	= bd6107_backlight_get_brightness,
+	.check_fb	= bd6107_backlight_check_fb,
+};
+
+static int bd6107_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct bd6107_platform_data *pdata = client->dev.platform_data;
+	struct backlight_device *backlight;
+	struct backlight_properties props;
+	struct bd6107 *bd;
+	int ret;
+
+	if (pdata == NULL || !pdata->reset) {
+		dev_err(&client->dev, "No reset GPIO in platform data\n");
+		return -EINVAL;
+	}
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA)) {
+		dev_warn(&client->dev,
+			 "I2C adapter doesn't support I2C_FUNC_SMBUS_BYTE\n");
+		return -EIO;
+	}
+
+	bd = devm_kzalloc(&client->dev, sizeof(*bd), GFP_KERNEL);
+	if (!bd)
+		return -ENOMEM;
+
+	bd->client = client;
+	bd->pdata = pdata;
+
+	ret = devm_gpio_request_one(&client->dev, pdata->reset,
+				    GPIOF_DIR_OUT | GPIOF_INIT_LOW, "reset");
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to request reset GPIO\n");
+		return ret;
+	}
+
+	memset(&props, 0, sizeof(props));
+	props.type = BACKLIGHT_RAW;
+	props.max_brightness = 128;
+	props.brightness = clamp_t(unsigned int, pdata->def_value, 0,
+				   props.max_brightness);
+
+	backlight = backlight_device_register(dev_name(&client->dev),
+					      &bd->client->dev, bd,
+					      &bd6107_backlight_ops, &props);
+	if (IS_ERR(backlight)) {
+		dev_err(&client->dev, "failed to register backlight\n");
+		return PTR_ERR(backlight);
+	}
+
+	backlight_update_status(backlight);
+	i2c_set_clientdata(client, backlight);
+
+	return 0;
+}
+
+static int bd6107_remove(struct i2c_client *client)
+{
+	struct backlight_device *backlight = i2c_get_clientdata(client);
+
+	backlight->props.brightness = 0;
+	backlight_update_status(backlight);
+	backlight_device_unregister(backlight);
+
+	return 0;
+}
+
+static const struct i2c_device_id bd6107_ids[] = {
+	{ "bd6107", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, bd6107_ids);
+
+static struct i2c_driver bd6107_driver = {
+	.driver = {
+		.name = "bd6107",
+	},
+	.probe = bd6107_probe,
+	.remove = bd6107_remove,
+	.id_table = bd6107_ids,
+};
+
+module_i2c_driver(bd6107_driver);
+
+MODULE_DESCRIPTION("Rohm BD6107 Backlight Driver");
+MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/bd6107.h b/include/linux/platform_data/bd6107.h
new file mode 100644
index 0000000..671d650
--- /dev/null
+++ b/include/linux/platform_data/bd6107.h
@@ -0,0 +1,19 @@
+/*
+ * bd6107.h - Rohm BD6107 LEDs Driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __BD6107_H__
+#define __BD6107_H__
+
+struct device;
+
+struct bd6107_platform_data {
+	struct device *fbdev;
+	int reset;			/* Reset GPIO */
+	unsigned int def_value;
+};
+
+#endif
-- 
1.7.10.4
