From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 22 Nov 2016 15:49:20 +0800
Subject: [PATCH 5/6] reset: hisilicon: Use new driver reset-hi6222
In-Reply-To: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
References: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1479800961-6249-6-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using new reset-hi6220 with common reset.c
And keeps the same reset define

dts hi6220.c should be updated with new node sys_ctrl_rst
Solving potential issue of sys_ctrl can not be used as clock and reset
at the same time.

sys_ctrl: sys_ctrl at f7030000 {
	compatible = "hisilicon,hi6220-sysctrl", "syscon";
	reg = <0x0 0xf7030000 0x0 0x2000>;
	#clock-cells = <1>;
};

sys_ctrl_rst: sys_rst_controller {
	compatible = "hisilicon,hi6220-reset-sysctrl";
	#reset-cells = <1>;
	hisi,rst-syscon = <&sys_ctrl>;
};

uart1: serial at ..... {
        ...
        resets = <&sys_ctrl_rst PERIPH_RSTEN3_UART1>;
        ...
};

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/reset/hisilicon/Makefile               |   2 +-
 drivers/reset/hisilicon/hi6220_reset.c         | 157 -------------------------
 drivers/reset/hisilicon/reset-hi6220.c         | 123 +++++++++++++++++++
 include/dt-bindings/reset/hisi,hi6220-resets.h | 130 ++++++++++----------
 4 files changed, 190 insertions(+), 222 deletions(-)
 delete mode 100644 drivers/reset/hisilicon/hi6220_reset.c
 create mode 100644 drivers/reset/hisilicon/reset-hi6220.c

diff --git a/drivers/reset/hisilicon/Makefile b/drivers/reset/hisilicon/Makefile
index 57e9893..caddac1 100644
--- a/drivers/reset/hisilicon/Makefile
+++ b/drivers/reset/hisilicon/Makefile
@@ -1,3 +1,3 @@
 obj-y	+= reset.o
 obj-$(CONFIG_COMMON_RESET_HI3660) += reset-hi3660.o
-obj-$(CONFIG_COMMON_RESET_HI6220) += hi6220_reset.o
+obj-$(CONFIG_COMMON_RESET_HI6220) += reset-hi6220.o
diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
deleted file mode 100644
index 35ce53e..0000000
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ /dev/null
@@ -1,157 +0,0 @@
-/*
- * Hisilicon Hi6220 reset controller driver
- *
- * Copyright (c) 2016 Linaro Limited.
- * Copyright (c) 2015-2016 Hisilicon Limited.
- *
- * Author: Feng Chen <puck.chen@hisilicon.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/bitops.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/regmap.h>
-#include <linux/mfd/syscon.h>
-#include <linux/reset-controller.h>
-#include <linux/reset.h>
-#include <linux/platform_device.h>
-
-#define PERIPH_ASSERT_OFFSET      0x300
-#define PERIPH_DEASSERT_OFFSET    0x304
-#define PERIPH_MAX_INDEX          0x509
-
-#define SC_MEDIA_RSTEN            0x052C
-#define SC_MEDIA_RSTDIS           0x0530
-#define MEDIA_MAX_INDEX           8
-
-#define to_reset_data(x) container_of(x, struct hi6220_reset_data, rc_dev)
-
-enum hi6220_reset_ctrl_type {
-	PERIPHERAL,
-	MEDIA,
-};
-
-struct hi6220_reset_data {
-	struct reset_controller_dev rc_dev;
-	struct regmap *regmap;
-};
-
-static int hi6220_peripheral_assert(struct reset_controller_dev *rc_dev,
-				    unsigned long idx)
-{
-	struct hi6220_reset_data *data = to_reset_data(rc_dev);
-	struct regmap *regmap = data->regmap;
-	u32 bank = idx >> 8;
-	u32 offset = idx & 0xff;
-	u32 reg = PERIPH_ASSERT_OFFSET + bank * 0x10;
-
-	return regmap_write(regmap, reg, BIT(offset));
-}
-
-static int hi6220_peripheral_deassert(struct reset_controller_dev *rc_dev,
-				      unsigned long idx)
-{
-	struct hi6220_reset_data *data = to_reset_data(rc_dev);
-	struct regmap *regmap = data->regmap;
-	u32 bank = idx >> 8;
-	u32 offset = idx & 0xff;
-	u32 reg = PERIPH_DEASSERT_OFFSET + bank * 0x10;
-
-	return regmap_write(regmap, reg, BIT(offset));
-}
-
-static const struct reset_control_ops hi6220_peripheral_reset_ops = {
-	.assert = hi6220_peripheral_assert,
-	.deassert = hi6220_peripheral_deassert,
-};
-
-static int hi6220_media_assert(struct reset_controller_dev *rc_dev,
-			       unsigned long idx)
-{
-	struct hi6220_reset_data *data = to_reset_data(rc_dev);
-	struct regmap *regmap = data->regmap;
-
-	return regmap_write(regmap, SC_MEDIA_RSTEN, BIT(idx));
-}
-
-static int hi6220_media_deassert(struct reset_controller_dev *rc_dev,
-				 unsigned long idx)
-{
-	struct hi6220_reset_data *data = to_reset_data(rc_dev);
-	struct regmap *regmap = data->regmap;
-
-	return regmap_write(regmap, SC_MEDIA_RSTDIS, BIT(idx));
-}
-
-static const struct reset_control_ops hi6220_media_reset_ops = {
-	.assert = hi6220_media_assert,
-	.deassert = hi6220_media_deassert,
-};
-
-static int hi6220_reset_probe(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	struct device *dev = &pdev->dev;
-	enum hi6220_reset_ctrl_type type;
-	struct hi6220_reset_data *data;
-	struct regmap *regmap;
-
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	type = (enum hi6220_reset_ctrl_type)of_device_get_match_data(dev);
-
-	regmap = syscon_node_to_regmap(np);
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "failed to get reset controller regmap\n");
-		return PTR_ERR(regmap);
-	}
-
-	data->regmap = regmap;
-	data->rc_dev.of_node = np;
-	if (type == MEDIA) {
-		data->rc_dev.ops = &hi6220_media_reset_ops;
-		data->rc_dev.nr_resets = MEDIA_MAX_INDEX;
-	} else {
-		data->rc_dev.ops = &hi6220_peripheral_reset_ops;
-		data->rc_dev.nr_resets = PERIPH_MAX_INDEX;
-	}
-
-	return reset_controller_register(&data->rc_dev);
-}
-
-static const struct of_device_id hi6220_reset_match[] = {
-	{
-		.compatible = "hisilicon,hi6220-sysctrl",
-		.data = (void *)PERIPHERAL,
-	},
-	{
-		.compatible = "hisilicon,hi6220-mediactrl",
-		.data = (void *)MEDIA,
-	},
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(of, hi6220_reset_match);
-
-static struct platform_driver hi6220_reset_driver = {
-	.probe = hi6220_reset_probe,
-	.driver = {
-		.name = "reset-hi6220",
-		.of_match_table = hi6220_reset_match,
-	},
-};
-
-static int __init hi6220_reset_init(void)
-{
-	return platform_driver_register(&hi6220_reset_driver);
-}
-
-postcore_initcall(hi6220_reset_init);
diff --git a/drivers/reset/hisilicon/reset-hi6220.c b/drivers/reset/hisilicon/reset-hi6220.c
new file mode 100644
index 0000000..a2a64ae
--- /dev/null
+++ b/drivers/reset/hisilicon/reset-hi6220.c
@@ -0,0 +1,123 @@
+/*
+ * Copyright (c) 2016-2017 Linaro Ltd.
+ * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/reset/hisi,hi6220-resets.h>
+
+#include "reset.h"
+
+static const struct hisi_reset_channel_data hi6220_media_rst[] = {
+	[MEDIA_G3D] = HISI_RST_SEP(0x52c, 0),
+	[MEDIA_CODEC_VPU] = HISI_RST_SEP(0x52c, 2),
+	[MEDIA_CODEC_JPEG] = HISI_RST_SEP(0x52c, 3),
+	[MEDIA_ISP] = HISI_RST_SEP(0x52c, 4),
+	[MEDIA_ADE] = HISI_RST_SEP(0x52c, 5),
+	[MEDIA_MMU] = HISI_RST_SEP(0x52c, 6),
+	[MEDIA_XG2RAM1] = HISI_RST_SEP(0x52c, 7),
+};
+
+static struct hisi_reset_controller_data hi6220_media_controller = {
+	.nr_channels = ARRAY_SIZE(hi6220_media_rst),
+	.channels = hi6220_media_rst,
+};
+
+static const struct hisi_reset_channel_data hi6220_sysctrl_rst[] = {
+	[PERIPH_RSTDIS0_MMC0] = HISI_RST_SEP(0x300, 0),
+	[PERIPH_RSTDIS0_MMC1] = HISI_RST_SEP(0x300, 1),
+	[PERIPH_RSTDIS0_MMC2] = HISI_RST_SEP(0x300, 2),
+	[PERIPH_RSTDIS0_NANDC] = HISI_RST_SEP(0x300, 3),
+	[PERIPH_RSTDIS0_USBOTG_BUS] = HISI_RST_SEP(0x300, 4),
+	[PERIPH_RSTDIS0_POR_PICOPHY] = HISI_RST_SEP(0x300, 5),
+	[PERIPH_RSTDIS0_USBOTG] = HISI_RST_SEP(0x300, 6),
+	[PERIPH_RSTDIS0_USBOTG_32K] = HISI_RST_SEP(0x300, 7),
+	[PERIPH_RSTDIS1_HIFI] = HISI_RST_SEP(0x310, 0),
+	[PERIPH_RSTDIS1_DIGACODEC] = HISI_RST_SEP(0x310, 5),
+	[PERIPH_RSTEN2_IPF] = HISI_RST_SEP(0x320, 0),
+	[PERIPH_RSTEN2_SOCP] = HISI_RST_SEP(0x320, 1),
+	[PERIPH_RSTEN2_DMAC] = HISI_RST_SEP(0x320, 2),
+	[PERIPH_RSTEN2_SECENG] = HISI_RST_SEP(0x320, 3),
+	[PERIPH_RSTEN2_ABB] = HISI_RST_SEP(0x320, 4),
+	[PERIPH_RSTEN2_HPM0] = HISI_RST_SEP(0x320, 5),
+	[PERIPH_RSTEN2_HPM1] = HISI_RST_SEP(0x320, 6),
+	[PERIPH_RSTEN2_HPM2] = HISI_RST_SEP(0x320, 7),
+	[PERIPH_RSTEN2_HPM3] = HISI_RST_SEP(0x320, 8),
+	[PERIPH_RSTEN3_CSSYS] = HISI_RST_SEP(0x330, 0),
+	[PERIPH_RSTEN3_I2C0] = HISI_RST_SEP(0x330, 1),
+	[PERIPH_RSTEN3_I2C1] = HISI_RST_SEP(0x330, 2),
+	[PERIPH_RSTEN3_I2C2] = HISI_RST_SEP(0x330, 3),
+	[PERIPH_RSTEN3_I2C3] = HISI_RST_SEP(0x330, 4),
+	[PERIPH_RSTEN3_UART1] = HISI_RST_SEP(0x330, 5),
+	[PERIPH_RSTEN3_UART2] = HISI_RST_SEP(0x330, 6),
+	[PERIPH_RSTEN3_UART3] = HISI_RST_SEP(0x330, 7),
+	[PERIPH_RSTEN3_UART4] = HISI_RST_SEP(0x330, 8),
+	[PERIPH_RSTEN3_SSP] = HISI_RST_SEP(0x330, 9),
+	[PERIPH_RSTEN3_PWM] = HISI_RST_SEP(0x330, 10),
+	[PERIPH_RSTEN3_BLPWM] = HISI_RST_SEP(0x330, 11),
+	[PERIPH_RSTEN3_TSENSOR] = HISI_RST_SEP(0x330, 12),
+	[PERIPH_RSTEN3_DAPB] = HISI_RST_SEP(0x330, 18),
+	[PERIPH_RSTEN3_HKADC] = HISI_RST_SEP(0x330, 19),
+	[PERIPH_RSTEN3_CODEC_SSI] = HISI_RST_SEP(0x330, 20),
+	[PERIPH_RSTEN8_RS0] = HISI_RST_SEP(0x340, 0),
+	[PERIPH_RSTEN8_RS2] = HISI_RST_SEP(0x340, 1),
+	[PERIPH_RSTEN8_RS3] = HISI_RST_SEP(0x340, 2),
+	[PERIPH_RSTEN8_MS0] = HISI_RST_SEP(0x340, 3),
+	[PERIPH_RSTEN8_MS2] = HISI_RST_SEP(0x340, 5),
+	[PERIPH_RSTEN8_XG2RAM0] = HISI_RST_SEP(0x340, 6),
+	[PERIPH_RSTEN8_X2SRAM_TZMA] = HISI_RST_SEP(0x340, 7),
+	[PERIPH_RSTEN8_SRAM] = HISI_RST_SEP(0x340, 8),
+	[PERIPH_RSTEN8_HARQ] = HISI_RST_SEP(0x340, 10),
+	[PERIPH_RSTEN8_DDRC] = HISI_RST_SEP(0x340, 12),
+	[PERIPH_RSTEN8_DDRC_APB] = HISI_RST_SEP(0x340, 13),
+	[PERIPH_RSTEN8_DDRPACK_APB] = HISI_RST_SEP(0x340, 14),
+	[PERIPH_RSTEN8_DDRT] = HISI_RST_SEP(0x340, 17),
+	[PERIPH_RSDIST9_CARM_DAP] = HISI_RST_SEP(0x350, 0),
+	[PERIPH_RSDIST9_CARM_ATB] = HISI_RST_SEP(0x350, 1),
+	[PERIPH_RSDIST9_CARM_LBUS] = HISI_RST_SEP(0x350, 2),
+	[PERIPH_RSDIST9_CARM_POR] = HISI_RST_SEP(0x350, 3),
+	[PERIPH_RSDIST9_CARM_CORE] = HISI_RST_SEP(0x350, 4),
+	[PERIPH_RSDIST9_CARM_DBG] = HISI_RST_SEP(0x350, 5),
+	[PERIPH_RSDIST9_CARM_L2] = HISI_RST_SEP(0x350, 6),
+	[PERIPH_RSDIST9_CARM_SOCDBG] = HISI_RST_SEP(0x350, 7),
+	[PERIPH_RSDIST9_CARM_ETM] = HISI_RST_SEP(0x350, 8),
+};
+
+static struct hisi_reset_controller_data hi6220_sysctrl_controller = {
+	.nr_channels = ARRAY_SIZE(hi6220_sysctrl_rst),
+	.channels = hi6220_sysctrl_rst,
+};
+
+static const struct of_device_id hi6220_reset_match[] = {
+	{ .compatible = "hisilicon,hi6220-reset-sysctrl",
+	  .data = &hi6220_sysctrl_controller, },
+	{ .compatible = "hisilicon,hi6220-reset-mediactrl",
+	  .data = &hi6220_media_controller, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hi6220_reset_match);
+
+static struct platform_driver hi6220_reset_driver = {
+	.probe = hisi_reset_probe,
+	.driver = {
+		.name = "reset-hi6220",
+		.of_match_table = hi6220_reset_match,
+	},
+};
+
+static int __init hi6220_reset_init(void)
+{
+	return platform_driver_register(&hi6220_reset_driver);
+}
+arch_initcall(hi6220_reset_init);
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:hi6220-reset");
+MODULE_DESCRIPTION("HiSilicon hi6220 Reset Driver");
diff --git a/include/dt-bindings/reset/hisi,hi6220-resets.h b/include/dt-bindings/reset/hisi,hi6220-resets.h
index 322ec53..837f1a1 100644
--- a/include/dt-bindings/reset/hisi,hi6220-resets.h
+++ b/include/dt-bindings/reset/hisi,hi6220-resets.h
@@ -5,71 +5,73 @@
 #ifndef _DT_BINDINGS_RESET_CONTROLLER_HI6220
 #define _DT_BINDINGS_RESET_CONTROLLER_HI6220
 
-#define PERIPH_RSTDIS0_MMC0             0x000
-#define PERIPH_RSTDIS0_MMC1             0x001
-#define PERIPH_RSTDIS0_MMC2             0x002
-#define PERIPH_RSTDIS0_NANDC            0x003
-#define PERIPH_RSTDIS0_USBOTG_BUS       0x004
-#define PERIPH_RSTDIS0_POR_PICOPHY      0x005
-#define PERIPH_RSTDIS0_USBOTG           0x006
-#define PERIPH_RSTDIS0_USBOTG_32K       0x007
-#define PERIPH_RSTDIS1_HIFI             0x100
-#define PERIPH_RSTDIS1_DIGACODEC        0x105
-#define PERIPH_RSTEN2_IPF               0x200
-#define PERIPH_RSTEN2_SOCP              0x201
-#define PERIPH_RSTEN2_DMAC              0x202
-#define PERIPH_RSTEN2_SECENG            0x203
-#define PERIPH_RSTEN2_ABB               0x204
-#define PERIPH_RSTEN2_HPM0              0x205
-#define PERIPH_RSTEN2_HPM1              0x206
-#define PERIPH_RSTEN2_HPM2              0x207
-#define PERIPH_RSTEN2_HPM3              0x208
-#define PERIPH_RSTEN3_CSSYS             0x300
-#define PERIPH_RSTEN3_I2C0              0x301
-#define PERIPH_RSTEN3_I2C1              0x302
-#define PERIPH_RSTEN3_I2C2              0x303
-#define PERIPH_RSTEN3_I2C3              0x304
-#define PERIPH_RSTEN3_UART1             0x305
-#define PERIPH_RSTEN3_UART2             0x306
-#define PERIPH_RSTEN3_UART3             0x307
-#define PERIPH_RSTEN3_UART4             0x308
-#define PERIPH_RSTEN3_SSP               0x309
-#define PERIPH_RSTEN3_PWM               0x30a
-#define PERIPH_RSTEN3_BLPWM             0x30b
-#define PERIPH_RSTEN3_TSENSOR           0x30c
-#define PERIPH_RSTEN3_DAPB              0x312
-#define PERIPH_RSTEN3_HKADC             0x313
-#define PERIPH_RSTEN3_CODEC_SSI         0x314
-#define PERIPH_RSTEN3_PMUSSI1           0x316
-#define PERIPH_RSTEN8_RS0               0x400
-#define PERIPH_RSTEN8_RS2               0x401
-#define PERIPH_RSTEN8_RS3               0x402
-#define PERIPH_RSTEN8_MS0               0x403
-#define PERIPH_RSTEN8_MS2               0x405
-#define PERIPH_RSTEN8_XG2RAM0           0x406
-#define PERIPH_RSTEN8_X2SRAM_TZMA       0x407
-#define PERIPH_RSTEN8_SRAM              0x408
-#define PERIPH_RSTEN8_HARQ              0x40a
-#define PERIPH_RSTEN8_DDRC              0x40c
-#define PERIPH_RSTEN8_DDRC_APB          0x40d
-#define PERIPH_RSTEN8_DDRPACK_APB       0x40e
-#define PERIPH_RSTEN8_DDRT              0x411
-#define PERIPH_RSDIST9_CARM_DAP         0x500
-#define PERIPH_RSDIST9_CARM_ATB         0x501
-#define PERIPH_RSDIST9_CARM_LBUS        0x502
-#define PERIPH_RSDIST9_CARM_POR         0x503
-#define PERIPH_RSDIST9_CARM_CORE        0x504
-#define PERIPH_RSDIST9_CARM_DBG         0x505
-#define PERIPH_RSDIST9_CARM_L2          0x506
-#define PERIPH_RSDIST9_CARM_SOCDBG      0x507
-#define PERIPH_RSDIST9_CARM_ETM         0x508
 
+/* reset in sysctrl */
+#define PERIPH_RSTDIS0_MMC0             0
+#define PERIPH_RSTDIS0_MMC1             1
+#define PERIPH_RSTDIS0_MMC2             2
+#define PERIPH_RSTDIS0_NANDC            3
+#define PERIPH_RSTDIS0_USBOTG_BUS       4
+#define PERIPH_RSTDIS0_POR_PICOPHY      5
+#define PERIPH_RSTDIS0_USBOTG           6
+#define PERIPH_RSTDIS0_USBOTG_32K       7
+#define PERIPH_RSTDIS1_HIFI             8
+#define PERIPH_RSTDIS1_DIGACODEC        9
+#define PERIPH_RSTEN2_IPF               10
+#define PERIPH_RSTEN2_SOCP              11
+#define PERIPH_RSTEN2_DMAC              12
+#define PERIPH_RSTEN2_SECENG            13
+#define PERIPH_RSTEN2_ABB               14
+#define PERIPH_RSTEN2_HPM0              15
+#define PERIPH_RSTEN2_HPM1              16
+#define PERIPH_RSTEN2_HPM2              17
+#define PERIPH_RSTEN2_HPM3              18
+#define PERIPH_RSTEN3_CSSYS             19
+#define PERIPH_RSTEN3_I2C0              20
+#define PERIPH_RSTEN3_I2C1              21
+#define PERIPH_RSTEN3_I2C2              22
+#define PERIPH_RSTEN3_I2C3              23
+#define PERIPH_RSTEN3_UART1             24
+#define PERIPH_RSTEN3_UART2             25
+#define PERIPH_RSTEN3_UART3             26
+#define PERIPH_RSTEN3_UART4             27
+#define PERIPH_RSTEN3_SSP               28
+#define PERIPH_RSTEN3_PWM               29
+#define PERIPH_RSTEN3_BLPWM             30
+#define PERIPH_RSTEN3_TSENSOR           31
+#define PERIPH_RSTEN3_DAPB              32
+#define PERIPH_RSTEN3_HKADC             33
+#define PERIPH_RSTEN3_CODEC_SSI         34
+#define PERIPH_RSTEN8_RS0               35
+#define PERIPH_RSTEN8_RS2               36
+#define PERIPH_RSTEN8_RS3               37
+#define PERIPH_RSTEN8_MS0               38
+#define PERIPH_RSTEN8_MS2               39
+#define PERIPH_RSTEN8_XG2RAM0           40
+#define PERIPH_RSTEN8_X2SRAM_TZMA       41
+#define PERIPH_RSTEN8_SRAM              42
+#define PERIPH_RSTEN8_HARQ              43
+#define PERIPH_RSTEN8_DDRC              44
+#define PERIPH_RSTEN8_DDRC_APB          45
+#define PERIPH_RSTEN8_DDRPACK_APB       46
+#define PERIPH_RSTEN8_DDRT              47
+#define PERIPH_RSDIST9_CARM_DAP         48
+#define PERIPH_RSDIST9_CARM_ATB         49
+#define PERIPH_RSDIST9_CARM_LBUS        50
+#define PERIPH_RSDIST9_CARM_POR         51
+#define PERIPH_RSDIST9_CARM_CORE        52
+#define PERIPH_RSDIST9_CARM_DBG         53
+#define PERIPH_RSDIST9_CARM_L2          54
+#define PERIPH_RSDIST9_CARM_SOCDBG      55
+#define PERIPH_RSDIST9_CARM_ETM         56
+
+/* reset in media */
 #define MEDIA_G3D                       0
-#define MEDIA_CODEC_VPU                 2
-#define MEDIA_CODEC_JPEG                3
-#define MEDIA_ISP                       4
-#define MEDIA_ADE                       5
-#define MEDIA_MMU                       6
-#define MEDIA_XG2RAM1                   7
+#define MEDIA_CODEC_VPU                 1
+#define MEDIA_CODEC_JPEG                2
+#define MEDIA_ISP                       3
+#define MEDIA_ADE                       4
+#define MEDIA_MMU                       5
+#define MEDIA_XG2RAM1                   6
 
 #endif /*_DT_BINDINGS_RESET_CONTROLLER_HI6220*/
-- 
2.7.4
