From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 11 Mar 2011 16:08:05 -0700
Subject: [PATCH 03/10] ux500: Adding custom pin configuration file for
	snowball. - Adding dependency in Makefile. - Adding init
	function call to board-snowball.c - New header file.
In-Reply-To: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1299884892-6766-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/mach-ux500/Makefile              |    1 +
 arch/arm/mach-ux500/board-snowball-pins.c |  133 +++++++++++++++++++++++++++++
 arch/arm/mach-ux500/board-snowball.c      |    4 +-
 arch/arm/mach-ux500/board-snowball.h      |   18 ++++
 4 files changed, 155 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-snowball-pins.c
 create mode 100644 arch/arm/mach-ux500/board-snowball.h

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 60c26c6..d74f303 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
 				board-mop500-u8500uib.o \
 				board-mop500-pins.o
 obj-$(CONFIG_MACH_U8500_SNOWBALL) += board-snowball.o \
+				board-snowball-pins.o \
 				board-mop500-regulators.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
diff --git a/arch/arm/mach-ux500/board-snowball-pins.c b/arch/arm/mach-ux500/board-snowball-pins.c
new file mode 100644
index 0000000..216fd50
--- /dev/null
+++ b/arch/arm/mach-ux500/board-snowball-pins.c
@@ -0,0 +1,133 @@
+/*
+ * Copyright (C) 2011-2012 ST-Ericsson
+ *
+ * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/gpio.h>
+
+#include <plat/pincfg.h>
+
+#include <mach/hardware.h>
+
+#include "pins-db8500.h"
+
+static pin_cfg_t snowball_pins[] = {
+	/* I2C */
+	GPIO147_I2C0_SCL,
+	GPIO148_I2C0_SDA,
+	GPIO16_I2C1_SCL,
+	GPIO17_I2C1_SDA,
+	GPIO10_I2C2_SDA,
+	GPIO11_I2C2_SCL,
+	GPIO229_I2C3_SDA,
+	GPIO230_I2C3_SCL,
+
+        /* SSP0, to AB8500 */
+	GPIO143_SSP0_CLK,
+	GPIO144_SSP0_FRM,
+	GPIO145_SSP0_RXD	| PIN_PULL_DOWN,
+	GPIO146_SSP0_TXD,
+
+	/* MSP0: BT */
+	GPIO12_MSP0_TXD,
+	GPIO13_MSP0_TFS,
+	GPIO14_MSP0_TCK,
+	GPIO15_MSP0_RXD,
+
+	/* MSP2: HDMI */
+	GPIO193_MSP2_TXD,
+	GPIO194_MSP2_TCK,
+	GPIO195_MSP2_TFS,
+	GPIO196_MSP2_RXD	| PIN_OUTPUT_LOW,
+
+	/* MMC0: MicroSD card */
+	GPIO18_MC0_CMDDIR	| PIN_OUTPUT_HIGH,
+	GPIO19_MC0_DAT0DIR	| PIN_OUTPUT_HIGH,
+	GPIO20_MC0_DAT2DIR	| PIN_OUTPUT_HIGH,
+	GPIO21_MC0_DAT31DIR	| PIN_OUTPUT_HIGH,
+	GPIO22_MC0_FBCLK	| PIN_INPUT_NOPULL,
+	GPIO23_MC0_CLK		| PIN_OUTPUT_LOW,
+	GPIO24_MC0_CMD		| PIN_INPUT_PULLUP,
+	GPIO25_MC0_DAT0		| PIN_INPUT_PULLUP,
+	GPIO26_MC0_DAT1		| PIN_INPUT_PULLUP,
+	GPIO27_MC0_DAT2		| PIN_INPUT_PULLUP,
+	GPIO28_MC0_DAT3		| PIN_INPUT_PULLUP,
+
+	/* SDI1: WLAN */
+	GPIO208_MC1_CLK		| PIN_OUTPUT_LOW,
+	GPIO209_MC1_FBCLK	| PIN_INPUT_NOPULL,
+	GPIO210_MC1_CMD		| PIN_INPUT_PULLUP,
+	GPIO211_MC1_DAT0	| PIN_INPUT_PULLUP,
+	GPIO212_MC1_DAT1	| PIN_INPUT_PULLUP,
+	GPIO213_MC1_DAT2	| PIN_INPUT_PULLUP,
+	GPIO214_MC1_DAT3	| PIN_INPUT_PULLUP,
+
+	/* MMC2: LAN */
+	GPIO86_SM_ADQ0,
+	GPIO87_SM_ADQ1,
+	GPIO88_SM_ADQ2,
+	GPIO89_SM_ADQ3,
+	GPIO90_SM_ADQ4,
+	GPIO91_SM_ADQ5,
+	GPIO92_SM_ADQ6,
+	GPIO93_SM_ADQ7,
+
+	GPIO94_SM_ADVn,
+	GPIO95_SM_CS0n,
+	GPIO96_SM_OEn,
+	GPIO97_SM_WEn,
+
+	GPIO128_SM_CKO,
+	GPIO130_SM_FBCLK,
+	GPIO131_SM_ADQ8,
+	GPIO132_SM_ADQ9,
+	GPIO133_SM_ADQ10,
+	GPIO134_SM_ADQ11,
+	GPIO135_SM_ADQ12,
+	GPIO136_SM_ADQ13,
+	GPIO137_SM_ADQ14,
+	GPIO138_SM_ADQ15,
+
+	/* RSTn_LAN */
+	GPIO141_GPIO		| PIN_OUTPUT_HIGH,
+
+	/* MMC4: eMMC */
+	GPIO197_MC4_DAT3	| PIN_INPUT_PULLUP,
+	GPIO198_MC4_DAT2	| PIN_INPUT_PULLUP,
+	GPIO199_MC4_DAT1	| PIN_INPUT_PULLUP,
+	GPIO200_MC4_DAT0	| PIN_INPUT_PULLUP,
+	GPIO201_MC4_CMD		| PIN_INPUT_PULLUP,
+	GPIO202_MC4_FBCLK	| PIN_INPUT_NOPULL,
+	GPIO203_MC4_CLK		| PIN_OUTPUT_LOW,
+	GPIO204_MC4_DAT7	| PIN_INPUT_PULLUP,
+	GPIO205_MC4_DAT6	| PIN_INPUT_PULLUP,
+	GPIO206_MC4_DAT5	| PIN_INPUT_PULLUP,
+	GPIO207_MC4_DAT4	| PIN_INPUT_PULLUP,
+
+	GPIO141_GPIO		| PIN_OUTPUT_HIGH, /* RSTn_LAN */
+
+	/* UART: WLAN */
+	GPIO0_U0_CTSn	| PIN_INPUT_PULLUP,
+	GPIO1_U0_RTSn	| PIN_OUTPUT_HIGH,
+	GPIO2_U0_RXD	| PIN_INPUT_PULLUP,
+	GPIO3_U0_TXD	| PIN_OUTPUT_HIGH,
+
+	/* UART: DBG port */
+	GPIO29_U2_RXD	| PIN_INPUT_PULLUP,
+	GPIO30_U2_TXD	| PIN_OUTPUT_HIGH,
+	GPIO31_U2_CTSn	| PIN_INPUT_PULLUP,
+	GPIO32_U2_RTSn	| PIN_OUTPUT_HIGH,
+};
+
+void __init snowball_pins_init(void)
+{
+	nmk_config_pins(snowball_pins,
+				ARRAY_SIZE(snowball_pins));
+}
diff --git a/arch/arm/mach-ux500/board-snowball.c b/arch/arm/mach-ux500/board-snowball.c
index 620f132..3b351ef 100644
--- a/arch/arm/mach-ux500/board-snowball.c
+++ b/arch/arm/mach-ux500/board-snowball.c
@@ -36,7 +36,7 @@
 
 #include "ste-dma40-db8500.h"
 #include "devices-db8500.h"
-#include "board-mop500.h"
+#include "board-snowball.h"
 #include "board-mop500-regulators.h"
 
 static struct ab8500_platform_data ab8500_platdata = {
@@ -238,6 +238,8 @@ static void __init mop500_init_machine(void)
 {
 	u8500_init_devices();
 
+	snowball_pins_init();
+
 	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
 
 	mop500_i2c_init();
diff --git a/arch/arm/mach-ux500/board-snowball.h b/arch/arm/mach-ux500/board-snowball.h
new file mode 100644
index 0000000..fe08f7e
--- /dev/null
+++ b/arch/arm/mach-ux500/board-snowball.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __BOARD_SNOWBALL_H
+#define __BOARD_SNOWBALL_H
+
+struct i2c_board_info;
+
+extern void mop500_sdi_init(void);
+void __init snowball_pins_init(void);
+
+void mop500_uib_i2c_add(int busnum, struct i2c_board_info *info,
+		unsigned n);
+
+#endif
-- 
1.7.1
