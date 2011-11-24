From: rusko.peter@prolan.hu (Peter Rusko)
Date: Thu, 24 Nov 2011 12:49:54 +0100
Subject: [PATCH] mx28: added LRADC and touchscreen support
Message-ID: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is based on the Freescale SDK 2010.08. It supports the on-chip
Low Resolution ADC and a capacitive touchscreen connected to it.

Tested on Ka-Ro TX28 module

Signed-off-by: Peter Rusko <rusko.peter@prolan.hu>
---
 arch/arm/mach-mxs/devices-mx28.h                |    6 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-mxs-lradc.c  |   25 +
 arch/arm/mach-mxs/devices/platform-mxs-ts.c     |   34 +
 arch/arm/mach-mxs/include/mach/devices-common.h |   22 +
 arch/arm/mach-mxs/include/mach/lradc.h          |   61 ++
 arch/arm/mach-mxs/include/mach/mx28.h           |    4 +-
 arch/arm/mach-mxs/include/mach/regs-lradc.h     |  772 +++++++++++++++++++++++
 drivers/input/touchscreen/Kconfig               |   11 +
 drivers/input/touchscreen/Makefile              |    1 +
 drivers/input/touchscreen/mxs_ts.c              |  470 ++++++++++++++
 drivers/misc/Kconfig                            |    3 +
 drivers/misc/Makefile                           |    1 +
 drivers/misc/mxs_lradc.c                        |  381 +++++++++++
 15 files changed, 1793 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-lradc.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-ts.c
 create mode 100644 arch/arm/mach-mxs/include/mach/lradc.h
 create mode 100644 arch/arm/mach-mxs/include/mach/regs-lradc.h
 create mode 100644 drivers/input/touchscreen/mxs_ts.c
 create mode 100644 drivers/misc/mxs_lradc.c

diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index c888710..b0efa25 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -46,6 +46,12 @@ extern const struct mxs_mxs_mmc_data mx28_mxs_mmc_data[] __initconst;
 struct platform_device *__init mx28_add_mxsfb(
 		const struct mxsfb_platform_data *pdata);
 
+struct platform_device * __init mx28_add_lradc(
+		const struct mxs_lradc_plat_data *pdata);
+
+struct platform_device *__init mx28_add_ts(
+		const struct mxs_touchscreen_plat_data *pdata);
+
 extern const struct mxs_saif_data mx28_saif_data[] __initconst;
 #define mx28_add_saif(id)              mxs_add_saif(&mx28_saif_data[id])
 
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index 18b6bf5..58d1c1e 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -15,6 +15,9 @@ config MXS_HAVE_PLATFORM_FLEXCAN
 config MXS_HAVE_PLATFORM_MXS_I2C
 	bool
 
+config MXS_HAVE_PLATFORM_MXS_LRADC
+	bool
+
 config MXS_HAVE_PLATFORM_MXS_MMC
 	bool
 
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index f52e3e5..9ba66ed 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -4,6 +4,7 @@ obj-y += platform-dma.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_I2C) += platform-mxs-i2c.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_LRADC) += platform-mxs-lradc.o platform-mxs-ts.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_MMC) += platform-mxs-mmc.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_PWM) += platform-mxs-pwm.o
 obj-y += platform-gpio-mxs.o
diff --git a/arch/arm/mach-mxs/devices/platform-mxs-lradc.c b/arch/arm/mach-mxs/devices/platform-mxs-lradc.c
new file mode 100644
index 0000000..d1af2ec
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-mxs-lradc.c
@@ -0,0 +1,25 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <mach/devices-common.h>
+#include <mach/mx28.h>
+
+struct platform_device * __init mx28_add_lradc(
+		const struct mxs_lradc_plat_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = MX28_LRADC_BASE_ADDR,
+			.end = MX28_LRADC_BASE_ADDR + SZ_16K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+	};
+
+	return mxs_add_platform_device("mxs-lradc", 0,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/mach-mxs/devices/platform-mxs-ts.c b/arch/arm/mach-mxs/devices/platform-mxs-ts.c
new file mode 100644
index 0000000..05343af
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-mxs-ts.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <mach/devices-common.h>
+#include <mach/mx28.h>
+
+struct platform_device *__init mx28_add_ts(
+		const struct mxs_touchscreen_plat_data *pdata)
+{
+	struct resource res[] = {
+		{
+		 .flags = IORESOURCE_MEM,
+		 .start = MX28_LRADC_BASE_ADDR,
+		 .end   = MX28_LRADC_BASE_ADDR + 0x2000 - 1,
+		}, {
+		 .flags = IORESOURCE_IRQ,
+		 .start = MX28_INT_LRADC_TOUCH,
+		 .end   = MX28_INT_LRADC_TOUCH,
+		}, {
+		 .flags = IORESOURCE_IRQ,
+		 .start = MX28_INT_LRADC_CH5,
+		 .end   = MX28_INT_LRADC_CH5,
+		},
+	};
+
+	return mxs_add_platform_device("mxs-ts", 0,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+
+}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index a8080f4..e86b193 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -76,6 +76,12 @@ struct mxs_mxs_i2c_data {
 struct platform_device * __init mxs_add_mxs_i2c(
 		const struct mxs_mxs_i2c_data *data);
 
+/* lradc */
+struct mxs_lradc_plat_data {
+	unsigned int vddio_voltage;
+	unsigned int battery_voltage;
+};
+
 /* mmc */
 #include <mach/mmc.h>
 struct mxs_mxs_mmc_data {
@@ -104,3 +110,19 @@ struct mxs_saif_data {
 
 struct platform_device *__init mxs_add_saif(
 		const struct mxs_saif_data *data);
+
+/* touchscreen */
+struct mxs_touchscreen_plat_data {
+	u8 x_plus_chan;
+	u8 x_minus_chan;
+	u8 y_plus_chan;
+	u8 y_minus_chan;
+	unsigned int x_plus_val;
+	unsigned int x_minus_val;
+	unsigned int y_plus_val;
+	unsigned int y_minus_val;
+	unsigned int x_plus_mask;
+	unsigned int x_minus_mask;
+	unsigned int y_plus_mask;
+	unsigned int y_minus_mask;
+};
diff --git a/arch/arm/mach-mxs/include/mach/lradc.h b/arch/arm/mach-mxs/include/mach/lradc.h
new file mode 100644
index 0000000..c2c0a7d
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/lradc.h
@@ -0,0 +1,61 @@
+/*
+ * Freescale STMP37XX/STMP378X LRADC helper interface
+ *
+ * Embedded Alley Solutions, Inc <source@embeddedalley.com>
+ *
+ * Copyright 2008-2010 Freescale Semiconductor, Inc.
+ * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#ifndef __ASM_PLAT_LRADC_H
+#define __ASM_PLAT_LRADC_H
+
+int hw_lradc_use_channel(int);
+int hw_lradc_unuse_channel(int);
+extern u32 hw_lradc_vddio(void);
+void hw_lradc_set_delay_trigger_kick(int trigger, int value);
+void hw_lradc_configure_channel(int channel, int enable_div2,
+		int enable_acc, int samples);
+int hw_lradc_present(int channel);
+int hw_lradc_init_ladder(int channel, int trigger, unsigned sampling);
+int hw_lradc_stop_ladder(int channel, int trigger);
+void hw_lradc_set_delay_trigger(int trigger, u32 trigger_lradc,
+		u32 delay_triggers, u32 loops, u32 delays);
+void hw_lradc_clear_delay_trigger(int trigger, u32 trigger_lradc,
+		u32 delay_triggers);
+
+
+#define LRADC_CH0		0
+#define LRADC_CH1		1
+#define LRADC_CH2		2
+#define LRADC_CH3		3
+#define LRADC_CH4		4
+#define LRADC_CH5		5
+#define LRADC_CH6		6
+#define LRADC_CH7		7
+#define LRADC_TOUCH_X_PLUS	LRADC_CH2
+#define LRADC_TOUCH_Y_PLUS	LRADC_CH3
+#define LRADC_TOUCH_X_MINUS	LRADC_CH4
+#define LRADC_TOUCH_Y_MINUS	LRADC_CH5
+#define VDDIO_VOLTAGE_CH	LRADC_CH6
+#define BATTERY_VOLTAGE_CH	LRADC_CH7
+
+#define LRADC_CLOCK_6MHZ	0
+#define LRADC_CLOCK_4MHZ	1
+#define LRADC_CLOCK_3MHZ	2
+#define LRADC_CLOCK_2MHZ	3
+
+#define LRADC_DELAY_TRIGGER_BUTTON	0
+#define LRADC_DELAY_TRIGGER_BATTERY	1
+#define LRADC_DELAY_TRIGGER_TOUCHSCREEN	2
+#define LRADC_DELAY_TRIGGER_DIE		3
+
+#endif /* __ASM_PLAT_LRADC_H */
diff --git a/arch/arm/mach-mxs/include/mach/mx28.h b/arch/arm/mach-mxs/include/mach/mx28.h
index 75d8611..30c7990 100644
--- a/arch/arm/mach-mxs/include/mach/mx28.h
+++ b/arch/arm/mach-mxs/include/mach/mx28.h
@@ -104,8 +104,8 @@
 #define MX28_INT_CAN1			9
 #define MX28_INT_LRADC_TOUCH		10
 #define MX28_INT_HSADC			13
-#define MX28_INT_IRADC_THRESH0		14
-#define MX28_INT_IRADC_THRESH1		15
+#define MX28_INT_LRADC_THRESH0		14
+#define MX28_INT_LRADC_THRESH1		15
 #define MX28_INT_LRADC_CH0		16
 #define MX28_INT_LRADC_CH1		17
 #define MX28_INT_LRADC_CH2		18
diff --git a/arch/arm/mach-mxs/include/mach/regs-lradc.h b/arch/arm/mach-mxs/include/mach/regs-lradc.h
new file mode 100644
index 0000000..d7906b9
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/regs-lradc.h
@@ -0,0 +1,772 @@
+/*
+ * Freescale LRADC Register Definitions
+ *
+ * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ * This file is created by xml file. Don't Edit it.
+ *
+ * Xml Revision: 1.50
+ * Template revision: 26195
+ */
+
+#ifndef __ARCH_ARM___LRADC_H
+#define __ARCH_ARM___LRADC_H
+
+
+#define HW_LRADC_CTRL0	(0x00000000)
+#define HW_LRADC_CTRL0_SET	(0x00000004)
+#define HW_LRADC_CTRL0_CLR	(0x00000008)
+#define HW_LRADC_CTRL0_TOG	(0x0000000c)
+
+#define BM_LRADC_CTRL0_SFTRST	0x80000000
+#define BM_LRADC_CTRL0_CLKGATE	0x40000000
+#define BP_LRADC_CTRL0_RSRVD2	27
+#define BM_LRADC_CTRL0_RSRVD2	0x38000000
+#define BF_LRADC_CTRL0_RSRVD2(v)  \
+		(((v) << 27) & BM_LRADC_CTRL0_RSRVD2)
+#define BM_LRADC_CTRL0_ONCHIP_GROUNDREF	0x04000000
+#define BV_LRADC_CTRL0_ONCHIP_GROUNDREF__OFF 0x0
+#define BV_LRADC_CTRL0_ONCHIP_GROUNDREF__ON  0x1
+#define BM_LRADC_CTRL0_BUTTON1_DETECT_ENABLE	0x02000000
+#define BV_LRADC_CTRL0_BUTTON1_DETECT_ENABLE__OFF 0x0
+#define BV_LRADC_CTRL0_BUTTON1_DETECT_ENABLE__ON  0x1
+#define BM_LRADC_CTRL0_BUTTON0_DETECT_ENABLE	0x01000000
+#define BV_LRADC_CTRL0_BUTTON0_DETECT_ENABLE__OFF 0x0
+#define BV_LRADC_CTRL0_BUTTON0_DETECT_ENABLE__ON  0x1
+#define BM_LRADC_CTRL0_TOUCH_DETECT_ENABLE	0x00800000
+#define BV_LRADC_CTRL0_TOUCH_DETECT_ENABLE__OFF 0x0
+#define BV_LRADC_CTRL0_TOUCH_DETECT_ENABLE__ON  0x1
+#define BM_LRADC_CTRL0_TOUCH_SCREEN_TYPE	0x00400000
+#define BM_LRADC_CTRL0_YNLRSW	0x00200000
+#define BP_LRADC_CTRL0_YPLLSW	19
+#define BM_LRADC_CTRL0_YPLLSW	0x00180000
+#define BF_LRADC_CTRL0_YPLLSW(v)  \
+		(((v) << 19) & BM_LRADC_CTRL0_YPLLSW)
+#define BP_LRADC_CTRL0_XNURSW	17
+#define BM_LRADC_CTRL0_XNURSW	0x00060000
+#define BF_LRADC_CTRL0_XNURSW(v)  \
+		(((v) << 17) & BM_LRADC_CTRL0_XNURSW)
+#define BM_LRADC_CTRL0_XPULSW	0x00010000
+#define BP_LRADC_CTRL0_RSRVD1	8
+#define BM_LRADC_CTRL0_RSRVD1	0x0000FF00
+#define BF_LRADC_CTRL0_RSRVD1(v)  \
+		(((v) << 8) & BM_LRADC_CTRL0_RSRVD1)
+#define BP_LRADC_CTRL0_SCHEDULE	0
+#define BM_LRADC_CTRL0_SCHEDULE	0x000000FF
+#define BF_LRADC_CTRL0_SCHEDULE(v)  \
+		(((v) << 0) & BM_LRADC_CTRL0_SCHEDULE)
+
+#define HW_LRADC_CTRL1	(0x00000010)
+#define HW_LRADC_CTRL1_SET	(0x00000014)
+#define HW_LRADC_CTRL1_CLR	(0x00000018)
+#define HW_LRADC_CTRL1_TOG	(0x0000001c)
+
+#define BP_LRADC_CTRL1_RSRVD2	29
+#define BM_LRADC_CTRL1_RSRVD2	0xE0000000
+#define BF_LRADC_CTRL1_RSRVD2(v) \
+		(((v) << 29) & BM_LRADC_CTRL1_RSRVD2)
+#define BM_LRADC_CTRL1_BUTTON1_DETECT_IRQ_EN	0x10000000
+#define BV_LRADC_CTRL1_BUTTON1_DETECT_IRQ_EN__DISABLE 0x0
+#define BV_LRADC_CTRL1_BUTTON1_DETECT_IRQ_EN__ENABLE  0x1
+#define BM_LRADC_CTRL1_BUTTON0_DETECT_IRQ_EN	0x08000000
+#define BV_LRADC_CTRL1_BUTTON0_DETECT_IRQ_EN__DISABLE 0x0
+#define BV_LRADC_CTRL1_BUTTON0_DETECT_IRQ_EN__ENABLE  0x1
+#define BM_LRADC_CTRL1_THRESHOLD1_DETECT_IRQ_EN	0x04000000
+#define BV_LRADC_CTRL1_THRESHOLD1_DETECT_IRQ_EN__DISABLE 0x0
+#define BV_LRADC_CTRL1_THRESHOLD1_DETECT_IRQ_EN__ENABLE  0x1
+#define BM_LRADC_CTRL1_THRESHOLD0_DETECT_IRQ_EN	0x02000000
+#define BV_LRADC_CTRL1_THRESHOLD0_DETECT_IRQ_EN__DISABLE 0x0
+#define BV_LRADC_CTRL1_THRESHOLD0_DETECT_IRQ_EN__ENABLE  0x1
+#define BM_LRADC_CTRL1_TOUCH_DETECT_IRQ_EN	0x01000000
+#define BV_LRADC_CTRL1_TOUCH_DETECT_IRQ_EN__DISABLE 0x0
+#define BV_LRADC_CTRL1_TOUCH_DETECT_IRQ_EN__ENABLE  0x1
+#define BM_LRADC_CTRL1_LRADC7_IRQ_EN	0x00800000
+#define BV_LRADC_CTRL1_LRADC7_IRQ_EN__DISABLE 0x0
+#define BV_LRADC_CTRL1_LRADC7_IRQ_EN__ENABLE  0x1
+#define BM_LRADC_CTRL1_LRADC6_IRQ_EN	0x00400000
+#define BV_LRADC_CTRL1_LRADC6_IRQ_EN__DISABLE 0x0
+#define BV_LRADC_CTRL1_LRADC6_IRQ_EN__ENABLE  0x1
+#define BM_LRADC_CTRL1_LRADC5_IRQ_EN	0x00200000
+#define BV_LRADC_CTRL1_LRADC5_IRQ_EN__DISABLE 0x0
+#define BV_LRADC_CTRL1_LRADC5_IRQ_EN__ENABLE  0x1
+#define BM_LRADC_CTRL1_LRADC4_IRQ_EN	0x00100000
+#define BV_LRADC_CTRL1_LRADC4_IRQ_EN__DISABLE 0x0
+#define BV_LRADC_CTRL1_LRADC4_IRQ_EN__ENABLE  0x1
+#define BM_LRADC_CTRL1_LRADC3_IRQ_EN	0x00080000
+#define BV_LRADC_CTRL1_LRADC3_IRQ_EN__DISABLE 0x0
+#define BV_LRADC_CTRL1_LRADC3_IRQ_EN__ENABLE  0x1
+#define BM_LRADC_CTRL1_LRADC2_IRQ_EN	0x00040000
+#define BV_LRADC_CTRL1_LRADC2_IRQ_EN__DISABLE 0x0
+#define BV_LRADC_CTRL1_LRADC2_IRQ_EN__ENABLE  0x1
+#define BM_LRADC_CTRL1_LRADC1_IRQ_EN	0x00020000
+#define BV_LRADC_CTRL1_LRADC1_IRQ_EN__DISABLE 0x0
+#define BV_LRADC_CTRL1_LRADC1_IRQ_EN__ENABLE  0x1
+#define BM_LRADC_CTRL1_LRADC0_IRQ_EN	0x00010000
+#define BV_LRADC_CTRL1_LRADC0_IRQ_EN__DISABLE 0x0
+#define BV_LRADC_CTRL1_LRADC0_IRQ_EN__ENABLE  0x1
+#define BP_LRADC_CTRL1_RSRVD1	13
+#define BM_LRADC_CTRL1_RSRVD1	0x0000E000
+#define BF_LRADC_CTRL1_RSRVD1(v)  \
+		(((v) << 13) & BM_LRADC_CTRL1_RSRVD1)
+#define BM_LRADC_CTRL1_BUTTON1_DETECT_IRQ	0x00001000
+#define BV_LRADC_CTRL1_BUTTON1_DETECT_IRQ__CLEAR   0x0
+#define BV_LRADC_CTRL1_BUTTON1_DETECT_IRQ__PENDING 0x1
+#define BM_LRADC_CTRL1_BUTTON0_DETECT_IRQ	0x00000800
+#define BV_LRADC_CTRL1_BUTTON0_DETECT_IRQ__CLEAR   0x0
+#define BV_LRADC_CTRL1_BUTTON0_DETECT_IRQ__PENDING 0x1
+#define BM_LRADC_CTRL1_THRESHOLD1_DETECT_IRQ	0x00000400
+#define BV_LRADC_CTRL1_THRESHOLD1_DETECT_IRQ__CLEAR   0x0
+#define BV_LRADC_CTRL1_THRESHOLD1_DETECT_IRQ__PENDING 0x1
+#define BM_LRADC_CTRL1_THRESHOLD0_DETECT_IRQ	0x00000200
+#define BV_LRADC_CTRL1_THRESHOLD0_DETECT_IRQ__CLEAR   0x0
+#define BV_LRADC_CTRL1_THRESHOLD0_DETECT_IRQ__PENDING 0x1
+#define BM_LRADC_CTRL1_TOUCH_DETECT_IRQ	0x00000100
+#define BV_LRADC_CTRL1_TOUCH_DETECT_IRQ__CLEAR   0x0
+#define BV_LRADC_CTRL1_TOUCH_DETECT_IRQ__PENDING 0x1
+#define BM_LRADC_CTRL1_LRADC7_IRQ	0x00000080
+#define BV_LRADC_CTRL1_LRADC7_IRQ__CLEAR   0x0
+#define BV_LRADC_CTRL1_LRADC7_IRQ__PENDING 0x1
+#define BM_LRADC_CTRL1_LRADC6_IRQ	0x00000040
+#define BV_LRADC_CTRL1_LRADC6_IRQ__CLEAR   0x0
+#define BV_LRADC_CTRL1_LRADC6_IRQ__PENDING 0x1
+#define BM_LRADC_CTRL1_LRADC5_IRQ	0x00000020
+#define BV_LRADC_CTRL1_LRADC5_IRQ__CLEAR   0x0
+#define BV_LRADC_CTRL1_LRADC5_IRQ__PENDING 0x1
+#define BM_LRADC_CTRL1_LRADC4_IRQ	0x00000010
+#define BV_LRADC_CTRL1_LRADC4_IRQ__CLEAR   0x0
+#define BV_LRADC_CTRL1_LRADC4_IRQ__PENDING 0x1
+#define BM_LRADC_CTRL1_LRADC3_IRQ	0x00000008
+#define BV_LRADC_CTRL1_LRADC3_IRQ__CLEAR   0x0
+#define BV_LRADC_CTRL1_LRADC3_IRQ__PENDING 0x1
+#define BM_LRADC_CTRL1_LRADC2_IRQ	0x00000004
+#define BV_LRADC_CTRL1_LRADC2_IRQ__CLEAR   0x0
+#define BV_LRADC_CTRL1_LRADC2_IRQ__PENDING 0x1
+#define BM_LRADC_CTRL1_LRADC1_IRQ	0x00000002
+#define BV_LRADC_CTRL1_LRADC1_IRQ__CLEAR   0x0
+#define BV_LRADC_CTRL1_LRADC1_IRQ__PENDING 0x1
+#define BM_LRADC_CTRL1_LRADC0_IRQ	0x00000001
+#define BV_LRADC_CTRL1_LRADC0_IRQ__CLEAR   0x0
+#define BV_LRADC_CTRL1_LRADC0_IRQ__PENDING 0x1
+
+#define HW_LRADC_CTRL2	(0x00000020)
+#define HW_LRADC_CTRL2_SET	(0x00000024)
+#define HW_LRADC_CTRL2_CLR	(0x00000028)
+#define HW_LRADC_CTRL2_TOG	(0x0000002c)
+
+#define BP_LRADC_CTRL2_DIVIDE_BY_TWO	24
+#define BM_LRADC_CTRL2_DIVIDE_BY_TWO	0xFF000000
+#define BF_LRADC_CTRL2_DIVIDE_BY_TWO(v) \
+		(((v) << 24) & BM_LRADC_CTRL2_DIVIDE_BY_TWO)
+#define BP_LRADC_CTRL2_RSRVD3	16
+#define BM_LRADC_CTRL2_RSRVD3	0x00FF0000
+#define BF_LRADC_CTRL2_RSRVD3(v)  \
+		(((v) << 16) & BM_LRADC_CTRL2_RSRVD3)
+#define BM_LRADC_CTRL2_TEMPSENSE_PWD	0x00008000
+#define BV_LRADC_CTRL2_TEMPSENSE_PWD__ENABLE  0x0
+#define BV_LRADC_CTRL2_TEMPSENSE_PWD__DISABLE 0x1
+#define BP_LRADC_CTRL2_VTHSENSE	13
+#define BM_LRADC_CTRL2_VTHSENSE	0x00006000
+#define BF_LRADC_CTRL2_VTHSENSE(v)  \
+		(((v) << 13) & BM_LRADC_CTRL2_VTHSENSE)
+#define BM_LRADC_CTRL2_DISABLE_MUXAMP_BYPASS	0x00001000
+#define BP_LRADC_CTRL2_RSRVD2	10
+#define BM_LRADC_CTRL2_RSRVD2	0x00000C00
+#define BF_LRADC_CTRL2_RSRVD2(v)  \
+		(((v) << 10) & BM_LRADC_CTRL2_RSRVD2)
+#define BM_LRADC_CTRL2_TEMP_SENSOR_IENABLE1	0x00000200
+#define BV_LRADC_CTRL2_TEMP_SENSOR_IENABLE1__DISABLE 0x0
+#define BV_LRADC_CTRL2_TEMP_SENSOR_IENABLE1__ENABLE  0x1
+#define BM_LRADC_CTRL2_TEMP_SENSOR_IENABLE0	0x00000100
+#define BV_LRADC_CTRL2_TEMP_SENSOR_IENABLE0__DISABLE 0x0
+#define BV_LRADC_CTRL2_TEMP_SENSOR_IENABLE0__ENABLE  0x1
+#define BP_LRADC_CTRL2_TEMP_ISRC1	4
+#define BM_LRADC_CTRL2_TEMP_ISRC1	0x000000F0
+#define BF_LRADC_CTRL2_TEMP_ISRC1(v)  \
+		(((v) << 4) & BM_LRADC_CTRL2_TEMP_ISRC1)
+#define BV_LRADC_CTRL2_TEMP_ISRC1__300  0xF
+#define BV_LRADC_CTRL2_TEMP_ISRC1__280  0xE
+#define BV_LRADC_CTRL2_TEMP_ISRC1__260  0xD
+#define BV_LRADC_CTRL2_TEMP_ISRC1__240  0xC
+#define BV_LRADC_CTRL2_TEMP_ISRC1__220  0xB
+#define BV_LRADC_CTRL2_TEMP_ISRC1__200  0xA
+#define BV_LRADC_CTRL2_TEMP_ISRC1__180  0x9
+#define BV_LRADC_CTRL2_TEMP_ISRC1__160  0x8
+#define BV_LRADC_CTRL2_TEMP_ISRC1__140  0x7
+#define BV_LRADC_CTRL2_TEMP_ISRC1__120  0x6
+#define BV_LRADC_CTRL2_TEMP_ISRC1__100  0x5
+#define BV_LRADC_CTRL2_TEMP_ISRC1__80   0x4
+#define BV_LRADC_CTRL2_TEMP_ISRC1__60   0x3
+#define BV_LRADC_CTRL2_TEMP_ISRC1__40   0x2
+#define BV_LRADC_CTRL2_TEMP_ISRC1__20   0x1
+#define BV_LRADC_CTRL2_TEMP_ISRC1__ZERO 0x0
+#define BP_LRADC_CTRL2_TEMP_ISRC0	0
+#define BM_LRADC_CTRL2_TEMP_ISRC0	0x0000000F
+#define BF_LRADC_CTRL2_TEMP_ISRC0(v)  \
+		(((v) << 0) & BM_LRADC_CTRL2_TEMP_ISRC0)
+#define BV_LRADC_CTRL2_TEMP_ISRC0__300  0xF
+#define BV_LRADC_CTRL2_TEMP_ISRC0__280  0xE
+#define BV_LRADC_CTRL2_TEMP_ISRC0__260  0xD
+#define BV_LRADC_CTRL2_TEMP_ISRC0__240  0xC
+#define BV_LRADC_CTRL2_TEMP_ISRC0__220  0xB
+#define BV_LRADC_CTRL2_TEMP_ISRC0__200  0xA
+#define BV_LRADC_CTRL2_TEMP_ISRC0__180  0x9
+#define BV_LRADC_CTRL2_TEMP_ISRC0__160  0x8
+#define BV_LRADC_CTRL2_TEMP_ISRC0__140  0x7
+#define BV_LRADC_CTRL2_TEMP_ISRC0__120  0x6
+#define BV_LRADC_CTRL2_TEMP_ISRC0__100  0x5
+#define BV_LRADC_CTRL2_TEMP_ISRC0__80   0x4
+#define BV_LRADC_CTRL2_TEMP_ISRC0__60   0x3
+#define BV_LRADC_CTRL2_TEMP_ISRC0__40   0x2
+#define BV_LRADC_CTRL2_TEMP_ISRC0__20   0x1
+#define BV_LRADC_CTRL2_TEMP_ISRC0__ZERO 0x0
+
+#define HW_LRADC_CTRL3	(0x00000030)
+#define HW_LRADC_CTRL3_SET	(0x00000034)
+#define HW_LRADC_CTRL3_CLR	(0x00000038)
+#define HW_LRADC_CTRL3_TOG	(0x0000003c)
+
+#define BP_LRADC_CTRL3_RSRVD5	26
+#define BM_LRADC_CTRL3_RSRVD5	0xFC000000
+#define BF_LRADC_CTRL3_RSRVD5(v) \
+		(((v) << 26) & BM_LRADC_CTRL3_RSRVD5)
+#define BP_LRADC_CTRL3_DISCARD	24
+#define BM_LRADC_CTRL3_DISCARD	0x03000000
+#define BF_LRADC_CTRL3_DISCARD(v)  \
+		(((v) << 24) & BM_LRADC_CTRL3_DISCARD)
+#define BV_LRADC_CTRL3_DISCARD__1_SAMPLE  0x1
+#define BV_LRADC_CTRL3_DISCARD__2_SAMPLES 0x2
+#define BV_LRADC_CTRL3_DISCARD__3_SAMPLES 0x3
+#define BM_LRADC_CTRL3_FORCE_ANALOG_PWUP	0x00800000
+#define BV_LRADC_CTRL3_FORCE_ANALOG_PWUP__OFF 0x0
+#define BV_LRADC_CTRL3_FORCE_ANALOG_PWUP__ON  0x1
+#define BM_LRADC_CTRL3_FORCE_ANALOG_PWDN	0x00400000
+#define BV_LRADC_CTRL3_FORCE_ANALOG_PWDN__ON  0x0
+#define BV_LRADC_CTRL3_FORCE_ANALOG_PWDN__OFF 0x1
+#define BP_LRADC_CTRL3_RSRVD4	14
+#define BM_LRADC_CTRL3_RSRVD4	0x003FC000
+#define BF_LRADC_CTRL3_RSRVD4(v)  \
+		(((v) << 14) & BM_LRADC_CTRL3_RSRVD4)
+#define BP_LRADC_CTRL3_RSRVD3	10
+#define BM_LRADC_CTRL3_RSRVD3	0x00003C00
+#define BF_LRADC_CTRL3_RSRVD3(v)  \
+		(((v) << 10) & BM_LRADC_CTRL3_RSRVD3)
+#define BP_LRADC_CTRL3_CYCLE_TIME	8
+#define BM_LRADC_CTRL3_CYCLE_TIME	0x00000300
+#define BF_LRADC_CTRL3_CYCLE_TIME(v)  \
+		(((v) << 8) & BM_LRADC_CTRL3_CYCLE_TIME)
+#define BV_LRADC_CTRL3_CYCLE_TIME__6MHZ 0x0
+#define BV_LRADC_CTRL3_CYCLE_TIME__4MHZ 0x1
+#define BV_LRADC_CTRL3_CYCLE_TIME__3MHZ 0x2
+#define BV_LRADC_CTRL3_CYCLE_TIME__2MHZ 0x3
+#define BP_LRADC_CTRL3_RSRVD2	6
+#define BM_LRADC_CTRL3_RSRVD2	0x000000C0
+#define BF_LRADC_CTRL3_RSRVD2(v)  \
+		(((v) << 6) & BM_LRADC_CTRL3_RSRVD2)
+#define BP_LRADC_CTRL3_HIGH_TIME	4
+#define BM_LRADC_CTRL3_HIGH_TIME	0x00000030
+#define BF_LRADC_CTRL3_HIGH_TIME(v)  \
+		(((v) << 4) & BM_LRADC_CTRL3_HIGH_TIME)
+#define BV_LRADC_CTRL3_HIGH_TIME__42NS  0x0
+#define BV_LRADC_CTRL3_HIGH_TIME__83NS  0x1
+#define BV_LRADC_CTRL3_HIGH_TIME__125NS 0x2
+#define BV_LRADC_CTRL3_HIGH_TIME__250NS 0x3
+#define BP_LRADC_CTRL3_RSRVD1	2
+#define BM_LRADC_CTRL3_RSRVD1	0x0000000C
+#define BF_LRADC_CTRL3_RSRVD1(v)  \
+		(((v) << 2) & BM_LRADC_CTRL3_RSRVD1)
+#define BM_LRADC_CTRL3_DELAY_CLOCK	0x00000002
+#define BV_LRADC_CTRL3_DELAY_CLOCK__NORMAL  0x0
+#define BV_LRADC_CTRL3_DELAY_CLOCK__DELAYED 0x1
+#define BM_LRADC_CTRL3_INVERT_CLOCK	0x00000001
+#define BV_LRADC_CTRL3_INVERT_CLOCK__NORMAL 0x0
+#define BV_LRADC_CTRL3_INVERT_CLOCK__INVERT 0x1
+
+#define HW_LRADC_STATUS	(0x00000040)
+#define HW_LRADC_STATUS_SET	(0x00000044)
+#define HW_LRADC_STATUS_CLR	(0x00000048)
+#define HW_LRADC_STATUS_TOG	(0x0000004c)
+
+#define BP_LRADC_STATUS_RSRVD3	29
+#define BM_LRADC_STATUS_RSRVD3	0xE0000000
+#define BF_LRADC_STATUS_RSRVD3(v) \
+		(((v) << 29) & BM_LRADC_STATUS_RSRVD3)
+#define BM_LRADC_STATUS_BUTTON1_PRESENT	0x10000000
+#define BM_LRADC_STATUS_BUTTON0_PRESENT	0x08000000
+#define BM_LRADC_STATUS_TEMP1_PRESENT	0x04000000
+#define BM_LRADC_STATUS_TEMP0_PRESENT	0x02000000
+#define BM_LRADC_STATUS_TOUCH_PANEL_PRESENT	0x01000000
+#define BM_LRADC_STATUS_CHANNEL7_PRESENT	0x00800000
+#define BM_LRADC_STATUS_CHANNEL6_PRESENT	0x00400000
+#define BM_LRADC_STATUS_CHANNEL5_PRESENT	0x00200000
+#define BM_LRADC_STATUS_CHANNEL4_PRESENT	0x00100000
+#define BM_LRADC_STATUS_CHANNEL3_PRESENT	0x00080000
+#define BM_LRADC_STATUS_CHANNEL2_PRESENT	0x00040000
+#define BM_LRADC_STATUS_CHANNEL1_PRESENT	0x00020000
+#define BM_LRADC_STATUS_CHANNEL0_PRESENT	0x00010000
+#define BP_LRADC_STATUS_RSRVD2	3
+#define BM_LRADC_STATUS_RSRVD2	0x0000FFF8
+#define BF_LRADC_STATUS_RSRVD2(v)  \
+		(((v) << 3) & BM_LRADC_STATUS_RSRVD2)
+#define BM_LRADC_STATUS_BUTTON1_DETECT_RAW	0x00000004
+#define BV_LRADC_STATUS_BUTTON1_DETECT_RAW__OPEN 0x0
+#define BV_LRADC_STATUS_BUTTON1_DETECT_RAW__HIT  0x1
+#define BM_LRADC_STATUS_BUTTON0_DETECT_RAW	0x00000002
+#define BV_LRADC_STATUS_BUTTON0_DETECT_RAW__OPEN 0x0
+#define BV_LRADC_STATUS_BUTTON0_DETECT_RAW__HIT  0x1
+#define BM_LRADC_STATUS_TOUCH_DETECT_RAW	0x00000001
+#define BV_LRADC_STATUS_TOUCH_DETECT_RAW__OPEN 0x0
+#define BV_LRADC_STATUS_TOUCH_DETECT_RAW__HIT  0x1
+
+/*
+ *  multi-register-define name HW_LRADC_CHn
+ *              base 0x00000050
+ *              count 6
+ *              offset 0x10
+ */
+#define HW_LRADC_CHn(n)	(0x00000050 + (n) * 0x10)
+#define HW_LRADC_CHn_SET(n)	(0x00000054 + (n) * 0x10)
+#define HW_LRADC_CHn_CLR(n)	(0x00000058 + (n) * 0x10)
+#define HW_LRADC_CHn_TOG(n)	(0x0000005c + (n) * 0x10)
+#define BM_LRADC_CHn_TOGGLE	0x80000000
+#define BM_LRADC_CHn_RSRVD2	0x40000000
+#define BM_LRADC_CHn_ACCUMULATE	0x20000000
+#define BP_LRADC_CHn_NUM_SAMPLES	24
+#define BM_LRADC_CHn_NUM_SAMPLES	0x1F000000
+#define BF_LRADC_CHn_NUM_SAMPLES(v)  \
+		(((v) << 24) & BM_LRADC_CHn_NUM_SAMPLES)
+#define BP_LRADC_CHn_RSRVD1	18
+#define BM_LRADC_CHn_RSRVD1	0x00FC0000
+#define BF_LRADC_CHn_RSRVD1(v)  \
+		(((v) << 18) & BM_LRADC_CHn_RSRVD1)
+#define BP_LRADC_CHn_VALUE	0
+#define BM_LRADC_CHn_VALUE	0x0003FFFF
+#define BF_LRADC_CHn_VALUE(v)  \
+		(((v) << 0) & BM_LRADC_CHn_VALUE)
+
+#define HW_LRADC_CH6	(0x000000b0)
+#define HW_LRADC_CH6_SET	(0x000000b4)
+#define HW_LRADC_CH6_CLR	(0x000000b8)
+#define HW_LRADC_CH6_TOG	(0x000000bc)
+
+#define BM_LRADC_CH6_TOGGLE	0x80000000
+#define BM_LRADC_CH6_RSRVD2	0x40000000
+#define BM_LRADC_CH6_ACCUMULATE	0x20000000
+#define BP_LRADC_CH6_NUM_SAMPLES	24
+#define BM_LRADC_CH6_NUM_SAMPLES	0x1F000000
+#define BF_LRADC_CH6_NUM_SAMPLES(v)  \
+		(((v) << 24) & BM_LRADC_CH6_NUM_SAMPLES)
+#define BP_LRADC_CH6_RSRVD1	18
+#define BM_LRADC_CH6_RSRVD1	0x00FC0000
+#define BF_LRADC_CH6_RSRVD1(v)  \
+		(((v) << 18) & BM_LRADC_CH6_RSRVD1)
+#define BP_LRADC_CH6_VALUE	0
+#define BM_LRADC_CH6_VALUE	0x0003FFFF
+#define BF_LRADC_CH6_VALUE(v)  \
+		(((v) << 0) & BM_LRADC_CH6_VALUE)
+
+#define HW_LRADC_CH7	(0x000000c0)
+#define HW_LRADC_CH7_SET	(0x000000c4)
+#define HW_LRADC_CH7_CLR	(0x000000c8)
+#define HW_LRADC_CH7_TOG	(0x000000cc)
+
+#define BM_LRADC_CH7_TOGGLE	0x80000000
+#define BM_LRADC_CH7_TESTMODE_TOGGLE	0x40000000
+#define BM_LRADC_CH7_ACCUMULATE	0x20000000
+#define BP_LRADC_CH7_NUM_SAMPLES	24
+#define BM_LRADC_CH7_NUM_SAMPLES	0x1F000000
+#define BF_LRADC_CH7_NUM_SAMPLES(v)  \
+		(((v) << 24) & BM_LRADC_CH7_NUM_SAMPLES)
+#define BP_LRADC_CH7_RSRVD1	18
+#define BM_LRADC_CH7_RSRVD1	0x00FC0000
+#define BF_LRADC_CH7_RSRVD1(v)  \
+		(((v) << 18) & BM_LRADC_CH7_RSRVD1)
+#define BP_LRADC_CH7_VALUE	0
+#define BM_LRADC_CH7_VALUE	0x0003FFFF
+#define BF_LRADC_CH7_VALUE(v)  \
+		(((v) << 0) & BM_LRADC_CH7_VALUE)
+
+/*
+ *  multi-register-define name HW_LRADC_DELAYn
+ *              base 0x000000D0
+ *              count 4
+ *              offset 0x10
+ */
+#define HW_LRADC_DELAYn(n)	(0x000000d0 + (n) * 0x10)
+#define HW_LRADC_DELAYn_SET(n)	(0x000000d4 + (n) * 0x10)
+#define HW_LRADC_DELAYn_CLR(n)	(0x000000d8 + (n) * 0x10)
+#define HW_LRADC_DELAYn_TOG(n)	(0x000000dc + (n) * 0x10)
+#define BP_LRADC_DELAYn_TRIGGER_LRADCS	24
+#define BM_LRADC_DELAYn_TRIGGER_LRADCS	0xFF000000
+#define BF_LRADC_DELAYn_TRIGGER_LRADCS(v) \
+		(((v) << 24) & BM_LRADC_DELAYn_TRIGGER_LRADCS)
+#define BP_LRADC_DELAYn_RSRVD2	21
+#define BM_LRADC_DELAYn_RSRVD2	0x00E00000
+#define BF_LRADC_DELAYn_RSRVD2(v)  \
+		(((v) << 21) & BM_LRADC_DELAYn_RSRVD2)
+#define BM_LRADC_DELAYn_KICK	0x00100000
+#define BP_LRADC_DELAYn_TRIGGER_DELAYS	16
+#define BM_LRADC_DELAYn_TRIGGER_DELAYS	0x000F0000
+#define BF_LRADC_DELAYn_TRIGGER_DELAYS(v)  \
+		(((v) << 16) & BM_LRADC_DELAYn_TRIGGER_DELAYS)
+#define BP_LRADC_DELAYn_LOOP_COUNT	11
+#define BM_LRADC_DELAYn_LOOP_COUNT	0x0000F800
+#define BF_LRADC_DELAYn_LOOP_COUNT(v)  \
+		(((v) << 11) & BM_LRADC_DELAYn_LOOP_COUNT)
+#define BP_LRADC_DELAYn_DELAY	0
+#define BM_LRADC_DELAYn_DELAY	0x000007FF
+#define BF_LRADC_DELAYn_DELAY(v)  \
+		(((v) << 0) & BM_LRADC_DELAYn_DELAY)
+
+#define HW_LRADC_DEBUG0	(0x00000110)
+#define HW_LRADC_DEBUG0_SET	(0x00000114)
+#define HW_LRADC_DEBUG0_CLR	(0x00000118)
+#define HW_LRADC_DEBUG0_TOG	(0x0000011c)
+
+#define BP_LRADC_DEBUG0_READONLY	16
+#define BM_LRADC_DEBUG0_READONLY	0xFFFF0000
+#define BF_LRADC_DEBUG0_READONLY(v) \
+		(((v) << 16) & BM_LRADC_DEBUG0_READONLY)
+#define BP_LRADC_DEBUG0_RSRVD1	12
+#define BM_LRADC_DEBUG0_RSRVD1	0x0000F000
+#define BF_LRADC_DEBUG0_RSRVD1(v)  \
+		(((v) << 12) & BM_LRADC_DEBUG0_RSRVD1)
+#define BP_LRADC_DEBUG0_STATE	0
+#define BM_LRADC_DEBUG0_STATE	0x00000FFF
+#define BF_LRADC_DEBUG0_STATE(v)  \
+		(((v) << 0) & BM_LRADC_DEBUG0_STATE)
+
+#define HW_LRADC_DEBUG1	(0x00000120)
+#define HW_LRADC_DEBUG1_SET	(0x00000124)
+#define HW_LRADC_DEBUG1_CLR	(0x00000128)
+#define HW_LRADC_DEBUG1_TOG	(0x0000012c)
+
+#define BP_LRADC_DEBUG1_RSRVD3	24
+#define BM_LRADC_DEBUG1_RSRVD3	0xFF000000
+#define BF_LRADC_DEBUG1_RSRVD3(v) \
+		(((v) << 24) & BM_LRADC_DEBUG1_RSRVD3)
+#define BP_LRADC_DEBUG1_REQUEST	16
+#define BM_LRADC_DEBUG1_REQUEST	0x00FF0000
+#define BF_LRADC_DEBUG1_REQUEST(v)  \
+		(((v) << 16) & BM_LRADC_DEBUG1_REQUEST)
+#define BP_LRADC_DEBUG1_RSRVD2	13
+#define BM_LRADC_DEBUG1_RSRVD2	0x0000E000
+#define BF_LRADC_DEBUG1_RSRVD2(v)  \
+		(((v) << 13) & BM_LRADC_DEBUG1_RSRVD2)
+#define BP_LRADC_DEBUG1_TESTMODE_COUNT	8
+#define BM_LRADC_DEBUG1_TESTMODE_COUNT	0x00001F00
+#define BF_LRADC_DEBUG1_TESTMODE_COUNT(v)  \
+		(((v) << 8) & BM_LRADC_DEBUG1_TESTMODE_COUNT)
+#define BP_LRADC_DEBUG1_RSRVD1	3
+#define BM_LRADC_DEBUG1_RSRVD1	0x000000F8
+#define BF_LRADC_DEBUG1_RSRVD1(v)  \
+		(((v) << 3) & BM_LRADC_DEBUG1_RSRVD1)
+#define BM_LRADC_DEBUG1_TESTMODE6	0x00000004
+#define BV_LRADC_DEBUG1_TESTMODE6__NORMAL 0x0
+#define BV_LRADC_DEBUG1_TESTMODE6__TEST   0x1
+#define BM_LRADC_DEBUG1_TESTMODE5	0x00000002
+#define BV_LRADC_DEBUG1_TESTMODE5__NORMAL 0x0
+#define BV_LRADC_DEBUG1_TESTMODE5__TEST   0x1
+#define BM_LRADC_DEBUG1_TESTMODE	0x00000001
+#define BV_LRADC_DEBUG1_TESTMODE__NORMAL 0x0
+#define BV_LRADC_DEBUG1_TESTMODE__TEST   0x1
+
+#define HW_LRADC_CONVERSION	(0x00000130)
+#define HW_LRADC_CONVERSION_SET	(0x00000134)
+#define HW_LRADC_CONVERSION_CLR	(0x00000138)
+#define HW_LRADC_CONVERSION_TOG	(0x0000013c)
+
+#define BP_LRADC_CONVERSION_RSRVD3	21
+#define BM_LRADC_CONVERSION_RSRVD3	0xFFE00000
+#define BF_LRADC_CONVERSION_RSRVD3(v) \
+		(((v) << 21) & BM_LRADC_CONVERSION_RSRVD3)
+#define BM_LRADC_CONVERSION_AUTOMATIC	0x00100000
+#define BV_LRADC_CONVERSION_AUTOMATIC__DISABLE 0x0
+#define BV_LRADC_CONVERSION_AUTOMATIC__ENABLE  0x1
+#define BP_LRADC_CONVERSION_RSRVD2	18
+#define BM_LRADC_CONVERSION_RSRVD2	0x000C0000
+#define BF_LRADC_CONVERSION_RSRVD2(v)  \
+		(((v) << 18) & BM_LRADC_CONVERSION_RSRVD2)
+#define BP_LRADC_CONVERSION_SCALE_FACTOR	16
+#define BM_LRADC_CONVERSION_SCALE_FACTOR	0x00030000
+#define BF_LRADC_CONVERSION_SCALE_FACTOR(v)  \
+		(((v) << 16) & BM_LRADC_CONVERSION_SCALE_FACTOR)
+#define BV_LRADC_CONVERSION_SCALE_FACTOR__NIMH       0x0
+#define BV_LRADC_CONVERSION_SCALE_FACTOR__DUAL_NIMH  0x1
+#define BV_LRADC_CONVERSION_SCALE_FACTOR__LI_ION     0x2
+#define BV_LRADC_CONVERSION_SCALE_FACTOR__ALT_LI_ION 0x3
+#define BP_LRADC_CONVERSION_RSRVD1	10
+#define BM_LRADC_CONVERSION_RSRVD1	0x0000FC00
+#define BF_LRADC_CONVERSION_RSRVD1(v)  \
+		(((v) << 10) & BM_LRADC_CONVERSION_RSRVD1)
+#define BP_LRADC_CONVERSION_SCALED_BATT_VOLTAGE	0
+#define BM_LRADC_CONVERSION_SCALED_BATT_VOLTAGE	0x000003FF
+#define BF_LRADC_CONVERSION_SCALED_BATT_VOLTAGE(v)  \
+		(((v) << 0) & BM_LRADC_CONVERSION_SCALED_BATT_VOLTAGE)
+
+#define HW_LRADC_CTRL4	(0x00000140)
+#define HW_LRADC_CTRL4_SET	(0x00000144)
+#define HW_LRADC_CTRL4_CLR	(0x00000148)
+#define HW_LRADC_CTRL4_TOG	(0x0000014c)
+
+#define BP_LRADC_CTRL4_LRADC7SELECT	28
+#define BM_LRADC_CTRL4_LRADC7SELECT	0xF0000000
+#define BF_LRADC_CTRL4_LRADC7SELECT(v) \
+		(((v) << 28) & BM_LRADC_CTRL4_LRADC7SELECT)
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL0  0x0
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL1  0x1
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL2  0x2
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL3  0x3
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL4  0x4
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL5  0x5
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL6  0x6
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL7  0x7
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL8  0x8
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL9  0x9
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL10 0xA
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL11 0xB
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL12 0xC
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL13 0xD
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL14 0xE
+#define BV_LRADC_CTRL4_LRADC7SELECT__CHANNEL15 0xF
+#define BP_LRADC_CTRL4_LRADC6SELECT	24
+#define BM_LRADC_CTRL4_LRADC6SELECT	0x0F000000
+#define BF_LRADC_CTRL4_LRADC6SELECT(v)  \
+		(((v) << 24) & BM_LRADC_CTRL4_LRADC6SELECT)
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL0  0x0
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL1  0x1
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL2  0x2
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL3  0x3
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL4  0x4
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL5  0x5
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL6  0x6
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL7  0x7
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL8  0x8
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL9  0x9
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL10 0xA
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL11 0xB
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL12 0xC
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL13 0xD
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL14 0xE
+#define BV_LRADC_CTRL4_LRADC6SELECT__CHANNEL15 0xF
+#define BP_LRADC_CTRL4_LRADC5SELECT	20
+#define BM_LRADC_CTRL4_LRADC5SELECT	0x00F00000
+#define BF_LRADC_CTRL4_LRADC5SELECT(v)  \
+		(((v) << 20) & BM_LRADC_CTRL4_LRADC5SELECT)
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL0  0x0
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL1  0x1
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL2  0x2
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL3  0x3
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL4  0x4
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL5  0x5
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL6  0x6
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL7  0x7
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL8  0x8
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL9  0x9
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL10 0xA
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL11 0xB
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL12 0xC
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL13 0xD
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL14 0xE
+#define BV_LRADC_CTRL4_LRADC5SELECT__CHANNEL15 0xF
+#define BP_LRADC_CTRL4_LRADC4SELECT	16
+#define BM_LRADC_CTRL4_LRADC4SELECT	0x000F0000
+#define BF_LRADC_CTRL4_LRADC4SELECT(v)  \
+		(((v) << 16) & BM_LRADC_CTRL4_LRADC4SELECT)
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL0  0x0
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL1  0x1
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL2  0x2
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL3  0x3
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL4  0x4
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL5  0x5
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL6  0x6
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL7  0x7
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL8  0x8
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL9  0x9
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL10 0xA
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL11 0xB
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL12 0xC
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL13 0xD
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL14 0xE
+#define BV_LRADC_CTRL4_LRADC4SELECT__CHANNEL15 0xF
+#define BP_LRADC_CTRL4_LRADC3SELECT	12
+#define BM_LRADC_CTRL4_LRADC3SELECT	0x0000F000
+#define BF_LRADC_CTRL4_LRADC3SELECT(v)  \
+		(((v) << 12) & BM_LRADC_CTRL4_LRADC3SELECT)
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL0  0x0
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL1  0x1
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL2  0x2
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL3  0x3
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL4  0x4
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL5  0x5
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL6  0x6
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL7  0x7
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL8  0x8
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL9  0x9
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL10 0xA
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL11 0xB
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL12 0xC
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL13 0xD
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL14 0xE
+#define BV_LRADC_CTRL4_LRADC3SELECT__CHANNEL15 0xF
+#define BP_LRADC_CTRL4_LRADC2SELECT	8
+#define BM_LRADC_CTRL4_LRADC2SELECT	0x00000F00
+#define BF_LRADC_CTRL4_LRADC2SELECT(v)  \
+		(((v) << 8) & BM_LRADC_CTRL4_LRADC2SELECT)
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL0  0x0
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL1  0x1
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL2  0x2
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL3  0x3
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL4  0x4
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL5  0x5
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL6  0x6
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL7  0x7
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL8  0x8
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL9  0x9
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL10 0xA
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL11 0xB
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL12 0xC
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL13 0xD
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL14 0xE
+#define BV_LRADC_CTRL4_LRADC2SELECT__CHANNEL15 0xF
+#define BP_LRADC_CTRL4_LRADC1SELECT	4
+#define BM_LRADC_CTRL4_LRADC1SELECT	0x000000F0
+#define BF_LRADC_CTRL4_LRADC1SELECT(v)  \
+		(((v) << 4) & BM_LRADC_CTRL4_LRADC1SELECT)
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL0  0x0
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL1  0x1
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL2  0x2
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL3  0x3
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL4  0x4
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL5  0x5
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL6  0x6
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL7  0x7
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL8  0x8
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL9  0x9
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL10 0xA
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL11 0xB
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL12 0xC
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL13 0xD
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL14 0xE
+#define BV_LRADC_CTRL4_LRADC1SELECT__CHANNEL15 0xF
+#define BP_LRADC_CTRL4_LRADC0SELECT	0
+#define BM_LRADC_CTRL4_LRADC0SELECT	0x0000000F
+#define BF_LRADC_CTRL4_LRADC0SELECT(v)  \
+		(((v) << 0) & BM_LRADC_CTRL4_LRADC0SELECT)
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL0  0x0
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL1  0x1
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL2  0x2
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL3  0x3
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL4  0x4
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL5  0x5
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL6  0x6
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL7  0x7
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL8  0x8
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL9  0x9
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL10 0xA
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL11 0xB
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL12 0xC
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL13 0xD
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL14 0xE
+#define BV_LRADC_CTRL4_LRADC0SELECT__CHANNEL15 0xF
+
+#define HW_LRADC_THRESHOLD0	(0x00000150)
+#define HW_LRADC_THRESHOLD0_SET	(0x00000154)
+#define HW_LRADC_THRESHOLD0_CLR	(0x00000158)
+#define HW_LRADC_THRESHOLD0_TOG	(0x0000015c)
+
+#define BP_LRADC_THRESHOLD0_RSRVD1	25
+#define BM_LRADC_THRESHOLD0_RSRVD1	0xFE000000
+#define BF_LRADC_THRESHOLD0_RSRVD1(v) \
+		(((v) << 25) & BM_LRADC_THRESHOLD0_RSRVD1)
+#define BM_LRADC_THRESHOLD0_ENABLE	0x01000000
+#define BM_LRADC_THRESHOLD0_BATTCHRG_DISABLE	0x00800000
+#define BP_LRADC_THRESHOLD0_CHANNEL_SEL	20
+#define BM_LRADC_THRESHOLD0_CHANNEL_SEL	0x00700000
+#define BF_LRADC_THRESHOLD0_CHANNEL_SEL(v)  \
+		(((v) << 20) & BM_LRADC_THRESHOLD0_CHANNEL_SEL)
+#define BV_LRADC_THRESHOLD0_CHANNEL_SEL__CHANNEL0 0x0
+#define BV_LRADC_THRESHOLD0_CHANNEL_SEL__CHANNEL1 0x1
+#define BV_LRADC_THRESHOLD0_CHANNEL_SEL__CHANNEL2 0x2
+#define BV_LRADC_THRESHOLD0_CHANNEL_SEL__CHANNEL3 0x3
+#define BV_LRADC_THRESHOLD0_CHANNEL_SEL__CHANNEL4 0x4
+#define BV_LRADC_THRESHOLD0_CHANNEL_SEL__CHANNEL5 0x5
+#define BV_LRADC_THRESHOLD0_CHANNEL_SEL__CHANNEL6 0x6
+#define BV_LRADC_THRESHOLD0_CHANNEL_SEL__CHANNEL7 0x7
+#define BP_LRADC_THRESHOLD0_SETTING	18
+#define BM_LRADC_THRESHOLD0_SETTING	0x000C0000
+#define BF_LRADC_THRESHOLD0_SETTING(v)  \
+		(((v) << 18) & BM_LRADC_THRESHOLD0_SETTING)
+#define BV_LRADC_THRESHOLD0_SETTING__NO_COMPARE  0x0
+#define BV_LRADC_THRESHOLD0_SETTING__DETECT_LOW  0x1
+#define BV_LRADC_THRESHOLD0_SETTING__DETECT_HIGH 0x2
+#define BV_LRADC_THRESHOLD0_SETTING__RESERVED    0x3
+#define BP_LRADC_THRESHOLD0_VALUE	0
+#define BM_LRADC_THRESHOLD0_VALUE	0x0003FFFF
+#define BF_LRADC_THRESHOLD0_VALUE(v)  \
+		(((v) << 0) & BM_LRADC_THRESHOLD0_VALUE)
+
+#define HW_LRADC_THRESHOLD1	(0x00000160)
+#define HW_LRADC_THRESHOLD1_SET	(0x00000164)
+#define HW_LRADC_THRESHOLD1_CLR	(0x00000168)
+#define HW_LRADC_THRESHOLD1_TOG	(0x0000016c)
+
+#define BP_LRADC_THRESHOLD1_RSRVD1	25
+#define BM_LRADC_THRESHOLD1_RSRVD1	0xFE000000
+#define BF_LRADC_THRESHOLD1_RSRVD1(v) \
+		(((v) << 25) & BM_LRADC_THRESHOLD1_RSRVD1)
+#define BM_LRADC_THRESHOLD1_ENABLE	0x01000000
+#define BM_LRADC_THRESHOLD1_BATTCHRG_DISABLE	0x00800000
+#define BP_LRADC_THRESHOLD1_CHANNEL_SEL	20
+#define BM_LRADC_THRESHOLD1_CHANNEL_SEL	0x00700000
+#define BF_LRADC_THRESHOLD1_CHANNEL_SEL(v)  \
+		(((v) << 20) & BM_LRADC_THRESHOLD1_CHANNEL_SEL)
+#define BV_LRADC_THRESHOLD1_CHANNEL_SEL__CHANNEL0 0x0
+#define BV_LRADC_THRESHOLD1_CHANNEL_SEL__CHANNEL1 0x1
+#define BV_LRADC_THRESHOLD1_CHANNEL_SEL__CHANNEL2 0x2
+#define BV_LRADC_THRESHOLD1_CHANNEL_SEL__CHANNEL3 0x3
+#define BV_LRADC_THRESHOLD1_CHANNEL_SEL__CHANNEL4 0x4
+#define BV_LRADC_THRESHOLD1_CHANNEL_SEL__CHANNEL5 0x5
+#define BV_LRADC_THRESHOLD1_CHANNEL_SEL__CHANNEL6 0x6
+#define BV_LRADC_THRESHOLD1_CHANNEL_SEL__CHANNEL7 0x7
+#define BP_LRADC_THRESHOLD1_SETTING	18
+#define BM_LRADC_THRESHOLD1_SETTING	0x000C0000
+#define BF_LRADC_THRESHOLD1_SETTING(v)  \
+		(((v) << 18) & BM_LRADC_THRESHOLD1_SETTING)
+#define BV_LRADC_THRESHOLD1_SETTING__NO_COMPARE  0x0
+#define BV_LRADC_THRESHOLD1_SETTING__DETECT_LOW  0x1
+#define BV_LRADC_THRESHOLD1_SETTING__DETECT_HIGH 0x2
+#define BV_LRADC_THRESHOLD1_SETTING__RESERVED    0x3
+#define BP_LRADC_THRESHOLD1_VALUE	0
+#define BM_LRADC_THRESHOLD1_VALUE	0x0003FFFF
+#define BF_LRADC_THRESHOLD1_VALUE(v)  \
+		(((v) << 0) & BM_LRADC_THRESHOLD1_VALUE)
+
+#define HW_LRADC_VERSION	(0x00000170)
+
+#define BP_LRADC_VERSION_MAJOR	24
+#define BM_LRADC_VERSION_MAJOR	0xFF000000
+#define BF_LRADC_VERSION_MAJOR(v) \
+		(((v) << 24) & BM_LRADC_VERSION_MAJOR)
+#define BP_LRADC_VERSION_MINOR	16
+#define BM_LRADC_VERSION_MINOR	0x00FF0000
+#define BF_LRADC_VERSION_MINOR(v)  \
+		(((v) << 16) & BM_LRADC_VERSION_MINOR)
+#define BP_LRADC_VERSION_STEP	0
+#define BM_LRADC_VERSION_STEP	0x0000FFFF
+#define BF_LRADC_VERSION_STEP(v)  \
+		(((v) << 0) & BM_LRADC_VERSION_STEP)
+#endif /* __ARCH_ARM___LRADC_H */
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 3488ffe..36bd3cf 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -339,6 +339,17 @@ config TOUCHSCREEN_HP7XX
 	  To compile this driver as a module, choose M here: the
 	  module will be called jornada720_ts.
 
+config TOUCHSCREEN_MXS
+	tristate "MXS LRADC-based touchscreen"
+	depends on MXS_LRADC
+	select SERIO
+	help
+	  Say Y here if you want to enable touchscreen, connected to MXS
+	  Low-Resoulion ADC.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mxs_ts.
+
 config TOUCHSCREEN_HTCPEN
 	tristate "HTC Shift X9500 touchscreen"
 	depends on ISA
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index f957676..6c3728c 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_TOUCHSCREEN_MTOUCH)	+= mtouch.o
 obj-$(CONFIG_TOUCHSCREEN_MK712)		+= mk712.o
 obj-$(CONFIG_TOUCHSCREEN_HP600)		+= hp680_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_HP7XX)		+= jornada720_ts.o
+obj-$(CONFIG_TOUCHSCREEN_MXS)		+= mxs_ts.o
 obj-$(CONFIG_TOUCHSCREEN_HTCPEN)	+= htcpen.o
 obj-$(CONFIG_TOUCHSCREEN_USB_COMPOSITE)	+= usbtouchscreen.o
 obj-$(CONFIG_TOUCHSCREEN_PCAP)		+= pcap_ts.o
diff --git a/drivers/input/touchscreen/mxs_ts.c b/drivers/input/touchscreen/mxs_ts.c
new file mode 100644
index 0000000..ad05c3f
--- /dev/null
+++ b/drivers/input/touchscreen/mxs_ts.c
@@ -0,0 +1,470 @@
+/*
+ * Freesclae MXS Touchscreen driver
+ *
+ * Author: Vitaly Wool <vital@embeddedalley.com>
+ *
+ * Copyright 2008-2010 Freescale Semiconductor, Inc.
+ * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/fsl_devices.h>
+#include <linux/module.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <mach/lradc.h>
+#include <mach/devices-common.h>
+#include <mach/regs-lradc.h>
+#include <mach/mxs.h>
+
+#define TOUCH_DEBOUNCE_TOLERANCE	100
+
+struct mxs_ts_info {
+	int touch_irq;
+	int device_irq;
+	unsigned int base;
+	u8 x_plus_chan;
+	u8 x_minus_chan;
+	u8 y_plus_chan;
+	u8 y_minus_chan;
+
+	unsigned int x_plus_val;
+	unsigned int x_minus_val;
+	unsigned int y_plus_val;
+	unsigned int y_minus_val;
+	unsigned int x_plus_mask;
+	unsigned int x_minus_mask;
+	unsigned int y_plus_mask;
+	unsigned int y_minus_mask;
+
+	struct input_dev *idev;
+	enum {
+		TS_STATE_DISABLED,
+		TS_STATE_TOUCH_DETECT,
+		TS_STATE_TOUCH_VERIFY,
+		TS_STATE_X_PLANE,
+		TS_STATE_Y_PLANE,
+	} state;
+	u16 x;
+	u16 y;
+	int sample_count;
+};
+
+static inline void enter_state_touch_detect(struct mxs_ts_info *info)
+{
+	__raw_writel(0xFFFFFFFF,
+		     info->base + HW_LRADC_CHn_CLR(info->x_plus_chan));
+	__raw_writel(0xFFFFFFFF,
+		     info->base + HW_LRADC_CHn_CLR(info->y_plus_chan));
+	__raw_writel(0xFFFFFFFF,
+		     info->base + HW_LRADC_CHn_CLR(info->x_minus_chan));
+	__raw_writel(0xFFFFFFFF,
+		     info->base + HW_LRADC_CHn_CLR(info->y_minus_chan));
+
+	__raw_writel(BM_LRADC_CTRL1_LRADC0_IRQ << info->y_minus_chan,
+		     info->base + HW_LRADC_CTRL1_CLR);
+	__raw_writel(BM_LRADC_CTRL1_TOUCH_DETECT_IRQ,
+		     info->base + HW_LRADC_CTRL1_CLR);
+	/*
+	 * turn off the yplus and yminus pullup and pulldown, and turn off touch
+	 * detect (enables yminus, and xplus through a resistor.On a press,
+	 * xplus is pulled down)
+	 */
+	__raw_writel(info->y_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(info->y_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(info->x_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(info->x_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(BM_LRADC_CTRL0_TOUCH_DETECT_ENABLE,
+		     info->base + HW_LRADC_CTRL0_SET);
+	hw_lradc_set_delay_trigger_kick(LRADC_DELAY_TRIGGER_TOUCHSCREEN, 0);
+	info->state = TS_STATE_TOUCH_DETECT;
+	info->sample_count = 0;
+}
+
+static inline void enter_state_disabled(struct mxs_ts_info *info)
+{
+	__raw_writel(info->y_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(info->y_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(info->x_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(info->x_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(BM_LRADC_CTRL0_TOUCH_DETECT_ENABLE,
+		     info->base + HW_LRADC_CTRL0_CLR);
+	hw_lradc_set_delay_trigger_kick(LRADC_DELAY_TRIGGER_TOUCHSCREEN, 0);
+	info->state = TS_STATE_DISABLED;
+	info->sample_count = 0;
+}
+
+
+static inline void enter_state_x_plane(struct mxs_ts_info *info)
+{
+	__raw_writel(info->y_plus_val, info->base + HW_LRADC_CTRL0_SET);
+	__raw_writel(info->y_minus_val, info->base + HW_LRADC_CTRL0_SET);
+	__raw_writel(info->x_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(info->x_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(BM_LRADC_CTRL0_TOUCH_DETECT_ENABLE,
+		     info->base + HW_LRADC_CTRL0_CLR);
+	hw_lradc_set_delay_trigger_kick(LRADC_DELAY_TRIGGER_TOUCHSCREEN, 1);
+
+	info->state = TS_STATE_X_PLANE;
+	info->sample_count = 0;
+}
+
+static inline void enter_state_y_plane(struct mxs_ts_info *info)
+{
+	__raw_writel(info->y_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(info->y_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(info->x_plus_val, info->base + HW_LRADC_CTRL0_SET);
+	__raw_writel(info->x_minus_val, info->base + HW_LRADC_CTRL0_SET);
+	__raw_writel(BM_LRADC_CTRL0_TOUCH_DETECT_ENABLE,
+		     info->base + HW_LRADC_CTRL0_CLR);
+	hw_lradc_set_delay_trigger_kick(LRADC_DELAY_TRIGGER_TOUCHSCREEN, 1);
+	info->state = TS_STATE_Y_PLANE;
+	info->sample_count = 0;
+}
+
+static inline void enter_state_touch_verify(struct mxs_ts_info *info)
+{
+	__raw_writel(info->y_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(info->y_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(info->x_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(info->x_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
+	__raw_writel(BM_LRADC_CTRL0_TOUCH_DETECT_ENABLE,
+		     info->base + HW_LRADC_CTRL0_SET);
+	info->state = TS_STATE_TOUCH_VERIFY;
+	hw_lradc_set_delay_trigger_kick(LRADC_DELAY_TRIGGER_TOUCHSCREEN, 1);
+	info->sample_count = 0;
+}
+
+static void process_lradc(struct mxs_ts_info *info, u16 x, u16 y,
+			int pressure)
+{
+	switch (info->state) {
+	case TS_STATE_X_PLANE:
+		pr_debug("%s: x plane state, sample_count %d\n", __func__,
+				info->sample_count);
+		if (info->sample_count < 2) {
+			info->x = x;
+			info->sample_count++;
+		} else {
+			if (abs(info->x - x) > TOUCH_DEBOUNCE_TOLERANCE)
+				info->sample_count = 1;
+			else {
+				u16 x_c = info->x * (info->sample_count - 1);
+				info->x = (x_c + x) / info->sample_count;
+				info->sample_count++;
+			}
+		}
+		if (info->sample_count > 4)
+			enter_state_y_plane(info);
+		else
+			hw_lradc_set_delay_trigger_kick(
+					LRADC_DELAY_TRIGGER_TOUCHSCREEN, 1);
+		break;
+
+	case TS_STATE_Y_PLANE:
+		pr_debug("%s: y plane state, sample_count %d\n", __func__,
+				info->sample_count);
+		if (info->sample_count < 2) {
+			info->y = y;
+			info->sample_count++;
+		} else {
+			if (abs(info->y - y) > TOUCH_DEBOUNCE_TOLERANCE)
+				info->sample_count = 1;
+			else {
+				u16 y_c = info->y * (info->sample_count - 1);
+				info->y = (y_c + y) / info->sample_count;
+				info->sample_count++;
+			}
+		}
+		if (info->sample_count > 4)
+			enter_state_touch_verify(info);
+		else
+			hw_lradc_set_delay_trigger_kick(
+					LRADC_DELAY_TRIGGER_TOUCHSCREEN, 1);
+		break;
+
+	case TS_STATE_TOUCH_VERIFY:
+		pr_debug("%s: touch verify state, sample_count %d\n", __func__,
+				info->sample_count);
+		pr_debug("%s: x %d, y %d\n", __func__, info->x, info->y);
+		input_report_abs(info->idev, ABS_X, info->x);
+		input_report_abs(info->idev, ABS_Y, info->y);
+		input_report_abs(info->idev, ABS_PRESSURE, pressure);
+		input_sync(info->idev);
+		/* fall through */
+	case TS_STATE_TOUCH_DETECT:
+		pr_debug("%s: touch detect state, sample_count %d\n", __func__,
+				info->sample_count);
+		if (pressure) {
+			input_report_abs(info->idev, ABS_PRESSURE, pressure);
+			enter_state_x_plane(info);
+			hw_lradc_set_delay_trigger_kick(
+					LRADC_DELAY_TRIGGER_TOUCHSCREEN, 1);
+		} else
+			enter_state_touch_detect(info);
+		break;
+
+	default:
+		printk(KERN_ERR "%s: unknown touchscreen state %d\n", __func__,
+				info->state);
+	}
+}
+
+static irqreturn_t ts_handler(int irq, void *dev_id)
+{
+	struct mxs_ts_info *info = dev_id;
+	u16 x_plus, y_plus;
+	int pressure = 0;
+
+	if (irq == info->touch_irq)
+		__raw_writel(BM_LRADC_CTRL1_TOUCH_DETECT_IRQ,
+			     info->base + HW_LRADC_CTRL1_CLR);
+	else if (irq == info->device_irq)
+		__raw_writel(BM_LRADC_CTRL1_LRADC0_IRQ << info->y_minus_chan,
+			     info->base + HW_LRADC_CTRL1_CLR);
+
+	/* get x, y values */
+	x_plus = __raw_readl(info->base + HW_LRADC_CHn(info->x_plus_chan)) &
+		BM_LRADC_CHn_VALUE;
+	y_plus = __raw_readl(info->base + HW_LRADC_CHn(info->y_plus_chan)) &
+		BM_LRADC_CHn_VALUE;
+
+	/* pressed? */
+	if (__raw_readl(info->base + HW_LRADC_STATUS) &
+	    BM_LRADC_STATUS_TOUCH_DETECT_RAW)
+		pressure = 1;
+
+	pr_debug("%s: irq %d, x_plus %d, y_plus %d, pressure %d\n",
+			__func__, irq, x_plus, y_plus, pressure);
+
+	process_lradc(info, x_plus, y_plus, pressure);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit mxs_ts_probe(struct platform_device *pdev)
+{
+	struct input_dev *idev;
+	struct mxs_ts_info *info;
+	int ret = 0;
+	struct resource *res;
+	struct mxs_touchscreen_plat_data *plat_data;
+
+	plat_data = (struct mxs_touchscreen_plat_data *)pdev->dev.platform_data;
+	if (plat_data == NULL)
+		return -ENODEV;
+
+	idev = input_allocate_device();
+	if (idev == NULL)
+		return -ENOMEM;
+
+	info = kzalloc(sizeof(struct mxs_ts_info), GFP_KERNEL);
+	if (info == NULL) {
+		ret = -ENOMEM;
+		goto out_nomem_info;
+	}
+
+	idev->name = "MXS touchscreen";
+	idev->evbit[0] = BIT(EV_ABS);
+	input_set_abs_params(idev, ABS_X, 0, 0xFFF, 0, 0);
+	input_set_abs_params(idev, ABS_Y, 0, 0xFFF, 0, 0);
+	input_set_abs_params(idev, ABS_PRESSURE, 0, 1, 0, 0);
+
+	ret = input_register_device(idev);
+	if (ret)
+		goto out_nomem;
+
+	info->idev = idev;
+	info->x_plus_chan = plat_data->x_plus_chan;
+	info->x_minus_chan = plat_data->x_minus_chan;
+	info->y_plus_chan = plat_data->y_plus_chan;
+	info->y_minus_chan = plat_data->y_minus_chan;
+	info->x_plus_val = plat_data->x_plus_val;
+	info->x_minus_val = plat_data->x_minus_val;
+	info->y_plus_val = plat_data->y_plus_val;
+	info->y_minus_val = plat_data->y_minus_val;
+	info->x_plus_mask = plat_data->x_plus_mask;
+	info->x_minus_mask = plat_data->x_minus_mask;
+	info->y_plus_mask = plat_data->y_plus_mask;
+	info->y_minus_mask = plat_data->y_minus_mask;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		printk(KERN_ERR "%s: couldn't get MEM resource\n", __func__);
+		ret = -ENODEV;
+		goto out_nodev;
+	}
+	info->base = (unsigned int)MXS_IO_ADDRESS(res->start);
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		printk(KERN_ERR "%s: couldn't get IRQ resource\n", __func__);
+		ret = -ENODEV;
+		goto out_nodev;
+	}
+	info->touch_irq = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
+	if (!res) {
+		printk(KERN_ERR "%s: couldn't get IRQ resource\n", __func__);
+		ret = -ENODEV;
+		goto out_nodev;
+	}
+	info->device_irq = res->start;
+
+	ret = request_irq(info->touch_irq, ts_handler, IRQF_DISABLED,
+				"mxs_ts_touch", info);
+	if (ret)
+		goto out_nodev;
+
+	ret = request_irq(info->device_irq, ts_handler, IRQF_DISABLED,
+				"mxs_ts_dev", info);
+	if (ret) {
+		free_irq(info->touch_irq, info);
+		goto out_nodev;
+	}
+	enter_state_touch_detect(info);
+
+	hw_lradc_use_channel(info->x_plus_chan);
+	hw_lradc_use_channel(info->x_minus_chan);
+	hw_lradc_use_channel(info->y_plus_chan);
+	hw_lradc_use_channel(info->y_minus_chan);
+	hw_lradc_configure_channel(info->x_plus_chan, 0, 0, 0);
+	hw_lradc_configure_channel(info->x_minus_chan, 0, 0, 0);
+	hw_lradc_configure_channel(info->y_plus_chan, 0, 0, 0);
+	hw_lradc_configure_channel(info->y_minus_chan, 0, 0, 0);
+
+	/* Clear the accumulator & NUM_SAMPLES for the channels */
+	__raw_writel(0xFFFFFFFF,
+		     info->base + HW_LRADC_CHn_CLR(info->x_plus_chan));
+	__raw_writel(0xFFFFFFFF,
+		     info->base + HW_LRADC_CHn_CLR(info->x_minus_chan));
+	__raw_writel(0xFFFFFFFF,
+		     info->base + HW_LRADC_CHn_CLR(info->y_plus_chan));
+	__raw_writel(0xFFFFFFFF,
+		     info->base + HW_LRADC_CHn_CLR(info->y_minus_chan));
+
+	hw_lradc_set_delay_trigger(LRADC_DELAY_TRIGGER_TOUCHSCREEN,
+			0x3c, 0, 0, 8);
+
+	__raw_writel(BM_LRADC_CTRL1_LRADC0_IRQ << info->y_minus_chan,
+		     info->base + HW_LRADC_CTRL1_CLR);
+	__raw_writel(BM_LRADC_CTRL1_TOUCH_DETECT_IRQ,
+		     info->base + HW_LRADC_CTRL1_CLR);
+
+	__raw_writel(BM_LRADC_CTRL1_LRADC0_IRQ_EN << info->y_minus_chan,
+		     info->base + HW_LRADC_CTRL1_SET);
+	__raw_writel(BM_LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
+		     info->base + HW_LRADC_CTRL1_SET);
+
+	platform_set_drvdata(pdev, info);
+	device_init_wakeup(&pdev->dev, 1);
+	goto out;
+
+out_nodev:
+	input_free_device(idev);
+out_nomem:
+	kfree(info);
+out_nomem_info:
+	kfree(idev);
+out:
+	return ret;
+}
+
+static int __devexit mxs_ts_remove(struct platform_device *pdev)
+{
+	struct mxs_ts_info *info = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	hw_lradc_unuse_channel(info->x_plus_chan);
+	hw_lradc_unuse_channel(info->x_minus_chan);
+	hw_lradc_unuse_channel(info->y_plus_chan);
+	hw_lradc_unuse_channel(info->y_minus_chan);
+
+	__raw_writel(BM_LRADC_CTRL1_LRADC0_IRQ_EN << info->y_minus_chan,
+		     info->base + HW_LRADC_CTRL1_CLR);
+	__raw_writel(BM_LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
+		     info->base + HW_LRADC_CTRL1_CLR);
+
+	free_irq(info->device_irq, info);
+	free_irq(info->touch_irq, info);
+	input_free_device(info->idev);
+
+	enter_state_disabled(info);
+	kfree(info->idev);
+	kfree(info);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int mxs_ts_suspend(struct platform_device *pdev,
+				pm_message_t state)
+{
+	struct mxs_ts_info *info = platform_get_drvdata(pdev);
+
+	if (!device_may_wakeup(&pdev->dev)) {
+		hw_lradc_unuse_channel(info->x_plus_chan);
+		hw_lradc_unuse_channel(info->x_minus_chan);
+		hw_lradc_unuse_channel(info->y_plus_chan);
+		hw_lradc_unuse_channel(info->y_minus_chan);
+	}
+	return 0;
+}
+
+static int mxs_ts_resume(struct platform_device *pdev)
+{
+	struct mxs_ts_info *info = platform_get_drvdata(pdev);
+
+	if (!device_may_wakeup(&pdev->dev)) {
+		hw_lradc_use_channel(info->x_plus_chan);
+		hw_lradc_use_channel(info->x_minus_chan);
+		hw_lradc_use_channel(info->y_plus_chan);
+		hw_lradc_use_channel(info->y_minus_chan);
+	}
+	return 0;
+}
+#endif
+
+static struct platform_driver mxs_ts_driver = {
+	.probe		= mxs_ts_probe,
+	.remove		= __devexit_p(mxs_ts_remove),
+#ifdef CONFIG_PM
+	.suspend	= mxs_ts_suspend,
+	.resume		= mxs_ts_resume,
+#endif
+	.driver		= {
+		.name	= "mxs-ts",
+	},
+};
+
+static int __init mxs_ts_init(void)
+{
+	return platform_driver_register(&mxs_ts_driver);
+}
+
+static void __exit mxs_ts_exit(void)
+{
+	platform_driver_unregister(&mxs_ts_driver);
+}
+
+module_init(mxs_ts_init);
+module_exit(mxs_ts_exit);
+
+MODULE_DESCRIPTION("MXS touchscreen driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index d593878..ab89b1b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -499,6 +499,9 @@ config USB_SWITCH_FSA9480
 	  stereo and mono audio, video, microphone and UART data to use
 	  a common connector port.
 
+config MXS_LRADC
+	tristate "ARM MXS LRADC Support"
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index b26495a..0ce0017 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -47,4 +47,5 @@ obj-$(CONFIG_AB8500_PWM)	+= ab8500-pwm.o
 obj-y				+= lis3lv02d/
 obj-y				+= carma/
 obj-$(CONFIG_USB_SWITCH_FSA9480) += fsa9480.o
+obj-$(CONFIG_MXS_LRADC)		+= mxs_lradc.o
 obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
diff --git a/drivers/misc/mxs_lradc.c b/drivers/misc/mxs_lradc.c
new file mode 100644
index 0000000..cc32fac
--- /dev/null
+++ b/drivers/misc/mxs_lradc.c
@@ -0,0 +1,381 @@
+/*
+ * Freescale STMP37XX/STMP378X LRADC helper routines
+ *
+ * Embedded Alley Solutions, Inc <source@embeddedalley.com>
+ *
+ * Copyright 2008-2010 Freescale Semiconductor, Inc.
+ * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sysdev.h>
+#include <linux/platform_device.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/delay.h>
+
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+#include <mach/mxs.h>
+#include <mach/regs-lradc.h>
+#include <mach/lradc.h>
+
+struct lradc_device {
+	struct sys_device sys;
+	unsigned int base;
+	unsigned int vddio_voltage;
+	unsigned int battery_voltage;
+};
+
+static int channels[8];
+
+static __refdata struct lradc_device mxs_lradc;
+
+int hw_lradc_use_channel(int channel)
+{
+	if (channel < 0 || channel > 7)
+		return -EINVAL;
+	channels[channel]++;
+	return 0;
+}
+EXPORT_SYMBOL(hw_lradc_use_channel);
+
+int hw_lradc_unuse_channel(int channel)
+{
+	if (channel < 0 || channel > 7)
+		return -EINVAL;
+	channels[channel]--;
+	return 0;
+}
+EXPORT_SYMBOL(hw_lradc_unuse_channel);
+
+void hw_lradc_reinit(int enable_ground_ref, unsigned freq)
+{
+	__raw_writel(BM_LRADC_CTRL0_SFTRST,
+		     mxs_lradc.base + HW_LRADC_CTRL0_SET);
+	udelay(1);
+	__raw_writel(BM_LRADC_CTRL0_SFTRST,
+		     mxs_lradc.base + HW_LRADC_CTRL0_CLR);
+
+	/* Clear the Clock Gate for normal operation */
+	__raw_writel(BM_LRADC_CTRL0_CLKGATE,
+		     mxs_lradc.base + HW_LRADC_CTRL0_CLR);
+
+	if (enable_ground_ref)
+		__raw_writel(BM_LRADC_CTRL0_ONCHIP_GROUNDREF,
+			     mxs_lradc.base + HW_LRADC_CTRL0_SET);
+	else
+		__raw_writel(BM_LRADC_CTRL0_ONCHIP_GROUNDREF,
+			    mxs_lradc.base + HW_LRADC_CTRL0_CLR);
+
+	__raw_writel(BM_LRADC_CTRL3_CYCLE_TIME,
+		     mxs_lradc.base + HW_LRADC_CTRL3_CLR);
+	__raw_writel(BF_LRADC_CTRL3_CYCLE_TIME(freq),
+		     mxs_lradc.base + HW_LRADC_CTRL3_SET);
+
+	__raw_writel(BM_LRADC_CTRL4_LRADC6SELECT | BM_LRADC_CTRL4_LRADC7SELECT,
+		     mxs_lradc.base + HW_LRADC_CTRL4_CLR);
+	__raw_writel(BF_LRADC_CTRL4_LRADC6SELECT(mxs_lradc.vddio_voltage),
+		     mxs_lradc.base + HW_LRADC_CTRL4_SET);
+	__raw_writel(BF_LRADC_CTRL4_LRADC7SELECT(mxs_lradc.battery_voltage),
+		     mxs_lradc.base + HW_LRADC_CTRL4_SET);
+}
+
+int hw_lradc_init_ladder(int channel, int trigger, unsigned sampling)
+{
+	/*
+	 * check if the lradc channel is present in this product
+	 */
+	if (!hw_lradc_present(channel))
+		return -ENODEV;
+
+	hw_lradc_configure_channel(channel, !0 /* div2 */ ,
+				   0 /* acc */ ,
+				   0 /* num_samples */);
+
+	/* Setup the trigger loop forever */
+	hw_lradc_set_delay_trigger(trigger, 1 << channel,
+				   1 << trigger, 0, sampling);
+
+	/* Clear the accumulator & NUM_SAMPLES */
+	__raw_writel(0xFFFFFFFF, mxs_lradc.base + HW_LRADC_CHn_CLR(channel));
+	return 0;
+}
+EXPORT_SYMBOL(hw_lradc_init_ladder);
+
+int hw_lradc_stop_ladder(int channel, int trigger)
+{
+	/*
+	 * check if the lradc channel is present in this product
+	 */
+	if (!hw_lradc_present(channel))
+		return -ENODEV;
+	hw_lradc_clear_delay_trigger(trigger, 1 << channel, 1 << trigger);
+	return 0;
+}
+EXPORT_SYMBOL(hw_lradc_stop_ladder);
+
+int hw_lradc_present(int channel)
+{
+	if (channel < 0 || channel > 7)
+		return 0;
+	return __raw_readl(mxs_lradc.base + HW_LRADC_STATUS)
+	    & (1 << (16 + channel));
+}
+EXPORT_SYMBOL(hw_lradc_present);
+
+void hw_lradc_configure_channel(int channel, int enable_div2,
+				int enable_acc, int samples)
+{
+	if (enable_div2)
+		__raw_writel(BF_LRADC_CTRL2_DIVIDE_BY_TWO(1 << channel),
+			     mxs_lradc.base + HW_LRADC_CTRL2_SET);
+	else
+		__raw_writel(BF_LRADC_CTRL2_DIVIDE_BY_TWO(1 << channel),
+			     mxs_lradc.base + HW_LRADC_CTRL2_CLR);
+
+	/* Clear the accumulator & NUM_SAMPLES */
+	__raw_writel(0xFFFFFFFF, mxs_lradc.base + HW_LRADC_CHn_CLR(channel));
+
+	/* Sets NUM_SAMPLES bitfield of HW_LRADC_CHn register. */
+	__raw_writel(BM_LRADC_CHn_NUM_SAMPLES,
+		     mxs_lradc.base + HW_LRADC_CHn_CLR(channel));
+	__raw_writel(BF_LRADC_CHn_NUM_SAMPLES(samples),
+		     mxs_lradc.base + HW_LRADC_CHn_SET(channel));
+
+	if (enable_acc)
+		__raw_writel(BM_LRADC_CHn_ACCUMULATE,
+			     mxs_lradc.base + HW_LRADC_CHn_SET(channel));
+	else
+		__raw_writel(BM_LRADC_CHn_ACCUMULATE,
+			     mxs_lradc.base + HW_LRADC_CHn_CLR(channel));
+}
+EXPORT_SYMBOL(hw_lradc_configure_channel);
+
+void hw_lradc_set_delay_trigger(int trigger, u32 trigger_lradc,
+				u32 delay_triggers, u32 loops, u32 delays)
+{
+	/* set TRIGGER_LRADCS in HW_LRADC_DELAYn */
+	__raw_writel(BF_LRADC_DELAYn_TRIGGER_LRADCS(trigger_lradc),
+		     mxs_lradc.base + HW_LRADC_DELAYn_SET(trigger));
+	__raw_writel(BF_LRADC_DELAYn_TRIGGER_DELAYS(delay_triggers),
+		     mxs_lradc.base + HW_LRADC_DELAYn_SET(trigger));
+
+	__raw_writel(BM_LRADC_DELAYn_LOOP_COUNT | BM_LRADC_DELAYn_DELAY,
+		     mxs_lradc.base + HW_LRADC_DELAYn_CLR(trigger));
+	__raw_writel(BF_LRADC_DELAYn_LOOP_COUNT(loops),
+		     mxs_lradc.base  + HW_LRADC_DELAYn_SET(trigger));
+	__raw_writel(BF_LRADC_DELAYn_DELAY(delays),
+		     mxs_lradc.base + HW_LRADC_DELAYn_SET(trigger));
+}
+EXPORT_SYMBOL(hw_lradc_set_delay_trigger);
+
+void hw_lradc_clear_delay_trigger(int trigger, u32 trigger_lradc,
+				  u32 delay_triggers)
+{
+	__raw_writel(BF_LRADC_DELAYn_TRIGGER_LRADCS(trigger_lradc),
+		     mxs_lradc.base + HW_LRADC_DELAYn_CLR(trigger));
+	__raw_writel(BF_LRADC_DELAYn_TRIGGER_DELAYS(delay_triggers),
+		     mxs_lradc.base + HW_LRADC_DELAYn_CLR(trigger));
+}
+EXPORT_SYMBOL(hw_lradc_clear_delay_trigger);
+
+void hw_lradc_set_delay_trigger_kick(int trigger, int value)
+{
+	if (value)
+		__raw_writel(BM_LRADC_DELAYn_KICK,
+			     mxs_lradc.base + HW_LRADC_DELAYn_SET(trigger));
+	else
+		__raw_writel(BM_LRADC_DELAYn_KICK,
+			     mxs_lradc.base + HW_LRADC_DELAYn_CLR(trigger));
+}
+EXPORT_SYMBOL(hw_lradc_set_delay_trigger_kick);
+
+u32 hw_lradc_vddio(void)
+{
+	/* Clear the Soft Reset and Clock Gate for normal operation */
+	__raw_writel(BM_LRADC_CTRL0_SFTRST | BM_LRADC_CTRL0_CLKGATE,
+		     mxs_lradc.base + HW_LRADC_CTRL0_CLR);
+
+	/*
+	 * Clear the divide by two for channel 6 since
+	 * it has a HW divide-by-two built in.
+	 */
+	__raw_writel(BF_LRADC_CTRL2_DIVIDE_BY_TWO(1 << VDDIO_VOLTAGE_CH),
+		     mxs_lradc.base + HW_LRADC_CTRL2_CLR);
+
+	/* Clear the accumulator & NUM_SAMPLES */
+	__raw_writel(0xFFFFFFFF,
+		     mxs_lradc.base + HW_LRADC_CHn_CLR(VDDIO_VOLTAGE_CH));
+
+	/* Clear the interrupt flag */
+	__raw_writel(BM_LRADC_CTRL1_LRADC6_IRQ,
+		     mxs_lradc.base + HW_LRADC_CTRL1_CLR);
+
+	/*
+	 * Get VddIO; this is the max scale value for the button resistor
+	 * ladder.
+	 * schedule ch 6:
+	 */
+	__raw_writel(BF_LRADC_CTRL0_SCHEDULE(1 << VDDIO_VOLTAGE_CH),
+		     mxs_lradc.base + HW_LRADC_CTRL0_SET);
+
+	/* wait for completion */
+	while ((__raw_readl(mxs_lradc.base + HW_LRADC_CTRL1)
+		& BM_LRADC_CTRL1_LRADC6_IRQ) != BM_LRADC_CTRL1_LRADC6_IRQ)
+		cpu_relax();
+
+	/* Clear the interrupt flag */
+	__raw_writel(BM_LRADC_CTRL1_LRADC6_IRQ,
+		     mxs_lradc.base + HW_LRADC_CTRL1_CLR);
+
+	/* read ch 6 value. */
+	return __raw_readl(mxs_lradc.base + HW_LRADC_CHn(VDDIO_VOLTAGE_CH)) &
+			   BM_LRADC_CHn_VALUE;
+}
+EXPORT_SYMBOL(hw_lradc_vddio);
+
+#ifdef CONFIG_PM
+static u32 lradc_registers[0x16];
+static int do_gate;
+
+static int hw_lradc_suspend(struct device *dev, pm_message_t state)
+{
+	int i;
+
+	do_gate = 1;
+	for (i = 0; i < ARRAY_SIZE(channels); i++)
+		if (channels[i] > 0) {
+			do_gate = 0;
+			break;
+		}
+
+	for (i = 0; i < ARRAY_SIZE(lradc_registers); i++)
+		lradc_registers[i] = __raw_readl(mxs_lradc.base + (i << 4));
+
+	if (do_gate)
+		__raw_writel(BM_LRADC_CTRL0_CLKGATE,
+			     mxs_lradc.base + HW_LRADC_CTRL0_SET);
+	return 0;
+}
+
+static int hw_lradc_resume(struct device *dev)
+{
+	int i;
+
+	if (do_gate) {
+		__raw_writel(BM_LRADC_CTRL0_SFTRST,
+			     mxs_lradc.base + HW_LRADC_CTRL0_SET);
+		udelay(10);
+		__raw_writel(BM_LRADC_CTRL0_SFTRST |
+			     BM_LRADC_CTRL0_CLKGATE,
+			     mxs_lradc.base + HW_LRADC_CTRL0_CLR);
+	}
+	for (i = 0; i < ARRAY_SIZE(lradc_registers); i++)
+		__raw_writel(lradc_registers[i], mxs_lradc.base + (i << 4));
+	return 0;
+}
+
+#endif
+
+static struct sysdev_class mxs_lradc_sysclass = {
+	.name = "mxs-lradc",
+};
+
+static int lradc_freq = LRADC_CLOCK_6MHZ;
+
+static int __init lradc_freq_setup(char *str)
+{
+	long freq;
+
+	if (kstrtol(str, 0, &freq) < 0)
+		return 0;
+
+	if (freq < 0)
+		return 0;
+	if (freq >= 6)
+		lradc_freq = LRADC_CLOCK_6MHZ;
+	else if (freq >= 4)
+		lradc_freq = LRADC_CLOCK_4MHZ;
+	else if (freq >= 3)
+		lradc_freq = LRADC_CLOCK_3MHZ;
+	else if (freq >= 2)
+		lradc_freq = LRADC_CLOCK_2MHZ;
+	else
+		return 0;
+	return 1;
+}
+
+__setup("lradc_freq=", lradc_freq_setup);
+
+static int __devinit mxs_lradc_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct mxs_lradc_plat_data *plat_data;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL)
+		return -ENODEV;
+
+	plat_data = (struct mxs_lradc_plat_data *)(pdev->dev.platform_data);
+	if (plat_data == NULL)
+		return -EFAULT;
+
+	mxs_lradc.base = (unsigned int)MXS_IO_ADDRESS(res->start);
+	mxs_lradc.sys.id = -1;
+	mxs_lradc.sys.cls = &mxs_lradc_sysclass;
+	mxs_lradc.vddio_voltage = plat_data->vddio_voltage;
+	mxs_lradc.battery_voltage = plat_data->battery_voltage;
+	hw_lradc_reinit(0, lradc_freq);
+	return sysdev_register(&mxs_lradc.sys);
+}
+
+static int __devexit mxs_lradc_remove(struct platform_device *pdev)
+{
+	sysdev_unregister(&mxs_lradc.sys);
+	return 0;
+}
+
+static __refdata struct platform_driver mxs_lradc_drv = {
+	.probe = mxs_lradc_probe,
+	.remove = __devexit_p(mxs_lradc_remove),
+	.driver = {
+		.name = "mxs-lradc",
+		.owner = THIS_MODULE,
+#ifdef CONFIG_PM
+		.suspend = hw_lradc_suspend,
+		.resume = hw_lradc_resume,
+#endif
+	}
+};
+
+static int __init hw_lradc_init(void)
+{
+	sysdev_class_register(&mxs_lradc_sysclass);
+	platform_driver_register(&mxs_lradc_drv);
+	return 0;
+}
+
+static void __exit hw_lradc_exit(void)
+{
+	platform_driver_unregister(&mxs_lradc_drv);
+	sysdev_class_unregister(&mxs_lradc_sysclass);
+}
+
+subsys_initcall(hw_lradc_init);
+module_exit(hw_lradc_exit);
+
+MODULE_DESCRIPTION("MXS low resolution ADC");
+MODULE_LICENSE("GPL");
-- 
1.7.5.4
