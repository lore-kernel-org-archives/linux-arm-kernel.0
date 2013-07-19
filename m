From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Jul 2013 13:35:27 +0900
Subject: [PATCH 2/7] backlight: Add Sanyo LV5207LP backlight driver
In-Reply-To: <cover.1374207161.git.horms+renesas@verge.net.au>
References: <cover.1374207161.git.horms+renesas@verge.net.au>
Message-ID: <82e5c40d88f928afffe7bd4027719d3184433908.1374207161.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The LV5207LP is a multi-purpose 7 LEDs driver for the mobile market.
Only the main LED is supported by this driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/video/backlight/Kconfig        |    6 ++
 drivers/video/backlight/Makefile       |    1 +
 drivers/video/backlight/lv5207lp.c     |  171 ++++++++++++++++++++++++++++++++
 include/linux/platform_data/lv5207lp.h |   19 ++++
 4 files changed, 197 insertions(+)
 create mode 100644 drivers/video/backlight/lv5207lp.c
 create mode 100644 include/linux/platform_data/lv5207lp.h

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 5ab6423..b304e07 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -432,6 +432,12 @@ config BACKLIGHT_GPIO
 	  If you have a LCD backlight adjustable by GPIO, say Y to enable
 	  this driver.
 
+config BACKLIGHT_LV5207LP
+	tristate "Sanyo LV5207LP Backlight"
+	depends on I2C
+	help
+	  If you have a Sanyo LV5207LP say Y to enable the backlight driver.
+
 endif # BACKLIGHT_CLASS_DEVICE
 
 endif # BACKLIGHT_LCD_SUPPORT
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 65698a8..4e5e811 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_BACKLIGHT_LM3639)		+= lm3639_bl.o
 obj-$(CONFIG_BACKLIGHT_LOCOMO)		+= locomolcd.o
 obj-$(CONFIG_BACKLIGHT_LP855X)		+= lp855x_bl.o
 obj-$(CONFIG_BACKLIGHT_LP8788)		+= lp8788_bl.o
+obj-$(CONFIG_BACKLIGHT_LV5207LP)	+= lv5207lp.o
 obj-$(CONFIG_BACKLIGHT_MAX8925)		+= max8925_bl.o
 obj-$(CONFIG_BACKLIGHT_OMAP1)		+= omap1_bl.o
 obj-$(CONFIG_BACKLIGHT_OT200)		+= ot200_bl.o
diff --git a/drivers/video/backlight/lv5207lp.c b/drivers/video/backlight/lv5207lp.c
new file mode 100644
index 0000000..498fd73
--- /dev/null
+++ b/drivers/video/backlight/lv5207lp.c
@@ -0,0 +1,171 @@
+/*
+ * Sanyo LV5207LP LED Driver
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
+#include <linux/err.h>
+#include <linux/fb.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/platform_data/lv5207lp.h>
+#include <linux/slab.h>
+
+#define LV5207LP_CTRL1			0x00
+#define LV5207LP_CPSW			(1 << 7)
+#define LV5207LP_SCTEN			(1 << 6)
+#define LV5207LP_C10			(1 << 5)
+#define LV5207LP_CKSW			(1 << 4)
+#define LV5207LP_RSW			(1 << 3)
+#define LV5207LP_GSW			(1 << 2)
+#define LV5207LP_BSW			(1 << 1)
+#define LV5207LP_CTRL2			0x01
+#define LV5207LP_MSW			(1 << 7)
+#define LV5207LP_MLED4			(1 << 6)
+#define LV5207LP_RED			0x02
+#define LV5207LP_GREEN			0x03
+#define LV5207LP_BLUE			0x04
+
+#define LV5207LP_MAX_BRIGHTNESS		32
+
+struct lv5207lp {
+	struct i2c_client *client;
+	struct backlight_device *backlight;
+	struct lv5207lp_platform_data *pdata;
+};
+
+static int lv5207lp_write(struct lv5207lp *lv, u8 reg, u8 data)
+{
+	return i2c_smbus_write_byte_data(lv->client, reg, data);
+}
+
+static int lv5207lp_backlight_update_status(struct backlight_device *backlight)
+{
+	struct lv5207lp *lv = bl_get_data(backlight);
+	int brightness = backlight->props.brightness;
+
+	if (backlight->props.power != FB_BLANK_UNBLANK ||
+	    backlight->props.fb_blank != FB_BLANK_UNBLANK ||
+	    backlight->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
+		brightness = 0;
+
+	if (brightness) {
+		lv5207lp_write(lv, LV5207LP_CTRL1,
+			       LV5207LP_CPSW | LV5207LP_C10 | LV5207LP_CKSW);
+		lv5207lp_write(lv, LV5207LP_CTRL2,
+			       LV5207LP_MSW | LV5207LP_MLED4 |
+			       (brightness - 1));
+	} else {
+		lv5207lp_write(lv, LV5207LP_CTRL1, 0);
+		lv5207lp_write(lv, LV5207LP_CTRL2, 0);
+	}
+
+	return 0;
+}
+
+static int lv5207lp_backlight_get_brightness(struct backlight_device *backlight)
+{
+	return backlight->props.brightness;
+}
+
+static int lv5207lp_backlight_check_fb(struct backlight_device *backlight,
+				       struct fb_info *info)
+{
+	struct lv5207lp *lv = bl_get_data(backlight);
+
+	return lv->pdata->fbdev == NULL || lv->pdata->fbdev == info->dev;
+}
+
+static const struct backlight_ops lv5207lp_backlight_ops = {
+	.options	= BL_CORE_SUSPENDRESUME,
+	.update_status	= lv5207lp_backlight_update_status,
+	.get_brightness	= lv5207lp_backlight_get_brightness,
+	.check_fb	= lv5207lp_backlight_check_fb,
+};
+
+static int lv5207lp_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct lv5207lp_platform_data *pdata = client->dev.platform_data;
+	struct backlight_device *backlight;
+	struct backlight_properties props;
+	struct lv5207lp *lv;
+
+	if (pdata == NULL) {
+		dev_err(&client->dev, "No platform data supplied\n");
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
+	lv = devm_kzalloc(&client->dev, sizeof(*lv), GFP_KERNEL);
+	if (!lv)
+		return -ENOMEM;
+
+	lv->client = client;
+	lv->pdata = pdata;
+
+	memset(&props, 0, sizeof(props));
+	props.type = BACKLIGHT_RAW;
+	props.max_brightness = min_t(unsigned int, pdata->max_value,
+				     LV5207LP_MAX_BRIGHTNESS);
+	props.brightness = clamp_t(unsigned int, pdata->def_value, 0,
+				   props.max_brightness);
+
+	backlight = backlight_device_register(dev_name(&client->dev),
+					      &lv->client->dev, lv,
+					      &lv5207lp_backlight_ops, &props);
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
+static int lv5207lp_remove(struct i2c_client *client)
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
+static const struct i2c_device_id lv5207lp_ids[] = {
+	{ "lv5207lp", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lv5207lp_ids);
+
+static struct i2c_driver lv5207lp_driver = {
+	.driver = {
+		.name = "lv5207lp",
+	},
+	.probe = lv5207lp_probe,
+	.remove = lv5207lp_remove,
+	.id_table = lv5207lp_ids,
+};
+
+module_i2c_driver(lv5207lp_driver);
+
+MODULE_DESCRIPTION("Sanyo LV5207LP Backlight Driver");
+MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/lv5207lp.h b/include/linux/platform_data/lv5207lp.h
new file mode 100644
index 0000000..7dc4d9a
--- /dev/null
+++ b/include/linux/platform_data/lv5207lp.h
@@ -0,0 +1,19 @@
+/*
+ * lv5207lp.h - Sanyo LV5207LP LEDs Driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __LV5207LP_H__
+#define __LV5207LP_H__
+
+struct device;
+
+struct lv5207lp_platform_data {
+	struct device *fbdev;
+	unsigned int max_value;
+	unsigned int def_value;
+};
+
+#endif
-- 
1.7.10.4
