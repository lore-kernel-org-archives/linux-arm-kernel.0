From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 16 Feb 2011 09:07:05 +0100
Subject: [PATCH 2/3] mach-ux500: add hrefv60 GPIO pins
Message-ID: <1297843625-6764-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bibek Basu <bibek.basu@stericsson.com>

This will centralize all GPIO pin muxing for the different boards
in the MOP500 family to a single file. It also kills off the
deprecated support for the ED (Early Drop) ASIC, this should
never be spotted in the open and ST-Ericsson have internally
deprecated this hardware.

Signed-off-by: Bibek Basu <bibek.basu@stericsson.com>
[Rebasing and kill old ASIC support]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-pins.c |  225 ++++++++++++++++++++++++++-----
 arch/arm/mach-ux500/board-mop500-sdi.c  |   65 +--------
 2 files changed, 200 insertions(+), 90 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index edd3a6b..fd4cf1c 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -8,19 +8,13 @@
 #include <linux/init.h>
 #include <linux/gpio.h>
 
+#include <asm/mach-types.h>
 #include <plat/pincfg.h>
-
 #include <mach/hardware.h>
 
 #include "pins-db8500.h"
 
-static pin_cfg_t mop500_pins[] = {
-	/* SSP0 */
-	GPIO143_SSP0_CLK,
-	GPIO144_SSP0_FRM,
-	GPIO145_SSP0_RXD,
-	GPIO146_SSP0_TXD,
-
+static pin_cfg_t mop500_pins_common[] = {
 	/* I2C */
 	GPIO147_I2C0_SCL,
 	GPIO148_I2C0_SDA,
@@ -31,6 +25,72 @@ static pin_cfg_t mop500_pins[] = {
 	GPIO229_I2C3_SDA,
 	GPIO230_I2C3_SCL,
 
+	/* MSP0 */
+	GPIO12_MSP0_TXD,
+	GPIO13_MSP0_TFS,
+	GPIO14_MSP0_TCK,
+	GPIO15_MSP0_RXD,
+
+	/* MSP2: HDMI */
+	GPIO193_MSP2_TXD,
+	GPIO194_MSP2_TCK,
+	GPIO195_MSP2_TFS,
+	GPIO196_MSP2_RXD | PIN_OUTPUT_LOW,
+
+	/* Touch screen INTERFACE */
+	GPIO84_GPIO	| PIN_INPUT_PULLUP, /* TOUCH_INT1 */
+
+	/* STMPE1601/tc35893 keypad  IRQ */
+	GPIO218_GPIO	| PIN_INPUT_PULLUP,
+
+	/* MMC0 (MicroSD card) */
+	GPIO18_MC0_CMDDIR	| PIN_OUTPUT_HIGH,
+	GPIO19_MC0_DAT0DIR	| PIN_OUTPUT_HIGH,
+	GPIO20_MC0_DAT2DIR	| PIN_OUTPUT_HIGH,
+
+	GPIO22_MC0_FBCLK	| PIN_INPUT_NOPULL,
+	GPIO23_MC0_CLK		| PIN_OUTPUT_LOW,
+	GPIO24_MC0_CMD		| PIN_INPUT_PULLUP,
+	GPIO25_MC0_DAT0		| PIN_INPUT_PULLUP,
+	GPIO26_MC0_DAT1		| PIN_INPUT_PULLUP,
+	GPIO27_MC0_DAT2		| PIN_INPUT_PULLUP,
+	GPIO28_MC0_DAT3		| PIN_INPUT_PULLUP,
+
+	/* SDI1 (SDIO) */
+	GPIO208_MC1_CLK		| PIN_OUTPUT_LOW,
+	GPIO209_MC1_FBCLK	| PIN_INPUT_NOPULL,
+	GPIO210_MC1_CMD		| PIN_INPUT_PULLUP,
+	GPIO211_MC1_DAT0	| PIN_INPUT_PULLUP,
+	GPIO212_MC1_DAT1	| PIN_INPUT_PULLUP,
+	GPIO213_MC1_DAT2	| PIN_INPUT_PULLUP,
+	GPIO214_MC1_DAT3	| PIN_INPUT_PULLUP,
+
+	/* MMC2 (On-board DATA INTERFACE eMMC) */
+	GPIO128_MC2_CLK		| PIN_OUTPUT_LOW,
+	GPIO129_MC2_CMD		| PIN_INPUT_PULLUP,
+	GPIO130_MC2_FBCLK	| PIN_INPUT_NOPULL,
+	GPIO131_MC2_DAT0	| PIN_INPUT_PULLUP,
+	GPIO132_MC2_DAT1	| PIN_INPUT_PULLUP,
+	GPIO133_MC2_DAT2	| PIN_INPUT_PULLUP,
+	GPIO134_MC2_DAT3	| PIN_INPUT_PULLUP,
+	GPIO135_MC2_DAT4	| PIN_INPUT_PULLUP,
+	GPIO136_MC2_DAT5	| PIN_INPUT_PULLUP,
+	GPIO137_MC2_DAT6	| PIN_INPUT_PULLUP,
+	GPIO138_MC2_DAT7	| PIN_INPUT_PULLUP,
+
+	/* MMC4 (On-board STORAGE INTERFACE eMMC) */
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
 	/* SKE keypad */
 	GPIO153_KP_I7,
 	GPIO154_KP_I6,
@@ -49,32 +109,133 @@ static pin_cfg_t mop500_pins[] = {
 	GPIO167_KP_O1,
 	GPIO168_KP_O0,
 
-	/* GPIO_EXP_INT */
-	GPIO217_GPIO,
-
-	/* STMPE1601 IRQ */
-	GPIO218_GPIO    | PIN_INPUT_PULLUP,
-
-	/* touch screen */
-	GPIO84_GPIO     | PIN_INPUT_PULLUP,
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
+	/* UART */
+	GPIO0_U0_CTSn	| PIN_INPUT_PULLUP,
+	GPIO1_U0_RTSn	| PIN_OUTPUT_HIGH,
+	GPIO2_U0_RXD	| PIN_INPUT_PULLUP,
+	GPIO3_U0_TXD	| PIN_OUTPUT_HIGH,
+
+	GPIO29_U2_RXD	| PIN_INPUT_PULLUP,
+	GPIO30_U2_TXD	| PIN_OUTPUT_HIGH,
+	GPIO31_U2_CTSn	| PIN_INPUT_PULLUP,
+	GPIO32_U2_RTSn	| PIN_OUTPUT_HIGH,
+
+	/* Display & HDMI HW sync */
+	GPIO68_LCD_VSI0	| PIN_INPUT_PULLUP,
+	GPIO69_LCD_VSI1	| PIN_INPUT_PULLUP,
+};
+
+static pin_cfg_t mop500_pins_default[] = {
+	/* SSP0 */
+	GPIO143_SSP0_CLK,
+	GPIO144_SSP0_FRM,
+	GPIO145_SSP0_RXD | PIN_PULL_DOWN,
+	GPIO146_SSP0_TXD,
+
+
+	GPIO217_GPIO	| PIN_INPUT_PULLUP, /* TC35892 IRQ */
+
+	/* SDI0 (MicroSD card) */
+	GPIO21_MC0_DAT31DIR	| PIN_OUTPUT_HIGH,
+
+	/* UART */
+	GPIO4_U1_RXD	| PIN_INPUT_PULLUP,
+	GPIO5_U1_TXD	| PIN_OUTPUT_HIGH,
+	GPIO6_U1_CTSn	| PIN_INPUT_PULLUP,
+	GPIO7_U1_RTSn	| PIN_OUTPUT_HIGH,
+};
+
+static pin_cfg_t mop500_pins_hrefv60[] = {
+	/* WLAN */
+	GPIO4_GPIO		| PIN_INPUT_PULLUP,/* WLAN_IRQ */
+	GPIO85_GPIO		| PIN_OUTPUT_LOW,/* WLAN_ENA */
+
+	/* XENON Flashgun INTERFACE */
+	GPIO6_IP_GPIO0	| PIN_INPUT_PULLUP,/* XENON_FLASH_ID */
+	GPIO7_IP_GPIO1	| PIN_INPUT_PULLUP,/* XENON_READY */
+	GPIO170_GPIO	| PIN_OUTPUT_LOW, /* XENON_CHARGE */
+
+	/* Assistant LED INTERFACE */
+	GPIO21_GPIO | PIN_OUTPUT_LOW,  /* XENON_EN1 */
+	GPIO64_IP_GPIO4 | PIN_OUTPUT_LOW,  /* XENON_EN2 */
+
+	/* Magnetometer */
+	GPIO31_GPIO | PIN_INPUT_PULLUP,  /* magnetometer_INT */
+	GPIO32_GPIO | PIN_INPUT_PULLDOWN, /* Magnetometer DRDY */
+
+	/* Display Interface */
+	GPIO65_GPIO		| PIN_OUTPUT_LOW, /* DISP1 RST */
+	GPIO66_GPIO		| PIN_OUTPUT_LOW, /* DISP2 RST */
+
+	/* Touch screen INTERFACE */
+	GPIO143_GPIO	| PIN_OUTPUT_LOW,/*TOUCH_RST1 */
+
+	/* Touch screen INTERFACE 2 */
+	GPIO67_GPIO	| PIN_INPUT_PULLUP, /* TOUCH_INT2 */
+	GPIO146_GPIO	| PIN_OUTPUT_LOW,/*TOUCH_RST2 */
+
+	/* ETM_PTM_TRACE INTERFACE */
+	GPIO70_GPIO	| PIN_OUTPUT_LOW,/* ETM_PTM_DATA23 */
+	GPIO71_GPIO	| PIN_OUTPUT_LOW,/* ETM_PTM_DATA22 */
+	GPIO72_GPIO	| PIN_OUTPUT_LOW,/* ETM_PTM_DATA21 */
+	GPIO73_GPIO	| PIN_OUTPUT_LOW,/* ETM_PTM_DATA20 */
+	GPIO74_GPIO	| PIN_OUTPUT_LOW,/* ETM_PTM_DATA19 */
+
+	/* NAHJ INTERFACE */
+	GPIO76_GPIO	| PIN_OUTPUT_LOW,/* NAHJ_CTRL */
+	GPIO216_GPIO	| PIN_OUTPUT_HIGH,/* NAHJ_CTRL_INV */
+
+	/* NFC INTERFACE */
+	GPIO77_GPIO	| PIN_OUTPUT_LOW, /* NFC_ENA */
+	GPIO144_GPIO	| PIN_INPUT_PULLDOWN, /* NFC_IRQ */
+	GPIO142_GPIO	| PIN_OUTPUT_LOW, /* NFC_RESET */
+
+	/* Keyboard MATRIX INTERFACE */
+	GPIO90_MC5_CMD	| PIN_OUTPUT_LOW, /* KP_O_1 */
+	GPIO87_MC5_DAT1	| PIN_OUTPUT_LOW, /* KP_O_2 */
+	GPIO86_MC5_DAT0	| PIN_OUTPUT_LOW, /* KP_O_3 */
+	GPIO96_KP_O6	| PIN_OUTPUT_LOW, /* KP_O_6 */
+	GPIO94_KP_O7	| PIN_OUTPUT_LOW, /* KP_O_7 */
+	GPIO93_MC5_DAT4	| PIN_INPUT_PULLUP, /* KP_I_0 */
+	GPIO89_MC5_DAT3	| PIN_INPUT_PULLUP, /* KP_I_2 */
+	GPIO88_MC5_DAT2	| PIN_INPUT_PULLUP, /* KP_I_3 */
+	GPIO91_GPIO	| PIN_INPUT_PULLUP, /* FORCE_SENSING_INT */
+	GPIO92_GPIO	| PIN_OUTPUT_LOW, /* FORCE_SENSING_RST */
+	GPIO97_GPIO	| PIN_OUTPUT_LOW, /* FORCE_SENSING_WU */
+
+	/* DiPro Sensor Interface */
+	GPIO139_GPIO	| PIN_INPUT_PULLUP, /* DIPRO_INT */
+
+	/* HAL SWITCH INTERFACE */
+	GPIO145_GPIO	| PIN_INPUT_PULLDOWN,/* HAL_SW */
+
+	/* Audio Amplifier Interface */
+	GPIO149_GPIO	| PIN_OUTPUT_LOW, /* VAUDIO_HF_EN */
+
+	/* GBF INTERFACE */
+	GPIO171_GPIO	| PIN_OUTPUT_LOW, /* GBF_ENA_RESET */
+
+	/* MSP : HDTV INTERFACE */
+	GPIO192_GPIO	| PIN_INPUT_PULLDOWN,
+
+	/* ACCELEROMETER_INTERFACE */
+	GPIO82_GPIO		| PIN_INPUT_PULLUP, /* ACC_INT1 */
+	GPIO83_GPIO		| PIN_INPUT_PULLUP, /* ACC_INT2 */
+
+	/* Proximity Sensor */
+	GPIO217_GPIO		| PIN_INPUT_PULLUP,
+
+
 };
 
 void __init mop500_pins_init(void)
 {
-	nmk_config_pins(mop500_pins,
-				ARRAY_SIZE(mop500_pins));
+	nmk_config_pins(mop500_pins_common,
+				ARRAY_SIZE(mop500_pins_common));
+	if (machine_is_hrefv60())
+		nmk_config_pins(mop500_pins_hrefv60,
+				ARRAY_SIZE(mop500_pins_hrefv60));
+	else
+		nmk_config_pins(mop500_pins_default,
+				ARRAY_SIZE(mop500_pins_default));
 }
diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index d1ae6a0..68c8375 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -12,59 +12,14 @@
 #include <linux/mmc/host.h>
 #include <linux/platform_device.h>
 
-#include <plat/pincfg.h>
 #include <plat/ste_dma40.h>
 #include <mach/devices.h>
 #include <mach/hardware.h>
 
 #include "devices-db8500.h"
-#include "pins-db8500.h"
 #include "board-mop500.h"
 #include "ste-dma40-db8500.h"
 
-static pin_cfg_t mop500_sdi_pins[] = {
-	/* SDI0 (MicroSD slot) */
-	GPIO18_MC0_CMDDIR,
-	GPIO19_MC0_DAT0DIR,
-	GPIO20_MC0_DAT2DIR,
-	GPIO21_MC0_DAT31DIR,
-	GPIO22_MC0_FBCLK,
-	GPIO23_MC0_CLK,
-	GPIO24_MC0_CMD,
-	GPIO25_MC0_DAT0,
-	GPIO26_MC0_DAT1,
-	GPIO27_MC0_DAT2,
-	GPIO28_MC0_DAT3,
-
-	/* SDI4 (on-board eMMC) */
-	GPIO197_MC4_DAT3,
-	GPIO198_MC4_DAT2,
-	GPIO199_MC4_DAT1,
-	GPIO200_MC4_DAT0,
-	GPIO201_MC4_CMD,
-	GPIO202_MC4_FBCLK,
-	GPIO203_MC4_CLK,
-	GPIO204_MC4_DAT7,
-	GPIO205_MC4_DAT6,
-	GPIO206_MC4_DAT5,
-	GPIO207_MC4_DAT4,
-};
-
-static pin_cfg_t mop500_sdi2_pins[] = {
-	/* SDI2 (POP eMMC) */
-	GPIO128_MC2_CLK,
-	GPIO129_MC2_CMD,
-	GPIO130_MC2_FBCLK,
-	GPIO131_MC2_DAT0,
-	GPIO132_MC2_DAT1,
-	GPIO133_MC2_DAT2,
-	GPIO134_MC2_DAT3,
-	GPIO135_MC2_DAT4,
-	GPIO136_MC2_DAT5,
-	GPIO137_MC2_DAT6,
-	GPIO138_MC2_DAT7,
-};
-
 /*
  * SDI 0 (MicroSD slot)
  */
@@ -216,22 +171,16 @@ static struct mmci_platform_data mop500_sdi4_data = {
 
 void __init mop500_sdi_init(void)
 {
-	nmk_config_pins(mop500_sdi_pins, ARRAY_SIZE(mop500_sdi_pins));
+	/* PoP:ed eMMC on top of DB8500 v1.0 has problems with high speed */
+	if (!cpu_is_u8500v10())
+		mop500_sdi2_data.capabilities |= MMC_CAP_MMC_HIGHSPEED;
+	db8500_add_sdi2(&mop500_sdi2_data);
+
+	/* On-board eMMC */
+	db8500_add_sdi4(&mop500_sdi4_data);
 
 	/*
 	 * sdi0 will finally be added when the TC35892 initializes and calls
 	 * mop500_sdi_tc35892_init() above.
 	 */
-
-	/* PoP:ed eMMC */
-	if (!cpu_is_u8500ed()) {
-		nmk_config_pins(mop500_sdi2_pins, ARRAY_SIZE(mop500_sdi2_pins));
-		/* POP eMMC on v1.0 has problems with high speed */
-		if (!cpu_is_u8500v10())
-			mop500_sdi2_data.capabilities |= MMC_CAP_MMC_HIGHSPEED;
-		db8500_add_sdi2(&mop500_sdi2_data);
-	}
-
-	/* On-board eMMC */
-	db8500_add_sdi4(&mop500_sdi4_data);
 }
-- 
1.7.3.2
