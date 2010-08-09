From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 9 Aug 2010 19:18:15 +0530
Subject: [PATCH 2/4] ux500: mop500: register eMMC devices
In-Reply-To: <1281361697-4874-1-git-send-email-rabin.vincent@stericsson.com>
References: <1281361697-4874-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1281361697-4874-2-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanumath Prasad <hanumath.prasad@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Hanumath Prasad <hanumath.prasad@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/Makefile           |    2 +-
 arch/arm/mach-ux500/board-mop500-sdi.c |   91 ++++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/board-mop500.c     |    3 +
 arch/arm/mach-ux500/board-mop500.h     |   12 ++++
 arch/arm/mach-ux500/pins-db8500.h      |   66 ++++++++++++------------
 5 files changed, 140 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-sdi.c
 create mode 100644 arch/arm/mach-ux500/board-mop500.h

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 4556aea..33903af 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -5,7 +5,7 @@
 obj-y				:= clock.o cpu.o devices.o
 obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o devices-db5500.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
-obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o
+obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o board-mop500-sdi.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
new file mode 100644
index 0000000..bac9956
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -0,0 +1,91 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Hanumath Prasad <hanumath.prasad@stericsson.com>
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/kernel.h>
+#include <linux/gpio.h>
+#include <linux/amba/bus.h>
+#include <linux/amba/mmci.h>
+#include <linux/mmc/host.h>
+#include <linux/platform_device.h>
+
+#include <plat/pincfg.h>
+#include <mach/devices.h>
+#include <mach/hardware.h>
+
+#include "pins-db8500.h"
+#include "board-mop500.h"
+
+static pin_cfg_t mop500_sdi_pins[] = {
+	/* SDI4 (on-board eMMC) */
+	GPIO197_MC4_DAT3,
+	GPIO198_MC4_DAT2,
+	GPIO199_MC4_DAT1,
+	GPIO200_MC4_DAT0,
+	GPIO201_MC4_CMD,
+	GPIO202_MC4_FBCLK,
+	GPIO203_MC4_CLK,
+	GPIO204_MC4_DAT7,
+	GPIO205_MC4_DAT6,
+	GPIO206_MC4_DAT5,
+	GPIO207_MC4_DAT4,
+};
+
+static pin_cfg_t mop500_sdi2_pins[] = {
+	/* SDI2 (POP eMMC) */
+	GPIO128_MC2_CLK,
+	GPIO129_MC2_CMD,
+	GPIO130_MC2_FBCLK,
+	GPIO131_MC2_DAT0,
+	GPIO132_MC2_DAT1,
+	GPIO133_MC2_DAT2,
+	GPIO134_MC2_DAT3,
+	GPIO135_MC2_DAT4,
+	GPIO136_MC2_DAT5,
+	GPIO137_MC2_DAT6,
+	GPIO138_MC2_DAT7,
+};
+
+/*
+ * SDI 2 (POP eMMC, not on DB8500ed)
+ */
+
+static struct mmci_platform_data mop500_sdi2_data = {
+	.ocr_mask	= MMC_VDD_165_195,
+	.f_max		= 100000000,
+	.capabilities	= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+	.gpio_cd	= -1,
+	.gpio_wp	= -1,
+};
+
+/*
+ * SDI 4 (on-board eMMC)
+ */
+
+static struct mmci_platform_data mop500_sdi4_data = {
+	.ocr_mask	= MMC_VDD_29_30,
+	.f_max		= 100000000,
+	.capabilities	= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
+			  MMC_CAP_MMC_HIGHSPEED,
+	.gpio_cd	= -1,
+	.gpio_wp	= -1,
+};
+
+void mop500_sdi_init(void)
+{
+	nmk_config_pins(mop500_sdi_pins, ARRAY_SIZE(mop500_sdi_pins));
+
+	u8500_sdi2_device.dev.platform_data = &mop500_sdi2_data;
+	u8500_sdi4_device.dev.platform_data = &mop500_sdi4_data;
+
+	if (!cpu_is_u8500ed()) {
+		nmk_config_pins(mop500_sdi2_pins, ARRAY_SIZE(mop500_sdi2_pins));
+		amba_device_register(&u8500_sdi2_device, &iomem_resource);
+	}
+
+	/* On-board eMMC */
+	amba_device_register(&u8500_sdi4_device, &iomem_resource);
+}
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 0e8fd13..de31032 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -30,6 +30,7 @@
 #include <mach/devices.h>
 
 #include "pins-db8500.h"
+#include "board-mop500.h"
 
 static pin_cfg_t mop500_pins[] = {
 	/* SSP0 */
@@ -163,6 +164,8 @@ static void __init u8500_init_machine(void)
 
 	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
 
+	mop500_sdi_init();
+
 	spi_register_board_info(u8500_spi_devices,
 			ARRAY_SIZE(u8500_spi_devices));
 }
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
new file mode 100644
index 0000000..2d24032
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -0,0 +1,12 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __BOARD_MOP500_H
+#define __BOARD_MOP500_H
+
+extern void mop500_sdi_init(void);
+
+#endif
diff --git a/arch/arm/mach-ux500/pins-db8500.h b/arch/arm/mach-ux500/pins-db8500.h
index 9055d5d..66f8761 100644
--- a/arch/arm/mach-ux500/pins-db8500.h
+++ b/arch/arm/mach-ux500/pins-db8500.h
@@ -96,57 +96,57 @@
 #define GPIO17_SLIM0_CLK	PIN_CFG(17, ALT_C)
 
 #define GPIO18_GPIO		PIN_CFG(18, GPIO)
-#define GPIO18_MC0_CMDDIR	PIN_CFG(18, ALT_A)
+#define GPIO18_MC0_CMDDIR	PIN_CFG_PULL(18, ALT_A, UP)
 #define GPIO18_U2_RXD		PIN_CFG(18, ALT_B)
 #define GPIO18_MS_IEP		PIN_CFG(18, ALT_C)
 
 #define GPIO19_GPIO		PIN_CFG(19, GPIO)
-#define GPIO19_MC0_DAT0DIR	PIN_CFG(19, ALT_A)
+#define GPIO19_MC0_DAT0DIR	PIN_CFG_PULL(19, ALT_A, UP)
 #define GPIO19_U2_TXD		PIN_CFG(19, ALT_B)
 #define GPIO19_MS_DAT0DIR	PIN_CFG(19, ALT_C)
 
 #define GPIO20_GPIO		PIN_CFG(20, GPIO)
-#define GPIO20_MC0_DAT2DIR	PIN_CFG(20, ALT_A)
+#define GPIO20_MC0_DAT2DIR	PIN_CFG_PULL(20, ALT_A, UP)
 #define GPIO20_UARTMOD_TXD	PIN_CFG(20, ALT_B)
 #define GPIO20_IP_TRIGOUT	PIN_CFG(20, ALT_C)
 
 #define GPIO21_GPIO		PIN_CFG(21, GPIO)
-#define GPIO21_MC0_DAT31DIR	PIN_CFG(21, ALT_A)
+#define GPIO21_MC0_DAT31DIR	PIN_CFG_PULL(21, ALT_A, UP)
 #define GPIO21_MSP0_SCK		PIN_CFG(21, ALT_B)
 #define GPIO21_MS_DAT31DIR	PIN_CFG(21, ALT_C)
 
 #define GPIO22_GPIO		PIN_CFG(22, GPIO)
-#define GPIO22_MC0_FBCLK	PIN_CFG(22, ALT_A)
+#define GPIO22_MC0_FBCLK	PIN_CFG_PULL(22, ALT_A, UP)
 #define GPIO22_UARTMOD_RXD	PIN_CFG(22, ALT_B)
 #define GPIO22_MS_FBCLK		PIN_CFG(22, ALT_C)
 
 #define GPIO23_GPIO		PIN_CFG(23, GPIO)
-#define GPIO23_MC0_CLK		PIN_CFG(23, ALT_A)
+#define GPIO23_MC0_CLK		PIN_CFG_PULL(23, ALT_A, UP)
 #define GPIO23_STMMOD_CLK	PIN_CFG(23, ALT_B)
 #define GPIO23_MS_CLK		PIN_CFG(23, ALT_C)
 
 #define GPIO24_GPIO		PIN_CFG(24, GPIO)
-#define GPIO24_MC0_CMD		PIN_CFG(24, ALT_A)
+#define GPIO24_MC0_CMD		PIN_CFG_PULL(24, ALT_A, UP)
 #define GPIO24_UARTMOD_RXD	PIN_CFG(24, ALT_B)
 #define GPIO24_MS_BS		PIN_CFG(24, ALT_C)
 
 #define GPIO25_GPIO		PIN_CFG(25, GPIO)
-#define GPIO25_MC0_DAT0		PIN_CFG(25, ALT_A)
+#define GPIO25_MC0_DAT0		PIN_CFG_PULL(25, ALT_A, UP)
 #define GPIO25_STMMOD_DAT0	PIN_CFG(25, ALT_B)
 #define GPIO25_MS_DAT0		PIN_CFG(25, ALT_C)
 
 #define GPIO26_GPIO		PIN_CFG(26, GPIO)
-#define GPIO26_MC0_DAT1		PIN_CFG(26, ALT_A)
+#define GPIO26_MC0_DAT1		PIN_CFG_PULL(26, ALT_A, UP)
 #define GPIO26_STMMOD_DAT1	PIN_CFG(26, ALT_B)
 #define GPIO26_MS_DAT1		PIN_CFG(26, ALT_C)
 
 #define GPIO27_GPIO		PIN_CFG(27, GPIO)
-#define GPIO27_MC0_DAT2		PIN_CFG(27, ALT_A)
+#define GPIO27_MC0_DAT2		PIN_CFG_PULL(27, ALT_A, UP)
 #define GPIO27_STMMOD_DAT2	PIN_CFG(27, ALT_B)
 #define GPIO27_MS_DAT2		PIN_CFG(27, ALT_C)
 
 #define GPIO28_GPIO		PIN_CFG(28, GPIO)
-#define GPIO28_MC0_DAT3		PIN_CFG(28, ALT_A)
+#define GPIO28_MC0_DAT3		PIN_CFG_PULL(28, ALT_A, UP)
 #define GPIO28_STMMOD_DAT3	PIN_CFG(28, ALT_B)
 #define GPIO28_MS_DAT3		PIN_CFG(28, ALT_C)
 
@@ -357,48 +357,48 @@
 #define GPIO97_MC5_DAT7		PIN_CFG(97, ALT_C)
 
 #define GPIO128_GPIO		PIN_CFG(128, GPIO)
-#define GPIO128_MC2_CLK		PIN_CFG(128, ALT_A)
+#define GPIO128_MC2_CLK		PIN_CFG_PULL(128, ALT_A, UP)
 #define GPIO128_SM_CKO		PIN_CFG(128, ALT_B)
 
 #define GPIO129_GPIO		PIN_CFG(129, GPIO)
-#define GPIO129_MC2_CMD		PIN_CFG(129, ALT_A)
+#define GPIO129_MC2_CMD		PIN_CFG_PULL(129, ALT_A, UP)
 #define GPIO129_SM_WAIT0n	PIN_CFG(129, ALT_B)
 
 #define GPIO130_GPIO		PIN_CFG(130, GPIO)
-#define GPIO130_MC2_FBCLK	PIN_CFG(130, ALT_A)
+#define GPIO130_MC2_FBCLK	PIN_CFG_PULL(130, ALT_A, UP)
 #define GPIO130_SM_FBCLK	PIN_CFG(130, ALT_B)
 #define GPIO130_MC2_RSTN	PIN_CFG(130, ALT_C)
 
 #define GPIO131_GPIO		PIN_CFG(131, GPIO)
-#define GPIO131_MC2_DAT0	PIN_CFG(131, ALT_A)
+#define GPIO131_MC2_DAT0	PIN_CFG_PULL(131, ALT_A, UP)
 #define GPIO131_SM_ADQ8		PIN_CFG(131, ALT_B)
 
 #define GPIO132_GPIO		PIN_CFG(132, GPIO)
-#define GPIO132_MC2_DAT1	PIN_CFG(132, ALT_A)
+#define GPIO132_MC2_DAT1	PIN_CFG_PULL(132, ALT_A, UP)
 #define GPIO132_SM_ADQ9		PIN_CFG(132, ALT_B)
 
 #define GPIO133_GPIO		PIN_CFG(133, GPIO)
-#define GPIO133_MC2_DAT2	PIN_CFG(133, ALT_A)
+#define GPIO133_MC2_DAT2	PIN_CFG_PULL(133, ALT_A, UP)
 #define GPIO133_SM_ADQ10	PIN_CFG(133, ALT_B)
 
 #define GPIO134_GPIO		PIN_CFG(134, GPIO)
-#define GPIO134_MC2_DAT3	PIN_CFG(134, ALT_A)
+#define GPIO134_MC2_DAT3	PIN_CFG_PULL(134, ALT_A, UP)
 #define GPIO134_SM_ADQ11	PIN_CFG(134, ALT_B)
 
 #define GPIO135_GPIO		PIN_CFG(135, GPIO)
-#define GPIO135_MC2_DAT4	PIN_CFG(135, ALT_A)
+#define GPIO135_MC2_DAT4	PIN_CFG_PULL(135, ALT_A, UP)
 #define GPIO135_SM_ADQ12	PIN_CFG(135, ALT_B)
 
 #define GPIO136_GPIO		PIN_CFG(136, GPIO)
-#define GPIO136_MC2_DAT5	PIN_CFG(136, ALT_A)
+#define GPIO136_MC2_DAT5	PIN_CFG_PULL(136, ALT_A, UP)
 #define GPIO136_SM_ADQ13	PIN_CFG(136, ALT_B)
 
 #define GPIO137_GPIO		PIN_CFG(137, GPIO)
-#define GPIO137_MC2_DAT6	PIN_CFG(137, ALT_A)
+#define GPIO137_MC2_DAT6	PIN_CFG_PULL(137, ALT_A, UP)
 #define GPIO137_SM_ADQ14	PIN_CFG(137, ALT_B)
 
 #define GPIO138_GPIO		PIN_CFG(138, GPIO)
-#define GPIO138_MC2_DAT7	PIN_CFG(138, ALT_A)
+#define GPIO138_MC2_DAT7	PIN_CFG_PULL(138, ALT_A, UP)
 #define GPIO138_SM_ADQ15	PIN_CFG(138, ALT_B)
 
 #define GPIO139_GPIO		PIN_CFG(139, GPIO)
@@ -569,39 +569,39 @@
 #define GPIO196_MSP2_RXD	PIN_CFG(196, ALT_A)
 
 #define GPIO197_GPIO		PIN_CFG(197, GPIO)
-#define GPIO197_MC4_DAT3	PIN_CFG(197, ALT_A)
+#define GPIO197_MC4_DAT3	PIN_CFG_PULL(197, ALT_A, UP)
 
 #define GPIO198_GPIO		PIN_CFG(198, GPIO)
-#define GPIO198_MC4_DAT2	PIN_CFG(198, ALT_A)
+#define GPIO198_MC4_DAT2	PIN_CFG_PULL(198, ALT_A, UP)
 
 #define GPIO199_GPIO		PIN_CFG(199, GPIO)
-#define GPIO199_MC4_DAT1	PIN_CFG(199, ALT_A)
+#define GPIO199_MC4_DAT1	PIN_CFG_PULL(199, ALT_A, UP)
 
 #define GPIO200_GPIO		PIN_CFG(200, GPIO)
-#define GPIO200_MC4_DAT0	PIN_CFG(200, ALT_A)
+#define GPIO200_MC4_DAT0	PIN_CFG_PULL(200, ALT_A, UP)
 
 #define GPIO201_GPIO		PIN_CFG(201, GPIO)
-#define GPIO201_MC4_CMD		PIN_CFG(201, ALT_A)
+#define GPIO201_MC4_CMD		PIN_CFG_PULL(201, ALT_A, UP)
 
 #define GPIO202_GPIO		PIN_CFG(202, GPIO)
-#define GPIO202_MC4_FBCLK	PIN_CFG(202, ALT_A)
+#define GPIO202_MC4_FBCLK	PIN_CFG_PULL(202, ALT_A, UP)
 #define GPIO202_PWL		PIN_CFG(202, ALT_B)
 #define GPIO202_MC4_RSTN	PIN_CFG(202, ALT_C)
 
 #define GPIO203_GPIO		PIN_CFG(203, GPIO)
-#define GPIO203_MC4_CLK		PIN_CFG(203, ALT_A)
+#define GPIO203_MC4_CLK		PIN_CFG_PULL(203, ALT_A, UP)
 
 #define GPIO204_GPIO		PIN_CFG(204, GPIO)
-#define GPIO204_MC4_DAT7	PIN_CFG(204, ALT_A)
+#define GPIO204_MC4_DAT7	PIN_CFG_PULL(204, ALT_A, UP)
 
 #define GPIO205_GPIO		PIN_CFG(205, GPIO)
-#define GPIO205_MC4_DAT6	PIN_CFG(205, ALT_A)
+#define GPIO205_MC4_DAT6	PIN_CFG_PULL(205, ALT_A, UP)
 
 #define GPIO206_GPIO		PIN_CFG(206, GPIO)
-#define GPIO206_MC4_DAT5	PIN_CFG(206, ALT_A)
+#define GPIO206_MC4_DAT5	PIN_CFG_PULL(206, ALT_A, UP)
 
 #define GPIO207_GPIO		PIN_CFG(207, GPIO)
-#define GPIO207_MC4_DAT4	PIN_CFG(207, ALT_A)
+#define GPIO207_MC4_DAT4	PIN_CFG_PULL(207, ALT_A, UP)
 
 #define GPIO208_GPIO		PIN_CFG(208, GPIO)
 #define GPIO208_MC1_CLK		PIN_CFG(208, ALT_A)
-- 
1.7.2.dirty
