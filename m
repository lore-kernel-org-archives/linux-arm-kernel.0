From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 16 Feb 2011 09:07:12 +0100
Subject: [PATCH 3/3] mach-ux500: basic HREFv60 support
Message-ID: <1297843632-6806-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The HREFv60 variant of the MOP500 family of boards remove the
external GPIO expander and route these pins back to some of the
readily available internal GPIO pins instead.

Based on a patch by Bibek Basu <bibek.basu@stericsson.com> for
an internal kernel version.

Cc: Bibek Basu <bibek.basu@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c        |   34 +++++++++++++++++++-----
 arch/arm/mach-ux500/board-mop500-stuib.c      |   12 +++++++-
 arch/arm/mach-ux500/board-mop500.c            |   23 ++++++++++++++--
 arch/arm/mach-ux500/board-mop500.h            |   14 +++++++++-
 arch/arm/mach-ux500/include/mach/uncompress.h |    6 +++-
 5 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 68c8375..70a486f 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -12,6 +12,7 @@
 #include <linux/mmc/host.h>
 #include <linux/platform_device.h>
 
+#include <asm/mach-types.h>
 #include <plat/ste_dma40.h>
 #include <mach/devices.h>
 #include <mach/hardware.h>
@@ -68,7 +69,6 @@ static struct mmci_platform_data mop500_sdi0_data = {
 	.ocr_mask	= MMC_VDD_29_30,
 	.f_max		= 100000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA,
-	.gpio_cd	= GPIO_SDMMC_CD,
 	.gpio_wp	= -1,
 #ifdef CONFIG_STE_DMA40
 	.dma_filter	= stedma40_filter,
@@ -77,20 +77,36 @@ static struct mmci_platform_data mop500_sdi0_data = {
 #endif
 };
 
+/* GPIO pins used by the sdi0 level shifter */
+static int sdi0_en;
+static int sdi0_vsel;
+
 void mop500_sdi_tc35892_init(void)
 {
 	int ret;
 
-	ret = gpio_request(GPIO_SDMMC_EN, "SDMMC_EN");
+	if (machine_is_hrefv60())       {
+		sdi0_en = HREFV60_SDMMC_EN_GPIO;
+		sdi0_vsel = HREFV60_SDMMC_1V8_3V_GPIO;
+	} else  {
+		sdi0_en = GPIO_SDMMC_EN;
+		sdi0_vsel = GPIO_SDMMC_1V8_3V_SEL;
+	}
+	ret = gpio_request(sdi0_en, "level shifter enable");
 	if (!ret)
-		ret = gpio_request(GPIO_SDMMC_1V8_3V_SEL,
-				   "GPIO_SDMMC_1V8_3V_SEL");
-	if (ret)
+		ret = gpio_request(sdi0_vsel,
+				   "level shifter 1v8-3v select");
+
+	if (ret) {
+		pr_warning("unable to config sdi0 gpios for level shifter.\n");
 		return;
+	}
 
-	gpio_direction_output(GPIO_SDMMC_1V8_3V_SEL, 0);
-	gpio_direction_output(GPIO_SDMMC_EN, 1);
+	/* Select the default 2.9V and enable level shifter */
+	gpio_direction_output(sdi0_vsel, 0);
+	gpio_direction_output(sdi0_en, 1);
 
+	/* Add the device */
 	db8500_add_sdi0(&mop500_sdi0_data);
 }
 
@@ -179,6 +195,10 @@ void __init mop500_sdi_init(void)
 	/* On-board eMMC */
 	db8500_add_sdi4(&mop500_sdi4_data);
 
+	if (machine_is_hrefv60())
+		mop500_sdi0_data.gpio_cd = HREFV60_SDMMC_CD_GPIO;
+	else
+		mop500_sdi0_data.gpio_cd = GPIO_SDMMC_CD;
 	/*
 	 * sdi0 will finally be added when the TC35892 initializes and calls
 	 * mop500_sdi_tc35892_init() above.
diff --git a/arch/arm/mach-ux500/board-mop500-stuib.c b/arch/arm/mach-ux500/board-mop500-stuib.c
index 8b6323e..8c97977 100644
--- a/arch/arm/mach-ux500/board-mop500-stuib.c
+++ b/arch/arm/mach-ux500/board-mop500-stuib.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/input/matrix_keypad.h>
+#include <asm/mach-types.h>
 
 #include "board-mop500.h"
 
@@ -154,7 +155,6 @@ static struct bu21013_platform_device tsc_plat_device = {
 	.cs_dis = bu21013_gpio_board_exit,
 	.irq_read_val = bu21013_read_pin_val,
 	.irq = NOMADIK_GPIO_TO_IRQ(TOUCH_GPIO_PIN),
-	.cs_pin = GPIO_BU21013_CS,
 	.touch_x_max = TOUCH_XMAX,
 	.touch_y_max = TOUCH_YMAX,
 	.ext_clk = false,
@@ -167,7 +167,6 @@ static struct bu21013_platform_device tsc_plat2_device = {
 	.cs_dis = bu21013_gpio_board_exit,
 	.irq_read_val = bu21013_read_pin_val,
 	.irq = NOMADIK_GPIO_TO_IRQ(TOUCH_GPIO_PIN),
-	.cs_pin = GPIO_BU21013_CS,
 	.touch_x_max = TOUCH_XMAX,
 	.touch_y_max = TOUCH_YMAX,
 	.ext_clk = false,
@@ -189,6 +188,15 @@ static struct i2c_board_info __initdata u8500_i2c3_devices_stuib[] = {
 
 void __init mop500_stuib_init(void)
 {
+	if (machine_is_hrefv60()) {
+		tsc_plat_device.cs_pin = HREFV60_TOUCH_RST_GPIO;
+		tsc_plat2_device.cs_pin = HREFV60_TOUCH_RST_GPIO;
+	} else {
+		tsc_plat_device.cs_pin = GPIO_BU21013_CS;
+		tsc_plat2_device.cs_pin = GPIO_BU21013_CS;
+
+	}
+
 	mop500_uib_i2c_add(0, mop500_i2c0_devices_stuib,
 			ARRAY_SIZE(mop500_i2c0_devices_stuib));
 
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 72448e1..8790d98 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -202,7 +202,6 @@ static struct gpio_keys_button mop500_gpio_keys[] = {
 		.desc			= "SFH7741 Proximity Sensor",
 		.type			= EV_SW,
 		.code			= SW_FRONT_PROXIMITY,
-		.gpio			= GPIO_PROX_SENSOR,
 		.active_low		= 0,
 		.can_disable		= 1,
 	}
@@ -379,8 +378,18 @@ static void __init mop500_uart_init(void)
 	db8500_add_uart2(&uart2_plat);
 }
 
-static void __init u8500_init_machine(void)
+static void __init mop500_init_machine(void)
 {
+	/*
+	 * The HREFv60 board removed a GPIO expander and routed
+	 * all these GPIO pins to the internal GPIO controller
+	 * instead.
+	 */
+	if (machine_is_hrefv60())
+		mop500_gpio_keys[0].gpio = HREFV60_PROX_SENSE_GPIO;
+	else
+		mop500_gpio_keys[0].gpio = GPIO_PROX_SENSOR;
+
 	u8500_init_devices();
 
 	mop500_pins_init();
@@ -407,5 +416,13 @@ MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
 	.timer		= &ux500_timer,
-	.init_machine	= u8500_init_machine,
+	.init_machine	= mop500_init_machine,
+MACHINE_END
+
+MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
+	.boot_params	= 0x100,
+	.map_io		= u8500_map_io,
+	.init_irq	= ux500_init_irq,
+	.timer		= &ux500_timer,
+	.init_machine	= mop500_init_machine,
 MACHINE_END
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index 48abca7..56722f4 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -7,9 +7,21 @@
 #ifndef __BOARD_MOP500_H
 #define __BOARD_MOP500_H
 
-#define MOP500_EGPIO(x)			(NOMADIK_NR_GPIO + (x))
+/* HREFv60-specific GPIO assignments, this board has no GPIO expander */
+#define HREFV60_TOUCH_RST_GPIO		143
+#define HREFV60_PROX_SENSE_GPIO		217
+#define HREFV60_HAL_SW_GPIO		145
+#define HREFV60_SDMMC_EN_GPIO		169
+#define HREFV60_SDMMC_1V8_3V_GPIO	5
+#define HREFV60_SDMMC_CD_GPIO		95
+#define HREFV60_ACCEL_INT1_GPIO		82
+#define HREFV60_ACCEL_INT2_GPIO		83
+#define HREFV60_MAGNET_DRDY_GPIO	32
+#define HREFV60_DISP1_RST_GPIO		65
+#define HREFV60_DISP2_RST_GPIO		66
 
 /* GPIOs on the TC35892 expander */
+#define MOP500_EGPIO(x)			(NOMADIK_NR_GPIO + (x))
 #define GPIO_SDMMC_CD			MOP500_EGPIO(3)
 #define GPIO_PROX_SENSOR		MOP500_EGPIO(7)
 #define GPIO_BU21013_CS			MOP500_EGPIO(13)
diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index 9a6614c..ab0fe14 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -50,7 +50,11 @@ static void flush(void)
 
 static inline void arch_decomp_setup(void)
 {
-	if (machine_is_u8500())
+	/* Check in run time if we run on an U8500 or U5500 */
+	if (machine_is_u8500() ||
+	    machine_is_svp8500v1() ||
+	    machine_is_svp8500v2() ||
+	    machine_is_hrefv60())
 		ux500_uart_base = U8500_UART2_BASE;
 	else if (machine_is_u5500())
 		ux500_uart_base = U5500_UART0_BASE;
-- 
1.7.3.2
