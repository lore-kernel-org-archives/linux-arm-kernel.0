From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 22 Nov 2016 15:49:18 +0800
Subject: [PATCH 3/6] reset: hisilicon: add reset-hi3660
In-Reply-To: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
References: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1479800961-6249-4-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hi3660 reset driver based on common reset.c

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/reset/hisilicon/Kconfig                |  7 +++
 drivers/reset/hisilicon/Makefile               |  1 +
 drivers/reset/hisilicon/reset-hi3660.c         | 78 ++++++++++++++++++++++++++
 include/dt-bindings/reset/hisi,hi3660-resets.h | 38 +++++++++++++
 4 files changed, 124 insertions(+)
 create mode 100644 drivers/reset/hisilicon/reset-hi3660.c
 create mode 100644 include/dt-bindings/reset/hisi,hi3660-resets.h

diff --git a/drivers/reset/hisilicon/Kconfig b/drivers/reset/hisilicon/Kconfig
index 1ff8b0c..10134dc 100644
--- a/drivers/reset/hisilicon/Kconfig
+++ b/drivers/reset/hisilicon/Kconfig
@@ -1,3 +1,10 @@
+config COMMON_RESET_HI3660
+	tristate "Hi3660 Reset Driver"
+	depends on ARCH_HISI || COMPILE_TEST
+	default ARCH_HISI
+	help
+	  Build the Hisilicon Hi3660 reset driver.
+
 config COMMON_RESET_HI6220
 	tristate "Hi6220 Reset Driver"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/reset/hisilicon/Makefile b/drivers/reset/hisilicon/Makefile
index df511f5..57e9893 100644
--- a/drivers/reset/hisilicon/Makefile
+++ b/drivers/reset/hisilicon/Makefile
@@ -1,2 +1,3 @@
 obj-y	+= reset.o
+obj-$(CONFIG_COMMON_RESET_HI3660) += reset-hi3660.o
 obj-$(CONFIG_COMMON_RESET_HI6220) += hi6220_reset.o
diff --git a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
new file mode 100644
index 0000000..7da3153
--- /dev/null
+++ b/drivers/reset/hisilicon/reset-hi3660.c
@@ -0,0 +1,78 @@
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
+#include <dt-bindings/reset/hisi,hi3660-resets.h>
+
+#include "reset.h"
+
+static const struct hisi_reset_channel_data hi3660_iomcu_rst[] = {
+	[HI3660_RST_I2C0] = HISI_RST_SEP(0x20, 3),
+	[HI3660_RST_I2C1] = HISI_RST_SEP(0x20, 4),
+	[HI3660_RST_I2C2] = HISI_RST_SEP(0x20, 5),
+	[HI3660_RST_I2C6] = HISI_RST_SEP(0x20, 27),
+};
+
+static struct hisi_reset_controller_data hi3660_iomcu_controller = {
+	.nr_channels = ARRAY_SIZE(hi3660_iomcu_rst),
+	.channels = hi3660_iomcu_rst,
+};
+
+static const struct hisi_reset_channel_data hi3660_crgctrl_rst[] = {
+	[HI3660_RST_I2C3] = HISI_RST_SEP(0x78, 7),
+	[HI3660_RST_I2C4] = HISI_RST_SEP(0x78, 27),
+	[HI3660_RST_I2C7] = HISI_RST_SEP(0x60, 14),
+	[HI3660_RST_SD] = HISI_RST_SEP(0x90, 18),
+	[HI3660_RST_SDIO] = HISI_RST_SEP(0x90, 20),
+	[HI3660_RST_UFS] = HISI_RST_SEP(0x84, 12),
+	[HI3660_RST_UFS_ASSERT] = HISI_RST_SEP(0x84, 7),
+	[HI3660_RST_PCIE_SYS] = HISI_RST_SEP(0x84, 26),
+	[HI3660_RST_PCIE_PHY] = HISI_RST_SEP(0x84, 27),
+	[HI3660_RST_PCIE_BUS] = HISI_RST_SEP(0x84, 31),
+	[HI3660_RST_USB3OTG_PHY] = HISI_RST_SEP(0x90, 3),
+	[HI3660_RST_USB3OTG] = HISI_RST_SEP(0x90, 5),
+	[HI3660_RST_USB3OTG_32K] = HISI_RST_SEP(0x90, 6),
+	[HI3660_RST_USB3OTG_AHB] = HISI_RST_SEP(0x90, 7),
+	[HI3660_RST_USB3OTG_MUX] = HISI_RST_SEP(0x90, 8),
+};
+
+static struct hisi_reset_controller_data hi3660_crgctrl_controller = {
+	.nr_channels = ARRAY_SIZE(hi3660_crgctrl_rst),
+	.channels = hi3660_crgctrl_rst,
+};
+
+static const struct of_device_id hi3660_reset_match[] = {
+	{ .compatible = "hisilicon,hi3660-reset-crgctrl",
+	  .data = &hi3660_crgctrl_controller, },
+	{ .compatible = "hisilicon,hi3660-reset-iomcu",
+	  .data = &hi3660_iomcu_controller, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hi3660_reset_match);
+
+static struct platform_driver hi3660_reset_driver = {
+	.probe = hisi_reset_probe,
+	.driver = {
+		.name = "reset-hi3660",
+		.of_match_table = hi3660_reset_match,
+	},
+};
+
+static int __init hi3660_reset_init(void)
+{
+	return platform_driver_register(&hi3660_reset_driver);
+}
+arch_initcall(hi3660_reset_init);
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:hi3660-reset");
+MODULE_DESCRIPTION("HiSilicon Hi3660 Reset Driver");
diff --git a/include/dt-bindings/reset/hisi,hi3660-resets.h b/include/dt-bindings/reset/hisi,hi3660-resets.h
new file mode 100644
index 0000000..a65f382
--- /dev/null
+++ b/include/dt-bindings/reset/hisi,hi3660-resets.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (c) 2016-2017 Linaro Ltd.
+ * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_HI3660
+#define _DT_BINDINGS_RESET_CONTROLLER_HI3660
+
+/* reset in iomcu */
+#define HI3660_RST_I2C0		0
+#define HI3660_RST_I2C1		1
+#define HI3660_RST_I2C2		2
+#define HI3660_RST_I2C6		3
+
+
+/* reset in crgctrl */
+#define HI3660_RST_I2C3		0
+#define HI3660_RST_I2C4		1
+#define HI3660_RST_I2C7		2
+#define HI3660_RST_SD		3
+#define HI3660_RST_SDIO		4
+#define HI3660_RST_UFS		5
+#define HI3660_RST_UFS_ASSERT	6
+#define HI3660_RST_PCIE_SYS	7
+#define HI3660_RST_PCIE_PHY	8
+#define HI3660_RST_PCIE_BUS	9
+#define HI3660_RST_USB3OTG_PHY  10
+#define HI3660_RST_USB3OTG	11
+#define HI3660_RST_USB3OTG_32K	12
+#define HI3660_RST_USB3OTG_AHB	13
+#define HI3660_RST_USB3OTG_MUX	14
+
+#endif /*_DT_BINDINGS_RESET_CONTROLLER_HI3660*/
-- 
2.7.4
