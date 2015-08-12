From: petr.cvek@tul.cz (Petr Cvek)
Date: Thu, 13 Aug 2015 00:51:25 +0200
Subject: [PATCH v1 RFC] This patch repairs HTC Magician machine (PXA27x)
 support
Message-ID: <55CBCDED.8010409@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixing original code: Problems to successful boot due to the bad LCD
power sequence (wrongly configured GPIO).

Add/fix platform data and helper function for various hardware
(touchscreen, audio, USB device, ...).

Add new discovered GPIOs and fix names by GPIO context.

Add new LEDs driver.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/Kconfig                 |    1 +
 arch/arm/mach-pxa/include/mach/magician.h |   21 +-
 arch/arm/mach-pxa/magician.c              | 1148 +++++++++++++++++++++++------
 drivers/leds/Kconfig                      |    9 +
 drivers/leds/Makefile                     |    1 +
 drivers/leds/leds-pasic3.c                |  192 +++++
 drivers/mfd/htc-pasic3.c                  |  115 ++-
 include/linux/mfd/htc-pasic3.h            |   69 +-
 8 files changed, 1293 insertions(+), 263 deletions(-)
 create mode 100644 drivers/leds/leds-pasic3.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index f096836..5c7b6ee 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -294,6 +294,7 @@ config MACH_MAGICIAN
 	bool "Enable HTC Magician Support"
 	select IWMMXT
 	select PXA27x
+	select HTC_EGPIO
 
 config MACH_MIOA701
 	bool "Mitac Mio A701 Support"
diff --git a/arch/arm/mach-pxa/include/mach/magician.h b/arch/arm/mach-pxa/include/mach/magician.h
index ba6a6e1..8d3936d 100644
--- a/arch/arm/mach-pxa/include/mach/magician.h
+++ b/arch/arm/mach-pxa/include/mach/magician.h
@@ -32,6 +32,8 @@
 #define GPIO37_MAGICIAN_KEY_HANGUP		37
 #define GPIO38_MAGICIAN_KEY_CONTACTS		38
 #define GPIO40_MAGICIAN_GSM_OUT2		40
+#define GPIO46_MAGICIAN_IR_RX			46
+#define GPIO47_MAGICIAN_IR_TX			47
 #define GPIO48_MAGICIAN_UNKNOWN			48
 #define GPIO56_MAGICIAN_UNKNOWN			56
 #define GPIO57_MAGICIAN_CAM_RESET		57
@@ -52,14 +54,16 @@
 #define GPIO101_MAGICIAN_KEY_VOL_DOWN 		101
 #define GPIO102_MAGICIAN_KEY_PHONE		102
 #define GPIO103_MAGICIAN_LED_KP			103
-#define GPIO104_MAGICIAN_LCD_POWER_1 		104
-#define GPIO105_MAGICIAN_LCD_POWER_2		105
-#define GPIO106_MAGICIAN_LCD_POWER_3		106
+#define GPIO104_MAGICIAN_LCD_VOFF_EN           104
+#define GPIO105_MAGICIAN_LCD_VON_EN            105
+#define GPIO106_MAGICIAN_LCD_DCDC_NRESET       106
 #define GPIO107_MAGICIAN_DS1WM_IRQ		107
 #define GPIO108_MAGICIAN_GSM_READY		108
 #define GPIO114_MAGICIAN_UNKNOWN		114
 #define GPIO115_MAGICIAN_nPEN_IRQ		115
 #define GPIO116_MAGICIAN_nCAM_EN		116
+#define GPIO117_MAGICIAN_I2C_SCL		117
+#define GPIO118_MAGICIAN_I2C_SDA		118
 #define GPIO119_MAGICIAN_UNKNOWN		119
 #define GPIO120_MAGICIAN_UNKNOWN		120
 
@@ -98,16 +102,19 @@
 #define EGPIO_MAGICIAN_BL_POWER			MAGICIAN_EGPIO(1, 7)
 #define EGPIO_MAGICIAN_SD_POWER			MAGICIAN_EGPIO(2, 0)
 #define EGPIO_MAGICIAN_CARKIT_MIC		MAGICIAN_EGPIO(2, 1)
-#define EGPIO_MAGICIAN_UNKNOWN_WAVEDEV_DLL	MAGICIAN_EGPIO(2, 2)
+#define EGPIO_MAGICIAN_IR_RECEIVE_SHUTDOWN		MAGICIAN_EGPIO(2, 2)
 #define EGPIO_MAGICIAN_FLASH_VPP		MAGICIAN_EGPIO(2, 3)
 #define EGPIO_MAGICIAN_BL_POWER2		MAGICIAN_EGPIO(2, 4)
 #define EGPIO_MAGICIAN_BQ24022_ISET2		MAGICIAN_EGPIO(2, 5)
+#define EGPIO_MAGICIAN_NICD_CHARGE		MAGICIAN_EGPIO(2, 6)
 #define EGPIO_MAGICIAN_GSM_POWER		MAGICIAN_EGPIO(2, 7)
 
 /* input */
 
-#define EGPIO_MAGICIAN_CABLE_STATE_AC		MAGICIAN_EGPIO(4, 0)
-#define EGPIO_MAGICIAN_CABLE_STATE_USB		MAGICIAN_EGPIO(4, 1)
+/* AC=1, USB=0 */
+#define EGPIO_MAGICIAN_CABLE_TYPE		MAGICIAN_EGPIO(4, 0)
+/* =1 when AC or USB cable inserted */
+#define EGPIO_MAGICIAN_CABLE_INSERT1		MAGICIAN_EGPIO(4, 1)
 
 #define EGPIO_MAGICIAN_BOARD_ID0		MAGICIAN_EGPIO(5, 0)
 #define EGPIO_MAGICIAN_BOARD_ID1		MAGICIAN_EGPIO(5, 1)
@@ -116,5 +123,7 @@
 #define EGPIO_MAGICIAN_nSD_READONLY		MAGICIAN_EGPIO(5, 4)
 
 #define EGPIO_MAGICIAN_EP_INSERT		MAGICIAN_EGPIO(6, 1)
+/* FIXME same like 4,1, may differ for host/device */
+#define EGPIO_MAGICIAN_CABLE_INSERT2	MAGICIAN_EGPIO(6, 4)
 
 #endif /* _MAGICIAN_H_ */
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index a9761c2..6872d5b 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -4,13 +4,54 @@
  * and T-Mobile MDA Compact.
  *
  * Copyright (c) 2006-2007 Philipp Zabel
+ * Copyright (c) 2014-2015 Petr Cvek (massive rework)
  *
- * Based on hx4700.c, spitz.c and others.
+ * Based on hx4700.c, spitz.c, board-overo.c and others.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
+ *
+ * NOTICE MDA Compact (T-mobile XDA) facts:
+ *   On "LCD type = 1, system_rev = 2" (0x3a in CPLD)
+ * Samsung LTP280QV - valid LCD init sequence sequence:
+ *   powerup: Vdigital->Vanalog->gate Voff->gate Von->data enable
+ *   powerdown: data disable->gate Von->gate Voff->Vanalog->Vdigital
+ * Measured on PCB:
+ *   GPIO106
+ *     Affects VOFF, VON and other voltages
+ *     Probably main reset pin for DC-DC converter
+ *   GPIO75
+ *     Must be AF0+OUT (WM leaves it to AF2+OUT), not LCD signal
+ *     GPIO106 works only when GPIO75 is high (DC-DC power enable?)
+ *     After LCD powerup, value is irrelevant
+ *   GPIO104
+ *     LCD VOFF (gate off voltage)
+ *   GPIO105
+ *     LCD VON (gate on voltage)
+ * FFUART (/dev/ttyS0) WM: 38400,8,n,1,crtscts (GSM data?)
+ * BTUART (/dev/ttyS1) WM: 115200,8,n,1,crtscts (GSM AT commands)
+ *   Use a HTC line discipline: 0x02 channel(==0x16) data 0x02
+ * EGPIO(CPLD) should be always present (controls "all" supply power)
+ *   For rootfs on MMC/SD: EGPIO module controls card power (in kernel)
+ * cpu-freq often freeze platform (errata?, use userspace gov)
+ * Do not use YUV420, (erratum E24) causes LCD hang (forever)
+ * Many GSM related pins are unknown
+ * gpio-rc-recv probably require lowpass filter (sw is OK)
+ * TODO EGPIO_MAGICIAN_IR_RECEIVE_SHUTDOWN
+ * FIXME AC charging blocks IrDA
+ * Unimplemented blocking of camera+power+reset, reset and door open reset
+ *   Registers: htc-pasic3.h (but blocks charging too)
+ * Other PXA machines have wait_for_sync for ADS7846 (during LCD refresh)
+ * pda-power has not optimal charging (accu can be bloated)
+ * TODO Current switching works? Is gpio-regulator/bq24022 required?
+ * pdata supports alternative drivers (mutually exclusive modules)
+ *   i2c-pxa vs i2c-gpio (SCCB)
+ *   pwm_bl vs gpio_backlight
+ *   pxa27x_udc vs phy-gpio-vbus-usb
+ *   physmap-flash vs pxa2xx-flash
+ *
  */
 
 #include <linux/kernel.h>
@@ -28,8 +69,14 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/gpio-regulator.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/max1586.h>
+
 #include <linux/usb/gpio_vbus.h>
 #include <linux/i2c/pxa-i2c.h>
+#include <linux/i2c-gpio.h>
+#include <linux/i2c.h>
+
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -42,46 +89,74 @@
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
+#include <linux/platform_data/camera-pxa.h>
+
+#include <linux/platform_data/gpio_backlight.h>
+
+#include <linux/platform_data/pxa2xx_udc.h>
+#include <mach/udc.h>
+#include <mach/pxa27x-udc.h>
+#include <linux/usb/g_hid.h>
+
+#include <media/soc_camera.h>
+#include <sound/uda1380.h>
 
 #include "devices.h"
 #include "generic.h"
 
+#include <linux/spi/ads7846.h>
+#include <linux/spi/pxa2xx_spi.h>
+#include <linux/spi/spi.h>
+#include <linux/i2c/pxa-i2c.h>
+#include <media/gpio-ir-recv.h>
+
 static unsigned long magician_pin_config[] __initdata = {
 
 	/* SDRAM and Static Memory I/O Signals */
 	GPIO20_nSDCS_2,
 	GPIO21_nSDCS_3,
 	GPIO15_nCS_1,
-	GPIO78_nCS_2,   /* PASIC3 */
-	GPIO79_nCS_3,   /* EGPIO CPLD */
+	GPIO78_nCS_2,	/* PASIC3 */
+	GPIO79_nCS_3,	/* EGPIO CPLD */
 	GPIO80_nCS_4,
 	GPIO33_nCS_5,
+	GPIO49_nPWE,
+	GPIO18_RDY,
 
-	/* I2C */
+	/* I2C UDA1380 + OV9640 */
 	GPIO117_I2C_SCL,
 	GPIO118_I2C_SDA,
 
-	/* PWM 0 */
+	/* Omnivision camera power and reset GPIO*/
+	MFP_CFG_OUT(GPIO116, AF0, DRIVE_HIGH),	/* nEnable, active in low*/
+	MFP_CFG_OUT(GPIO57, AF0, DRIVE_HIGH),	/* Reset, active in high*/
+
+#if IS_ENABLED(CONFIG_PWM_PXA)
+	/* PWM 0 - LCD backlight */
 	GPIO16_PWM0_OUT,
+#else
+	/* Ensure static backlight without any driver */
+	MFP_CFG_OUT(GPIO16, AF0, DRIVE_HIGH),	/* Backlight enabled */
+#endif
 
-	/* I2S */
+	/* I2S UDA1380 capture */
 	GPIO28_I2S_BITCLK_OUT,
 	GPIO29_I2S_SDATA_IN,
 	GPIO31_I2S_SYNC,
 	GPIO113_I2S_SYSCLK,
 
-	/* SSP 1 */
+	/* SSP 1 UDA1380 playback */
 	GPIO23_SSP1_SCLK,
 	GPIO24_SSP1_SFRM,
 	GPIO25_SSP1_TXD,
 
-	/* SSP 2 */
+	/* SSP 2 TSC2046 touchscreen */
 	GPIO19_SSP2_SCLK,
 	GPIO14_SSP2_SFRM,
 	GPIO89_SSP2_TXD,
 	GPIO88_SSP2_RXD,
 
-	/* MMC */
+	/* MMC/SD/SDHC slot */
 	GPIO32_MMC_CLK,
 	GPIO92_MMC_DAT_0,
 	GPIO109_MMC_DAT_1,
@@ -89,10 +164,28 @@ static unsigned long magician_pin_config[] __initdata = {
 	GPIO111_MMC_DAT_3,
 	GPIO112_MMC_CMD,
 
-	/* LCD */
-	GPIOxx_LCD_TFT_16BPP,
-
-	/* QCI */
+	/*
+	 * LCD
+	 * NOTICE Samsung LTP280QV:
+	 *   cannot use GPIOxx_LCD_TFT_16BPP, GPIO75 is LCD power,
+	 * 74 unused (AF0 by bootloader?)
+	 */
+	GPIOxx_LCD_16BPP,
+	GPIO76_LCD_PCLK,
+	GPIO77_LCD_BIAS,	/* data_valid (v/hsync) (ADS7846 sync?) */
+
+	/* NOTICE valid LCD init sequence */
+
+	/* for GPIO75_MAGICIAN_SAMSUNG_POWER */
+	MFP_CFG_OUT(GPIO75, AF0, DRIVE_HIGH),
+	/* for GPIO106_MAGICIAN_LCD_DCDC_NRESET */
+	MFP_CFG_OUT(GPIO106, AF0, DRIVE_HIGH),
+	/* for GPIO104_MAGICIAN_LCD_VOFF_EN */
+	MFP_CFG_OUT(GPIO104, AF0, DRIVE_HIGH),
+	/* for GPIO105_MAGICIAN_LCD_VON_EN */
+	MFP_CFG_OUT(GPIO105, AF0, DRIVE_HIGH),
+
+	/* QCI camera interface */
 	GPIO12_CIF_DD_7,
 	GPIO17_CIF_DD_6,
 	GPIO50_CIF_DD_3,
@@ -107,25 +200,101 @@ static unsigned long magician_pin_config[] __initdata = {
 	GPIO85_CIF_LV,
 
 	/* Magician specific input GPIOs */
-	GPIO9_GPIO,	/* unknown */
 	GPIO10_GPIO,	/* GSM_IRQ */
 	GPIO13_GPIO,	/* CPLD_IRQ */
 	GPIO107_GPIO,	/* DS1WM_IRQ */
 	GPIO108_GPIO,	/* GSM_READY */
 	GPIO115_GPIO,	/* nPEN_IRQ */
 
-	/* I2C */
-	GPIO117_I2C_SCL,
-	GPIO118_I2C_SDA,
+	/* IrDA transmitter(?) disable */
+	MFP_CFG_OUT(GPIO83, AF0, DRIVE_HIGH),
+
+	/* Vibration motor */
+	MFP_CFG_OUT(GPIO22, AF0, DRIVE_LOW),
+
+	/* Keypad LEDs (red/green phone) */
+	MFP_CFG_OUT(GPIO103, AF0, DRIVE_LOW),
+
+	/* GSM pins */
+	MFP_CFG_OUT(GPIO11, AF0, DRIVE_LOW), /* CPU is unavailable(?) */
+	MFP_CFG_OUT(GPIO26, AF0, DRIVE_LOW), /* GSM power, active high */
+	MFP_CFG_OUT(GPIO86, AF0, DRIVE_HIGH), /* GSM reset, active high */
+
+	/* USB connector */
+	MFP_CFG_OUT(GPIO27, AF0, DRIVE_LOW), /* usbc pull-up enable */
+	MFP_CFG_OUT(GPIO30, AF0, DRIVE_LOW), /* charging enable, active low */
+
+	/* FFUART, FIXME never observed to do something, GSM data? */
+	GPIO34_FFUART_RXD,
+	GPIO35_FFUART_CTS,
+	GPIO36_FFUART_DCD,
+	GPIO39_FFUART_TXD,
+	GPIO41_FFUART_RTS,
+
+	/* BTUART, AT commands/data, HTC port line discipline */
+	GPIO42_BTUART_RXD,
+	GPIO43_BTUART_TXD,
+	GPIO44_BTUART_CTS,
+	GPIO45_BTUART_RTS,
+
+	/* Power I2C, enabled controller will overrule GPIO */
+	GPIO3_GPIO,	/* SCL */
+	GPIO4_GPIO,	/* SDA */
+
+	/* IrDA GPIOs, if pxaficp, it will change AF accordingly to mode */
+	MFP_CFG_IN(GPIO46, AF0),
+	MFP_CFG_OUT(GPIO47, AF0, DRIVE_LOW),
+	MFP_CFG_OUT(GPIO83, AF0, DRIVE_HIGH),
+
+	/* TODO unknown */
+	GPIO9_GPIO,		/* unknown */
+	MFP_CFG_OUT(GPIO40, AF0, DRIVE_LOW),	/* FIXME GSM? */
+	MFP_CFG_OUT(GPIO87, AF0, DRIVE_LOW),	/* FIXME GSM? */
+
+	/* Left GPIOs (undefined here):
+	 * 18, 49 : bootloader=VLIO?, WinM=TODO
+	 * 48 : AF0/out0
+	 * 56 : AF0/out0
+	 * 74 : bootloader=AF0/output
+	 * 86 : bootloader=AF0/input (but should be gsm reset???)
+	 * 114 : AF0/out0
+	 * 119 : AF0/out0
+	 * 120 : AF0/out
+	 * 1 : dedicated reset, AF0/output
+	 * 13 : cpld irq, output (??)
+	 */
 };
 
 /*
- * IRDA
+ * IrDA
  */
 
 static struct pxaficp_platform_data magician_ficp_info = {
 	.gpio_pwdown		= GPIO83_MAGICIAN_nIR_EN,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
+	/* TODO test with FIR dongle */
+	.transceiver_cap	= IR_SIRMODE | IR_FIRMODE | IR_OFF,
+	.gpio_pwdown_inverted = 0,
+};
+
+/*
+ * LIRC
+ * IrDA module can receive CIR, but it does not filter the carrier
+ * frequency. Low pass filter in driver (or HW) may be required.
+ */
+
+struct gpio_ir_recv_platform_data lirc_gpio_pdata = {
+	.gpio_nr = GPIO46_MAGICIAN_IR_RX,
+	.map_name = NULL,
+	.allowed_protos = 0,
+	.active_low = 0,
+};
+
+static struct platform_device lirc_gpio = {
+	.name = "gpio-rc-recv",
+	.dev = {
+		.platform_data = &lirc_gpio_pdata,
+	},
+	.id = -1,
 };
 
 /*
@@ -134,60 +303,59 @@ static struct pxaficp_platform_data magician_ficp_info = {
 
 #define INIT_KEY(_code, _gpio, _desc)	\
 	{				\
-		.code   = KEY_##_code,	\
-		.gpio   = _gpio,	\
-		.desc   = _desc,	\
-		.type   = EV_KEY,	\
-		.wakeup = 1,		\
+		.code = KEY_##_code,	\
+		.gpio = _gpio,	\
+		.desc = _desc,	\
+		.type = EV_KEY,	\
+		.wakeup = 1,	\
 	}
 
 static struct gpio_keys_button magician_button_table[] = {
-	INIT_KEY(POWER,      GPIO0_MAGICIAN_KEY_POWER,      "Power button"),
-	INIT_KEY(ESC,        GPIO37_MAGICIAN_KEY_HANGUP,    "Hangup button"),
-	INIT_KEY(F10,        GPIO38_MAGICIAN_KEY_CONTACTS,  "Contacts button"),
-	INIT_KEY(CALENDAR,   GPIO90_MAGICIAN_KEY_CALENDAR,  "Calendar button"),
-	INIT_KEY(CAMERA,     GPIO91_MAGICIAN_KEY_CAMERA,    "Camera button"),
-	INIT_KEY(UP,         GPIO93_MAGICIAN_KEY_UP,        "Up button"),
-	INIT_KEY(DOWN,       GPIO94_MAGICIAN_KEY_DOWN,      "Down button"),
-	INIT_KEY(LEFT,       GPIO95_MAGICIAN_KEY_LEFT,      "Left button"),
-	INIT_KEY(RIGHT,      GPIO96_MAGICIAN_KEY_RIGHT,     "Right button"),
-	INIT_KEY(KPENTER,    GPIO97_MAGICIAN_KEY_ENTER,     "Action button"),
-	INIT_KEY(RECORD,     GPIO98_MAGICIAN_KEY_RECORD,    "Record button"),
-	INIT_KEY(VOLUMEUP,   GPIO100_MAGICIAN_KEY_VOL_UP,   "Volume up"),
+	INIT_KEY(POWER, GPIO0_MAGICIAN_KEY_POWER, "Power button"),
+	INIT_KEY(ESC, GPIO37_MAGICIAN_KEY_HANGUP, "Hangup button"),
+	INIT_KEY(F10, GPIO38_MAGICIAN_KEY_CONTACTS, "Contacts button"),
+	INIT_KEY(CALENDAR, GPIO90_MAGICIAN_KEY_CALENDAR, "Calendar button"),
+	INIT_KEY(CAMERA, GPIO91_MAGICIAN_KEY_CAMERA, "Camera button"),
+	INIT_KEY(UP, GPIO93_MAGICIAN_KEY_UP, "Up button"),
+	INIT_KEY(DOWN, GPIO94_MAGICIAN_KEY_DOWN, "Down button"),
+	INIT_KEY(LEFT, GPIO95_MAGICIAN_KEY_LEFT, "Left button"),
+	INIT_KEY(RIGHT, GPIO96_MAGICIAN_KEY_RIGHT, "Right button"),
+	INIT_KEY(KPENTER, GPIO97_MAGICIAN_KEY_ENTER, "Action button"),
+	INIT_KEY(RECORD, GPIO98_MAGICIAN_KEY_RECORD, "Record button"),
+	INIT_KEY(VOLUMEUP, GPIO100_MAGICIAN_KEY_VOL_UP, "Volume up"),
 	INIT_KEY(VOLUMEDOWN, GPIO101_MAGICIAN_KEY_VOL_DOWN, "Volume down"),
-	INIT_KEY(PHONE,      GPIO102_MAGICIAN_KEY_PHONE,    "Phone button"),
-	INIT_KEY(PLAY,       GPIO99_MAGICIAN_HEADPHONE_IN,  "Headset button"),
+	INIT_KEY(PHONE, GPIO102_MAGICIAN_KEY_PHONE, "Phone button"),
+	INIT_KEY(PLAY, GPIO99_MAGICIAN_HEADPHONE_IN, "Headset button"),
 };
 
 static struct gpio_keys_platform_data gpio_keys_data = {
-	.buttons  = magician_button_table,
+	.buttons = magician_button_table,
 	.nbuttons = ARRAY_SIZE(magician_button_table),
 };
 
 static struct platform_device gpio_keys = {
 	.name = "gpio-keys",
-	.dev  = {
+	.dev = {
 		.platform_data = &gpio_keys_data,
 	},
-	.id   = -1,
+	.id = -1,
 };
 
-
 /*
  * EGPIO (Xilinx CPLD)
- *
- * 7 32-bit aligned 8-bit registers: 3x output, 1x irq, 3x input
+ * 32-bit aligned
+ * 7x 8-bit registers: 3x output, 1x irq, 3x input
  */
 
 static struct resource egpio_resources[] = {
 	[0] = {
 		.start = PXA_CS3_PHYS,
-		.end   = PXA_CS3_PHYS + 0x20 - 1,
+		.end = PXA_CS3_PHYS + 0x20 - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
 		.start = PXA_GPIO_TO_IRQ(GPIO13_MAGICIAN_CPLD_IRQ),
-		.end   = PXA_GPIO_TO_IRQ(GPIO13_MAGICIAN_CPLD_IRQ),
+		.end = PXA_GPIO_TO_IRQ(GPIO13_MAGICIAN_CPLD_IRQ),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -198,7 +366,12 @@ static struct htc_egpio_chip egpio_chips[] = {
 		.gpio_base = MAGICIAN_EGPIO(0, 0),
 		.num_gpios = 24,
 		.direction = HTC_EGPIO_OUTPUT,
-		.initial_values = 0x40, /* EGPIO_MAGICIAN_GSM_RESET */
+
+		/*
+		 * Depends on modules configuration
+		 * Things like MMC and LCD should be enabled
+		 */
+		.initial_values = 0x21a0c0,
 	},
 	[1] = {
 		.reg_start = 4,
@@ -209,19 +382,19 @@ static struct htc_egpio_chip egpio_chips[] = {
 };
 
 static struct htc_egpio_platform_data egpio_info = {
-	.reg_width    = 8,
-	.bus_width    = 32,
-	.irq_base     = IRQ_BOARD_START,
-	.num_irqs     = 4,
+	.reg_width = 8,
+	.bus_width = 32,
+	.irq_base = IRQ_BOARD_START,
+	.num_irqs = 4,
 	.ack_register = 3,
-	.chip         = egpio_chips,
-	.num_chips    = ARRAY_SIZE(egpio_chips),
+	.chip	= egpio_chips,
+	.num_chips = ARRAY_SIZE(egpio_chips),
 };
 
 static struct platform_device egpio = {
-	.name          = "htc-egpio",
-	.id            = -1,
-	.resource      = egpio_resources,
+	.name	= "htc-egpio",
+	.id	= -1,
+	.resource = egpio_resources,
 	.num_resources = ARRAY_SIZE(egpio_resources),
 	.dev = {
 		.platform_data = &egpio_info,
@@ -229,95 +402,89 @@ static struct platform_device egpio = {
 };
 
 /*
- * LCD - Toppoly TD028STEB1 or Samsung LTP280QV
+ * PXAFB LCD - Toppoly TD028STEB1 or Samsung LTP280QV
  */
 
 static struct pxafb_mode_info toppoly_modes[] = {
 	{
-		.pixclock     = 96153,
-		.bpp          = 16,
-		.xres         = 240,
-		.yres         = 320,
-		.hsync_len    = 11,
-		.vsync_len    = 3,
-		.left_margin  = 19,
+		.pixclock = 96153,
+		.bpp	= 16,
+		.xres	= 240,
+		.yres	= 320,
+		.hsync_len = 11,
+		.vsync_len = 3,
+		.left_margin = 19,
 		.upper_margin = 2,
 		.right_margin = 10,
 		.lower_margin = 2,
-		.sync         = 0,
+		.sync	= 0,
 	},
 };
 
 static struct pxafb_mode_info samsung_modes[] = {
 	{
-		.pixclock     = 96153,
-		.bpp          = 16,
-		.xres         = 240,
-		.yres         = 320,
-		.hsync_len    = 8,
-		.vsync_len    = 4,
-		.left_margin  = 9,
+		.pixclock = 96153,
+		.bpp	= 16,
+		.xres	= 240,
+		.yres	= 320,
+		.hsync_len = 8,
+		.vsync_len = 4,
+		.left_margin = 9,
 		.upper_margin = 4,
 		.right_margin = 9,
 		.lower_margin = 4,
-		.sync         = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.sync	= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	},
 };
 
 static void toppoly_lcd_power(int on, struct fb_var_screeninfo *si)
 {
-	pr_debug("Toppoly LCD power\n");
+	pr_debug("Toppoly LCD power: %s\n", on ? "on" : "off");
 
 	if (on) {
-		pr_debug("on\n");
 		gpio_set_value(EGPIO_MAGICIAN_TOPPOLY_POWER, 1);
-		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 1);
+		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 1);
 		udelay(2000);
 		gpio_set_value(EGPIO_MAGICIAN_LCD_POWER, 1);
 		udelay(2000);
 		/* FIXME: enable LCDC here */
 		udelay(2000);
-		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 1);
+		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 1);
 		udelay(2000);
-		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 1);
+		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 1);
 	} else {
-		pr_debug("off\n");
-		msleep(15);
-		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 0);
+		mdelay(15);
+		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 0);
 		udelay(500);
-		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 0);
+		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 0);
 		udelay(1000);
-		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 0);
+		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 0);
 		gpio_set_value(EGPIO_MAGICIAN_LCD_POWER, 0);
 	}
 }
 
 static void samsung_lcd_power(int on, struct fb_var_screeninfo *si)
 {
-	pr_debug("Samsung LCD power\n");
+	pr_debug("Samsung LCD power: %s\n", on ? "on" : "off");
 
 	if (on) {
-		pr_debug("on\n");
 		if (system_rev < 3)
 			gpio_set_value(GPIO75_MAGICIAN_SAMSUNG_POWER, 1);
 		else
 			gpio_set_value(EGPIO_MAGICIAN_LCD_POWER, 1);
-		mdelay(10);
-		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 1);
-		mdelay(10);
-		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 1);
-		mdelay(30);
-		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 1);
-		mdelay(10);
+		mdelay(6);
+		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 1);
+		mdelay(6);	/* Avdd -> Voff >5ms */
+		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 1);
+		mdelay(16);	/* Voff -> Von >(5+10)ms */
+		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 1);
 	} else {
-		pr_debug("off\n");
-		mdelay(10);
-		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 0);
-		mdelay(30);
-		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 0);
-		mdelay(10);
-		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 0);
-		mdelay(10);
+		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 0);
+		mdelay(16);
+		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 0);
+		mdelay(6);
+		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 0);
+		mdelay(6);
 		if (system_rev < 3)
 			gpio_set_value(GPIO75_MAGICIAN_SAMSUNG_POWER, 0);
 		else
@@ -326,19 +493,19 @@ static void samsung_lcd_power(int on, struct fb_var_screeninfo *si)
 }
 
 static struct pxafb_mach_info toppoly_info = {
-	.modes           = toppoly_modes,
-	.num_modes       = 1,
-	.fixed_modes     = 1,
-	.lcd_conn	= LCD_COLOR_TFT_16BPP,
+	.modes = toppoly_modes,
+	.num_modes = 1,
+	.fixed_modes = 1,
+	.lcd_conn = LCD_COLOR_TFT_16BPP,
 	.pxafb_lcd_power = toppoly_lcd_power,
 };
 
 static struct pxafb_mach_info samsung_info = {
-	.modes           = samsung_modes,
-	.num_modes       = 1,
-	.fixed_modes     = 1,
-	.lcd_conn	 = LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL |\
-			   LCD_ALTERNATE_MAPPING,
+	.modes = samsung_modes,
+	.num_modes = 1,
+	.fixed_modes = 1,
+	.lcd_conn = LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL |
+		LCD_ALTERNATE_MAPPING,
 	.pxafb_lcd_power = samsung_lcd_power,
 };
 
@@ -347,17 +514,22 @@ static struct pxafb_mach_info samsung_info = {
  */
 
 static struct gpio magician_bl_gpios[] = {
-	{ EGPIO_MAGICIAN_BL_POWER,  GPIOF_DIR_OUT, "Backlight power" },
-	{ EGPIO_MAGICIAN_BL_POWER2, GPIOF_DIR_OUT, "Backlight power 2" },
+	{ EGPIO_MAGICIAN_BL_POWER, GPIOF_DIR_OUT, "Backlight power" },
+	{ EGPIO_MAGICIAN_BL_POWER2, GPIOF_DIR_OUT, "Extra backlight power" },
 };
 
 static int magician_backlight_init(struct device *dev)
 {
-	return gpio_request_array(ARRAY_AND_SIZE(magician_bl_gpios));
+	int ret;
+
+	pr_debug("Backlight init\n");
+	ret = gpio_request_array(ARRAY_AND_SIZE(magician_bl_gpios));
+	return ret;
 }
 
 static int magician_backlight_notify(struct device *dev, int brightness)
 {
+	pr_debug("Brightness = %i\n", brightness);
 	gpio_set_value(EGPIO_MAGICIAN_BL_POWER, brightness);
 	if (brightness >= 200) {
 		gpio_set_value(EGPIO_MAGICIAN_BL_POWER2, 1);
@@ -373,28 +545,57 @@ static void magician_backlight_exit(struct device *dev)
 	gpio_free_array(ARRAY_AND_SIZE(magician_bl_gpios));
 }
 
-static struct platform_pwm_backlight_data backlight_data = {
-	.pwm_id         = 0,
+/*
+ * LCD backlight by PWM (main)
+ * PWM frequency for MP1521 should be:
+ *   100-400 Hz = 2?.5*10^6 - 10?*10^6 ns
+ */
+
+static struct platform_pwm_backlight_data pwm_backlight_data = {
+	.pwm_id = 0,
 	.max_brightness = 272,
 	.dft_brightness = 100,
-	.pwm_period_ns  = 30923,
-	.enable_gpio    = -1,
-	.init           = magician_backlight_init,
-	.notify         = magician_backlight_notify,
-	.exit           = magician_backlight_exit,
+	.pwm_period_ns = 30923,
+	.enable_gpio = -1,
+	.init = magician_backlight_init,
+	.notify = magician_backlight_notify,
+	.exit = magician_backlight_exit,
 };
 
-static struct platform_device backlight = {
+static struct platform_device pwm_backlight = {
 	.name = "pwm-backlight",
-	.id   = -1,
-	.dev  = {
-		.parent        = &pxa27x_device_pwm0.dev,
-		.platform_data = &backlight_data,
+	.id = -1,
+	.dev = {
+		.parent	= &pxa27x_device_pwm0.dev,
+		.platform_data = &pwm_backlight_data,
 	},
 };
 
+/* Backlight controlled by single GPIO (alternative) */
+static struct gpio_backlight_platform_data gpio_backlight_data = {
+/* .fbdev = &pxa_device_fb.dev, */
+	.gpio = EGPIO_MAGICIAN_BL_POWER,
+	.def_value = 1,
+	.name = "backlight",
+};
+
+static struct platform_device gpio_backlight = {
+	.name = "gpio-backlight",
+	.dev = {
+		.platform_data = &gpio_backlight_data,
+	},
+};
+
+/*
+ * fixed regulator for pwm_backlight
+ */
+
+static struct regulator_consumer_supply pwm_backlight_supply[] = {
+	REGULATOR_SUPPLY("power", "pwm_backlight"),
+};
+
 /*
- * LEDs
+ * Phone keys backlight, vibra
  */
 
 static struct gpio_led gpio_leds[] = {
@@ -417,76 +618,135 @@ static struct gpio_led_platform_data gpio_led_info = {
 
 static struct platform_device leds_gpio = {
 	.name = "leds-gpio",
-	.id   = -1,
-	.dev  = {
+	.id = -1,
+	.dev = {
 		.platform_data = &gpio_led_info,
 	},
 };
 
+/*
+ * SoC Camera
+ */
+
+static struct pxacamera_platform_data magician_pxacamera_pdata = {
+	.flags = PXA_CAMERA_MASTER | PXA_CAMERA_DATAWIDTH_8 |
+		PXA_CAMERA_PCLK_EN | PXA_CAMERA_MCLK_EN,
+	.mclk_10khz = 4800,
+};
+
+static int magician_camera_power(struct device *dev, int power)
+{
+	pr_debug("Camera power = %i\n", power);
+
+	gpio_set_value(GPIO116_MAGICIAN_nCAM_EN, !power);
+	mdelay(3);
+
+	return 0;
+}
+
+static int magician_camera_reset(struct device *dev)
+{
+	pr_debug("Camera reset\n");
+
+	gpio_set_value(GPIO57_MAGICIAN_CAM_RESET, 1);
+	mdelay(3);
+	gpio_set_value(GPIO57_MAGICIAN_CAM_RESET, 0);
+	mdelay(3);
+
+	return 0;
+}
+
+static struct i2c_board_info magician_camera_i2c_board_info = {
+	I2C_BOARD_INFO("ov9640", 0x30),
+	.flags = I2C_CLIENT_SCCB,
+};
+
+static struct soc_camera_link magician_camera_iclink = {
+	.bus_id			= 0,
+	.flags			= SOCAM_DATAWIDTH_8,
+	.i2c_adapter_id	= 0,
+	.board_info		= &magician_camera_i2c_board_info,
+	.power		= magician_camera_power,
+	.reset		= magician_camera_reset,
+};
+
+static struct platform_device magician_camera = {
+	.name = "soc-camera-pdrv",
+	.id = 0,
+	.dev = {
+		.platform_data = &magician_camera_iclink,
+	},
+};
+
+/*
+ * PASIC3: DS1WM, LEDs, sysreset
+ */
+
 static struct pasic3_led pasic3_leds[] = {
 	{
-		.led = {
-			.name            = "magician:red",
+		.cdev = {
+			.name = "magician:red",
 			.default_trigger = "ds2760-battery.0-charging",
 		},
 		.hw_num = 0,
-		.bit2   = PASIC3_BIT2_LED0,
-		.mask   = PASIC3_MASK_LED0,
+		.bit_blink_en	= R06_CH0_EN,
+		.bit_force_on	= R06_CH0_FORCE_ON,
+		.bit_mask		= MASK_CH0,
+		.reg_delay_on	= PASIC3_CH0_DELAY_ON,
+		.reg_delay_off	= PASIC3_CH0_DELAY_OFF,
 	},
 	{
-		.led = {
-			.name            = "magician:green",
+		.cdev = {
+			.name = "magician:green",
 			.default_trigger = "ds2760-battery.0-charging-or-full",
 		},
 		.hw_num = 1,
-		.bit2   = PASIC3_BIT2_LED1,
-		.mask   = PASIC3_MASK_LED1,
+		.bit_blink_en	= R06_CH1_EN,
+		.bit_force_on	= R06_CH1_FORCE_ON,
+		.bit_mask		= MASK_CH1,
+		.reg_delay_on	= PASIC3_CH1_DELAY_ON,
+		.reg_delay_off	= PASIC3_CH1_DELAY_OFF,
 	},
 	{
-		.led = {
-			.name            = "magician:blue",
+		.cdev = {
+			.name = "magician:blue",
 			.default_trigger = "bluetooth",
 		},
 		.hw_num = 2,
-		.bit2   = PASIC3_BIT2_LED2,
-		.mask   = PASIC3_MASK_LED2,
+		.bit_blink_en	= R06_CH2_EN,
+		.bit_force_on	= R06_CH2_FORCE_ON,
+		.bit_mask		= MASK_CH2,
+		.reg_delay_on	= PASIC3_CH2_DELAY_ON,
+		.reg_delay_off	= PASIC3_CH2_DELAY_OFF,
 	},
 };
 
-static struct pasic3_leds_machinfo pasic3_leds_info = {
-	.num_leds   = ARRAY_SIZE(pasic3_leds),
-	.power_gpio = EGPIO_MAGICIAN_LED_POWER,
-	.leds       = pasic3_leds,
-};
-
-/*
- * PASIC3 with DS1WM
- */
-
 static struct resource pasic3_resources[] = {
 	[0] = {
-		.start  = PXA_CS2_PHYS,
-		.end	= PXA_CS2_PHYS + 0x1b,
-		.flags  = IORESOURCE_MEM,
+		.start = PXA_CS2_PHYS,
+		.end = PXA_CS2_PHYS + 0x1b,
+		.flags = IORESOURCE_MEM,
 	},
 	/* No IRQ handler in the PASIC3, DS1WM needs an external IRQ */
 	[1] = {
-		.start  = PXA_GPIO_TO_IRQ(GPIO107_MAGICIAN_DS1WM_IRQ),
-		.end    = PXA_GPIO_TO_IRQ(GPIO107_MAGICIAN_DS1WM_IRQ),
-		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
+		.start = PXA_GPIO_TO_IRQ(GPIO107_MAGICIAN_DS1WM_IRQ),
+		.end = PXA_GPIO_TO_IRQ(GPIO107_MAGICIAN_DS1WM_IRQ),
+		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
 
 static struct pasic3_platform_data pasic3_platform_data = {
-	.led_pdata  = &pasic3_leds_info,
+	.power_gpio = EGPIO_MAGICIAN_LED_POWER, /* Green LED doesn't use it */
+	.leds = pasic3_leds,
+	.num_leds = ARRAY_SIZE(pasic3_leds),
 	.clock_rate = 4000000,
 };
 
 static struct platform_device pasic3 = {
-	.name		= "pasic3",
+	.name	= "pasic3",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(pasic3_resources),
-	.resource	= pasic3_resources,
+	.resource		= pasic3_resources,
 	.dev = {
 		.platform_data = &pasic3_platform_data,
 	},
@@ -496,87 +756,183 @@ static struct platform_device pasic3 = {
  * USB "Transceiver"
  */
 
+#if IS_ENABLED(CONFIG_USB_PXA27X)
+static void magician_udc_command(int cmd)
+{
+	if (cmd == PXA2XX_UDC_CMD_CONNECT)
+		UP2OCR |= UP2OCR_DPPUE | UP2OCR_DPPUBE;
+	else if (cmd == PXA2XX_UDC_CMD_DISCONNECT)
+		UP2OCR &= ~(UP2OCR_DPPUE | UP2OCR_DPPUBE);
+}
+
+/* HACK, shared USB connected state with pda-power */
+int my_usb_online = 1;
+
+static int magician_udc_is_connected(void)
+{
+	/* Shared with pda_power or gpio-vbus */
+	return my_usb_online;
+}
+
+static struct pxa2xx_udc_mach_info magician_udc_info __initdata = {
+	.udc_command	= magician_udc_command,
+	.udc_is_connected = magician_udc_is_connected,
+	.gpio_pullup	= GPIO27_MAGICIAN_USBC_PUEN,
+};
+
+#else
+
+/* GPIO USB client vbus sensing, when no PXA UDC installed */
+
 static struct resource gpio_vbus_resource = {
 	.flags = IORESOURCE_IRQ,
 	.start = IRQ_MAGICIAN_VBUS,
-	.end   = IRQ_MAGICIAN_VBUS,
+	.end = IRQ_MAGICIAN_VBUS,
 };
 
 static struct gpio_vbus_mach_info gpio_vbus_info = {
 	.gpio_pullup = GPIO27_MAGICIAN_USBC_PUEN,
-	.gpio_vbus   = EGPIO_MAGICIAN_CABLE_STATE_USB,
+	.gpio_vbus = EGPIO_MAGICIAN_CABLE_INSERT1,
 };
 
 static struct platform_device gpio_vbus = {
-	.name          = "gpio-vbus",
-	.id            = -1,
+	.name = "gpio-vbus",
+	.id = -1,
 	.num_resources = 1,
-	.resource      = &gpio_vbus_resource,
+	.resource = &gpio_vbus_resource,
 	.dev = {
 		.platform_data = &gpio_vbus_info,
 	},
 };
+#endif	/* IS_ENABLED(CONFIG_USB_PXA27X) */
 
 /*
- * External power
+ * Charging functions
  */
 
-static int power_supply_init(struct device *dev)
+static int magician_supply_init(struct device *dev)
 {
-	return gpio_request(EGPIO_MAGICIAN_CABLE_STATE_AC, "CABLE_STATE_AC");
+	int ret = -1;
+
+	ret = gpio_request(EGPIO_MAGICIAN_CABLE_TYPE, "AC charger in USB");
+	if (ret) {
+		pr_err("Cannot request AC/USB charger GPIO (%i)\n", ret);
+		goto err_ac;
+	}
+
+	ret = gpio_request(EGPIO_MAGICIAN_CABLE_INSERT1, "Cable inserted");
+	if (ret) {
+		pr_err("Cannot request cable detection GPIO (%i)\n", ret);
+		goto err_usb;
+	}
+
+	return 0;
+
+err_usb:
+	gpio_free(EGPIO_MAGICIAN_CABLE_TYPE);
+err_ac:
+	return ret;
+}
+
+static void magician_set_charge(int flags)
+{
+	/* EGPIO_MAGICIAN_BQ24022_ISET2: =1 500mA, =0 100mA
+	 *
+	 * RTC NiCd voltage can be read from ADS7846
+	 * in0_input=1930, when =0 (after =1 its going up)
+	 * in0_input=1367, when =1
+	 * in0_input=2499, always (without NiCd)
+	 *
+	 * FIXME Will disabled NiCd slow accu discharge?
+	 *
+	 * Charging from USB can be 500mA too
+	 * NOTICE: IrDA=on, Vcore=1V, Fcore=104MHz, everything other=off
+	 *   -> power consumption still over 100mA
+	 */
+
+	if (flags & PDA_POWER_CHARGE_AC) {
+		pr_debug("Charging from AC\n");
+		gpio_set_value(EGPIO_MAGICIAN_NICD_CHARGE, 1);
+	} else if (flags & PDA_POWER_CHARGE_USB) {
+		pr_debug("Charging from USB\n");
+		gpio_set_value(EGPIO_MAGICIAN_NICD_CHARGE, 1);
+	} else {
+		pr_debug("Charging disabled\n");
+		gpio_set_value(EGPIO_MAGICIAN_NICD_CHARGE, 0);
+	}
+
+	gpio_set_value(EGPIO_MAGICIAN_NICD_CHARGE, 1);
 }
 
 static int magician_is_ac_online(void)
 {
-	return gpio_get_value(EGPIO_MAGICIAN_CABLE_STATE_AC);
+	return gpio_get_value(EGPIO_MAGICIAN_CABLE_INSERT1) &&
+		gpio_get_value(EGPIO_MAGICIAN_CABLE_TYPE); /* AC=1 */
+}
+
+static int magician_is_usb_online(void)
+{
+	my_usb_online = gpio_get_value(EGPIO_MAGICIAN_CABLE_INSERT1) &&
+		(!gpio_get_value(EGPIO_MAGICIAN_CABLE_TYPE)); /* USB=0 */
+	return my_usb_online;
 }
 
-static void power_supply_exit(struct device *dev)
+static void magician_supply_exit(struct device *dev)
 {
-	gpio_free(EGPIO_MAGICIAN_CABLE_STATE_AC);
+	/* HACK FIXME EGPIO pin is used with two drivers */
+	my_usb_online = 1;
+
+	gpio_free(EGPIO_MAGICIAN_CABLE_INSERT1);
+	gpio_free(EGPIO_MAGICIAN_CABLE_TYPE);
 }
 
 static char *magician_supplicants[] = {
 	"ds2760-battery.0", "backup-battery"
 };
 
+/*
+ * pda_power Li-ion charger
+ */
+
 static struct pda_power_pdata power_supply_info = {
-	.init            = power_supply_init,
-	.is_ac_online    = magician_is_ac_online,
-	.exit            = power_supply_exit,
-	.supplied_to     = magician_supplicants,
+	.init = magician_supply_init,
+	.exit = magician_supply_exit,
+	.is_ac_online = magician_is_ac_online,
+	.is_usb_online = magician_is_usb_online,
+	.set_charge = magician_set_charge,
+	.supplied_to = magician_supplicants,
 	.num_supplicants = ARRAY_SIZE(magician_supplicants),
 };
 
 static struct resource power_supply_resources[] = {
 	[0] = {
-		.name  = "ac",
+		.name = "ac",
 		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
-		         IORESOURCE_IRQ_LOWEDGE,
+			IORESOURCE_IRQ_LOWEDGE,
 		.start = IRQ_MAGICIAN_VBUS,
-		.end   = IRQ_MAGICIAN_VBUS,
+		.end = IRQ_MAGICIAN_VBUS,
 	},
 	[1] = {
-		.name  = "usb",
+		.name = "usb",
 		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
-		         IORESOURCE_IRQ_LOWEDGE,
+			IORESOURCE_IRQ_LOWEDGE,
 		.start = IRQ_MAGICIAN_VBUS,
-		.end   = IRQ_MAGICIAN_VBUS,
+		.end = IRQ_MAGICIAN_VBUS,
 	},
 };
 
 static struct platform_device power_supply = {
 	.name = "pda-power",
-	.id   = -1,
-	.dev  = {
+	.id = -1,
+	.dev = {
 		.platform_data = &power_supply_info,
 	},
-	.resource      = power_supply_resources,
+	.resource = power_supply_resources,
 	.num_resources = ARRAY_SIZE(power_supply_resources),
 };
 
 /*
- * Battery charger
+ * Charging current switcher
  */
 
 static struct regulator_consumer_supply bq24022_consumers[] = {
@@ -586,11 +942,12 @@ static struct regulator_consumer_supply bq24022_consumers[] = {
 
 static struct regulator_init_data bq24022_init_data = {
 	.constraints = {
-		.max_uA         = 500000,
-		.valid_ops_mask = REGULATOR_CHANGE_CURRENT | REGULATOR_CHANGE_STATUS,
+		.max_uA = 500000,
+		.valid_ops_mask =
+			REGULATOR_CHANGE_CURRENT | REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  = ARRAY_SIZE(bq24022_consumers),
-	.consumer_supplies      = bq24022_consumers,
+	.num_consumer_supplies = ARRAY_SIZE(bq24022_consumers),
+	.consumer_supplies = bq24022_consumers,
 };
 
 static struct gpio bq24022_gpios[] = {
@@ -607,7 +964,7 @@ static struct gpio_regulator_config bq24022_info = {
 
 	.enable_gpio = GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
 	.enable_high = 0,
-	.enabled_at_boot = 0,
+	.enabled_at_boot = 1,
 
 	.gpios = bq24022_gpios,
 	.nr_gpios = ARRAY_SIZE(bq24022_gpios),
@@ -621,21 +978,98 @@ static struct gpio_regulator_config bq24022_info = {
 
 static struct platform_device bq24022 = {
 	.name = "gpio-regulator",
-	.id   = -1,
-	.dev  = {
+	.id = 2,
+	.dev = {
 		.platform_data = &bq24022_info,
 	},
 };
 
 /*
+ * fixed regulator for ads7846
+ */
+
+static struct regulator_consumer_supply ads7846_supply =
+	REGULATOR_SUPPLY("vcc", "spi2.0");
+
+static struct regulator_init_data vads7846_regulator = {
+	.constraints = {
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = 1,
+	.consumer_supplies = &ads7846_supply,
+};
+
+static struct fixed_voltage_config vads7846 = {
+	.supply_name = "vads7846",
+	.microvolts = 3300000, /* probably */
+	.gpio = -EINVAL,
+	.startup_delay = 0,
+	.init_data = &vads7846_regulator,
+};
+
+static struct platform_device vads7846_device = {
+	.name = "reg-fixed-voltage",
+	.id = 1,
+	.dev = {
+		.platform_data = &vads7846,
+	},
+};
+
+/*
+ * Vcore regulator MAX1587A
+ */
+
+static struct regulator_consumer_supply magician_max1587a_consumers[] = {
+	REGULATOR_SUPPLY("vcc_core", NULL),
+};
+
+static struct regulator_init_data magician_max1587a_v3_info = {
+	.constraints = {
+		.name		= "vcc_core range",
+		.min_uV		= 700000,
+		.max_uV		= 1500000,
+		.always_on	= 1,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.consumer_supplies	= magician_max1587a_consumers,
+	.num_consumer_supplies	= ARRAY_SIZE(magician_max1587a_consumers),
+};
+
+static struct max1586_subdev_data magician_max1587a_subdevs[] = {
+	{
+		.name		= "vcc_core",
+		.id		= MAX1586_V3,
+		.platform_data	= &magician_max1587a_v3_info,
+	}
+};
+
+static struct max1586_platform_data magician_max1587a_info = {
+	.subdevs     = magician_max1587a_subdevs,
+	.num_subdevs = ARRAY_SIZE(magician_max1587a_subdevs),
+	/*
+	 * NOTICE measured directly on the PCB (board_id == 0x3a), but
+	 * if R24 is present, it will boost the voltage
+	 * (write 1.475V, get 1.645V and smoke)
+	 */
+	.v3_gain     = MAX1586_GAIN_NO_R24,
+};
+
+static struct i2c_board_info magician_pwr_i2c_board_info[] __initdata = {
+	{
+		I2C_BOARD_INFO("max1586", 0x14),
+		.platform_data	= &magician_max1587a_info,
+	},
+};
+
+/*
  * MMC/SD
  */
 
 static int magician_mci_init(struct device *dev,
-				irq_handler_t detect_irq, void *data)
+	irq_handler_t detect_irq, void *data)
 {
 	return request_irq(IRQ_MAGICIAN_SD, detect_irq, 0,
-			   "mmc card detect", data);
+		"mmc card detect", data);
 }
 
 static void magician_mci_exit(struct device *dev, void *data)
@@ -644,15 +1078,40 @@ static void magician_mci_exit(struct device *dev, void *data)
 }
 
 static struct pxamci_platform_data magician_mci_info = {
-	.ocr_mask 		= MMC_VDD_32_33|MMC_VDD_33_34,
-	.init     		= magician_mci_init,
-	.exit     		= magician_mci_exit,
+	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
+	.init			= magician_mci_init,
+	.exit			= magician_mci_exit,
 	.gpio_card_detect	= -1,
 	.gpio_card_ro		= EGPIO_MAGICIAN_nSD_READONLY,
 	.gpio_card_ro_invert	= 1,
 	.gpio_power		= EGPIO_MAGICIAN_SD_POWER,
 };
 
+/*
+ * AUDIO codec UDA1380
+ */
+
+static struct uda1380_platform_data uda1380_info = {
+	.gpio_power = EGPIO_MAGICIAN_CODEC_POWER,
+	.gpio_reset = EGPIO_MAGICIAN_CODEC_RESET,
+	.dac_clk = UDA1380_DAC_CLK_WSPLL,
+};
+
+static struct i2c_board_info magician_audio_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("uda1380", 0x18),
+		.platform_data = &uda1380_info,
+	},
+};
+
+/*
+ * Magician Audio controller
+ */
+
+static struct platform_device magician_audio_device = {
+	.name = "magician-audio",
+	.id = -1,
+};
 
 /*
  * USB OHCI
@@ -660,47 +1119,257 @@ static struct pxamci_platform_data magician_mci_info = {
 
 static struct pxaohci_platform_data magician_ohci_info = {
 	.port_mode	= PMM_PERPORT_MODE,
-	.flags		= ENABLE_PORT1 | ENABLE_PORT3 | POWER_CONTROL_LOW,
+	/* port1: CSR Bluetooth, port2: OTG with UDC */
+	.flags		= ENABLE_PORT1 | ENABLE_PORT2 | POWER_CONTROL_LOW,
 	.power_budget	= 0,
+	.power_on_delay = 100,
 };
 
-
 /*
  * StrataFlash
  */
 
+static int magician_flash_init(struct platform_device *pdev)
+{
+	int ret = gpio_request(EGPIO_MAGICIAN_FLASH_VPP, "flash Vpp enable");
+
+	if (ret) {
+		pr_err("Cannot request flash enable GPIO (%i)\n", ret);
+		return ret;
+	}
+
+	ret = gpio_direction_output(EGPIO_MAGICIAN_FLASH_VPP, 1);
+	if (ret) {
+		pr_err("Cannot set direction for flash enable (%i)\n", ret);
+		gpio_free(EGPIO_MAGICIAN_FLASH_VPP);
+	}
+
+	return ret;
+}
+
 static void magician_set_vpp(struct platform_device *pdev, int vpp)
 {
 	gpio_set_value(EGPIO_MAGICIAN_FLASH_VPP, vpp);
 }
 
+static void magician_flash_exit(struct platform_device *pdev)
+{
+	gpio_free(EGPIO_MAGICIAN_FLASH_VPP);
+}
+
 static struct resource strataflash_resource = {
 	.start = PXA_CS0_PHYS,
-	.end   = PXA_CS0_PHYS + SZ_64M - 1,
+	.end = PXA_CS0_PHYS + SZ_64M - 1,
 	.flags = IORESOURCE_MEM,
 };
 
+static struct mtd_partition magician_flash_parts[] = {
+	{
+		.name = "Bootloader",	/*htc or will uboot?*/
+		.offset = 0x0,
+		.size = 0x40000,
+		.mask_flags = MTD_WRITEABLE,	/* EXPERIMENTAL */
+	},
+	{
+		.name = "Linux Kernel",	/*wince or linux?*/
+		.offset = 0x40000,
+		.size = MTDPART_SIZ_FULL,
+	},
+};
+
+#if 1
+/*
+ * physmap-flash driver
+ */
+
 static struct physmap_flash_data strataflash_data = {
 	.width = 4,
+	.init = magician_flash_init,
 	.set_vpp = magician_set_vpp,
+	.exit = magician_flash_exit,
+	.parts = magician_flash_parts,
+	.nr_parts = ARRAY_SIZE(magician_flash_parts),
 };
 
 static struct platform_device strataflash = {
-	.name          = "physmap-flash",
-	.id            = -1,
-	.resource      = &strataflash_resource,
+	.name = "physmap-flash",
+	.id = -1,
+	.resource = &strataflash_resource,
 	.num_resources = 1,
 	.dev = {
 		.platform_data = &strataflash_data,
 	},
 };
 
+#else
+
 /*
- * I2C
+ * pxa2xx-flash driver
+ */
+
+static struct flash_platform_data magician_flash_data = {
+	.map_name = "cfi_probe",
+	.parts = magician_flash_parts,
+	.nr_parts = ARRAY_SIZE(magician_flash_parts),
+	.width = 2,
+};
+
+static struct platform_device strataflash = {
+	.name = "pxa2xx-flash",
+	.id = -1,
+	.dev = {
+		.platform_data = &magician_flash_data,
+	},
+	.resource = &strataflash_resource,
+	.num_resources = 1,
+};
+#endif
+
+/*
+ * PXA I2C normal controller (main)
  */
 
 static struct i2c_pxa_platform_data i2c_info = {
-	.fast_mode = 1,
+	.fast_mode = 0,	/* fast mode seems to be have bit errors */
+	.use_pio = 0, /* no polling */
+};
+
+/*
+ * PXA I2C power controller
+ */
+
+static struct i2c_pxa_platform_data magician_i2c_power_info = {
+	.fast_mode = 0,
+	.use_pio = 0,
+};
+
+/*
+ * GPIO I2C normal controller (alternative)
+ */
+
+static struct i2c_gpio_platform_data rtc_device_data = {
+	.sda_pin = GPIO118_MAGICIAN_I2C_SDA,
+	.scl_pin = GPIO117_MAGICIAN_I2C_SCL,
+	.udelay = 100
+};
+
+static struct platform_device i2c_gpio_bus_alt = {
+	.name = "i2c-gpio",
+	.id = 0,
+	.dev = {
+		.platform_data = &rtc_device_data,
+	}
+};
+
+/* HID should be configurable through configfs */
+#if 0
+/* hid descriptor for a keyboard */
+static struct hidg_func_descriptor my_hid_data = {
+	.subclass		= 0, /* No subclass */
+	.protocol		= 1, /* Keyboard */
+	.report_length		= 8,
+	.report_desc_length	= 63,
+	.report_desc		= {
+		0x05, 0x01,	/* USAGE_PAGE (Generic Desktop) */
+		0x09, 0x06,	/* USAGE (Keyboard) */
+		0xa1, 0x01,	/* COLLECTION (Application) */
+		0x05, 0x07,	/* USAGE_PAGE (Keyboard) */
+		0x19, 0xe0,	/* USAGE_MINIMUM (Keyboard LeftControl) */
+		0x29, 0xe7,	/* USAGE_MAXIMUM (Keyboard Right GUI) */
+		0x15, 0x00,	/* LOGICAL_MINIMUM (0) */
+		0x25, 0x01,	/* LOGICAL_MAXIMUM (1) */
+		0x75, 0x01,	/* REPORT_SIZE (1) */
+		0x95, 0x08,	/* REPORT_COUNT (8) */
+		0x81, 0x02,	/* INPUT (Data,Var,Abs) */
+		0x95, 0x01,	/* REPORT_COUNT (1) */
+		0x75, 0x08,	/* REPORT_SIZE (8) */
+		0x81, 0x03,	/* INPUT (Cnst,Var,Abs) */
+		0x95, 0x05,	/* REPORT_COUNT (5) */
+		0x75, 0x01,	/* REPORT_SIZE (1) */
+		0x05, 0x08,	/* USAGE_PAGE (LEDs) */
+		0x19, 0x01,	/* USAGE_MINIMUM (Num Lock) */
+		0x29, 0x05,	/* USAGE_MAXIMUM (Kana) */
+		0x91, 0x02,	/* OUTPUT (Data,Var,Abs) */
+		0x95, 0x01,	/* REPORT_COUNT (1) */
+		0x75, 0x03,	/* REPORT_SIZE (3) */
+		0x91, 0x03,	/* OUTPUT (Cnst,Var,Abs) */
+		0x95, 0x06,	/* REPORT_COUNT (6) */
+		0x75, 0x08,	/* REPORT_SIZE (8) */
+		0x15, 0x00,	/* LOGICAL_MINIMUM (0) */
+		0x25, 0x65,	/* LOGICAL_MAXIMUM (101) */
+		0x05, 0x07,	/* USAGE_PAGE (Keyboard) */
+		0x19, 0x00,	/* USAGE_MINIMUM (Reserved) */
+		0x29, 0x65,	/* USAGE_MAXIMUM (Keyboard Application) */
+		0x81, 0x00,	/* INPUT (Data,Ary,Abs) */
+		0xc0		/* END_COLLECTION */
+	}
+};
+
+static struct platform_device my_hid = {
+	.name	= "hidg",
+	.id		= 0,
+	.num_resources		= 0,
+	.resource			= 0,
+	.dev.platform_data	= &my_hid_data,
+};
+#endif
+
+static struct ads7846_platform_data ads7846_pdata = {
+	.model	= 7846,
+	.x_min		= 0,
+	.y_min		= 0,
+	.x_max		= 4096,
+	.y_max		= 4096,
+	.x_plate_ohms	= 320,	/* measured */
+	.y_plate_ohms	= 500,
+	.pressure_max	= 255,	/* up to 12bit sampling */
+	.debounce_max	= 10,
+	.debounce_tol	= 3,
+	.debounce_rep	= 1,
+	.gpio_pendown	= GPIO115_MAGICIAN_nPEN_IRQ,
+	.keep_vref_on	= 1,	/* FIXME, external Vref? */
+	.vref_delay_usecs = 100,
+	/* .wait_for_sync, GPIO77_LCD_BIAS low noise measure, latency! */
+};
+
+struct pxa2xx_spi_chip tsc2046_chip_info = {
+	.tx_threshold = 1,
+	.rx_threshold = 2,
+	.timeout = 64,
+	.gpio_cs = -1,
+};
+
+static struct pxa2xx_spi_master magician_spi_info = {
+	.num_chipselect = 1,
+/*	.enable_dma = 1, */ /* FIXME probably unnecessary */
+};
+
+static struct spi_board_info ads7846_spi_board_info[] __initdata = {
+	{
+		.modalias		= "ads7846",
+		.bus_num		= 2,
+		.max_speed_hz	= 1857143,
+		.platform_data	= &ads7846_pdata,
+		.controller_data	= &tsc2046_chip_info,
+		.irq	= PXA_GPIO_TO_IRQ(GPIO115_MAGICIAN_nPEN_IRQ),
+	},
+};
+
+/*
+ * Global GPIOs
+ */
+
+static struct gpio magician_global_gpios[] = {
+	{ GPIO13_MAGICIAN_CPLD_IRQ, GPIOF_IN, "CPLD_IRQ" },
+	{ GPIO107_MAGICIAN_DS1WM_IRQ, GPIOF_IN, "DS1WM_IRQ" },
+
+	/* NOTICE valid LCD init sequence */
+	{ GPIO106_MAGICIAN_LCD_DCDC_NRESET, GPIOF_OUT_INIT_HIGH,
+		"LCD DCDC nreset" },
+	{ GPIO104_MAGICIAN_LCD_VOFF_EN, GPIOF_OUT_INIT_HIGH,
+		"LCD VOFF enable" },
+	{ GPIO105_MAGICIAN_LCD_VON_EN, GPIOF_OUT_INIT_HIGH,
+		"LCD VON enable" },
 };
 
 /*
@@ -708,24 +1377,35 @@ static struct i2c_pxa_platform_data i2c_info = {
  */
 
 static struct platform_device *devices[] __initdata = {
-	&gpio_keys,
 	&egpio,
-	&backlight,
 	&pasic3,
-	&bq24022,
-	&gpio_vbus,
-	&power_supply,
+	&gpio_keys,
+	&magician_camera,
+	&vads7846_device,
 	&strataflash,
 	&leds_gpio,
-};
+	&magician_audio_device,
 
-static struct gpio magician_global_gpios[] = {
-	{ GPIO13_MAGICIAN_CPLD_IRQ,   GPIOF_IN, "CPLD_IRQ" },
-	{ GPIO107_MAGICIAN_DS1WM_IRQ, GPIOF_IN, "DS1WM_IRQ" },
-	{ GPIO104_MAGICIAN_LCD_POWER_1, GPIOF_OUT_INIT_LOW, "LCD power 1" },
-	{ GPIO105_MAGICIAN_LCD_POWER_2, GPIOF_OUT_INIT_LOW, "LCD power 2" },
-	{ GPIO106_MAGICIAN_LCD_POWER_3, GPIOF_OUT_INIT_LOW, "LCD power 3" },
-	{ GPIO83_MAGICIAN_nIR_EN, GPIOF_OUT_INIT_HIGH, "nIR_EN" },
+	/* NOTICE mutually exclusive */
+	&power_supply,
+	&bq24022,
+
+	/* NOTICE mutually exclusive with UDC*/
+#if !(IS_ENABLED(CONFIG_USB_PXA27X))
+	&gpio_vbus,
+#endif
+
+	/* NOTICE mutually exclusive with PXA I2C */
+	&i2c_gpio_bus_alt,
+
+	/* NOTICE mutually exclusive */
+	&pwm_backlight,
+	&gpio_backlight,
+
+	&lirc_gpio,
+#if 0
+	&my_hid,	/* HID should be configurable through configfs */
+#endif
 };
 
 static void __init magician_init(void)
@@ -735,21 +1415,27 @@ static void __init magician_init(void)
 	int err;
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(magician_pin_config));
+
 	err = gpio_request_array(ARRAY_AND_SIZE(magician_global_gpios));
 	if (err)
-		pr_err("magician: Failed to request GPIOs: %d\n", err);
+		pr_err("magician: Failed to request global GPIOs: %d\n", err);
 
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
-
-	platform_add_devices(ARRAY_AND_SIZE(devices));
-
 	pxa_set_ficp_info(&magician_ficp_info);
-	pxa27x_set_i2c_power_info(NULL);
+
+	pxa27x_set_i2c_power_info(&magician_i2c_power_info);
 	pxa_set_i2c_info(&i2c_info);
+
+	i2c_register_board_info(0,
+		ARRAY_AND_SIZE(magician_audio_i2c_devices));
+	i2c_register_board_info(1,
+		ARRAY_AND_SIZE(magician_pwr_i2c_board_info));
+
 	pxa_set_mci_info(&magician_mci_info);
 	pxa_set_ohci_info(&magician_ohci_info);
+	pxa_set_udc_info(&magician_udc_info);
 
 	/* Check LCD type we have */
 	cpld = ioremap_nocache(PXA_CS3_PHYS, 0x1000);
@@ -758,15 +1444,29 @@ static void __init magician_init(void)
 		iounmap(cpld);
 		system_rev = board_id & 0x7;
 		lcd_select = board_id & 0x8;
-		pr_info("LCD type: %s\n", lcd_select ? "Samsung" : "Toppoly");
+		pr_info("LCD type: %s, board type: 0x%02x\n",
+			lcd_select ? "Samsung" : "Toppoly",
+			board_id);
+
 		if (lcd_select && (system_rev < 3))
+			/* NOTICE valid LCD init sequence */
 			gpio_request_one(GPIO75_MAGICIAN_SAMSUNG_POWER,
-			                 GPIOF_OUT_INIT_LOW, "SAMSUNG_POWER");
+				GPIOF_OUT_INIT_HIGH, "LCD Samsung Power");
+
 		pxa_set_fb_info(NULL, lcd_select ? &samsung_info : &toppoly_info);
 	} else
 		pr_err("LCD detection: CPLD mapping failed\n");
-}
 
+	pxa2xx_set_spi_info(2, &magician_spi_info);
+	spi_register_board_info(ARRAY_AND_SIZE(ads7846_spi_board_info));
+
+	pxa_set_camera_info(&magician_pxacamera_pdata);
+
+	regulator_register_always_on(0, "power", pwm_backlight_supply,
+		ARRAY_SIZE(pwm_backlight_supply), 5000000);
+
+	platform_add_devices(ARRAY_AND_SIZE(devices));
+}
 
 MACHINE_START(MAGICIAN, "HTC Magician")
 	.atag_offset = 0x100,
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 9ad35f7..516ba65 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -586,6 +586,15 @@ config LEDS_PM8941_WLED
 	  This option enables support for the 'White' LED block
 	  on Qualcomm PM8941 PMICs.
 
+config LEDS_PASIC3
+	tristate "LED support for the HTC Magician/Alpine PASIC3"
+	depends on LEDS_CLASS
+	depends on HTC_PASIC3
+	select REGMAP
+	help
+	  This option enables support for the PASIC3 chip (different chip
+	  than Compaq ASIC3).
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 8d6a24a..b1c659c 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_LEDS_VERSATILE)		+= leds-versatile.o
 obj-$(CONFIG_LEDS_MENF21BMC)		+= leds-menf21bmc.o
 obj-$(CONFIG_LEDS_PM8941_WLED)		+= leds-pm8941-wled.o
 obj-$(CONFIG_LEDS_KTD2692)		+= leds-ktd2692.o
+obj-$(CONFIG_LEDS_PASIC3)		+= leds-pasic3.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/drivers/leds/leds-pasic3.c b/drivers/leds/leds-pasic3.c
new file mode 100644
index 0000000..ecb0557
--- /dev/null
+++ b/drivers/leds/leds-pasic3.c
@@ -0,0 +1,192 @@
+/*
+ * AIC3 (or PASIC3) LED driver for HTC Magician/Alpine/.. (not Compaq ASIC3)
+ *
+ * Copyright (c) 2015 Petr Cvek <petr.cvek@tul.cz>
+ *
+ * Based on leds-asic3.c driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/slab.h>
+
+#include <linux/mfd/htc-pasic3.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+
+/*
+ * 1 tick is around 62-63 ms, blinking settings (on+off):
+ *	Min: 1+1 ticks ~125ms
+ *	Max: 127+127 ticks ~15?875ms
+ * Sometimes takes time to change after write (counter overflow?)
+ */
+
+#define MS_TO_CLK(ms)	DIV_ROUND_CLOSEST(((ms)*1024), 64000)
+#define CLK_TO_MS(clk)	(((clk)*64000)/1024)
+#define MAX_CLK		254		/* 127 + 127 (2x 7 bit reg) */
+#define MAX_MS		CLK_TO_MS(MAX_CLK)
+
+static void brightness_set(struct led_classdev *cdev,
+	enum led_brightness value)
+{
+	struct platform_device *pdev = to_platform_device(cdev->dev->parent);
+	const struct mfd_cell *cell = mfd_get_cell(pdev);
+	struct pasic3_led *led;
+	struct device *dev;
+	u8 val;
+
+	if (!cell->platform_data) {
+		pr_err("No platform data\n");
+		return;
+	}
+
+	led = cell->platform_data;
+	dev = pdev->dev.parent;
+
+	if (value == LED_OFF) {
+		val = pasic3_read_register(dev, PASIC3_CH_CONTROL);
+		pasic3_write_register(dev, PASIC3_CH_CONTROL,
+			val & ~(led->bit_blink_en | led->bit_force_on));
+
+		val = pasic3_read_register(dev, PASIC3_MASK_A);
+		pasic3_write_register(dev, PASIC3_MASK_A, val & ~led->bit_mask);
+	} else {
+		val = pasic3_read_register(dev, PASIC3_CH_CONTROL);
+		pasic3_write_register(dev, PASIC3_CH_CONTROL,
+			val | led->bit_force_on);
+	}
+}
+
+static int blink_set(struct led_classdev *cdev,
+	unsigned long *delay_on,
+	unsigned long *delay_off)
+{
+	struct platform_device *pdev = to_platform_device(cdev->dev->parent);
+	const struct mfd_cell *cell = mfd_get_cell(pdev);
+	struct device *dev;
+	struct pasic3_led *led;
+	u32 on, off;
+	u8 val;
+
+	if (!cell->platform_data) {
+		pr_err("No platform data\n");
+		return -EINVAL;
+	}
+
+	if (*delay_on > MAX_MS || *delay_off > MAX_MS)
+		return -EINVAL;
+
+	if (*delay_on == 0 && *delay_off == 0) {
+		/* If both are zero then a sensible default should be chosen */
+		on = MS_TO_CLK(500);
+		off = MS_TO_CLK(500);
+	} else {
+		on = MS_TO_CLK(*delay_on);
+		off = MS_TO_CLK(*delay_off);
+		if ((on + off) > MAX_CLK)
+			return -EINVAL;
+		/* Minimal value must be 1 */
+		on = on ? on : 1;
+		off = off ? off : 1;
+	}
+
+	led = cell->platform_data;
+	dev = pdev->dev.parent;
+
+	pasic3_write_register(dev, led->reg_delay_on, on);
+	pasic3_write_register(dev, led->reg_delay_off, off);
+
+	val = pasic3_read_register(dev, PASIC3_CH_CONTROL);
+	pasic3_write_register(dev, PASIC3_CH_CONTROL, val | led->bit_blink_en);
+
+	*delay_on = CLK_TO_MS(on);
+	*delay_off = CLK_TO_MS(off);
+
+	return 0;
+}
+
+static int pasic3_led_probe(struct platform_device *pdev)
+{
+	struct pasic3_led *led = dev_get_platdata(&pdev->dev);
+	int ret;
+
+	ret = mfd_cell_enable(pdev);
+	if (ret < 0)
+		return ret;
+
+	led->cdev.flags = LED_CORE_SUSPENDRESUME;
+	led->cdev.brightness_set = brightness_set;
+	led->cdev.blink_set = blink_set;
+
+	ret = led_classdev_register(&pdev->dev, &led->cdev);
+	if (ret < 0)
+		goto out;
+
+	return 0;
+
+out:
+	(void) mfd_cell_disable(pdev);
+	return ret;
+}
+
+static int pasic3_led_remove(struct platform_device *pdev)
+{
+	struct pasic3_led *led = dev_get_platdata(&pdev->dev);
+
+	led_classdev_unregister(&led->cdev);
+
+	return mfd_cell_disable(pdev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int pasic3_led_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	const struct mfd_cell *cell = mfd_get_cell(pdev);
+	int ret;
+
+	ret = 0;
+	if (cell->suspend)
+		ret = (*cell->suspend)(pdev);
+
+	return ret;
+}
+
+static int pasic3_led_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	const struct mfd_cell *cell = mfd_get_cell(pdev);
+	int ret;
+
+	ret = 0;
+	if (cell->resume)
+		ret = (*cell->resume)(pdev);
+
+	return ret;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(pasic3_led_pm_ops, pasic3_led_suspend,
+	pasic3_led_resume);
+
+static struct platform_driver pasic3_led_driver = {
+	.probe		= pasic3_led_probe,
+	.remove		= pasic3_led_remove,
+	.driver		= {
+		.name	= "leds-pasic3",
+		.pm	= &pasic3_led_pm_ops,
+	},
+};
+
+module_platform_driver(pasic3_led_driver);
+
+MODULE_AUTHOR("Petr Cvek <petr.cvek@tul.cz>");
+MODULE_DESCRIPTION("HTC Magician PASIC3 LED driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:leds-pasic3");
diff --git a/drivers/mfd/htc-pasic3.c b/drivers/mfd/htc-pasic3.c
index e88d4f6..3df3f0a 100644
--- a/drivers/mfd/htc-pasic3.c
+++ b/drivers/mfd/htc-pasic3.c
@@ -3,6 +3,9 @@
  *
  * Copyright (C) 2006 Philipp Zabel <philipp.zabel@gmail.com>
  *
+ * LED support:
+ * Copyright (C) 2015 Petr Cvek <petr.cvek@tul.cz>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; version 2 of the License.
@@ -65,8 +68,76 @@ EXPORT_SYMBOL(pasic3_read_register); /* for leds-pasic3 */
  * LEDs
  */
 
-static struct mfd_cell led_cell __initdata = {
-	.name = "leds-pasic3",
+
+static int pasic3_leds_enable(struct platform_device *pdev)
+{
+	const struct mfd_cell *cell = mfd_get_cell(pdev);
+	struct pasic3_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct pasic3_led *led;
+
+	led = cell->platform_data;
+	pdata = led->pdata;
+
+	gpio_set_value(pdata->power_gpio, 1);
+
+	return 0;
+}
+
+static int pasic3_leds_disable(struct platform_device *pdev)
+{
+	const struct mfd_cell *cell = mfd_get_cell(pdev);
+	struct pasic3_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct pasic3_led *led;
+
+	led = cell->platform_data;
+	pdata = led->pdata;
+
+	gpio_set_value(pdata->power_gpio, 0);
+
+	return 0;
+}
+
+static int pasic3_leds_suspend(struct platform_device *pdev)
+{
+	const struct mfd_cell *cell = mfd_get_cell(pdev);
+	struct pasic3_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct pasic3_led *led;
+
+	led = cell->platform_data;
+	pdata = led->pdata;
+
+	gpio_set_value(pdata->power_gpio, 0);
+
+	return 0;
+}
+
+#define PASIC3_NUM_LEDS 3
+
+static struct mfd_cell pasic3_cell_leds[PASIC3_NUM_LEDS] = {
+	[0] = {
+		.name		= "leds-pasic3",
+		.id			= 0,
+		.enable		= pasic3_leds_enable,
+		.disable	= pasic3_leds_disable,
+		.suspend	= pasic3_leds_suspend,
+		.resume		= pasic3_leds_enable,
+	},
+	[1] = {
+		.name		= "leds-pasic3",
+		.id			= 1,
+		.enable		= pasic3_leds_enable,
+		.disable	= pasic3_leds_disable,
+		.suspend	= pasic3_leds_suspend,
+		.resume		= pasic3_leds_enable,
+	},
+	[2] = {
+		.name		= "leds-pasic3",
+		.id			= 2,
+		.enable		= pasic3_leds_enable,
+		.disable	= pasic3_leds_disable,
+		.suspend	= pasic3_leds_suspend,
+		.resume		= pasic3_leds_enable,
+	},
 };
 
 /*
@@ -78,10 +149,10 @@ static int ds1wm_enable(struct platform_device *pdev)
 	struct device *dev = pdev->dev.parent;
 	int c;
 
-	c = pasic3_read_register(dev, 0x28);
-	pasic3_write_register(dev, 0x28, c & 0x7f);
+	c = pasic3_read_register(dev, PASIC3_GPIO);
+	pasic3_write_register(dev, PASIC3_GPIO, c & ~DS1WM_nEN);
 
-	dev_dbg(dev, "DS1WM OWM_EN low (active) %02x\n", c & 0x7f);
+	dev_dbg(dev, "DS1WM OWM_EN low (active) %02x\n", c & ~DS1WM_nEN);
 	return 0;
 }
 
@@ -90,10 +161,10 @@ static int ds1wm_disable(struct platform_device *pdev)
 	struct device *dev = pdev->dev.parent;
 	int c;
 
-	c = pasic3_read_register(dev, 0x28);
-	pasic3_write_register(dev, 0x28, c | 0x80);
+	c = pasic3_read_register(dev, PASIC3_GPIO);
+	pasic3_write_register(dev, PASIC3_GPIO, c | DS1WM_nEN);
 
-	dev_dbg(dev, "DS1WM OWM_EN high (inactive) %02x\n", c | 0x80);
+	dev_dbg(dev, "DS1WM OWM_EN high (inactive) %02x\n", c | DS1WM_nEN);
 	return 0;
 }
 
@@ -172,13 +243,27 @@ static int __init pasic3_probe(struct platform_device *pdev)
 			dev_warn(dev, "failed to register DS1WM\n");
 	}
 
-	if (pdata && pdata->led_pdata) {
-		led_cell.platform_data = pdata->led_pdata;
-		led_cell.pdata_size = sizeof(struct pasic3_leds_machinfo);
-		ret = mfd_add_devices(&pdev->dev, pdev->id, &led_cell, 1, r,
-				      0, NULL);
+	if (pdata && pdata->leds) {
+		int i;
+
+		for (i = 0; i < PASIC3_NUM_LEDS; ++i) {
+			pdata->leds[i].pdata = pdata;
+			pasic3_cell_leds[i].platform_data = &pdata->leds[i];
+			pasic3_cell_leds[i].pdata_size = sizeof(pdata->leds[i]);
+		}
+		ret = mfd_add_devices(&pdev->dev, 0,
+			pasic3_cell_leds, PASIC3_NUM_LEDS, NULL, 0, NULL);
+
 		if (ret < 0)
 			dev_warn(dev, "failed to register LED device\n");
+
+		if (pdata->power_gpio) {
+			ret = gpio_request(pdata->power_gpio,
+				"Red-Blue LED Power");
+			if (ret < 0)
+				dev_warn(dev, "failed to request power GPIO\n");
+		}
+
 	}
 
 	return 0;
@@ -187,10 +272,14 @@ static int __init pasic3_probe(struct platform_device *pdev)
 static int pasic3_remove(struct platform_device *pdev)
 {
 	struct pasic3_data *asic = platform_get_drvdata(pdev);
+	struct pasic3_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct resource *r;
 
 	mfd_remove_devices(&pdev->dev);
 
+	if (pdata->power_gpio)
+		gpio_free(pdata->power_gpio);
+
 	iounmap(asic->mapping);
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(r->start, resource_size(r));
diff --git a/include/linux/mfd/htc-pasic3.h b/include/linux/mfd/htc-pasic3.h
index 3d3ed67..e8e4cd2 100644
--- a/include/linux/mfd/htc-pasic3.h
+++ b/include/linux/mfd/htc-pasic3.h
@@ -18,36 +18,65 @@
 extern void pasic3_write_register(struct device *dev, u32 reg, u8 val);
 extern u8 pasic3_read_register(struct device *dev, u32 reg);
 
-/*
- * mask for registers 0x20,0x21,0x22
- */
-#define PASIC3_MASK_LED0 0x04
-#define PASIC3_MASK_LED1 0x08
-#define PASIC3_MASK_LED2 0x40
+#define PASIC3_CH0_DELAY_ON		0x00
+#define PASIC3_CH0_DELAY_OFF	0x01
+#define PASIC3_CH1_DELAY_ON		0x02
+#define PASIC3_CH1_DELAY_OFF	0x03
+#define PASIC3_CH2_DELAY_ON		0x04
+#define PASIC3_CH2_DELAY_OFF	0x05
+#define PASIC3_DELAY_MASK		0x7f
+
+#define PASIC3_CH_CONTROL		0x06
+#define		R06_CH0_EN			(1<<0)
+#define		R06_CH1_EN			(1<<1)
+#define		R06_CH2_EN			(1<<2)
+#define		R06_CH0_FORCE_ON	(1<<3)
+#define		R06_CH1_FORCE_ON	(1<<4)
+#define		R06_CH2_FORCE_ON	(1<<5)
 
 /*
- * bits in register 0x06
+ * pwm_ch0_out | force_on | (bit0 & bit1 & bit2)
+ * pwm_ch1_out | force_on | (bit0 & bit1 & bit2)
+ * pwm_ch2_out | force_on | (bit2?bit0:(bit0 & ! bit1))
  */
-#define PASIC3_BIT2_LED0 0x08
-#define PASIC3_BIT2_LED1 0x10
-#define PASIC3_BIT2_LED2 0x20
+
+#define PASIC3_MASK_A	0x20
+#define PASIC3_MASK_B	0x21
+#define PASIC3_MASK_C	0x22
+#define  MASK_CH0	(1<<2)
+#define  MASK_CH1	(1<<3)
+#define  MASK_CH2	(1<<6)
+#define  PASIC3_GPIO	0x28
+
+#define	DS1WM_nEN	(1<<7)
+#define  PASIC3_SYS	0x2a
+/* NORMAL_RST, CAM_PWR_RST and UNKNOWN will autoclear, set STATUS */
+#define  NORMAL_RST		(1<<0)
+#define  CAM_PWR_RST	(1<<1)
+#define  UNKNOWN		(1<<2)
+#define  STATUS_NORMAL_RST	(1<<4)
+#define  STATUS_CAM_PWR_RST	(1<<5)
+#define  STATUS_UNKNOWN		(1<<6)
+
+#define PASIC3_RST_EN		0x2c
+#define  EN_NORMAL_RST	0x40
+#define  EN_DOOR_RST	0x42
 
 struct pasic3_led {
-	struct led_classdev         led;
-	unsigned int                hw_num;
-	unsigned int                bit2;
-	unsigned int                mask;
-	struct pasic3_leds_machinfo *pdata;
+	struct led_classdev		cdev;
+	unsigned int	hw_num;
+	unsigned char	bit_blink_en;
+	unsigned char	bit_force_on;
+	unsigned char	bit_mask;
+	unsigned char	reg_delay_on;
+	unsigned char	reg_delay_off;
+	struct pasic3_platform_data *pdata;
 };
 
-struct pasic3_leds_machinfo {
+struct pasic3_platform_data {
 	unsigned int      num_leds;
 	unsigned int      power_gpio;
 	struct pasic3_led *leds;
-};
-
-struct pasic3_platform_data {
-	struct pasic3_leds_machinfo *led_pdata;
 	unsigned int                 clock_rate;
 };
 
-- 
1.7.12.1
