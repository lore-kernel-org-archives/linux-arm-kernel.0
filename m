From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  5 Apr 2011 22:24:08 +0200
Subject: [PATCH v2] leds: provide helper to register "leds-gpio" devices
In-Reply-To: <20110405163338.GA11832@n2100.arm.linux.org.uk>
References: <20110405163338.GA11832@n2100.arm.linux.org.uk>
Message-ID: <1302035048-25819-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function makes a deep copy of the platform data to allow it to live
in init memory.
The definition cannot go into leds-gpio.c because it needs to be builtin
to be usable by platforms.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
changes since v1:
 - don't add __init to the declaration of gpio_led_register_device

 drivers/leds/led-core.c |   27 ++++++++++++++++++++++++++-
 include/linux/leds.h    |   12 ++++++++++++
 2 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index 016d19f..a9a762e 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -2,8 +2,10 @@
  * LED Class Core
  *
  * Copyright 2005-2006 Openedhand Ltd.
+ * Richard Purdie <rpurdie@openedhand.com>
  *
- * Author: Richard Purdie <rpurdie@openedhand.com>
+ * Copyright (C) 2009-2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -16,6 +18,9 @@
 #include <linux/module.h>
 #include <linux/rwsem.h>
 #include <linux/leds.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
 #include "leds.h"
 
 DECLARE_RWSEM(leds_list_lock);
@@ -23,3 +28,23 @@ EXPORT_SYMBOL_GPL(leds_list_lock);
 
 LIST_HEAD(leds_list);
 EXPORT_SYMBOL_GPL(leds_list);
+
+struct platform_device *__init gpio_led_register_device(
+                const struct gpio_led_platform_data *pdata)
+{
+	struct platform_device *ret = ERR_PTR(-ENOMEM);
+	struct gpio_led_platform_data _pdata = *pdata;
+	_pdata.leds = kmemdup(pdata->leds,
+			pdata->num_leds * sizeof(*pdata->leds), GFP_KERNEL);
+
+	if (!_pdata.leds)
+		return ERR_PTR(-ENOMEM);
+
+	ret = platform_device_register_resndata(NULL, "leds-gpio", -1,
+			NULL, 0, &_pdata, sizeof(_pdata));
+
+	if (IS_ERR(ret))
+		kfree(_pdata.leds);
+
+	return ret;
+}
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 61e0340..1c82006 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -207,5 +207,17 @@ struct gpio_led_platform_data {
 					unsigned long *delay_off);
 };
 
+/**
+ * gpio_led_register_device - register a gpio-led device
+ * @pdata: the platform data used for the new device
+ *
+ * Use this function instead of platform_device_add()ing a static struct
+ * platform_device.
+ *
+ * Note: as pdata and pdata->leds is copied these usually can and should be
+ * __initdata.
+ */
+struct platform_device *gpio_led_register_device(
+		const struct gpio_led_platform_data *pdata);
 
 #endif		/* __LINUX_LEDS_H_INCLUDED */
-- 
1.7.2.3
