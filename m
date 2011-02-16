From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 16 Feb 2011 09:06:53 +0100
Subject: [PATCH 1/3] mach-ux500: move MOP500 pins to separate file
Message-ID: <1297843613-6728-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

Split off pin definitions for the MOP500 board family to its
own file.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Makefile            |    3 +-
 arch/arm/mach-ux500/board-mop500-pins.c |   80 +++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/board-mop500.c      |   63 +------------------------
 arch/arm/mach-ux500/board-mop500.h      |    1 +
 4 files changed, 84 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-pins.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index eec3279..b549a8f 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -9,7 +9,8 @@ obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o prcmu.o
 obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
 				board-mop500-regulators.o \
 				board-mop500-uib.o board-mop500-stuib.o \
-				board-mop500-u8500uib.o
+				board-mop500-u8500uib.o \
+				board-mop500-pins.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
new file mode 100644
index 0000000..edd3a6b
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
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
+static pin_cfg_t mop500_pins[] = {
+	/* SSP0 */
+	GPIO143_SSP0_CLK,
+	GPIO144_SSP0_FRM,
+	GPIO145_SSP0_RXD,
+	GPIO146_SSP0_TXD,
+
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
+	/* SKE keypad */
+	GPIO153_KP_I7,
+	GPIO154_KP_I6,
+	GPIO155_KP_I5,
+	GPIO156_KP_I4,
+	GPIO157_KP_O7,
+	GPIO158_KP_O6,
+	GPIO159_KP_O5,
+	GPIO160_KP_O4,
+	GPIO161_KP_I3,
+	GPIO162_KP_I2,
+	GPIO163_KP_I1,
+	GPIO164_KP_I0,
+	GPIO165_KP_O3,
+	GPIO166_KP_O2,
+	GPIO167_KP_O1,
+	GPIO168_KP_O0,
+
+	/* GPIO_EXP_INT */
+	GPIO217_GPIO,
+
+	/* STMPE1601 IRQ */
+	GPIO218_GPIO    | PIN_INPUT_PULLUP,
+
+	/* touch screen */
+	GPIO84_GPIO     | PIN_INPUT_PULLUP,
+
+	/* USB OTG */
+	GPIO256_USB_NXT		| PIN_PULL_DOWN,
+	GPIO257_USB_STP		| PIN_PULL_UP,
+	GPIO258_USB_XCLK	| PIN_PULL_DOWN,
+	GPIO259_USB_DIR		| PIN_PULL_DOWN,
+	GPIO260_USB_DAT7	| PIN_PULL_DOWN,
+	GPIO261_USB_DAT6	| PIN_PULL_DOWN,
+	GPIO262_USB_DAT5	| PIN_PULL_DOWN,
+	GPIO263_USB_DAT4	| PIN_PULL_DOWN,
+	GPIO264_USB_DAT3	| PIN_PULL_DOWN,
+	GPIO265_USB_DAT2	| PIN_PULL_DOWN,
+	GPIO266_USB_DAT1	| PIN_PULL_DOWN,
+	GPIO267_USB_DAT0	| PIN_PULL_DOWN,
+};
+
+void __init mop500_pins_init(void)
+{
+	nmk_config_pins(mop500_pins,
+				ARRAY_SIZE(mop500_pins));
+}
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 67d9c63..72448e1 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -28,7 +28,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <plat/pincfg.h>
 #include <plat/i2c.h>
 #include <plat/ste_dma40.h>
 
@@ -39,69 +38,9 @@
 
 #include "ste-dma40-db8500.h"
 #include "devices-db8500.h"
-#include "pins-db8500.h"
 #include "board-mop500.h"
 #include "board-mop500-regulators.h"
 
-static pin_cfg_t mop500_pins[] = {
-	/* SSP0 */
-	GPIO143_SSP0_CLK,
-	GPIO144_SSP0_FRM,
-	GPIO145_SSP0_RXD,
-	GPIO146_SSP0_TXD,
-
-	/* I2C */
-	GPIO147_I2C0_SCL,
-	GPIO148_I2C0_SDA,
-	GPIO16_I2C1_SCL,
-	GPIO17_I2C1_SDA,
-	GPIO10_I2C2_SDA,
-	GPIO11_I2C2_SCL,
-	GPIO229_I2C3_SDA,
-	GPIO230_I2C3_SCL,
-
-	/* SKE keypad */
-	GPIO153_KP_I7,
-	GPIO154_KP_I6,
-	GPIO155_KP_I5,
-	GPIO156_KP_I4,
-	GPIO157_KP_O7,
-	GPIO158_KP_O6,
-	GPIO159_KP_O5,
-	GPIO160_KP_O4,
-	GPIO161_KP_I3,
-	GPIO162_KP_I2,
-	GPIO163_KP_I1,
-	GPIO164_KP_I0,
-	GPIO165_KP_O3,
-	GPIO166_KP_O2,
-	GPIO167_KP_O1,
-	GPIO168_KP_O0,
-
-	/* GPIO_EXP_INT */
-	GPIO217_GPIO,
-
-	/* STMPE1601 IRQ */
-	GPIO218_GPIO    | PIN_INPUT_PULLUP,
-
-	/* touch screen */
-	GPIO84_GPIO	| PIN_INPUT_PULLUP,
-
-	/* USB OTG */
-	GPIO256_USB_NXT		| PIN_PULL_DOWN,
-	GPIO257_USB_STP		| PIN_PULL_UP,
-	GPIO258_USB_XCLK	| PIN_PULL_DOWN,
-	GPIO259_USB_DIR		| PIN_PULL_DOWN,
-	GPIO260_USB_DAT7	| PIN_PULL_DOWN,
-	GPIO261_USB_DAT6	| PIN_PULL_DOWN,
-	GPIO262_USB_DAT5	| PIN_PULL_DOWN,
-	GPIO263_USB_DAT4	| PIN_PULL_DOWN,
-	GPIO264_USB_DAT3	| PIN_PULL_DOWN,
-	GPIO265_USB_DAT2	| PIN_PULL_DOWN,
-	GPIO266_USB_DAT1	| PIN_PULL_DOWN,
-	GPIO267_USB_DAT0	| PIN_PULL_DOWN,
-};
-
 static struct ab8500_platform_data ab8500_platdata = {
 	.irq_base	= MOP500_AB8500_IRQ_BASE,
 	.regulator	= ab8500_regulators,
@@ -444,7 +383,7 @@ static void __init u8500_init_machine(void)
 {
 	u8500_init_devices();
 
-	nmk_config_pins(mop500_pins, ARRAY_SIZE(mop500_pins));
+	mop500_pins_init();
 
 	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
 
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index 19b6c27..48abca7 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -22,6 +22,7 @@ extern void mop500_sdi_init(void);
 extern void mop500_sdi_tc35892_init(void);
 void __init mop500_u8500uib_init(void);
 void __init mop500_stuib_init(void);
+void __init mop500_pins_init(void);
 
 void mop500_uib_i2c_add(int busnum, struct i2c_board_info *info,
 		unsigned n);
-- 
1.7.3.2
