From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 14 Jun 2016 10:17:51 +0800
Subject: [PATCH 03/10] mfd: Add driver for X-Powers AC100 audio codec / RTC
 combo IC
In-Reply-To: <1465870678-30128-1-git-send-email-wens@csie.org>
References: <1465870678-30128-1-git-send-email-wens@csie.org>
Message-ID: <1465870678-30128-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AC100 is a multifunction device with an audio codec subsystem and
an RTC subsystem. These two subsystems share a common register space
and host interface.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/Kconfig       |  10 ++++
 drivers/mfd/Makefile      |   2 +
 drivers/mfd/ac100.c       | 116 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/ac100.h |  62 +++++++++++++++++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 drivers/mfd/ac100.c
 create mode 100644 include/linux/mfd/ac100.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 1bcf601de5bc..bd83849a0c8d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -101,6 +101,16 @@ config MFD_BCM590XX
 	help
 	  Support for the BCM590xx PMUs from Broadcom
 
+config MFD_AC100
+	tristate "X-Powers AC100"
+	select MFD_CORE
+	depends on SUNXI_RSB
+	help
+	  If you say Y here you get support for the X-Powers AC100 audio codec
+	  IC.
+	  This driver include only the core APIs. You have to select individual
+	  components like codecs or RTC under the corresponding menus.
+
 config MFD_AXP20X
 	tristate
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 42a66e19e191..60f9a6b0557c 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -113,6 +113,8 @@ obj-$(CONFIG_PMIC_DA9052)	+= da9052-irq.o
 obj-$(CONFIG_PMIC_DA9052)	+= da9052-core.o
 obj-$(CONFIG_MFD_DA9052_SPI)	+= da9052-spi.o
 obj-$(CONFIG_MFD_DA9052_I2C)	+= da9052-i2c.o
+
+obj-$(CONFIG_MFD_AC100)		+= ac100.o
 obj-$(CONFIG_MFD_AXP20X)	+= axp20x.o
 obj-$(CONFIG_MFD_AXP20X_I2C)	+= axp20x-i2c.o
 obj-$(CONFIG_MFD_AXP20X_RSB)	+= axp20x-rsb.o
diff --git a/drivers/mfd/ac100.c b/drivers/mfd/ac100.c
new file mode 100644
index 000000000000..3e6752e9dc07
--- /dev/null
+++ b/drivers/mfd/ac100.c
@@ -0,0 +1,116 @@
+/*
+ * ac100.c - MFD core driver for X-Powers' AC100 Audio Codec IC
+ *
+ * The AC100 is a highly integrated audio codec and RTC subsystem designed
+ * for mobile applications. It has 3 I2S/PCM interfaces, a 2 channel DAC,
+ * a 2 channel ADC with 5 inputs and a builtin mixer. The RTC subsystem has
+ * 3 clock outputs.
+ *
+ * The audio codec and RTC parts are completely separate, sharing only the
+ * host interface for access to its registers.
+ *
+ * Author: Chen-Yu Tsai <wens@csie.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/ac100.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/sunxi-rsb.h>
+
+static const struct regmap_range ac100_writeable_ranges[] = {
+	regmap_reg_range(AC100_CLK32K_ANALOG_CTRL, AC100_CLK32K_OUT_CTRL3),
+	regmap_reg_range(AC100_RTC_RST, AC100_RTC_UPD),
+	regmap_reg_range(AC100_ALM_INT_ENA, AC100_ALM_INT_STA),
+	regmap_reg_range(AC100_ALM_SEC, AC100_RTC_GP(15)),
+};
+
+static const struct regmap_range ac100_volatile_ranges[] = {
+	regmap_reg_range(AC100_RTC_RST, AC100_RTC_RST),
+	regmap_reg_range(AC100_RTC_SEC, AC100_ALM_INT_STA),
+	regmap_reg_range(AC100_ALM_SEC, AC100_ALM_UPD),
+};
+
+static const struct regmap_access_table ac100_writeable_table = {
+	.yes_ranges	= ac100_writeable_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(ac100_writeable_ranges),
+};
+
+static const struct regmap_access_table ac100_volatile_table = {
+	.yes_ranges	= ac100_volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(ac100_volatile_ranges),
+};
+
+static const struct regmap_config ac100_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 16,
+	.wr_table	= &ac100_writeable_table,
+	.volatile_table	= &ac100_volatile_table,
+	.max_register	= AC100_RTC_GP(15),
+	.cache_type	= REGCACHE_RBTREE,
+};
+
+static struct mfd_cell ac100_cells[] = {
+	{
+		.name		= "ac100-codec",
+		.of_compatible	= "x-powers,ac100-codec",
+	}, {
+		.name		= "ac100-rtc",
+		.of_compatible	= "x-powers,ac100-rtc",
+	},
+};
+
+static int ac100_rsb_probe(struct sunxi_rsb_device *rdev)
+{
+	struct ac100_dev *ac100;
+	int ret;
+
+	ac100 = devm_kzalloc(&rdev->dev, sizeof(*ac100), GFP_KERNEL);
+	if (!ac100)
+		return -ENOMEM;
+
+	ac100->dev = &rdev->dev;
+	sunxi_rsb_device_set_drvdata(rdev, ac100);
+
+	ac100->regmap = devm_regmap_init_sunxi_rsb(rdev, &ac100_regmap_config);
+	if (IS_ERR(ac100->regmap)) {
+		ret = PTR_ERR(ac100->regmap);
+		dev_err(ac100->dev, "regmap init failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_mfd_add_devices(ac100->dev, PLATFORM_DEVID_NONE, ac100_cells,
+				   ARRAY_SIZE(ac100_cells), NULL, 0, NULL);
+	if (ret) {
+		dev_err(ac100->dev, "failed to add MFD devices: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id ac100_of_match[] = {
+	{ .compatible = "x-powers,ac100" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ac100_of_match);
+
+static struct sunxi_rsb_driver ac100_rsb_driver = {
+	.driver = {
+		.name	= "ac100",
+		.of_match_table	= of_match_ptr(ac100_of_match),
+	},
+	.probe	= ac100_rsb_probe,
+};
+module_sunxi_rsb_driver(ac100_rsb_driver);
+
+MODULE_DESCRIPTION("Audio codec MFD core driver for AC100");
+MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/ac100.h b/include/linux/mfd/ac100.h
new file mode 100644
index 000000000000..6d3b9f5c5aa2
--- /dev/null
+++ b/include/linux/mfd/ac100.h
@@ -0,0 +1,62 @@
+/*
+ * Functions and registers to access AC100 codec / RTC combo IC.
+ *
+ * Copyright (C) 2013, Carlo Caione <carlo@caione.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_MFD_AC100_H
+#define __LINUX_MFD_AC100_H
+
+#include <linux/regmap.h>
+
+struct ac100_dev {
+	struct device			*dev;
+	struct regmap			*regmap;
+};
+
+/* Audio codec related registers */
+#define AC100_AUDIO_CHIP_RST		0x00
+#define AC100_PLL_CTRL1			0x01
+#define AC100_PLL_CTRL2			0x02
+#define AC100_SYSCLK_CTRL		0x03
+#define AC100_MOD_CLK_ENA		0x04
+#define AC100_MOD_RST_CTRL		0x05
+
+/* RTC */
+#define AC100_CLK32K_ANALOG_CTRL	0xc0
+#define AC100_CLK32K_OUT_CTRL1		0xc1
+#define AC100_CLK32K_OUT_CTRL2		0xc2
+#define AC100_CLK32K_OUT_CTRL3		0xc3
+
+/* RTC module */
+#define AC100_RTC_RST			0xc6
+#define AC100_RTC_CTRL			0xc7
+#define AC100_RTC_SEC			0xc8 /* second */
+#define AC100_RTC_MIN			0xc9 /* minute */
+#define AC100_RTC_HOU			0xca /* hour */
+#define AC100_RTC_WEE			0xcb /* weekday */
+#define AC100_RTC_DAY			0xcc /* day */
+#define AC100_RTC_MON			0xcd /* month */
+#define AC100_RTC_YEA			0xce /* year */
+#define AC100_RTC_UPD			0xcf /* update trigger */
+
+/* RTC Alarm */
+#define AC100_ALM_INT_ENA		0xd0
+#define	AC100_ALM_INT_STA		0xd1
+#define AC100_ALM_SEC			0xd8
+#define AC100_ALM_MIN			0xd9
+#define AC100_ALM_HOU			0xda
+#define AC100_ALM_WEE			0xdb
+#define AC100_ALM_DAY			0xdc
+#define AC100_ALM_MON			0xdd
+#define AC100_ALM_YEA			0xde
+#define AC100_ALM_UPD			0xdf
+
+/* RTC general purpose register 0 ~ 15 */
+#define AC100_RTC_GP(x)			(0xe0 + (x))
+
+#endif /* __LINUX_MFD_AC100_H */
-- 
2.8.1
