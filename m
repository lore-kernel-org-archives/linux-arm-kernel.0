From: B39297@freescale.com (Wu Guoxing-B39297)
Date: Fri, 4 Nov 2011 08:42:51 +0000
Subject: [PATCH v2] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function
In-Reply-To: <3D55990BDF4852409EA769663F22E54AC04776@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1320383924-18762-1-git-send-email-b39297@freescale.com>
	<3D55990BDF4852409EA769663F22E54AC04776@039-SN1MPN1-006.039d.mgd.msft.net>
Message-ID: <3D55990BDF4852409EA769663F22E54AC048C3@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Grant Likely into the cc list.

Sorry for missing.

Best Regards
Wu Guoxing

-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Wu Guoxing-B39297
Sent: Friday, November 04, 2011 2:01 PM
To: linux-arm-kernel at lists.infradead.org
Cc: s.hauer at pengutronix.de; shawn.guo at linaro.org
Subject: RE: [PATCH v2] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function

Changes since v1:
  Introduce "struct mc9s08dz60" for i2c client, instead of a static variable.

-----Original Message-----
From: Wu Guoxing-B39297
Sent: Friday, November 04, 2011 1:19 PM
To: linux-arm-kernel at lists.infradead.org
Cc: s.hauer at pengutronix.de; shawn.guo at linaro.org; Wu Guoxing-B39297
Subject: [PATCH v2] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function

we only use the gpio function of mc9s08dz60 mcu chip, so just add the gpio driver, as this mcu will never be used in other board.

Signed-off-by: Wu Guoxing <b39297@freescale.com>
---
 drivers/gpio/Kconfig           |    6 ++
 drivers/gpio/Makefile          |    1 +
 drivers/gpio/gpio-mc9s08dz60.c |  180 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+), 0 deletions(-)  create mode 100644 drivers/gpio/gpio-mc9s08dz60.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig index d539efd..7f6beee 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -487,4 +487,10 @@ config GPIO_TPS65910
 	help
 	  Select this option to enable GPIO driver for the TPS65910
 	  chip family.
+
+config GPIO_MC9S08DZ60
+	bool "MX35 3DS BOARD MC9S08DZ60 GPIO functions"
+	depends on I2C && MACH_MX35_3DS
+	help
+	  Select this to enable the MC9S08DZ60 GPIO driver
 endif
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile index 9588948..85b8799 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_GPIO_WM831X)	+= gpio-wm831x.o
 obj-$(CONFIG_GPIO_WM8350)	+= gpio-wm8350.o
 obj-$(CONFIG_GPIO_WM8994)	+= gpio-wm8994.o
 obj-$(CONFIG_GPIO_XILINX)	+= gpio-xilinx.o
+obj-$(CONFIG_GPIO_MC9S08DZ60) += gpio-mc9s08dz60.o
diff --git a/drivers/gpio/gpio-mc9s08dz60.c b/drivers/gpio/gpio-mc9s08dz60.c new file mode 100644 index 0000000..5724317
--- /dev/null
+++ b/drivers/gpio/gpio-mc9s08dz60.c
@@ -0,0 +1,180 @@
+/*
+ * Copyright 2009-2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * Author: Wu Guoxing <b39297@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+
+#define GPIO_GROUP_NUM 2
+#define GPIO_NUM_PER_GROUP 8
+#define GPIO_NUM (GPIO_GROUP_NUM*GPIO_NUM_PER_GROUP)
+
+struct mc9s08dz60 {
+	struct i2c_client *client;
+	struct gpio_chip chip;
+};
+
+static struct mc9s08dz60 *to_mc9s08dz60(struct gpio_chip *gc) {
+	return container_of(gc, struct mc9s08dz60, chip); }
+
+
+static int gpio_to_reg_and_bit(int offset, u8 *reg, u8 *bit) {
+	u8 ret = 0;
+	if (offset >= GPIO_NUM)
+		ret = -1;
+	else {
+		*reg = 0x20 + offset / GPIO_NUM_PER_GROUP;
+		*bit = offset % GPIO_NUM_PER_GROUP;
+	}
+
+	return ret;
+}
+
+static int mc9s08dz60_get_value(struct gpio_chip *gc, unsigned offset) 
+{
+	int ret = 0;
+	u8 reg, bit;
+	s32 value;
+	struct mc9s08dz60 *mc9s = to_mc9s08dz60(gc);
+
+	if (!gpio_to_reg_and_bit(offset, &reg, &bit)) {
+		value = i2c_smbus_read_byte_data(mc9s->client, reg);
+		if (value >= 0)
+			ret = (value >> bit) & 0x1;
+	}
+
+	return ret;
+}
+
+static void mc9s08dz60_set_value(struct gpio_chip *gc, unsigned offset, 
+int val) {
+	u8 reg, bit;
+	s32 value;
+	struct mc9s08dz60 *mc9s = to_mc9s08dz60(gc);
+
+	if (!gpio_to_reg_and_bit(offset, &reg, &bit)) {
+		value = i2c_smbus_read_byte_data(mc9s->client, reg);
+		if (value >= 0) {
+			if (val)
+				value |= 1 << bit;
+			else
+				value &= ~(1 << bit);
+
+			i2c_smbus_write_byte_data(mc9s->client, reg,
+						  value);
+		}
+	}
+}
+
+static int mc9s08dz60_direction_output(struct gpio_chip *gc,
+				       unsigned offset, int val)
+{
+	mc9s08dz60_set_value(gc, offset, val);
+	return 0;
+}
+
+static int mc9s08dz60_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	int ret = 0;
+	struct mc9s08dz60 *mc9s;
+
+	mc9s = kzalloc(sizeof(*mc9s), GFP_KERNEL);
+	if (!mc9s)
+		return -ENOMEM;
+
+	mc9s->chip.label = client->name;
+	mc9s->chip.base = -1;
+	mc9s->chip.dev = &client->dev;
+	mc9s->chip.owner = THIS_MODULE;
+	mc9s->chip.ngpio = GPIO_NUM;
+	mc9s->chip.get = mc9s08dz60_get_value;
+	mc9s->chip.set = mc9s08dz60_set_value;
+	mc9s->chip.direction_output = mc9s08dz60_direction_output;
+	mc9s->client = client;
+
+	ret = gpiochip_add(&mc9s->chip);
+	if (ret)
+		goto error;
+
+	i2c_set_clientdata(client, mc9s);
+
+	return 0;
+
+error:
+	kfree(mc9s);
+	return ret;
+}
+
+static int mc9s08dz60_remove(struct i2c_client *client) {
+	struct mc9s08dz60 *mc9s;
+	int ret;
+
+	mc9s = i2c_get_clientdata(client);
+	if (mc9s == NULL)
+		return -ENODEV;
+
+	i2c_set_clientdata(client, NULL);
+
+	ret = gpiochip_remove(&mc9s->chip);
+	if (!ret)
+		kfree(mc9s);
+
+	return ret;
+}
+
+static const struct i2c_device_id mc9s08dz60_id[] = {
+	{"mc9s08dz60", 0},
+	{},
+};
+
+MODULE_DEVICE_TABLE(i2c, mc9s08dz60_id);
+
+static struct i2c_driver mc9s08dz60_i2c_driver = {
+	.driver = {.owner = THIS_MODULE,
+		   .name = "mc9s08dz60",
+		   },
+	.probe = mc9s08dz60_probe,
+	.remove = mc9s08dz60_remove,
+	.id_table = mc9s08dz60_id,
+};
+
+int __init mc9s08dz60_init(void)
+{
+	int err;
+
+	err = i2c_add_driver(&mc9s08dz60_i2c_driver);
+	return err;
+}
+
+void __exit mc9s08dz60_exit(void)
+{
+	i2c_del_driver(&mc9s08dz60_i2c_driver);
+}
+
+module_init(mc9s08dz60_init);
+module_exit(mc9s08dz60_exit);
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc."
+		"Wu Guoxing <b39297@freescale.com>"); MODULE_DESCRIPTION("mc9s08dz60 
+gpio function on mx35 3ds board"); MODULE_LICENSE("GPL v2");
--
1.7.1



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
