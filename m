From: biao.huang@mediatek.com (Biao Huang)
Date: Thu, 26 Nov 2015 16:44:31 +0800
Subject: [PATCH 4/5] pinctrl: mediatek: Add Pinctrl/GPIO/EINT driver for mt2701
In-Reply-To: <1448527472-20651-1-git-send-email-biao.huang@mediatek.com>
References: <1448527472-20651-1-git-send-email-biao.huang@mediatek.com>
Message-ID: <1448527472-20651-5-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mt2701 support using mediatek common pinctrl driver.
MT2701 have some special pins need an extra setting register
than other ICs, so adding this support to common code.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 drivers/pinctrl/mediatek/Kconfig              |    6 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt2701.c     |  571 ++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    7 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |    3 +
 drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h | 2323 +++++++++++++++++++++++++
 6 files changed, 2911 insertions(+)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt2701.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 02f6f92..13e9939 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -9,6 +9,12 @@ config PINCTRL_MTK_COMMON
 	select OF_GPIO
 
 # For ARMv7 SoCs
+config PINCTRL_MT2701
+	bool "Mediatek MT2701 pin control" if COMPILE_TEST && !MACH_MT2701
+	depends on OF
+	default MACH_MT2701
+	select PINCTRL_MTK_COMMON
+
 config PINCTRL_MT8135
 	bool "Mediatek MT8135 pin control" if COMPILE_TEST && !MACH_MT8135
 	depends on OF
diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
index eb923d6..da30314 100644
--- a/drivers/pinctrl/mediatek/Makefile
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_PINCTRL_MTK_COMMON)	+= pinctrl-mtk-common.o
 
 # SoC Drivers
+obj-$(CONFIG_PINCTRL_MT2701)		+= pinctrl-mt2701.o
 obj-$(CONFIG_PINCTRL_MT8135)		+= pinctrl-mt8135.o
 obj-$(CONFIG_PINCTRL_MT8127)		+= pinctrl-mt8127.o
 obj-$(CONFIG_PINCTRL_MT8173)		+= pinctrl-mt8173.o
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2701.c b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
new file mode 100644
index 0000000..da372e9
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
@@ -0,0 +1,571 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author: Biao Huang <biao.huang@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <dt-bindings/pinctrl/mt65xx.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/regmap.h>
+
+#include "pinctrl-mtk-common.h"
+#include "pinctrl-mtk-mt2701.h"
+
+/**
+ * struct mtk_spec_pinmux_set
+ * - For special pins' mode setting
+ * @pin: The pin number.
+ * @offset: The offset of extra setting register.
+ * @bit: The bit of extra setting register.
+ */
+struct mtk_spec_pinmux_set {
+	unsigned short pin;
+	unsigned short offset;
+	unsigned char bit;
+};
+
+#define MTK_PINMUX_SPEC(_pin, _offset, _bit)	\
+	{					\
+		.pin = _pin,			\
+		.offset = _offset,		\
+		.bit = _bit,			\
+	}
+
+static const struct mtk_drv_group_desc mt2701_drv_grp[] =  {
+	/* 0E4E8SR 4/8/12/16 */
+	MTK_DRV_GRP(4, 16, 1, 2, 4),
+	/* 0E2E4SR  2/4/6/8 */
+	MTK_DRV_GRP(2, 8, 1, 2, 2),
+	/* E8E4E2  2/4/6/8/10/12/14/16 */
+	MTK_DRV_GRP(2, 16, 0, 2, 2)
+};
+
+static const struct mtk_pin_drv_grp mt2701_pin_drv[] = {
+	MTK_PIN_DRV_GRP(0, 0xf50, 0, 1),
+	MTK_PIN_DRV_GRP(1, 0xf50, 0, 1),
+	MTK_PIN_DRV_GRP(2, 0xf50, 0, 1),
+	MTK_PIN_DRV_GRP(3, 0xf50, 0, 1),
+	MTK_PIN_DRV_GRP(4, 0xf50, 0, 1),
+	MTK_PIN_DRV_GRP(5, 0xf50, 0, 1),
+	MTK_PIN_DRV_GRP(6, 0xf50, 0, 1),
+	MTK_PIN_DRV_GRP(7, 0xf50, 4, 1),
+	MTK_PIN_DRV_GRP(8, 0xf50, 4, 1),
+	MTK_PIN_DRV_GRP(9, 0xf50, 4, 1),
+	MTK_PIN_DRV_GRP(10, 0xf50, 8, 1),
+	MTK_PIN_DRV_GRP(11, 0xf50, 8, 1),
+	MTK_PIN_DRV_GRP(12, 0xf50, 8, 1),
+	MTK_PIN_DRV_GRP(13, 0xf50, 8, 1),
+	MTK_PIN_DRV_GRP(14, 0xf50, 12, 0),
+	MTK_PIN_DRV_GRP(15, 0xf50, 12, 0),
+	MTK_PIN_DRV_GRP(16, 0xf60, 0, 0),
+	MTK_PIN_DRV_GRP(17, 0xf60, 0, 0),
+	MTK_PIN_DRV_GRP(18, 0xf60, 4, 0),
+	MTK_PIN_DRV_GRP(19, 0xf60, 4, 0),
+	MTK_PIN_DRV_GRP(20, 0xf60, 4, 0),
+	MTK_PIN_DRV_GRP(21, 0xf60, 4, 0),
+	MTK_PIN_DRV_GRP(22, 0xf60, 8, 0),
+	MTK_PIN_DRV_GRP(23, 0xf60, 8, 0),
+	MTK_PIN_DRV_GRP(24, 0xf60, 8, 0),
+	MTK_PIN_DRV_GRP(25, 0xf60, 8, 0),
+	MTK_PIN_DRV_GRP(26, 0xf60, 8, 0),
+	MTK_PIN_DRV_GRP(27, 0xf60, 12, 0),
+	MTK_PIN_DRV_GRP(28, 0xf60, 12, 0),
+	MTK_PIN_DRV_GRP(29, 0xf60, 12, 0),
+	MTK_PIN_DRV_GRP(30, 0xf60, 0, 0),
+	MTK_PIN_DRV_GRP(31, 0xf60, 0, 0),
+	MTK_PIN_DRV_GRP(32, 0xf60, 0, 0),
+	MTK_PIN_DRV_GRP(33, 0xf70, 0, 0),
+	MTK_PIN_DRV_GRP(34, 0xf70, 0, 0),
+	MTK_PIN_DRV_GRP(35, 0xf70, 0, 0),
+	MTK_PIN_DRV_GRP(36, 0xf70, 0, 0),
+	MTK_PIN_DRV_GRP(37, 0xf70, 0, 0),
+	MTK_PIN_DRV_GRP(38, 0xf70, 4, 0),
+	MTK_PIN_DRV_GRP(39, 0xf70, 8, 1),
+	MTK_PIN_DRV_GRP(40, 0xf70, 8, 1),
+	MTK_PIN_DRV_GRP(41, 0xf70, 8, 1),
+	MTK_PIN_DRV_GRP(42, 0xf70, 8, 1),
+	MTK_PIN_DRV_GRP(43, 0xf70, 12, 0),
+	MTK_PIN_DRV_GRP(44, 0xf70, 12, 0),
+	MTK_PIN_DRV_GRP(45, 0xf70, 12, 0),
+	MTK_PIN_DRV_GRP(47, 0xf80, 0, 0),
+	MTK_PIN_DRV_GRP(48, 0xf80, 0, 0),
+	MTK_PIN_DRV_GRP(49, 0xf80, 4, 0),
+	MTK_PIN_DRV_GRP(50, 0xf70, 4, 0),
+	MTK_PIN_DRV_GRP(51, 0xf70, 4, 0),
+	MTK_PIN_DRV_GRP(52, 0xf70, 4, 0),
+	MTK_PIN_DRV_GRP(53, 0xf80, 12, 0),
+	MTK_PIN_DRV_GRP(54, 0xf80, 12, 0),
+	MTK_PIN_DRV_GRP(55, 0xf80, 12, 0),
+	MTK_PIN_DRV_GRP(56, 0xf80, 12, 0),
+	MTK_PIN_DRV_GRP(60, 0xf90, 8, 1),
+	MTK_PIN_DRV_GRP(61, 0xf90, 8, 1),
+	MTK_PIN_DRV_GRP(62, 0xf90, 8, 1),
+	MTK_PIN_DRV_GRP(63, 0xf90, 12, 1),
+	MTK_PIN_DRV_GRP(64, 0xf90, 12, 1),
+	MTK_PIN_DRV_GRP(65, 0xf90, 12, 1),
+	MTK_PIN_DRV_GRP(66, 0xfa0, 0, 1),
+	MTK_PIN_DRV_GRP(67, 0xfa0, 0, 1),
+	MTK_PIN_DRV_GRP(68, 0xfa0, 0, 1),
+	MTK_PIN_DRV_GRP(69, 0xfa0, 0, 1),
+	MTK_PIN_DRV_GRP(70, 0xfa0, 0, 1),
+	MTK_PIN_DRV_GRP(71, 0xfa0, 0, 1),
+	MTK_PIN_DRV_GRP(72, 0xf80, 4, 0),
+	MTK_PIN_DRV_GRP(73, 0xf80, 4, 0),
+	MTK_PIN_DRV_GRP(74, 0xf80, 4, 0),
+	MTK_PIN_DRV_GRP(85, 0xda0, 0, 2),
+	MTK_PIN_DRV_GRP(86, 0xd90, 0, 2),
+	MTK_PIN_DRV_GRP(87, 0xdb0, 0, 2),
+	MTK_PIN_DRV_GRP(88, 0xdb0, 0, 2),
+	MTK_PIN_DRV_GRP(89, 0xdb0, 0, 2),
+	MTK_PIN_DRV_GRP(90, 0xdb0, 0, 2),
+	MTK_PIN_DRV_GRP(105, 0xd40, 0, 2),
+	MTK_PIN_DRV_GRP(106, 0xd30, 0, 2),
+	MTK_PIN_DRV_GRP(107, 0xd50, 0, 2),
+	MTK_PIN_DRV_GRP(108, 0xd50, 0, 2),
+	MTK_PIN_DRV_GRP(109, 0xd50, 0, 2),
+	MTK_PIN_DRV_GRP(110, 0xd50, 0, 2),
+	MTK_PIN_DRV_GRP(111, 0xce0, 0, 2),
+	MTK_PIN_DRV_GRP(112, 0xce0, 0, 2),
+	MTK_PIN_DRV_GRP(113, 0xce0, 0, 2),
+	MTK_PIN_DRV_GRP(114, 0xce0, 0, 2),
+	MTK_PIN_DRV_GRP(115, 0xce0, 0, 2),
+	MTK_PIN_DRV_GRP(116, 0xcd0, 0, 2),
+	MTK_PIN_DRV_GRP(117, 0xcc0, 0, 2),
+	MTK_PIN_DRV_GRP(118, 0xce0, 0, 2),
+	MTK_PIN_DRV_GRP(119, 0xce0, 0, 2),
+	MTK_PIN_DRV_GRP(120, 0xce0, 0, 2),
+	MTK_PIN_DRV_GRP(121, 0xce0, 0, 2),
+	MTK_PIN_DRV_GRP(126, 0xf80, 4, 0),
+	MTK_PIN_DRV_GRP(188, 0xf70, 4, 0),
+	MTK_PIN_DRV_GRP(189, 0xfe0, 8, 0),
+	MTK_PIN_DRV_GRP(190, 0xfe0, 8, 0),
+	MTK_PIN_DRV_GRP(191, 0xfe0, 8, 0),
+	MTK_PIN_DRV_GRP(192, 0xfe0, 8, 0),
+	MTK_PIN_DRV_GRP(193, 0xfe0, 8, 0),
+	MTK_PIN_DRV_GRP(194, 0xfe0, 12, 0),
+	MTK_PIN_DRV_GRP(195, 0xfe0, 12, 0),
+	MTK_PIN_DRV_GRP(196, 0xfe0, 12, 0),
+	MTK_PIN_DRV_GRP(197, 0xfe0, 12, 0),
+	MTK_PIN_DRV_GRP(198, 0xfe0, 12, 0),
+	MTK_PIN_DRV_GRP(199, 0xf50, 4, 1),
+	MTK_PIN_DRV_GRP(200, 0xfd0, 0, 0),
+	MTK_PIN_DRV_GRP(201, 0xfd0, 0, 0),
+	MTK_PIN_DRV_GRP(202, 0xfd0, 0, 0),
+	MTK_PIN_DRV_GRP(203, 0xfd0, 4, 0),
+	MTK_PIN_DRV_GRP(204, 0xfd0, 4, 0),
+	MTK_PIN_DRV_GRP(205, 0xfd0, 4, 0),
+	MTK_PIN_DRV_GRP(206, 0xfd0, 4, 0),
+	MTK_PIN_DRV_GRP(207, 0xfd0, 4, 0),
+	MTK_PIN_DRV_GRP(208, 0xfd0, 8, 0),
+	MTK_PIN_DRV_GRP(209, 0xfd0, 8, 0),
+	MTK_PIN_DRV_GRP(210, 0xfd0, 12, 1),
+	MTK_PIN_DRV_GRP(211, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(212, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(213, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(214, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(215, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(216, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(217, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(218, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(219, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(220, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(221, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(222, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(223, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(224, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(225, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(226, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(227, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(228, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(229, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(230, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(231, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(232, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(233, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(234, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(235, 0xff0, 0, 1),
+	MTK_PIN_DRV_GRP(236, 0xff0, 4, 0),
+	MTK_PIN_DRV_GRP(237, 0xff0, 4, 0),
+	MTK_PIN_DRV_GRP(238, 0xff0, 4, 0),
+	MTK_PIN_DRV_GRP(239, 0xff0, 4, 0),
+	MTK_PIN_DRV_GRP(240, 0xff0, 4, 0),
+	MTK_PIN_DRV_GRP(241, 0xff0, 4, 0),
+	MTK_PIN_DRV_GRP(242, 0xff0, 8, 0),
+	MTK_PIN_DRV_GRP(243, 0xff0, 8, 0),
+	MTK_PIN_DRV_GRP(248, 0xf00, 0, 0),
+	MTK_PIN_DRV_GRP(249, 0xfc0, 0, 2),
+	MTK_PIN_DRV_GRP(250, 0xfc0, 0, 2),
+	MTK_PIN_DRV_GRP(251, 0xfc0, 0, 2),
+	MTK_PIN_DRV_GRP(252, 0xfc0, 0, 2),
+	MTK_PIN_DRV_GRP(253, 0xfc0, 0, 2),
+	MTK_PIN_DRV_GRP(254, 0xfc0, 0, 2),
+	MTK_PIN_DRV_GRP(255, 0xfc0, 0, 2),
+	MTK_PIN_DRV_GRP(256, 0xfc0, 0, 2),
+	MTK_PIN_DRV_GRP(257, 0xce0, 0, 2),
+	MTK_PIN_DRV_GRP(258, 0xcb0, 0, 2),
+	MTK_PIN_DRV_GRP(259, 0xc90, 0, 2),
+	MTK_PIN_DRV_GRP(260, 0x3a0, 0, 2),
+	MTK_PIN_DRV_GRP(261, 0xd50, 0, 2),
+	MTK_PIN_DRV_GRP(262, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(263, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(264, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(265, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(266, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(267, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(268, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(269, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(270, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(271, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(272, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(273, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(274, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(275, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(276, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(277, 0xf00, 8, 0),
+	MTK_PIN_DRV_GRP(278, 0xf70, 8, 1),
+};
+
+static const struct mtk_pin_spec_pupd_set_samereg mt2701_spec_pupd[] = {
+	MTK_PIN_PUPD_SPEC_SR(111, 0xd00, 12, 13, 14),	/* ms0 data7 */
+	MTK_PIN_PUPD_SPEC_SR(112, 0xd00, 8, 9, 10),	/* ms0 data6 */
+	MTK_PIN_PUPD_SPEC_SR(113, 0xd00, 4, 5, 6),	/* ms0 data5 */
+	MTK_PIN_PUPD_SPEC_SR(114, 0xd00, 0, 1, 2),	/* ms0 data4 */
+	MTK_PIN_PUPD_SPEC_SR(115, 0xd10, 0, 1, 2),	/* ms0 rstb */
+	MTK_PIN_PUPD_SPEC_SR(116, 0xcd0, 8, 9, 10),	/* ms0 cmd */
+	MTK_PIN_PUPD_SPEC_SR(117, 0xcc0, 8, 9, 10),	/* ms0 clk */
+	MTK_PIN_PUPD_SPEC_SR(118, 0xcf0, 12, 13, 14),	/* ms0 data3 */
+	MTK_PIN_PUPD_SPEC_SR(119, 0xcf0, 8, 9, 10),	/* ms0 data2 */
+	MTK_PIN_PUPD_SPEC_SR(120, 0xcf0, 4, 5, 6),	/* ms0 data1 */
+	MTK_PIN_PUPD_SPEC_SR(121, 0xcf0, 0, 1, 2),	/* ms0 data0 */
+
+	MTK_PIN_PUPD_SPEC_SR(105, 0xd40, 8, 9, 10),	/* ms1 cmd */
+	MTK_PIN_PUPD_SPEC_SR(106, 0xd30, 8, 9, 10),	/* ms1 clk */
+	MTK_PIN_PUPD_SPEC_SR(107, 0xd60, 0, 1, 2),	/* ms1 dat0 */
+	MTK_PIN_PUPD_SPEC_SR(108, 0xd60, 10, 9, 8),	/* ms1 dat1 */
+	MTK_PIN_PUPD_SPEC_SR(109, 0xd60, 4, 5, 6),	/* ms1 dat2 */
+	MTK_PIN_PUPD_SPEC_SR(110, 0xc60, 12, 13, 14),	/* ms1 dat3 */
+
+	MTK_PIN_PUPD_SPEC_SR(85, 0xda0, 8, 9, 10),	/* ms2 cmd */
+	MTK_PIN_PUPD_SPEC_SR(86, 0xd90, 8, 9, 10),	/* ms2 clk */
+	MTK_PIN_PUPD_SPEC_SR(87, 0xdc0, 0, 1, 2),	/* ms2 dat0 */
+	MTK_PIN_PUPD_SPEC_SR(88, 0xdc0, 10, 9, 8),	/* ms2 dat1 */
+	MTK_PIN_PUPD_SPEC_SR(89, 0xdc0, 4, 5, 6),	/* ms2 dat2 */
+	MTK_PIN_PUPD_SPEC_SR(90, 0xdc0, 12, 13, 14),	/* ms2 dat3 */
+
+	MTK_PIN_PUPD_SPEC_SR(249, 0x140, 0, 1, 2),	/* ms0e rstb */
+	MTK_PIN_PUPD_SPEC_SR(250, 0x130, 12, 13, 14),	/* ms0e dat7 */
+	MTK_PIN_PUPD_SPEC_SR(251, 0x130, 8, 9, 10),	/* ms0e dat6 */
+	MTK_PIN_PUPD_SPEC_SR(252, 0x130, 4, 5, 6),	/* ms0e dat5 */
+	MTK_PIN_PUPD_SPEC_SR(253, 0x130, 0, 1, 2),	/* ms0e dat4 */
+	MTK_PIN_PUPD_SPEC_SR(254, 0xf40, 12, 13, 14),	/* ms0e dat3 */
+	MTK_PIN_PUPD_SPEC_SR(255, 0xf40, 8, 9, 10),	/* ms0e dat2 */
+	MTK_PIN_PUPD_SPEC_SR(256, 0xf40, 4, 5, 6),	/* ms0e dat1 */
+	MTK_PIN_PUPD_SPEC_SR(257, 0xf40, 0, 1, 2),	/* ms0e dat0 */
+	MTK_PIN_PUPD_SPEC_SR(258, 0xcb0, 8, 9, 10),	/* ms0e cmd */
+	MTK_PIN_PUPD_SPEC_SR(259, 0xc90, 8, 9, 10),	/* ms0e clk */
+	MTK_PIN_PUPD_SPEC_SR(261, 0x140, 8, 9, 10),	/* ms1 ins */
+};
+
+static int mt2701_spec_pull_set(struct regmap *regmap, unsigned int pin,
+		unsigned char align, bool isup, unsigned int r1r0)
+{
+	return mtk_pctrl_spec_pull_set_samereg(regmap, mt2701_spec_pupd,
+		ARRAY_SIZE(mt2701_spec_pupd), pin, align, isup, r1r0);
+}
+
+static const struct mtk_pin_ies_smt_set mt2701_ies_set[] = {
+	MTK_PIN_IES_SMT_SPEC(0, 6, 0xb20, 0),
+	MTK_PIN_IES_SMT_SPEC(7, 9, 0xb20, 1),
+	MTK_PIN_IES_SMT_SPEC(10, 13, 0xb30, 3),
+	MTK_PIN_IES_SMT_SPEC(14, 15, 0xb30, 13),
+	MTK_PIN_IES_SMT_SPEC(16, 17, 0xb40, 7),
+	MTK_PIN_IES_SMT_SPEC(18, 21, 0xb40, 13),
+	MTK_PIN_IES_SMT_SPEC(22, 26, 0xb40, 13),
+	MTK_PIN_IES_SMT_SPEC(27, 29, 0xb40, 13),
+	MTK_PIN_IES_SMT_SPEC(30, 32, 0xb40, 7),
+	MTK_PIN_IES_SMT_SPEC(33, 37, 0xb40, 13),
+	MTK_PIN_IES_SMT_SPEC(38, 38, 0xb20, 13),
+	MTK_PIN_IES_SMT_SPEC(39, 42, 0xb40, 13),
+	MTK_PIN_IES_SMT_SPEC(43, 45, 0xb20, 10),
+	MTK_PIN_IES_SMT_SPEC(47, 48, 0xb20, 11),
+	MTK_PIN_IES_SMT_SPEC(49, 49, 0xb20, 12),
+	MTK_PIN_IES_SMT_SPEC(50, 52, 0xb20, 13),
+	MTK_PIN_IES_SMT_SPEC(53, 56, 0xb20, 14),
+	MTK_PIN_IES_SMT_SPEC(57, 58, 0xb20, 15),
+	MTK_PIN_IES_SMT_SPEC(59, 59, 0xb30, 10),
+	MTK_PIN_IES_SMT_SPEC(60, 62, 0xb30, 0),
+	MTK_PIN_IES_SMT_SPEC(63, 65, 0xb30, 1),
+	MTK_PIN_IES_SMT_SPEC(66, 71, 0xb30, 2),
+	MTK_PIN_IES_SMT_SPEC(72, 74, 0xb20, 12),
+	MTK_PIN_IES_SMT_SPEC(75, 76, 0xb30, 3),
+	MTK_PIN_IES_SMT_SPEC(77, 78, 0xb30, 4),
+	MTK_PIN_IES_SMT_SPEC(79, 82, 0xb30, 5),
+	MTK_PIN_IES_SMT_SPEC(83, 84, 0xb30, 2),
+	MTK_PIN_IES_SMT_SPEC(85, 85, 0xda0, 4),
+	MTK_PIN_IES_SMT_SPEC(86, 86, 0xd90, 4),
+	MTK_PIN_IES_SMT_SPEC(87, 90, 0xdb0, 4),
+	MTK_PIN_IES_SMT_SPEC(101, 104, 0xb30, 6),
+	MTK_PIN_IES_SMT_SPEC(105, 105, 0xd40, 4),
+	MTK_PIN_IES_SMT_SPEC(106, 106, 0xd30, 4),
+	MTK_PIN_IES_SMT_SPEC(107, 110, 0xd50, 4),
+	MTK_PIN_IES_SMT_SPEC(111, 115, 0xce0, 4),
+	MTK_PIN_IES_SMT_SPEC(116, 116, 0xcd0, 4),
+	MTK_PIN_IES_SMT_SPEC(117, 117, 0xcc0, 4),
+	MTK_PIN_IES_SMT_SPEC(118, 121, 0xce0, 4),
+	MTK_PIN_IES_SMT_SPEC(122, 125, 0xb30, 7),
+	MTK_PIN_IES_SMT_SPEC(126, 126, 0xb20, 12),
+	MTK_PIN_IES_SMT_SPEC(127, 142, 0xb30, 9),
+	MTK_PIN_IES_SMT_SPEC(143, 160, 0xb30, 10),
+	MTK_PIN_IES_SMT_SPEC(161, 168, 0xb30, 12),
+	MTK_PIN_IES_SMT_SPEC(169, 183, 0xb30, 10),
+	MTK_PIN_IES_SMT_SPEC(184, 186, 0xb30, 9),
+	MTK_PIN_IES_SMT_SPEC(187, 187, 0xb30, 14),
+	MTK_PIN_IES_SMT_SPEC(188, 188, 0xb20, 13),
+	MTK_PIN_IES_SMT_SPEC(189, 193, 0xb30, 15),
+	MTK_PIN_IES_SMT_SPEC(194, 198, 0xb40, 0),
+	MTK_PIN_IES_SMT_SPEC(199, 199, 0xb20, 1),
+	MTK_PIN_IES_SMT_SPEC(200, 202, 0xb40, 1),
+	MTK_PIN_IES_SMT_SPEC(203, 207, 0xb40, 2),
+	MTK_PIN_IES_SMT_SPEC(208, 209, 0xb40, 3),
+	MTK_PIN_IES_SMT_SPEC(210, 210, 0xb40, 4),
+	MTK_PIN_IES_SMT_SPEC(211, 235, 0xb40, 5),
+	MTK_PIN_IES_SMT_SPEC(236, 241, 0xb40, 6),
+	MTK_PIN_IES_SMT_SPEC(242, 243, 0xb40, 7),
+	MTK_PIN_IES_SMT_SPEC(244, 247, 0xb40, 8),
+	MTK_PIN_IES_SMT_SPEC(248, 248, 0xb40, 9),
+	MTK_PIN_IES_SMT_SPEC(249, 257, 0xfc0, 4),
+	MTK_PIN_IES_SMT_SPEC(258, 258, 0xcb0, 4),
+	MTK_PIN_IES_SMT_SPEC(259, 259, 0xc90, 4),
+	MTK_PIN_IES_SMT_SPEC(260, 260, 0x3a0, 4),
+	MTK_PIN_IES_SMT_SPEC(261, 261, 0xd50, 4),
+	MTK_PIN_IES_SMT_SPEC(262, 277, 0xb40, 12),
+	MTK_PIN_IES_SMT_SPEC(278, 278, 0xb40, 13),
+};
+
+static const struct mtk_pin_ies_smt_set mt2701_smt_set[] = {
+	MTK_PIN_IES_SMT_SPEC(0, 6, 0xb50, 0),
+	MTK_PIN_IES_SMT_SPEC(7, 9, 0xb50, 1),
+	MTK_PIN_IES_SMT_SPEC(10, 13, 0xb60, 3),
+	MTK_PIN_IES_SMT_SPEC(14, 15, 0xb60, 13),
+	MTK_PIN_IES_SMT_SPEC(16, 17, 0xb70, 7),
+	MTK_PIN_IES_SMT_SPEC(18, 21, 0xb70, 13),
+	MTK_PIN_IES_SMT_SPEC(22, 26, 0xb70, 13),
+	MTK_PIN_IES_SMT_SPEC(27, 29, 0xb70, 13),
+	MTK_PIN_IES_SMT_SPEC(30, 32, 0xb70, 7),
+	MTK_PIN_IES_SMT_SPEC(33, 37, 0xb70, 13),
+	MTK_PIN_IES_SMT_SPEC(38, 38, 0xb50, 13),
+	MTK_PIN_IES_SMT_SPEC(39, 42, 0xb70, 13),
+	MTK_PIN_IES_SMT_SPEC(43, 45, 0xb50, 10),
+	MTK_PIN_IES_SMT_SPEC(47, 48, 0xb50, 11),
+	MTK_PIN_IES_SMT_SPEC(49, 49, 0xb50, 12),
+	MTK_PIN_IES_SMT_SPEC(50, 52, 0xb50, 13),
+	MTK_PIN_IES_SMT_SPEC(53, 56, 0xb50, 14),
+	MTK_PIN_IES_SMT_SPEC(57, 58, 0xb50, 15),
+	MTK_PIN_IES_SMT_SPEC(59, 59, 0xb60, 10),
+	MTK_PIN_IES_SMT_SPEC(60, 62, 0xb60, 0),
+	MTK_PIN_IES_SMT_SPEC(63, 65, 0xb60, 1),
+	MTK_PIN_IES_SMT_SPEC(66, 71, 0xb60, 2),
+	MTK_PIN_IES_SMT_SPEC(72, 74, 0xb50, 12),
+	MTK_PIN_IES_SMT_SPEC(75, 76, 0xb60, 3),
+	MTK_PIN_IES_SMT_SPEC(77, 78, 0xb60, 4),
+	MTK_PIN_IES_SMT_SPEC(79, 82, 0xb60, 5),
+	MTK_PIN_IES_SMT_SPEC(83, 84, 0xb60, 2),
+	MTK_PIN_IES_SMT_SPEC(85, 85, 0xda0, 11),
+	MTK_PIN_IES_SMT_SPEC(86, 86, 0xd90, 11),
+	MTK_PIN_IES_SMT_SPEC(87, 87, 0xdc0, 3),
+	MTK_PIN_IES_SMT_SPEC(88, 88, 0xdc0, 7),
+	MTK_PIN_IES_SMT_SPEC(89, 89, 0xdc0, 11),
+	MTK_PIN_IES_SMT_SPEC(90, 90, 0xdc0, 15),
+	MTK_PIN_IES_SMT_SPEC(101, 104, 0xb60, 6),
+	MTK_PIN_IES_SMT_SPEC(105, 105, 0xd40, 11),
+	MTK_PIN_IES_SMT_SPEC(106, 106, 0xd30, 11),
+	MTK_PIN_IES_SMT_SPEC(107, 107, 0xd60, 3),
+	MTK_PIN_IES_SMT_SPEC(108, 108, 0xd60, 7),
+	MTK_PIN_IES_SMT_SPEC(109, 109, 0xd60, 11),
+	MTK_PIN_IES_SMT_SPEC(110, 110, 0xd60, 15),
+	MTK_PIN_IES_SMT_SPEC(111, 111, 0xd00, 15),
+	MTK_PIN_IES_SMT_SPEC(112, 112, 0xd00, 11),
+	MTK_PIN_IES_SMT_SPEC(113, 113, 0xd00, 7),
+	MTK_PIN_IES_SMT_SPEC(114, 114, 0xd00, 3),
+	MTK_PIN_IES_SMT_SPEC(115, 115, 0xd10, 3),
+	MTK_PIN_IES_SMT_SPEC(116, 116, 0xcd0, 11),
+	MTK_PIN_IES_SMT_SPEC(117, 117, 0xcc0, 11),
+	MTK_PIN_IES_SMT_SPEC(118, 118, 0xcf0, 15),
+	MTK_PIN_IES_SMT_SPEC(119, 119, 0xcf0, 11),
+	MTK_PIN_IES_SMT_SPEC(120, 120, 0xcf0, 7),
+	MTK_PIN_IES_SMT_SPEC(121, 121, 0xcf0, 3),
+	MTK_PIN_IES_SMT_SPEC(122, 125, 0xb60, 7),
+	MTK_PIN_IES_SMT_SPEC(126, 126, 0xb50, 12),
+	MTK_PIN_IES_SMT_SPEC(127, 142, 0xb60, 9),
+	MTK_PIN_IES_SMT_SPEC(143, 160, 0xb60, 10),
+	MTK_PIN_IES_SMT_SPEC(161, 168, 0xb60, 12),
+	MTK_PIN_IES_SMT_SPEC(169, 183, 0xb60, 10),
+	MTK_PIN_IES_SMT_SPEC(184, 186, 0xb60, 9),
+	MTK_PIN_IES_SMT_SPEC(187, 187, 0xb60, 14),
+	MTK_PIN_IES_SMT_SPEC(188, 188, 0xb50, 13),
+	MTK_PIN_IES_SMT_SPEC(189, 193, 0xb60, 15),
+	MTK_PIN_IES_SMT_SPEC(194, 198, 0xb70, 0),
+	MTK_PIN_IES_SMT_SPEC(199, 199, 0xb50, 1),
+	MTK_PIN_IES_SMT_SPEC(200, 202, 0xb70, 1),
+	MTK_PIN_IES_SMT_SPEC(203, 207, 0xb70, 2),
+	MTK_PIN_IES_SMT_SPEC(208, 209, 0xb70, 3),
+	MTK_PIN_IES_SMT_SPEC(210, 210, 0xb70, 4),
+	MTK_PIN_IES_SMT_SPEC(211, 235, 0xb70, 5),
+	MTK_PIN_IES_SMT_SPEC(236, 241, 0xb70, 6),
+	MTK_PIN_IES_SMT_SPEC(242, 243, 0xb70, 7),
+	MTK_PIN_IES_SMT_SPEC(244, 247, 0xb70, 8),
+	MTK_PIN_IES_SMT_SPEC(248, 248, 0xb70, 9),
+	MTK_PIN_IES_SMT_SPEC(249, 249, 0x140, 3),
+	MTK_PIN_IES_SMT_SPEC(250, 250, 0x130, 15),
+	MTK_PIN_IES_SMT_SPEC(251, 251, 0x130, 11),
+	MTK_PIN_IES_SMT_SPEC(252, 252, 0x130, 7),
+	MTK_PIN_IES_SMT_SPEC(253, 253, 0x130, 3),
+	MTK_PIN_IES_SMT_SPEC(254, 254, 0xf40, 15),
+	MTK_PIN_IES_SMT_SPEC(255, 255, 0xf40, 11),
+	MTK_PIN_IES_SMT_SPEC(256, 256, 0xf40, 7),
+	MTK_PIN_IES_SMT_SPEC(257, 257, 0xf40, 3),
+	MTK_PIN_IES_SMT_SPEC(258, 258, 0xcb0, 11),
+	MTK_PIN_IES_SMT_SPEC(259, 259, 0xc90, 11),
+	MTK_PIN_IES_SMT_SPEC(260, 260, 0x3a0, 11),
+	MTK_PIN_IES_SMT_SPEC(261, 261, 0x0b0, 3),
+	MTK_PIN_IES_SMT_SPEC(262, 277, 0xb70, 12),
+	MTK_PIN_IES_SMT_SPEC(278, 278, 0xb70, 13),
+};
+
+static int mt2701_ies_smt_set(struct regmap *regmap, unsigned int pin,
+		unsigned char align, int value, enum pin_config_param arg)
+{
+	if (arg == PIN_CONFIG_INPUT_ENABLE)
+		return mtk_pconf_spec_set_ies_smt_range(regmap, mt2701_ies_set,
+			ARRAY_SIZE(mt2701_ies_set), pin, align, value);
+	else if (arg == PIN_CONFIG_INPUT_SCHMITT_ENABLE)
+		return mtk_pconf_spec_set_ies_smt_range(regmap, mt2701_smt_set,
+			ARRAY_SIZE(mt2701_smt_set), pin, align, value);
+	return -EINVAL;
+}
+
+static const struct mtk_spec_pinmux_set mt2701_spec_pinmux[] = {
+	MTK_PINMUX_SPEC(22, 0xb10, 3),
+	MTK_PINMUX_SPEC(23, 0xb10, 4),
+	MTK_PINMUX_SPEC(24, 0xb10, 5),
+	MTK_PINMUX_SPEC(29, 0xb10, 9),
+	MTK_PINMUX_SPEC(208, 0xb10, 7),
+	MTK_PINMUX_SPEC(209, 0xb10, 8),
+	MTK_PINMUX_SPEC(203, 0xf20, 0),
+	MTK_PINMUX_SPEC(204, 0xf20, 1),
+};
+
+static void mt2701_spec_pinmux_set(struct regmap *reg, unsigned int pin,
+			unsigned int mode)
+{
+	unsigned int i, value, mask;
+	unsigned int info_num = ARRAY_SIZE(mt2701_spec_pinmux);
+	unsigned int spec_flag;
+
+	for (i = 0; i < info_num; i++) {
+		if (pin == mt2701_spec_pinmux[i].pin)
+			break;
+	}
+
+	if (i == info_num)
+		return;
+
+	spec_flag = (mode >> 3);
+	mask = BIT(mt2701_spec_pinmux[i].bit);
+	if (!spec_flag)
+		value = mask;
+	else
+		value = 0;
+	regmap_update_bits(reg, mt2701_spec_pinmux[i].offset, mask, value);
+}
+
+static const struct mtk_pinctrl_devdata mt2701_pinctrl_data = {
+	.pins = mtk_pins_mt2701,
+	.npins = ARRAY_SIZE(mtk_pins_mt2701),
+	.grp_desc = mt2701_drv_grp,
+	.n_grp_cls = ARRAY_SIZE(mt2701_drv_grp),
+	.pin_drv_grp = mt2701_pin_drv,
+	.n_pin_drv_grps = ARRAY_SIZE(mt2701_pin_drv),
+	.spec_pull_set = mt2701_spec_pull_set,
+	.spec_ies_smt_set = mt2701_ies_smt_set,
+	.spec_pinmux_set = mt2701_spec_pinmux_set,
+	.dir_offset = 0x0000,
+	.pullen_offset = 0x0150,
+	.pullsel_offset = 0x0280,
+	.dout_offset = 0x0500,
+	.din_offset = 0x0630,
+	.pinmux_offset = 0x0760,
+	.type1_start = 280,
+	.type1_end = 280,
+	.port_shf = 4,
+	.port_mask = 0xf,
+	.port_align = 4,
+	.eint_offsets = {
+		.name = "mt2701_eint",
+		.stat      = 0x000,
+		.ack       = 0x040,
+		.mask      = 0x080,
+		.mask_set  = 0x0c0,
+		.mask_clr  = 0x100,
+		.sens      = 0x140,
+		.sens_set  = 0x180,
+		.sens_clr  = 0x1c0,
+		.soft      = 0x200,
+		.soft_set  = 0x240,
+		.soft_clr  = 0x280,
+		.pol       = 0x300,
+		.pol_set   = 0x340,
+		.pol_clr   = 0x380,
+		.dom_en    = 0x400,
+		.dbnc_ctrl = 0x500,
+		.dbnc_set  = 0x600,
+		.dbnc_clr  = 0x700,
+		.port_mask = 6,
+		.ports     = 6,
+	},
+	.ap_num = 169,
+	.db_cnt = 16,
+};
+
+static int mt2701_pinctrl_probe(struct platform_device *pdev)
+{
+	return mtk_pctrl_init(pdev, &mt2701_pinctrl_data, NULL);
+}
+
+static const struct of_device_id mt2701_pctrl_match[] = {
+	{ .compatible = "mediatek,mt2701-pinctrl", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mt2701_pctrl_match);
+
+static struct platform_driver mtk_pinctrl_driver = {
+	.probe = mt2701_pinctrl_probe,
+	.driver = {
+		.name = "mediatek-mt2701-pinctrl",
+		.owner = THIS_MODULE,
+		.of_match_table = mt2701_pctrl_match,
+	},
+};
+
+static int __init mtk_pinctrl_init(void)
+{
+	return platform_driver_register(&mtk_pinctrl_driver);
+}
+
+module_init(mtk_pinctrl_init);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MediaTek MT2701 Pinctrl Driver");
+MODULE_AUTHOR("Biao Huang <biao.huang@mediatek.com>");
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index f307f1d..a422bb9 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -47,6 +47,8 @@
 static const char * const mtk_gpio_functions[] = {
 	"func0", "func1", "func2", "func3",
 	"func4", "func5", "func6", "func7",
+	"func8", "func9", "func10", "func11",
+	"func12", "func13", "func14", "func15",
 };
 
 /*
@@ -667,9 +669,14 @@ static int mtk_pmx_set_mode(struct pinctrl_dev *pctldev,
 	unsigned int mask = (1L << GPIO_MODE_BITS) - 1;
 	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
+	if (pctl->devdata->spec_pinmux_set)
+		pctl->devdata->spec_pinmux_set(mtk_get_regmap(pctl, pin),
+					pin, mode);
+
 	reg_addr = ((pin / MAX_GPIO_MODE_PER_REG) << pctl->devdata->port_shf)
 			+ pctl->devdata->pinmux_offset;
 
+	mode &= mask;
 	bit = pin % MAX_GPIO_MODE_PER_REG;
 	mask <<= (GPIO_MODE_BITS * bit);
 	val = (mode << (GPIO_MODE_BITS * bit));
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 55a5343..fcf11dd 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -209,6 +209,7 @@ struct mtk_eint_offsets {
  * means when user set smt, input enable is set at the same time. So they
  * also need special control. If special control is success, this should
  * return 0, otherwise return non-zero value.
+ * @spec_pinmux_set: Some pins are special, their pinmux need extra setting
  *
  * @dir_offset: The direction register offset.
  * @pullen_offset: The pull-up/pull-down enable register offset.
@@ -234,6 +235,8 @@ struct mtk_pinctrl_devdata {
 			unsigned char align, bool isup, unsigned int arg);
 	int (*spec_ies_smt_set)(struct regmap *reg, unsigned int pin,
 			unsigned char align, int value, enum pin_config_param arg);
+	void (*spec_pinmux_set)(struct regmap *reg, unsigned int pin,
+			unsigned int mode);
 	unsigned int dir_offset;
 	unsigned int ies_offset;
 	unsigned int smt_offset;
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h
new file mode 100644
index 0000000..f906420
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h
@@ -0,0 +1,2323 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author: Biao Huang <biao.huang@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __PINCTRL_MTK_MT2701_H
+#define __PINCTRL_MTK_MT2701_H
+
+#include <linux/pinctrl/pinctrl.h>
+#include "pinctrl-mtk-common.h"
+
+static const struct mtk_desc_pin mtk_pins_mt2701[] = {
+	MTK_PIN(
+		PINCTRL_PIN(0, "PWRAP_SPI0_MI"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 148),
+		MTK_FUNCTION(0, "GPIO0"),
+		MTK_FUNCTION(1, "PWRAP_SPIDO"),
+		MTK_FUNCTION(2, "PWRAP_SPIDI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(1, "PWRAP_SPI0_MO"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 149),
+		MTK_FUNCTION(0, "GPIO1"),
+		MTK_FUNCTION(1, "PWRAP_SPIDI"),
+		MTK_FUNCTION(2, "PWRAP_SPIDO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(2, "PWRAP_INT"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 150),
+		MTK_FUNCTION(0, "GPIO2"),
+		MTK_FUNCTION(1, "PWRAP_INT")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(3, "PWRAP_SPI0_CK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 151),
+		MTK_FUNCTION(0, "GPIO3"),
+		MTK_FUNCTION(1, "PWRAP_SPICK_I")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(4, "PWRAP_SPI0_CSN"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 152),
+		MTK_FUNCTION(0, "GPIO4"),
+		MTK_FUNCTION(1, "PWRAP_SPICS_B_I")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(5, "PWRAP_SPI0_CK2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 153),
+		MTK_FUNCTION(0, "GPIO5"),
+		MTK_FUNCTION(1, "PWRAP_SPICK2_I"),
+		MTK_FUNCTION(5, "ANT_SEL1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(6, "PWRAP_SPI0_CSN2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 154),
+		MTK_FUNCTION(0, "GPIO6"),
+		MTK_FUNCTION(1, "PWRAP_SPICS2_B_I"),
+		MTK_FUNCTION(5, "ANT_SEL0"),
+		MTK_FUNCTION(7, "DBG_MON_A[0]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(7, "SPI1_CSN"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 155),
+		MTK_FUNCTION(0, "GPIO7"),
+		MTK_FUNCTION(1, "SPI1_CS"),
+		MTK_FUNCTION(4, "KCOL0"),
+		MTK_FUNCTION(7, "DBG_MON_B[12]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(8, "SPI1_MI"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 156),
+		MTK_FUNCTION(0, "GPIO8"),
+		MTK_FUNCTION(1, "SPI1_MI"),
+		MTK_FUNCTION(2, "SPI1_MO"),
+		MTK_FUNCTION(4, "KCOL1"),
+		MTK_FUNCTION(7, "DBG_MON_B[13]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(9, "SPI1_MO"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 157),
+		MTK_FUNCTION(0, "GPIO9"),
+		MTK_FUNCTION(1, "SPI1_MO"),
+		MTK_FUNCTION(2, "SPI1_MI"),
+		MTK_FUNCTION(3, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(4, "KCOL2"),
+		MTK_FUNCTION(7, "DBG_MON_B[14]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(10, "RTC32K_CK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 158),
+		MTK_FUNCTION(0, "GPIO10"),
+		MTK_FUNCTION(1, "RTC32K_CK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(11, "WATCHDOG"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 159),
+		MTK_FUNCTION(0, "GPIO11"),
+		MTK_FUNCTION(1, "WATCHDOG")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(12, "SRCLKENA"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 160),
+		MTK_FUNCTION(0, "GPIO12"),
+		MTK_FUNCTION(1, "SRCLKENA")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(13, "SRCLKENAI"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 161),
+		MTK_FUNCTION(0, "GPIO13"),
+		MTK_FUNCTION(1, "SRCLKENAI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(14, "URXD2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 162),
+		MTK_FUNCTION(0, "GPIO14"),
+		MTK_FUNCTION(1, "URXD2"),
+		MTK_FUNCTION(2, "UTXD2"),
+		MTK_FUNCTION(5, "SRCCLKENAI2"),
+		MTK_FUNCTION(7, "DBG_MON_B[30]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(15, "UTXD2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 163),
+		MTK_FUNCTION(0, "GPIO15"),
+		MTK_FUNCTION(1, "UTXD2"),
+		MTK_FUNCTION(2, "URXD2"),
+		MTK_FUNCTION(7, "DBG_MON_B[31]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(16, "I2S5_DATA_IN"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 164),
+		MTK_FUNCTION(0, "GPIO16"),
+		MTK_FUNCTION(1, "I2S5_DATA_IN"),
+		MTK_FUNCTION(3, "PCM_RX"),
+		MTK_FUNCTION(4, "ANT_SEL4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(17, "I2S5_BCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 165),
+		MTK_FUNCTION(0, "GPIO17"),
+		MTK_FUNCTION(1, "I2S5_BCK"),
+		MTK_FUNCTION(3, "PCM_CLK0"),
+		MTK_FUNCTION(4, "ANT_SEL2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(18, "PCM_CLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 166),
+		MTK_FUNCTION(0, "GPIO18"),
+		MTK_FUNCTION(1, "PCM_CLK0"),
+		MTK_FUNCTION(2, "MRG_CLK"),
+		MTK_FUNCTION(4, "MM_TEST_CK"),
+		MTK_FUNCTION(5, "CONN_DSP_JCK"),
+		MTK_FUNCTION(6, "WCN_PCM_CLKO"),
+		MTK_FUNCTION(7, "DBG_MON_A[3]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(19, "PCM_SYNC"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 167),
+		MTK_FUNCTION(0, "GPIO19"),
+		MTK_FUNCTION(1, "PCM_SYNC"),
+		MTK_FUNCTION(2, "MRG_SYNC"),
+		MTK_FUNCTION(5, "CONN_DSP_JINTP"),
+		MTK_FUNCTION(6, "WCN_PCM_SYNC"),
+		MTK_FUNCTION(7, "DBG_MON_A[5]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(20, "PCM_RX"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO20"),
+		MTK_FUNCTION(1, "PCM_RX"),
+		MTK_FUNCTION(2, "MRG_RX"),
+		MTK_FUNCTION(3, "MRG_TX"),
+		MTK_FUNCTION(4, "PCM_TX"),
+		MTK_FUNCTION(5, "CONN_DSP_JDI"),
+		MTK_FUNCTION(6, "WCN_PCM_RX"),
+		MTK_FUNCTION(7, "DBG_MON_A[4]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(21, "PCM_TX"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO21"),
+		MTK_FUNCTION(1, "PCM_TX"),
+		MTK_FUNCTION(2, "MRG_TX"),
+		MTK_FUNCTION(3, "MRG_RX"),
+		MTK_FUNCTION(4, "PCM_RX"),
+		MTK_FUNCTION(5, "CONN_DSP_JMS"),
+		MTK_FUNCTION(6, "WCN_PCM_TX"),
+		MTK_FUNCTION(7, "DBG_MON_A[2]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(22, "EINT0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 0),
+		MTK_FUNCTION(0, "GPIO22"),
+		MTK_FUNCTION(1, "UCTS0"),
+		MTK_FUNCTION(3, "KCOL3"),
+		MTK_FUNCTION(4, "CONN_DSP_JDO"),
+		MTK_FUNCTION(5, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(7, "DBG_MON_A[30]"),
+		MTK_FUNCTION(10, "PCIE0_PERST_N")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(23, "EINT1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 1),
+		MTK_FUNCTION(0, "GPIO23"),
+		MTK_FUNCTION(1, "URTS0"),
+		MTK_FUNCTION(3, "KCOL2"),
+		MTK_FUNCTION(4, "CONN_MCU_TDO"),
+		MTK_FUNCTION(5, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(7, "DBG_MON_A[29]"),
+		MTK_FUNCTION(10, "PCIE1_PERST_N")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(24, "EINT2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 2),
+		MTK_FUNCTION(0, "GPIO24"),
+		MTK_FUNCTION(1, "UCTS1"),
+		MTK_FUNCTION(3, "KCOL1"),
+		MTK_FUNCTION(4, "CONN_MCU_DBGACK_N"),
+		MTK_FUNCTION(7, "DBG_MON_A[28]"),
+		MTK_FUNCTION(10, "PCIE2_PERST_N")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(25, "EINT3"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 3),
+		MTK_FUNCTION(0, "GPIO25"),
+		MTK_FUNCTION(1, "URTS1"),
+		MTK_FUNCTION(3, "KCOL0"),
+		MTK_FUNCTION(4, "CONN_MCU_DBGI_N"),
+		MTK_FUNCTION(7, "DBG_MON_A[27]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(26, "EINT4"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 4),
+		MTK_FUNCTION(0, "GPIO26"),
+		MTK_FUNCTION(1, "UCTS3"),
+		MTK_FUNCTION(2, "DRV_VBUS_P1"),
+		MTK_FUNCTION(3, "KROW3"),
+		MTK_FUNCTION(4, "CONN_MCU_TCK0"),
+		MTK_FUNCTION(5, "CONN_MCU_AICE_JCKC"),
+		MTK_FUNCTION(6, "PCIE2_WAKE_N"),
+		MTK_FUNCTION(7, "DBG_MON_A[26]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(27, "EINT5"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 5),
+		MTK_FUNCTION(0, "GPIO27"),
+		MTK_FUNCTION(1, "URTS3"),
+		MTK_FUNCTION(2, "IDDIG_P1"),
+		MTK_FUNCTION(3, "KROW2"),
+		MTK_FUNCTION(4, "CONN_MCU_TDI"),
+		MTK_FUNCTION(6, "PCIE1_WAKE_N"),
+		MTK_FUNCTION(7, "DBG_MON_A[25]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(28, "EINT6"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 6),
+		MTK_FUNCTION(0, "GPIO28"),
+		MTK_FUNCTION(1, "DRV_VBUS"),
+		MTK_FUNCTION(3, "KROW1"),
+		MTK_FUNCTION(4, "CONN_MCU_TRST_B"),
+		MTK_FUNCTION(6, "PCIE0_WAKE_N"),
+		MTK_FUNCTION(7, "DBG_MON_A[24]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(29, "EINT7"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 7),
+		MTK_FUNCTION(0, "GPIO29"),
+		MTK_FUNCTION(1, "IDDIG"),
+		MTK_FUNCTION(2, "MSDC1_WP"),
+		MTK_FUNCTION(3, "KROW0"),
+		MTK_FUNCTION(4, "CONN_MCU_TMS"),
+		MTK_FUNCTION(5, "CONN_MCU_AICE_JMSC"),
+		MTK_FUNCTION(7, "DBG_MON_A[23]"),
+		MTK_FUNCTION(14, "PCIE2_PERST_N")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(30, "I2S5_LRCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 12),
+		MTK_FUNCTION(0, "GPIO30"),
+		MTK_FUNCTION(1, "I2S5_LRCK"),
+		MTK_FUNCTION(3, "PCM_SYNC"),
+		MTK_FUNCTION(4, "ANT_SEL1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(31, "I2S5_MCLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 13),
+		MTK_FUNCTION(0, "GPIO31"),
+		MTK_FUNCTION(1, "I2S5_MCLK"),
+		MTK_FUNCTION(4, "ANT_SEL0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(32, "I2S5_DATA"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 14),
+		MTK_FUNCTION(0, "GPIO32"),
+		MTK_FUNCTION(1, "I2S5_DATA"),
+		MTK_FUNCTION(2, "I2S5_DATA_BYPS"),
+		MTK_FUNCTION(3, "PCM_TX"),
+		MTK_FUNCTION(4, "ANT_SEL3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(33, "I2S1_DATA"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 15),
+		MTK_FUNCTION(0, "GPIO33"),
+		MTK_FUNCTION(1, "I2S1_DATA"),
+		MTK_FUNCTION(2, "I2S1_DATA_BYPS"),
+		MTK_FUNCTION(3, "PCM_TX"),
+		MTK_FUNCTION(4, "IMG_TEST_CK"),
+		MTK_FUNCTION(5, "G1_RXD0"),
+		MTK_FUNCTION(6, "WCN_PCM_TX"),
+		MTK_FUNCTION(7, "DBG_MON_B[8]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(34, "I2S1_DATA_IN"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 16),
+		MTK_FUNCTION(0, "GPIO34"),
+		MTK_FUNCTION(1, "I2S1_DATA_IN"),
+		MTK_FUNCTION(3, "PCM_RX"),
+		MTK_FUNCTION(4, "VDEC_TEST_CK"),
+		MTK_FUNCTION(5, "G1_RXD1"),
+		MTK_FUNCTION(6, "WCN_PCM_RX"),
+		MTK_FUNCTION(7, "DBG_MON_B[7]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(35, "I2S1_BCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 17),
+		MTK_FUNCTION(0, "GPIO35"),
+		MTK_FUNCTION(1, "I2S1_BCK"),
+		MTK_FUNCTION(3, "PCM_CLK0"),
+		MTK_FUNCTION(5, "G1_RXD2"),
+		MTK_FUNCTION(6, "WCN_PCM_CLKO"),
+		MTK_FUNCTION(7, "DBG_MON_B[9]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(36, "I2S1_LRCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 18),
+		MTK_FUNCTION(0, "GPIO36"),
+		MTK_FUNCTION(1, "I2S1_LRCK"),
+		MTK_FUNCTION(3, "PCM_SYNC"),
+		MTK_FUNCTION(5, "G1_RXD3"),
+		MTK_FUNCTION(6, "WCN_PCM_SYNC"),
+		MTK_FUNCTION(7, "DBG_MON_B[10]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(37, "I2S1_MCLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 19),
+		MTK_FUNCTION(0, "GPIO37"),
+		MTK_FUNCTION(1, "I2S1_MCLK"),
+		MTK_FUNCTION(5, "G1_RXDV"),
+		MTK_FUNCTION(7, "DBG_MON_B[11]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(38, "I2S2_DATA"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 20),
+		MTK_FUNCTION(0, "GPIO38"),
+		MTK_FUNCTION(2, "I2S2_DATA_BYPS"),
+		MTK_FUNCTION(3, "PCM_TX"),
+		MTK_FUNCTION(4, "DMIC_DAT0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(39, "JTMS"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 21),
+		MTK_FUNCTION(0, "GPIO39"),
+		MTK_FUNCTION(1, "JTMS"),
+		MTK_FUNCTION(2, "CONN_MCU_TMS"),
+		MTK_FUNCTION(3, "CONN_MCU_AICE_JMSC"),
+		MTK_FUNCTION(4, "DFD_TMS_XI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(40, "JTCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 22),
+		MTK_FUNCTION(0, "GPIO40"),
+		MTK_FUNCTION(1, "JTCK"),
+		MTK_FUNCTION(2, "CONN_MCU_TCK1"),
+		MTK_FUNCTION(3, "CONN_MCU_AICE_JCKC"),
+		MTK_FUNCTION(4, "DFD_TCK_XI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(41, "JTDI"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 23),
+		MTK_FUNCTION(0, "GPIO41"),
+		MTK_FUNCTION(1, "JTDI"),
+		MTK_FUNCTION(2, "CONN_MCU_TDI"),
+		MTK_FUNCTION(4, "DFD_TDI_XI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(42, "JTDO"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 24),
+		MTK_FUNCTION(0, "GPIO42"),
+		MTK_FUNCTION(1, "JTDO"),
+		MTK_FUNCTION(2, "CONN_MCU_TDO"),
+		MTK_FUNCTION(4, "DFD_TDO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(43, "NCLE"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 25),
+		MTK_FUNCTION(0, "GPIO43"),
+		MTK_FUNCTION(1, "NCLE"),
+		MTK_FUNCTION(2, "EXT_XCS2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(44, "NCEB1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 26),
+		MTK_FUNCTION(0, "GPIO44"),
+		MTK_FUNCTION(1, "NCEB1"),
+		MTK_FUNCTION(2, "IDDIG")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(45, "NCEB0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 27),
+		MTK_FUNCTION(0, "GPIO45"),
+		MTK_FUNCTION(1, "NCEB0"),
+		MTK_FUNCTION(2, "DRV_VBUS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(46, "IR"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 28),
+		MTK_FUNCTION(0, "GPIO46"),
+		MTK_FUNCTION(1, "IR")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(47, "NREB"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 29),
+		MTK_FUNCTION(0, "GPIO47"),
+		MTK_FUNCTION(1, "NREB"),
+		MTK_FUNCTION(2, "IDDIG_P1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(48, "NRNB"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 30),
+		MTK_FUNCTION(0, "GPIO48"),
+		MTK_FUNCTION(1, "NRNB"),
+		MTK_FUNCTION(2, "DRV_VBUS_P1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(49, "I2S0_DATA"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 31),
+		MTK_FUNCTION(0, "GPIO49"),
+		MTK_FUNCTION(1, "I2S0_DATA"),
+		MTK_FUNCTION(2, "I2S0_DATA_BYPS"),
+		MTK_FUNCTION(3, "PCM_TX"),
+		MTK_FUNCTION(6, "WCN_I2S_DO"),
+		MTK_FUNCTION(7, "DBG_MON_B[3]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(50, "I2S2_BCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 32),
+		MTK_FUNCTION(0, "GPIO50"),
+		MTK_FUNCTION(1, "I2S2_BCK"),
+		MTK_FUNCTION(3, "PCM_CLK0"),
+		MTK_FUNCTION(4, "DMIC_SCK1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(51, "I2S2_DATA_IN"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 33),
+		MTK_FUNCTION(0, "GPIO51"),
+		MTK_FUNCTION(1, "I2S2_DATA_IN"),
+		MTK_FUNCTION(3, "PCM_RX"),
+		MTK_FUNCTION(4, "DMIC_SCK0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(52, "I2S2_LRCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 34),
+		MTK_FUNCTION(0, "GPIO52"),
+		MTK_FUNCTION(1, "I2S2_LRCK"),
+		MTK_FUNCTION(3, "PCM_SYNC"),
+		MTK_FUNCTION(4, "DMIC_DAT1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(53, "SPI0_CSN"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 35),
+		MTK_FUNCTION(0, "GPIO53"),
+		MTK_FUNCTION(1, "SPI0_CS"),
+		MTK_FUNCTION(3, "SPDIF"),
+		MTK_FUNCTION(4, "ADC_CK"),
+		MTK_FUNCTION(5, "PWM1"),
+		MTK_FUNCTION(7, "DBG_MON_A[7]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(54, "SPI0_CK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 36),
+		MTK_FUNCTION(0, "GPIO54"),
+		MTK_FUNCTION(1, "SPI0_CK"),
+		MTK_FUNCTION(3, "SPDIF_IN1"),
+		MTK_FUNCTION(4, "ADC_DAT_IN"),
+		MTK_FUNCTION(7, "DBG_MON_A[10]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(55, "SPI0_MI"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 37),
+		MTK_FUNCTION(0, "GPIO55"),
+		MTK_FUNCTION(1, "SPI0_MI"),
+		MTK_FUNCTION(2, "SPI0_MO"),
+		MTK_FUNCTION(3, "MSDC1_WP"),
+		MTK_FUNCTION(4, "ADC_WS"),
+		MTK_FUNCTION(5, "PWM2"),
+		MTK_FUNCTION(7, "DBG_MON_A[8]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(56, "SPI0_MO"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 38),
+		MTK_FUNCTION(0, "GPIO56"),
+		MTK_FUNCTION(1, "SPI0_MO"),
+		MTK_FUNCTION(2, "SPI0_MI"),
+		MTK_FUNCTION(3, "SPDIF_IN0"),
+		MTK_FUNCTION(7, "DBG_MON_A[9]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(57, "SDA1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 39),
+		MTK_FUNCTION(0, "GPIO57"),
+		MTK_FUNCTION(1, "SDA1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(58, "SCL1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 40),
+		MTK_FUNCTION(0, "GPIO58"),
+		MTK_FUNCTION(1, "SCL1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(59, "RAMBUF_I_CLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO59"),
+		MTK_FUNCTION(1, "RAMBUF_I_CLK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(60, "WB_RSTB"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 41),
+		MTK_FUNCTION(0, "GPIO60"),
+		MTK_FUNCTION(1, "WB_RSTB"),
+		MTK_FUNCTION(7, "DBG_MON_A[11]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(61, "F2W_DATA"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 42),
+		MTK_FUNCTION(0, "GPIO61"),
+		MTK_FUNCTION(1, "F2W_DATA"),
+		MTK_FUNCTION(7, "DBG_MON_A[16]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(62, "F2W_CLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 43),
+		MTK_FUNCTION(0, "GPIO62"),
+		MTK_FUNCTION(1, "F2W_CK"),
+		MTK_FUNCTION(7, "DBG_MON_A[15]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(63, "WB_SCLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 44),
+		MTK_FUNCTION(0, "GPIO63"),
+		MTK_FUNCTION(1, "WB_SCLK"),
+		MTK_FUNCTION(7, "DBG_MON_A[13]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(64, "WB_SDATA"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 45),
+		MTK_FUNCTION(0, "GPIO64"),
+		MTK_FUNCTION(1, "WB_SDATA"),
+		MTK_FUNCTION(7, "DBG_MON_A[12]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(65, "WB_SEN"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 46),
+		MTK_FUNCTION(0, "GPIO65"),
+		MTK_FUNCTION(1, "WB_SEN"),
+		MTK_FUNCTION(7, "DBG_MON_A[14]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(66, "WB_CRTL0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 47),
+		MTK_FUNCTION(0, "GPIO66"),
+		MTK_FUNCTION(1, "WB_CRTL0"),
+		MTK_FUNCTION(5, "DFD_NTRST_XI"),
+		MTK_FUNCTION(7, "DBG_MON_A[17]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(67, "WB_CRTL1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 48),
+		MTK_FUNCTION(0, "GPIO67"),
+		MTK_FUNCTION(1, "WB_CRTL1"),
+		MTK_FUNCTION(5, "DFD_TMS_XI"),
+		MTK_FUNCTION(7, "DBG_MON_A[18]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(68, "WB_CRTL2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 49),
+		MTK_FUNCTION(0, "GPIO68"),
+		MTK_FUNCTION(1, "WB_CRTL2"),
+		MTK_FUNCTION(5, "DFD_TCK_XI"),
+		MTK_FUNCTION(7, "DBG_MON_A[19]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(69, "WB_CRTL3"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 50),
+		MTK_FUNCTION(0, "GPIO69"),
+		MTK_FUNCTION(1, "WB_CRTL3"),
+		MTK_FUNCTION(5, "DFD_TDI_XI"),
+		MTK_FUNCTION(7, "DBG_MON_A[20]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(70, "WB_CRTL4"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 51),
+		MTK_FUNCTION(0, "GPIO70"),
+		MTK_FUNCTION(1, "WB_CRTL4"),
+		MTK_FUNCTION(5, "DFD_TDO"),
+		MTK_FUNCTION(7, "DBG_MON_A[21]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(71, "WB_CRTL5"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 52),
+		MTK_FUNCTION(0, "GPIO71"),
+		MTK_FUNCTION(1, "WB_CRTL5"),
+		MTK_FUNCTION(7, "DBG_MON_A[22]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(72, "I2S0_DATA_IN"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 53),
+		MTK_FUNCTION(0, "GPIO72"),
+		MTK_FUNCTION(1, "I2S0_DATA_IN"),
+		MTK_FUNCTION(3, "PCM_RX"),
+		MTK_FUNCTION(4, "PWM0"),
+		MTK_FUNCTION(5, "DISP_PWM"),
+		MTK_FUNCTION(6, "WCN_I2S_DI"),
+		MTK_FUNCTION(7, "DBG_MON_B[2]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(73, "I2S0_LRCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 54),
+		MTK_FUNCTION(0, "GPIO73"),
+		MTK_FUNCTION(1, "I2S0_LRCK"),
+		MTK_FUNCTION(3, "PCM_SYNC"),
+		MTK_FUNCTION(6, "WCN_I2S_LRCK"),
+		MTK_FUNCTION(7, "DBG_MON_B[5]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(74, "I2S0_BCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 55),
+		MTK_FUNCTION(0, "GPIO74"),
+		MTK_FUNCTION(1, "I2S0_BCK"),
+		MTK_FUNCTION(3, "PCM_CLK0"),
+		MTK_FUNCTION(6, "WCN_I2S_BCK"),
+		MTK_FUNCTION(7, "DBG_MON_B[4]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(75, "SDA0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 56),
+		MTK_FUNCTION(0, "GPIO75"),
+		MTK_FUNCTION(1, "SDA0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(76, "SCL0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 57),
+		MTK_FUNCTION(0, "GPIO76"),
+		MTK_FUNCTION(1, "SCL0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(77, "SDA2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 58),
+		MTK_FUNCTION(0, "GPIO77"),
+		MTK_FUNCTION(1, "SDA2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(78, "SCL2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 59),
+		MTK_FUNCTION(0, "GPIO78"),
+		MTK_FUNCTION(1, "SCL2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(79, "URXD0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 60),
+		MTK_FUNCTION(0, "GPIO79"),
+		MTK_FUNCTION(1, "URXD0"),
+		MTK_FUNCTION(2, "UTXD0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(80, "UTXD0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 61),
+		MTK_FUNCTION(0, "GPIO80"),
+		MTK_FUNCTION(1, "UTXD0"),
+		MTK_FUNCTION(2, "URXD0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(81, "URXD1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 62),
+		MTK_FUNCTION(0, "GPIO81"),
+		MTK_FUNCTION(1, "URXD1"),
+		MTK_FUNCTION(2, "UTXD1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(82, "UTXD1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 63),
+		MTK_FUNCTION(0, "GPIO82"),
+		MTK_FUNCTION(1, "UTXD1"),
+		MTK_FUNCTION(2, "URXD1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(83, "LCM_RST"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 64),
+		MTK_FUNCTION(0, "GPIO83"),
+		MTK_FUNCTION(1, "LCM_RST"),
+		MTK_FUNCTION(2, "VDAC_CK_XI"),
+		MTK_FUNCTION(7, "DBG_MON_B[1]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(84, "DSI_TE"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 65),
+		MTK_FUNCTION(0, "GPIO84"),
+		MTK_FUNCTION(1, "DSI_TE"),
+		MTK_FUNCTION(7, "DBG_MON_B[0]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(85, "MSDC2_CMD"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 66),
+		MTK_FUNCTION(0, "GPIO85"),
+		MTK_FUNCTION(1, "MSDC2_CMD"),
+		MTK_FUNCTION(2, "ANT_SEL0"),
+		MTK_FUNCTION(3, "SDA1"),
+		MTK_FUNCTION(6, "I2SOUT_BCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(86, "MSDC2_CLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 67),
+		MTK_FUNCTION(0, "GPIO86"),
+		MTK_FUNCTION(1, "MSDC2_CLK"),
+		MTK_FUNCTION(2, "ANT_SEL1"),
+		MTK_FUNCTION(3, "SCL1"),
+		MTK_FUNCTION(6, "I2SOUT_LRCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(87, "MSDC2_DAT0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 68),
+		MTK_FUNCTION(0, "GPIO87"),
+		MTK_FUNCTION(1, "MSDC2_DAT0"),
+		MTK_FUNCTION(2, "ANT_SEL2"),
+		MTK_FUNCTION(5, "UTXD0"),
+		MTK_FUNCTION(6, "I2SOUT_DATA_OUT")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(88, "MSDC2_DAT1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 71),
+		MTK_FUNCTION(0, "GPIO88"),
+		MTK_FUNCTION(1, "MSDC2_DAT1"),
+		MTK_FUNCTION(2, "ANT_SEL3"),
+		MTK_FUNCTION(3, "PWM0"),
+		MTK_FUNCTION(5, "URXD0"),
+		MTK_FUNCTION(6, "PWM1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(89, "MSDC2_DAT2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 72),
+		MTK_FUNCTION(0, "GPIO89"),
+		MTK_FUNCTION(1, "MSDC2_DAT2"),
+		MTK_FUNCTION(2, "ANT_SEL4"),
+		MTK_FUNCTION(3, "SDA2"),
+		MTK_FUNCTION(5, "UTXD1"),
+		MTK_FUNCTION(6, "PWM2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(90, "MSDC2_DAT3"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 73),
+		MTK_FUNCTION(0, "GPIO90"),
+		MTK_FUNCTION(1, "MSDC2_DAT3"),
+		MTK_FUNCTION(2, "ANT_SEL5"),
+		MTK_FUNCTION(3, "SCL2"),
+		MTK_FUNCTION(4, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(5, "URXD1"),
+		MTK_FUNCTION(6, "PWM3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(91, "TDN3"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPI91"),
+		MTK_FUNCTION(1, "TDN3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(92, "TDP3"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPI92"),
+		MTK_FUNCTION(1, "TDP3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(93, "TDN2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPI93"),
+		MTK_FUNCTION(1, "TDN2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(94, "TDP2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPI94"),
+		MTK_FUNCTION(1, "TDP2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(95, "TCN"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPI95"),
+		MTK_FUNCTION(1, "TCN")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(96, "TCP"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPI96"),
+		MTK_FUNCTION(1, "TCP")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(97, "TDN1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPI97"),
+		MTK_FUNCTION(1, "TDN1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(98, "TDP1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPI98"),
+		MTK_FUNCTION(1, "TDP1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(99, "TDN0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPI99"),
+		MTK_FUNCTION(1, "TDN0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(100, "TDP0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPI100"),
+		MTK_FUNCTION(1, "TDP0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(101, "SPI2_CSN"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 74),
+		MTK_FUNCTION(0, "GPIO101"),
+		MTK_FUNCTION(1, "SPI2_CS"),
+		MTK_FUNCTION(3, "SCL3"),
+		MTK_FUNCTION(4, "KROW0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(102, "SPI2_MI"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 75),
+		MTK_FUNCTION(0, "GPIO102"),
+		MTK_FUNCTION(1, "SPI2_MI"),
+		MTK_FUNCTION(2, "SPI2_MO"),
+		MTK_FUNCTION(3, "SDA3"),
+		MTK_FUNCTION(4, "KROW1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(103, "SPI2_MO"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 76),
+		MTK_FUNCTION(0, "GPIO103"),
+		MTK_FUNCTION(1, "SPI2_MO"),
+		MTK_FUNCTION(2, "SPI2_MI"),
+		MTK_FUNCTION(3, "SCL3"),
+		MTK_FUNCTION(4, "KROW2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(104, "SPI2_CLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 77),
+		MTK_FUNCTION(0, "GPIO104"),
+		MTK_FUNCTION(1, "SPI2_CK"),
+		MTK_FUNCTION(3, "SDA3"),
+		MTK_FUNCTION(4, "KROW3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(105, "MSDC1_CMD"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 78),
+		MTK_FUNCTION(0, "GPIO105"),
+		MTK_FUNCTION(1, "MSDC1_CMD"),
+		MTK_FUNCTION(2, "ANT_SEL0"),
+		MTK_FUNCTION(3, "SDA1"),
+		MTK_FUNCTION(6, "I2SOUT_BCK"),
+		MTK_FUNCTION(7, "DBG_MON_B[27]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(106, "MSDC1_CLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 79),
+		MTK_FUNCTION(0, "GPIO106"),
+		MTK_FUNCTION(1, "MSDC1_CLK"),
+		MTK_FUNCTION(2, "ANT_SEL1"),
+		MTK_FUNCTION(3, "SCL1"),
+		MTK_FUNCTION(6, "I2SOUT_LRCK"),
+		MTK_FUNCTION(7, "DBG_MON_B[28]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(107, "MSDC1_DAT0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 80),
+		MTK_FUNCTION(0, "GPIO107"),
+		MTK_FUNCTION(1, "MSDC1_DAT0"),
+		MTK_FUNCTION(2, "ANT_SEL2"),
+		MTK_FUNCTION(5, "UTXD0"),
+		MTK_FUNCTION(6, "I2SOUT_DATA_OUT"),
+		MTK_FUNCTION(7, "DBG_MON_B[26]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(108, "MSDC1_DAT1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 81),
+		MTK_FUNCTION(0, "GPIO108"),
+		MTK_FUNCTION(1, "MSDC1_DAT1"),
+		MTK_FUNCTION(2, "ANT_SEL3"),
+		MTK_FUNCTION(3, "PWM0"),
+		MTK_FUNCTION(5, "URXD0"),
+		MTK_FUNCTION(6, "PWM1"),
+		MTK_FUNCTION(7, "DBG_MON_B[25]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(109, "MSDC1_DAT2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 82),
+		MTK_FUNCTION(0, "GPIO109"),
+		MTK_FUNCTION(1, "MSDC1_DAT2"),
+		MTK_FUNCTION(2, "ANT_SEL4"),
+		MTK_FUNCTION(3, "SDA2"),
+		MTK_FUNCTION(5, "UTXD1"),
+		MTK_FUNCTION(6, "PWM2"),
+		MTK_FUNCTION(7, "DBG_MON_B[24]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(110, "MSDC1_DAT3"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 83),
+		MTK_FUNCTION(0, "GPIO110"),
+		MTK_FUNCTION(1, "MSDC1_DAT3"),
+		MTK_FUNCTION(2, "ANT_SEL5"),
+		MTK_FUNCTION(3, "SCL2"),
+		MTK_FUNCTION(4, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(5, "URXD1"),
+		MTK_FUNCTION(6, "PWM3"),
+		MTK_FUNCTION(7, "DBG_MON_B[23]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(111, "MSDC0_DAT7"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 84),
+		MTK_FUNCTION(0, "GPIO111"),
+		MTK_FUNCTION(1, "MSDC0_DAT7"),
+		MTK_FUNCTION(4, "NLD7")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(112, "MSDC0_DAT6"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 85),
+		MTK_FUNCTION(0, "GPIO112"),
+		MTK_FUNCTION(1, "MSDC0_DAT6"),
+		MTK_FUNCTION(4, "NLD6")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(113, "MSDC0_DAT5"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 86),
+		MTK_FUNCTION(0, "GPIO113"),
+		MTK_FUNCTION(1, "MSDC0_DAT5"),
+		MTK_FUNCTION(4, "NLD5")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(114, "MSDC0_DAT4"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 87),
+		MTK_FUNCTION(0, "GPIO114"),
+		MTK_FUNCTION(1, "MSDC0_DAT4"),
+		MTK_FUNCTION(4, "NLD4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(115, "MSDC0_RSTB"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 88),
+		MTK_FUNCTION(0, "GPIO115"),
+		MTK_FUNCTION(1, "MSDC0_RSTB"),
+		MTK_FUNCTION(4, "NLD8")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(116, "MSDC0_CMD"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 89),
+		MTK_FUNCTION(0, "GPIO116"),
+		MTK_FUNCTION(1, "MSDC0_CMD"),
+		MTK_FUNCTION(4, "NALE")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(117, "MSDC0_CLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 90),
+		MTK_FUNCTION(0, "GPIO117"),
+		MTK_FUNCTION(1, "MSDC0_CLK"),
+		MTK_FUNCTION(4, "NWEB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(118, "MSDC0_DAT3"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 91),
+		MTK_FUNCTION(0, "GPIO118"),
+		MTK_FUNCTION(1, "MSDC0_DAT3"),
+		MTK_FUNCTION(4, "NLD3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(119, "MSDC0_DAT2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 92),
+		MTK_FUNCTION(0, "GPIO119"),
+		MTK_FUNCTION(1, "MSDC0_DAT2"),
+		MTK_FUNCTION(4, "NLD2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(120, "MSDC0_DAT1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 93),
+		MTK_FUNCTION(0, "GPIO120"),
+		MTK_FUNCTION(1, "MSDC0_DAT1"),
+		MTK_FUNCTION(4, "NLD1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(121, "MSDC0_DAT0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 94),
+		MTK_FUNCTION(0, "GPIO121"),
+		MTK_FUNCTION(1, "MSDC0_DAT0"),
+		MTK_FUNCTION(4, "NLD0"),
+		MTK_FUNCTION(5, "WATCHDOG")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(122, "CEC"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 95),
+		MTK_FUNCTION(0, "GPIO122"),
+		MTK_FUNCTION(1, "CEC"),
+		MTK_FUNCTION(4, "SDA2"),
+		MTK_FUNCTION(5, "URXD0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(123, "HTPLG"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 96),
+		MTK_FUNCTION(0, "GPIO123"),
+		MTK_FUNCTION(1, "HTPLG"),
+		MTK_FUNCTION(4, "SCL2"),
+		MTK_FUNCTION(5, "UTXD0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(124, "HDMISCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 97),
+		MTK_FUNCTION(0, "GPIO124"),
+		MTK_FUNCTION(1, "HDMISCK"),
+		MTK_FUNCTION(4, "SDA1"),
+		MTK_FUNCTION(5, "PWM3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(125, "HDMISD"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 98),
+		MTK_FUNCTION(0, "GPIO125"),
+		MTK_FUNCTION(1, "HDMISD"),
+		MTK_FUNCTION(4, "SCL1"),
+		MTK_FUNCTION(5, "PWM4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(126, "I2S0_MCLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 99),
+		MTK_FUNCTION(0, "GPIO126"),
+		MTK_FUNCTION(1, "I2S0_MCLK"),
+		MTK_FUNCTION(6, "WCN_I2S_MCLK"),
+		MTK_FUNCTION(7, "DBG_MON_B[6]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(127, "RAMBUF_IDATA0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO127"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(128, "RAMBUF_IDATA1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO128"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(129, "RAMBUF_IDATA2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO129"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(130, "RAMBUF_IDATA3"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO130"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(131, "RAMBUF_IDATA4"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO131"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(132, "RAMBUF_IDATA5"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO132"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA5")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(133, "RAMBUF_IDATA6"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO133"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA6")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(134, "RAMBUF_IDATA7"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO134"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA7")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(135, "RAMBUF_IDATA8"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO135"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA8")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(136, "RAMBUF_IDATA9"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO136"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA9")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(137, "RAMBUF_IDATA10"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO137"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA10")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(138, "RAMBUF_IDATA11"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO138"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA11")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(139, "RAMBUF_IDATA12"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO139"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA12")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(140, "RAMBUF_IDATA13"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO140"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA13")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(141, "RAMBUF_IDATA14"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO141"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA14")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(142, "RAMBUF_IDATA15"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO142"),
+		MTK_FUNCTION(1, "RAMBUF_IDATA15")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(143, "RAMBUF_ODATA0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO143"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(144, "RAMBUF_ODATA1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO144"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(145, "RAMBUF_ODATA2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO145"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(146, "RAMBUF_ODATA3"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO146"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(147, "RAMBUF_ODATA4"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO147"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(148, "RAMBUF_ODATA5"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO148"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA5")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(149, "RAMBUF_ODATA6"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO149"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA6")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(150, "RAMBUF_ODATA7"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO150"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA7")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(151, "RAMBUF_ODATA8"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO151"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA8")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(152, "RAMBUF_ODATA9"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO152"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA9")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(153, "RAMBUF_ODATA10"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO153"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA10")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(154, "RAMBUF_ODATA11"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO154"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA11")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(155, "RAMBUF_ODATA12"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO155"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA12")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(156, "RAMBUF_ODATA13"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO156"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA13")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(157, "RAMBUF_ODATA14"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO157"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA14")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(158, "RAMBUF_ODATA15"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO158"),
+		MTK_FUNCTION(1, "RAMBUF_ODATA15")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(159, "RAMBUF_BE0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO159"),
+		MTK_FUNCTION(1, "RAMBUF_BE0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(160, "RAMBUF_BE1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO160"),
+		MTK_FUNCTION(1, "RAMBUF_BE1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(161, "AP2PT_INT"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO161"),
+		MTK_FUNCTION(1, "AP2PT_INT")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(162, "AP2PT_INT_CLR"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO162"),
+		MTK_FUNCTION(1, "AP2PT_INT_CLR")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(163, "PT2AP_INT"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO163"),
+		MTK_FUNCTION(1, "PT2AP_INT")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(164, "PT2AP_INT_CLR"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO164"),
+		MTK_FUNCTION(1, "PT2AP_INT_CLR")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(165, "AP2UP_INT"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO165"),
+		MTK_FUNCTION(1, "AP2UP_INT")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(166, "AP2UP_INT_CLR"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO166"),
+		MTK_FUNCTION(1, "AP2UP_INT_CLR")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(167, "UP2AP_INT"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO167"),
+		MTK_FUNCTION(1, "UP2AP_INT")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(168, "UP2AP_INT_CLR"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO168"),
+		MTK_FUNCTION(1, "UP2AP_INT_CLR")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(169, "RAMBUF_ADDR0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO169"),
+		MTK_FUNCTION(1, "RAMBUF_ADDR0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(170, "RAMBUF_ADDR1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO170"),
+		MTK_FUNCTION(1, "RAMBUF_ADDR1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(171, "RAMBUF_ADDR2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO171"),
+		MTK_FUNCTION(1, "RAMBUF_ADDR2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(172, "RAMBUF_ADDR3"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO172"),
+		MTK_FUNCTION(1, "RAMBUF_ADDR3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(173, "RAMBUF_ADDR4"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO173"),
+		MTK_FUNCTION(1, "RAMBUF_ADDR4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(174, "RAMBUF_ADDR5"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO174"),
+		MTK_FUNCTION(1, "RAMBUF_ADDR5")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(175, "RAMBUF_ADDR6"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO175"),
+		MTK_FUNCTION(1, "RAMBUF_ADDR6")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(176, "RAMBUF_ADDR7"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO176"),
+		MTK_FUNCTION(1, "RAMBUF_ADDR7")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(177, "RAMBUF_ADDR8"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO177"),
+		MTK_FUNCTION(1, "RAMBUF_ADDR8")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(178, "RAMBUF_ADDR9"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO178"),
+		MTK_FUNCTION(1, "RAMBUF_ADDR9")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(179, "RAMBUF_ADDR10"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO179"),
+		MTK_FUNCTION(1, "RAMBUF_ADDR10")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(180, "RAMBUF_RW"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO180"),
+		MTK_FUNCTION(1, "RAMBUF_RW")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(181, "RAMBUF_LAST"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO181"),
+		MTK_FUNCTION(1, "RAMBUF_LAST")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(182, "RAMBUF_HP"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO182"),
+		MTK_FUNCTION(1, "RAMBUF_HP")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(183, "RAMBUF_REQ"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO183"),
+		MTK_FUNCTION(1, "RAMBUF_REQ")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(184, "RAMBUF_ALE"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO184"),
+		MTK_FUNCTION(1, "RAMBUF_ALE")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(185, "RAMBUF_DLE"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO185"),
+		MTK_FUNCTION(1, "RAMBUF_DLE")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(186, "RAMBUF_WDLE"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO186"),
+		MTK_FUNCTION(1, "RAMBUF_WDLE")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(187, "RAMBUF_O_CLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO187"),
+		MTK_FUNCTION(1, "RAMBUF_O_CLK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(188, "I2S2_MCLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 100),
+		MTK_FUNCTION(0, "GPIO188"),
+		MTK_FUNCTION(1, "I2S2_MCLK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(189, "I2S3_DATA"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 101),
+		MTK_FUNCTION(0, "GPIO189"),
+		MTK_FUNCTION(2, "I2S3_DATA_BYPS"),
+		MTK_FUNCTION(3, "PCM_TX")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(190, "I2S3_DATA_IN"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 102),
+		MTK_FUNCTION(0, "GPIO190"),
+		MTK_FUNCTION(1, "I2S3_DATA_IN"),
+		MTK_FUNCTION(3, "PCM_RX")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(191, "I2S3_BCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 103),
+		MTK_FUNCTION(0, "GPIO191"),
+		MTK_FUNCTION(1, "I2S3_BCK"),
+		MTK_FUNCTION(3, "PCM_CLK0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(192, "I2S3_LRCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 104),
+		MTK_FUNCTION(0, "GPIO192"),
+		MTK_FUNCTION(1, "I2S3_LRCK"),
+		MTK_FUNCTION(3, "PCM_SYNC")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(193, "I2S3_MCLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 105),
+		MTK_FUNCTION(0, "GPIO193"),
+		MTK_FUNCTION(1, "I2S3_MCLK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(194, "I2S4_DATA"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 106),
+		MTK_FUNCTION(0, "GPIO194"),
+		MTK_FUNCTION(1, "I2S4_DATA"),
+		MTK_FUNCTION(2, "I2S4_DATA_BYPS"),
+		MTK_FUNCTION(3, "PCM_TX")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(195, "I2S4_DATA_IN"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 107),
+		MTK_FUNCTION(0, "GPIO195"),
+		MTK_FUNCTION(1, "I2S4_DATA_IN"),
+		MTK_FUNCTION(3, "PCM_RX")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(196, "I2S4_BCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 108),
+		MTK_FUNCTION(0, "GPIO196"),
+		MTK_FUNCTION(1, "I2S4_BCK"),
+		MTK_FUNCTION(3, "PCM_CLK0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(197, "I2S4_LRCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 109),
+		MTK_FUNCTION(0, "GPIO197"),
+		MTK_FUNCTION(1, "I2S4_LRCK"),
+		MTK_FUNCTION(3, "PCM_SYNC")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(198, "I2S4_MCLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 110),
+		MTK_FUNCTION(0, "GPIO198"),
+		MTK_FUNCTION(1, "I2S4_MCLK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(199, "SPI1_CLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 111),
+		MTK_FUNCTION(0, "GPIO199"),
+		MTK_FUNCTION(1, "SPI1_CK"),
+		MTK_FUNCTION(3, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(4, "KCOL3"),
+		MTK_FUNCTION(7, "DBG_MON_B[15]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(200, "SPDIF_OUT"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 112),
+		MTK_FUNCTION(0, "GPIO200"),
+		MTK_FUNCTION(1, "SPDIF_OUT"),
+		MTK_FUNCTION(5, "G1_TXD3"),
+		MTK_FUNCTION(6, "URXD2"),
+		MTK_FUNCTION(7, "DBG_MON_B[16]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(201, "SPDIF_IN0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 113),
+		MTK_FUNCTION(0, "GPIO201"),
+		MTK_FUNCTION(1, "SPDIF_IN0"),
+		MTK_FUNCTION(5, "G1_TXEN"),
+		MTK_FUNCTION(6, "UTXD2"),
+		MTK_FUNCTION(7, "DBG_MON_B[17]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(202, "SPDIF_IN1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 114),
+		MTK_FUNCTION(0, "GPIO202"),
+		MTK_FUNCTION(1, "SPDIF_IN1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(203, "PWM0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 115),
+		MTK_FUNCTION(0, "GPIO203"),
+		MTK_FUNCTION(1, "PWM0"),
+		MTK_FUNCTION(2, "DISP_PWM"),
+		MTK_FUNCTION(5, "G1_TXD2"),
+		MTK_FUNCTION(7, "DBG_MON_B[18]"),
+		MTK_FUNCTION(9, "I2S2_DATA")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(204, "PWM1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 116),
+		MTK_FUNCTION(0, "GPIO204"),
+		MTK_FUNCTION(1, "PWM1"),
+		MTK_FUNCTION(2, "CLKM3"),
+		MTK_FUNCTION(5, "G1_TXD1"),
+		MTK_FUNCTION(7, "DBG_MON_B[19]"),
+		MTK_FUNCTION(9, "I2S3_DATA")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(205, "PWM2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 117),
+		MTK_FUNCTION(0, "GPIO205"),
+		MTK_FUNCTION(1, "PWM2"),
+		MTK_FUNCTION(2, "CLKM2"),
+		MTK_FUNCTION(5, "G1_TXD0"),
+		MTK_FUNCTION(7, "DBG_MON_B[20]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(206, "PWM3"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 118),
+		MTK_FUNCTION(0, "GPIO206"),
+		MTK_FUNCTION(1, "PWM3"),
+		MTK_FUNCTION(2, "CLKM1"),
+		MTK_FUNCTION(3, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(5, "G1_TXC"),
+		MTK_FUNCTION(7, "DBG_MON_B[21]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(207, "PWM4"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 119),
+		MTK_FUNCTION(0, "GPIO207"),
+		MTK_FUNCTION(1, "PWM4"),
+		MTK_FUNCTION(2, "CLKM0"),
+		MTK_FUNCTION(3, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(5, "G1_RXC"),
+		MTK_FUNCTION(7, "DBG_MON_B[22]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(208, "AUD_EXT_CK1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 120),
+		MTK_FUNCTION(0, "GPIO208"),
+		MTK_FUNCTION(1, "AUD_EXT_CK1"),
+		MTK_FUNCTION(2, "PWM0"),
+		MTK_FUNCTION(4, "ANT_SEL5"),
+		MTK_FUNCTION(5, "DISP_PWM"),
+		MTK_FUNCTION(7, "DBG_MON_A[31]"),
+		MTK_FUNCTION(11, "PCIE0_PERST_N")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(209, "AUD_EXT_CK2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 121),
+		MTK_FUNCTION(0, "GPIO209"),
+		MTK_FUNCTION(1, "AUD_EXT_CK2"),
+		MTK_FUNCTION(2, "MSDC1_WP"),
+		MTK_FUNCTION(5, "PWM1"),
+		MTK_FUNCTION(7, "DBG_MON_A[32]"),
+		MTK_FUNCTION(11, "PCIE1_PERST_N")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(210, "AUD_CLOCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO210"),
+		MTK_FUNCTION(1, "AUD_CLOCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(211, "DVP_RESET"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO211"),
+		MTK_FUNCTION(1, "DVP_RESET")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(212, "DVP_CLOCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO212"),
+		MTK_FUNCTION(1, "DVP_CLOCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(213, "DVP_CS"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO213"),
+		MTK_FUNCTION(1, "DVP_CS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(214, "DVP_CK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO214"),
+		MTK_FUNCTION(1, "DVP_CK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(215, "DVP_DI"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO215"),
+		MTK_FUNCTION(1, "DVP_DI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(216, "DVP_DO"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO216"),
+		MTK_FUNCTION(1, "DVP_DO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(217, "AP_CS"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO217"),
+		MTK_FUNCTION(1, "AP_CS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(218, "AP_CK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO218"),
+		MTK_FUNCTION(1, "AP_CK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(219, "AP_DI"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO219"),
+		MTK_FUNCTION(1, "AP_DI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(220, "AP_DO"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO220"),
+		MTK_FUNCTION(1, "AP_DO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(221, "DVD_BCLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO221"),
+		MTK_FUNCTION(1, "DVD_BCLK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(222, "T8032_CLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO222"),
+		MTK_FUNCTION(1, "T8032_CLK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(223, "AP_BCLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO223"),
+		MTK_FUNCTION(1, "AP_BCLK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(224, "HOST_CS"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO224"),
+		MTK_FUNCTION(1, "HOST_CS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(225, "HOST_CK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO225"),
+		MTK_FUNCTION(1, "HOST_CK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(226, "HOST_DO0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO226"),
+		MTK_FUNCTION(1, "HOST_DO0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(227, "HOST_DO1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO227"),
+		MTK_FUNCTION(1, "HOST_DO1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(228, "SLV_CS"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO228"),
+		MTK_FUNCTION(1, "SLV_CS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(229, "SLV_CK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO229"),
+		MTK_FUNCTION(1, "SLV_CK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(230, "SLV_DI0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO230"),
+		MTK_FUNCTION(1, "SLV_DI0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(231, "SLV_DI1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO231"),
+		MTK_FUNCTION(1, "SLV_DI1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(232, "AP2DSP_INT"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO232"),
+		MTK_FUNCTION(1, "AP2DSP_INT")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(233, "AP2DSP_INT_CLR"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO233"),
+		MTK_FUNCTION(1, "AP2DSP_INT_CLR")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(234, "DSP2AP_INT"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO234"),
+		MTK_FUNCTION(1, "DSP2AP_INT")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(235, "DSP2AP_INT_CLR"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO235"),
+		MTK_FUNCTION(1, "DSP2AP_INT_CLR")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(236, "EXT_SDIO3"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 122),
+		MTK_FUNCTION(0, "GPIO236"),
+		MTK_FUNCTION(1, "EXT_SDIO3"),
+		MTK_FUNCTION(2, "IDDIG"),
+		MTK_FUNCTION(7, "DBG_MON_A[1]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(237, "EXT_SDIO2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 123),
+		MTK_FUNCTION(0, "GPIO237"),
+		MTK_FUNCTION(1, "EXT_SDIO2"),
+		MTK_FUNCTION(2, "DRV_VBUS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(238, "EXT_SDIO1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 124),
+		MTK_FUNCTION(0, "GPIO238"),
+		MTK_FUNCTION(1, "EXT_SDIO1"),
+		MTK_FUNCTION(2, "IDDIG_P1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(239, "EXT_SDIO0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 125),
+		MTK_FUNCTION(0, "GPIO239"),
+		MTK_FUNCTION(1, "EXT_SDIO0"),
+		MTK_FUNCTION(2, "DRV_VBUS_P1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(240, "EXT_XCS"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 126),
+		MTK_FUNCTION(0, "GPIO240"),
+		MTK_FUNCTION(1, "EXT_XCS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(241, "EXT_SCK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 127),
+		MTK_FUNCTION(0, "GPIO241"),
+		MTK_FUNCTION(1, "EXT_SCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(242, "URTS2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 128),
+		MTK_FUNCTION(0, "GPIO242"),
+		MTK_FUNCTION(1, "URTS2"),
+		MTK_FUNCTION(2, "UTXD3"),
+		MTK_FUNCTION(3, "URXD3"),
+		MTK_FUNCTION(4, "SCL1"),
+		MTK_FUNCTION(7, "DBG_MON_B[32]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(243, "UCTS2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 129),
+		MTK_FUNCTION(0, "GPIO243"),
+		MTK_FUNCTION(1, "UCTS2"),
+		MTK_FUNCTION(2, "URXD3"),
+		MTK_FUNCTION(3, "UTXD3"),
+		MTK_FUNCTION(4, "SDA1"),
+		MTK_FUNCTION(7, "DBG_MON_A[6]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(244, "HDMI_SDA_RX"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 130),
+		MTK_FUNCTION(0, "GPIO244"),
+		MTK_FUNCTION(1, "HDMI_SDA_RX")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(245, "HDMI_SCL_RX"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 131),
+		MTK_FUNCTION(0, "GPIO245"),
+		MTK_FUNCTION(1, "HDMI_SCL_RX")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(246, "MHL_SENCE"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 132),
+		MTK_FUNCTION(0, "GPIO246")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(247, "HDMI_HPD_CBUS_RX"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 69),
+		MTK_FUNCTION(0, "GPIO247"),
+		MTK_FUNCTION(1, "HDMI_HPD_RX")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(248, "HDMI_TESTOUTP_RX"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 133),
+		MTK_FUNCTION(0, "GPIO248"),
+		MTK_FUNCTION(1, "HDMI_TESTOUTP_RX")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(249, "MSDC0E_RSTB"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 134),
+		MTK_FUNCTION(0, "GPIO249"),
+		MTK_FUNCTION(1, "MSDC0E_RSTB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(250, "MSDC0E_DAT7"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 135),
+		MTK_FUNCTION(0, "GPIO250"),
+		MTK_FUNCTION(1, "MSDC3_DAT7"),
+		MTK_FUNCTION(6, "PCIE0_CLKREQ_N")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(251, "MSDC0E_DAT6"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 136),
+		MTK_FUNCTION(0, "GPIO251"),
+		MTK_FUNCTION(1, "MSDC3_DAT6"),
+		MTK_FUNCTION(6, "PCIE0_WAKE_N")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(252, "MSDC0E_DAT5"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 137),
+		MTK_FUNCTION(0, "GPIO252"),
+		MTK_FUNCTION(1, "MSDC3_DAT5"),
+		MTK_FUNCTION(6, "PCIE1_CLKREQ_N")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(253, "MSDC0E_DAT4"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 138),
+		MTK_FUNCTION(0, "GPIO253"),
+		MTK_FUNCTION(1, "MSDC3_DAT4"),
+		MTK_FUNCTION(6, "PCIE1_WAKE_N")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(254, "MSDC0E_DAT3"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 139),
+		MTK_FUNCTION(0, "GPIO254"),
+		MTK_FUNCTION(1, "MSDC3_DAT3"),
+		MTK_FUNCTION(6, "PCIE2_CLKREQ_N")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(255, "MSDC0E_DAT2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 140),
+		MTK_FUNCTION(0, "GPIO255"),
+		MTK_FUNCTION(1, "MSDC3_DAT2"),
+		MTK_FUNCTION(6, "PCIE2_WAKE_N")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(256, "MSDC0E_DAT1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 141),
+		MTK_FUNCTION(0, "GPIO256"),
+		MTK_FUNCTION(1, "MSDC3_DAT1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(257, "MSDC0E_DAT0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 142),
+		MTK_FUNCTION(0, "GPIO257"),
+		MTK_FUNCTION(1, "MSDC3_DAT0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(258, "MSDC0E_CMD"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 143),
+		MTK_FUNCTION(0, "GPIO258"),
+		MTK_FUNCTION(1, "MSDC3_CMD")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(259, "MSDC0E_CLK"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 144),
+		MTK_FUNCTION(0, "GPIO259"),
+		MTK_FUNCTION(1, "MSDC3_CLK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(260, "MSDC0E_DSL"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 145),
+		MTK_FUNCTION(0, "GPIO260"),
+		MTK_FUNCTION(1, "MSDC3_DSL")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(261, "MSDC1_INS"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 146),
+		MTK_FUNCTION(0, "GPIO261"),
+		MTK_FUNCTION(1, "MSDC1_INS"),
+		MTK_FUNCTION(7, "DBG_MON_B[29]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(262, "G2_TXEN"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 8),
+		MTK_FUNCTION(0, "GPIO262"),
+		MTK_FUNCTION(1, "G2_TXEN")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(263, "G2_TXD3"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 9),
+		MTK_FUNCTION(0, "GPIO263"),
+		MTK_FUNCTION(1, "G2_TXD3"),
+		MTK_FUNCTION(6, "ANT_SEL5")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(264, "G2_TXD2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 10),
+		MTK_FUNCTION(0, "GPIO264"),
+		MTK_FUNCTION(1, "G2_TXD2"),
+		MTK_FUNCTION(6, "ANT_SEL4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(265, "G2_TXD1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 11),
+		MTK_FUNCTION(0, "GPIO265"),
+		MTK_FUNCTION(1, "G2_TXD1"),
+		MTK_FUNCTION(6, "ANT_SEL3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(266, "G2_TXD0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO266"),
+		MTK_FUNCTION(1, "G2_TXD0"),
+		MTK_FUNCTION(6, "ANT_SEL2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(267, "G2_TXC"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO267"),
+		MTK_FUNCTION(1, "G2_TXC")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(268, "G2_RXC"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO268"),
+		MTK_FUNCTION(1, "G2_RXC")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(269, "G2_RXD0"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO269"),
+		MTK_FUNCTION(1, "G2_RXD0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(270, "G2_RXD1"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO270"),
+		MTK_FUNCTION(1, "G2_RXD1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(271, "G2_RXD2"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO271"),
+		MTK_FUNCTION(1, "G2_RXD2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(272, "G2_RXD3"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO272"),
+		MTK_FUNCTION(1, "G2_RXD3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(273, "ESW_INT"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 168),
+		MTK_FUNCTION(0, "GPIO273"),
+		MTK_FUNCTION(1, "ESW_INT")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(274, "G2_RXDV"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO274"),
+		MTK_FUNCTION(1, "G2_RXDV")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(275, "MDC"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO275"),
+		MTK_FUNCTION(1, "MDC"),
+		MTK_FUNCTION(6, "ANT_SEL0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(276, "MDIO"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO276"),
+		MTK_FUNCTION(1, "MDIO"),
+		MTK_FUNCTION(6, "ANT_SEL1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(277, "ESW_RST"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO277"),
+		MTK_FUNCTION(1, "ESW_RST")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(278, "JTAG_RESET"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(0, 147),
+		MTK_FUNCTION(0, "GPIO278"),
+		MTK_FUNCTION(1, "JTAG_RESET")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(279, "USB3_RES_BOND"),
+		NULL, "mt2701",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO279"),
+		MTK_FUNCTION(1, "USB3_RES_BOND")
+	),
+};
+
+#endif /* __PINCTRL_MTK_MT2701_H */
-- 
1.7.9.5
