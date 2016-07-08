From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  8 Jul 2016 22:33:37 +0800
Subject: [PATCH v5 2/7] mfd: ac100: Add driver for X-Powers AC100 audio codec
 / RTC combo IC
In-Reply-To: <1467988422-17934-1-git-send-email-wens@csie.org>
References: <1467988422-17934-1-git-send-email-wens@csie.org>
Message-ID: <1467988422-17934-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AC100 is a multifunction device with an audio codec subsystem and
an RTC subsystem. These two subsystems share a common register space
and host interface.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
Changes since v4:

  - None.

Changes since v3:

  - Changed register name prefix to CLKOUT_ for clock output controls

Changes since v2:

  - Dropped file name
  - Added copyright line.
  - Changed MODULE_LICENSE to GPL v2, matching the header
  - Added Lee's ack

---
 drivers/mfd/Kconfig       |  10 +++
 drivers/mfd/Makefile      |   2 +
 drivers/mfd/ac100.c       | 137 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/ac100.h | 178 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 327 insertions(+)
 create mode 100644 drivers/mfd/ac100.c
 create mode 100644 include/linux/mfd/ac100.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 00ec1290b639..c2ceb303c856 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -112,6 +112,16 @@ config MFD_BCM590XX
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
index 2ba3ba35f745..bca83dbb5ed8 100644
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
index 000000000000..9bc69cd7807d
--- /dev/null
+++ b/drivers/mfd/ac100.c
@@ -0,0 +1,137 @@
+/*
+ * MFD core driver for X-Powers' AC100 Audio Codec IC
+ *
+ * The AC100 is a highly integrated audio codec and RTC subsystem designed
+ * for mobile applications. It has 3 I2S/PCM interfaces, a 2 channel DAC,
+ * a 2 channel ADC with 5 inputs and a builtin mixer. The RTC subsystem has
+ * 3 clock outputs.
+ *
+ * The audio codec and RTC parts are completely separate, sharing only the
+ * host interface for access to its registers.
+ *
+ * Copyright (2016) Chen-Yu Tsai
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
+	regmap_reg_range(AC100_CHIP_AUDIO_RST, AC100_I2S_SR_CTRL),
+	regmap_reg_range(AC100_I2S1_CLK_CTRL, AC100_I2S1_MXR_GAIN),
+	regmap_reg_range(AC100_I2S2_CLK_CTRL, AC100_I2S2_MXR_GAIN),
+	regmap_reg_range(AC100_I2S3_CLK_CTRL, AC100_I2S3_SIG_PATH_CTRL),
+	regmap_reg_range(AC100_ADC_DIG_CTRL, AC100_ADC_VOL_CTRL),
+	regmap_reg_range(AC100_HMIC_CTRL1, AC100_HMIC_STATUS),
+	regmap_reg_range(AC100_DAC_DIG_CTRL, AC100_DAC_MXR_GAIN),
+	regmap_reg_range(AC100_ADC_APC_CTRL, AC100_LINEOUT_CTRL),
+	regmap_reg_range(AC100_ADC_DAP_L_CTRL, AC100_ADC_DAP_OPT),
+	regmap_reg_range(AC100_DAC_DAP_CTRL, AC100_DAC_DAP_OPT),
+	regmap_reg_range(AC100_ADC_DAP_ENA, AC100_DAC_DAP_ENA),
+	regmap_reg_range(AC100_SRC1_CTRL1, AC100_SRC1_CTRL2),
+	regmap_reg_range(AC100_SRC2_CTRL1, AC100_SRC2_CTRL2),
+	regmap_reg_range(AC100_CLK32K_ANALOG_CTRL, AC100_CLKOUT_CTRL3),
+	regmap_reg_range(AC100_RTC_RST, AC100_RTC_UPD),
+	regmap_reg_range(AC100_ALM_INT_ENA, AC100_ALM_INT_STA),
+	regmap_reg_range(AC100_ALM_SEC, AC100_RTC_GP(15)),
+};
+
+static const struct regmap_range ac100_volatile_ranges[] = {
+	regmap_reg_range(AC100_CHIP_AUDIO_RST, AC100_PLL_CTRL2),
+	regmap_reg_range(AC100_HMIC_STATUS, AC100_HMIC_STATUS),
+	regmap_reg_range(AC100_ADC_DAP_L_STA, AC100_ADC_DAP_L_STA),
+	regmap_reg_range(AC100_SRC1_CTRL1, AC100_SRC1_CTRL1),
+	regmap_reg_range(AC100_SRC1_CTRL3, AC100_SRC2_CTRL1),
+	regmap_reg_range(AC100_SRC2_CTRL3, AC100_SRC2_CTRL4),
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
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/ac100.h b/include/linux/mfd/ac100.h
new file mode 100644
index 000000000000..3c148f196b9f
--- /dev/null
+++ b/include/linux/mfd/ac100.h
@@ -0,0 +1,178 @@
+/*
+ * Functions and registers to access AC100 codec / RTC combo IC.
+ *
+ * Copyright (C) 2016 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
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
+#define AC100_CHIP_AUDIO_RST		0x00
+#define AC100_PLL_CTRL1			0x01
+#define AC100_PLL_CTRL2			0x02
+#define AC100_SYSCLK_CTRL		0x03
+#define AC100_MOD_CLK_ENA		0x04
+#define AC100_MOD_RST_CTRL		0x05
+#define AC100_I2S_SR_CTRL		0x06
+
+/* I2S1 interface */
+#define AC100_I2S1_CLK_CTRL		0x10
+#define AC100_I2S1_SND_OUT_CTRL		0x11
+#define AC100_I2S1_SND_IN_CTRL		0x12
+#define AC100_I2S1_MXR_SRC		0x13
+#define AC100_I2S1_VOL_CTRL1		0x14
+#define AC100_I2S1_VOL_CTRL2		0x15
+#define AC100_I2S1_VOL_CTRL3		0x16
+#define AC100_I2S1_VOL_CTRL4		0x17
+#define AC100_I2S1_MXR_GAIN		0x18
+
+/* I2S2 interface */
+#define AC100_I2S2_CLK_CTRL		0x20
+#define AC100_I2S2_SND_OUT_CTRL		0x21
+#define AC100_I2S2_SND_IN_CTRL		0x22
+#define AC100_I2S2_MXR_SRC		0x23
+#define AC100_I2S2_VOL_CTRL1		0x24
+#define AC100_I2S2_VOL_CTRL2		0x25
+#define AC100_I2S2_VOL_CTRL3		0x26
+#define AC100_I2S2_VOL_CTRL4		0x27
+#define AC100_I2S2_MXR_GAIN		0x28
+
+/* I2S3 interface */
+#define AC100_I2S3_CLK_CTRL		0x30
+#define AC100_I2S3_SND_OUT_CTRL		0x31
+#define AC100_I2S3_SND_IN_CTRL		0x32
+#define AC100_I2S3_SIG_PATH_CTRL	0x33
+
+/* ADC digital controls */
+#define AC100_ADC_DIG_CTRL		0x40
+#define AC100_ADC_VOL_CTRL		0x41
+
+/* HMIC plug sensing / key detection */
+#define AC100_HMIC_CTRL1		0x44
+#define AC100_HMIC_CTRL2		0x45
+#define AC100_HMIC_STATUS		0x46
+
+/* DAC digital controls */
+#define AC100_DAC_DIG_CTRL		0x48
+#define AC100_DAC_VOL_CTRL		0x49
+#define AC100_DAC_MXR_SRC		0x4c
+#define AC100_DAC_MXR_GAIN		0x4d
+
+/* Analog controls */
+#define AC100_ADC_APC_CTRL		0x50
+#define AC100_ADC_SRC			0x51
+#define AC100_ADC_SRC_BST_CTRL		0x52
+#define AC100_OUT_MXR_DAC_A_CTRL	0x53
+#define AC100_OUT_MXR_SRC		0x54
+#define AC100_OUT_MXR_SRC_BST		0x55
+#define AC100_HPOUT_CTRL		0x56
+#define AC100_ERPOUT_CTRL		0x57
+#define AC100_SPKOUT_CTRL		0x58
+#define AC100_LINEOUT_CTRL		0x59
+
+/* ADC digital audio processing (high pass filter & auto gain control */
+#define AC100_ADC_DAP_L_STA		0x80
+#define AC100_ADC_DAP_R_STA		0x81
+#define AC100_ADC_DAP_L_CTRL		0x82
+#define AC100_ADC_DAP_R_CTRL		0x83
+#define AC100_ADC_DAP_L_T_L		0x84 /* Left Target Level */
+#define AC100_ADC_DAP_R_T_L		0x85 /* Right Target Level */
+#define AC100_ADC_DAP_L_H_A_C		0x86 /* Left High Avg. Coef */
+#define AC100_ADC_DAP_L_L_A_C		0x87 /* Left Low Avg. Coef */
+#define AC100_ADC_DAP_R_H_A_C		0x88 /* Right High Avg. Coef */
+#define AC100_ADC_DAP_R_L_A_C		0x89 /* Right Low Avg. Coef */
+#define AC100_ADC_DAP_L_D_T		0x8a /* Left Decay Time */
+#define AC100_ADC_DAP_L_A_T		0x8b /* Left Attack Time */
+#define AC100_ADC_DAP_R_D_T		0x8c /* Right Decay Time */
+#define AC100_ADC_DAP_R_A_T		0x8d /* Right Attack Time */
+#define AC100_ADC_DAP_N_TH		0x8e /* Noise Threshold */
+#define AC100_ADC_DAP_L_H_N_A_C		0x8f /* Left High Noise Avg. Coef */
+#define AC100_ADC_DAP_L_L_N_A_C		0x90 /* Left Low Noise Avg. Coef */
+#define AC100_ADC_DAP_R_H_N_A_C		0x91 /* Right High Noise Avg. Coef */
+#define AC100_ADC_DAP_R_L_N_A_C		0x92 /* Right Low Noise Avg. Coef */
+#define AC100_ADC_DAP_H_HPF_C		0x93 /* High High-Pass-Filter Coef */
+#define AC100_ADC_DAP_L_HPF_C		0x94 /* Low High-Pass-Filter Coef */
+#define AC100_ADC_DAP_OPT		0x95 /* AGC Optimum */
+
+/* DAC digital audio processing (high pass filter & dynamic range control) */
+#define AC100_DAC_DAP_CTRL		0xa0
+#define AC100_DAC_DAP_H_HPF_C		0xa1 /* High High-Pass-Filter Coef */
+#define AC100_DAC_DAP_L_HPF_C		0xa2 /* Low High-Pass-Filter Coef */
+#define AC100_DAC_DAP_L_H_E_A_C		0xa3 /* Left High Energy Avg Coef */
+#define AC100_DAC_DAP_L_L_E_A_C		0xa4 /* Left Low Energy Avg Coef */
+#define AC100_DAC_DAP_R_H_E_A_C		0xa5 /* Right High Energy Avg Coef */
+#define AC100_DAC_DAP_R_L_E_A_C		0xa6 /* Right Low Energy Avg Coef */
+#define AC100_DAC_DAP_H_G_D_T_C		0xa7 /* High Gain Delay Time Coef */
+#define AC100_DAC_DAP_L_G_D_T_C		0xa8 /* Low Gain Delay Time Coef */
+#define AC100_DAC_DAP_H_G_A_T_C		0xa9 /* High Gain Attack Time Coef */
+#define AC100_DAC_DAP_L_G_A_T_C		0xaa /* Low Gain Attack Time Coef */
+#define AC100_DAC_DAP_H_E_TH		0xab /* High Energy Threshold */
+#define AC100_DAC_DAP_L_E_TH		0xac /* Low Energy Threshold */
+#define AC100_DAC_DAP_H_G_K		0xad /* High Gain K parameter */
+#define AC100_DAC_DAP_L_G_K		0xae /* Low Gain K parameter */
+#define AC100_DAC_DAP_H_G_OFF		0xaf /* High Gain offset */
+#define AC100_DAC_DAP_L_G_OFF		0xb0 /* Low Gain offset */
+#define AC100_DAC_DAP_OPT		0xb1 /* DRC optimum */
+
+/* Digital audio processing enable */
+#define AC100_ADC_DAP_ENA		0xb4
+#define AC100_DAC_DAP_ENA		0xb5
+
+/* SRC control */
+#define AC100_SRC1_CTRL1		0xb8
+#define AC100_SRC1_CTRL2		0xb9
+#define AC100_SRC1_CTRL3		0xba
+#define AC100_SRC1_CTRL4		0xbb
+#define AC100_SRC2_CTRL1		0xbc
+#define AC100_SRC2_CTRL2		0xbd
+#define AC100_SRC2_CTRL3		0xbe
+#define AC100_SRC2_CTRL4		0xbf
+
+/* RTC clk control */
+#define AC100_CLK32K_ANALOG_CTRL	0xc0
+#define AC100_CLKOUT_CTRL1		0xc1
+#define AC100_CLKOUT_CTRL2		0xc2
+#define AC100_CLKOUT_CTRL3		0xc3
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
+/* RTC alarm */
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
