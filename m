From: viresh.kumar@st.com (Viresh KUMAR)
Date: Thu, 25 Mar 2010 12:57:08 +0530
Subject: [PATCH V2 12/12] ST SPEAr: Adding gpio pad multiplexing support
In-Reply-To: <1269502028-12867-12-git-send-email-viresh.kumar@st.com>
References: <1269502028-12867-1-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-2-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-3-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-4-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-5-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-6-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-7-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-8-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-9-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-10-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-11-git-send-email-viresh.kumar@st.com>
	<1269502028-12867-12-git-send-email-viresh.kumar@st.com>
Message-ID: <1269502028-12867-13-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO Pads in spear platform are are multiplexed in various machines.
This patch adds support for this pad multiplexing.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |  161 +++++++++-
 arch/arm/mach-spear3xx/spear300.c             |  358 ++++++++++++++++++++
 arch/arm/mach-spear3xx/spear300_evb.c         |   22 ++
 arch/arm/mach-spear3xx/spear310.c             |  129 +++++++
 arch/arm/mach-spear3xx/spear310_evb.c         |   30 ++
 arch/arm/mach-spear3xx/spear320.c             |  374 +++++++++++++++++++++
 arch/arm/mach-spear3xx/spear320_evb.c         |   27 ++
 arch/arm/mach-spear3xx/spear3xx.c             |  447 +++++++++++++++++++++++++
 arch/arm/plat-spear/Makefile                  |    2 +-
 arch/arm/plat-spear/include/plat/padmux.h     |   92 +++++
 arch/arm/plat-spear/padmux.c                  |  164 +++++++++
 11 files changed, 1798 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/plat-spear/include/plat/padmux.h
 create mode 100644 arch/arm/plat-spear/padmux.c

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index aeea845..af7e02c 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -19,7 +19,9 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
+#include <plat/padmux.h>
 
+/* spear3xx declarations */
 /*
  * Each GPT has 2 timer channels
  * Following GPT channels will be used as clock source and clockevent
@@ -34,25 +36,170 @@ extern struct amba_device uart_device;
 extern struct sys_timer spear_sys_timer;
 
 /* Add spear3xx family function declarations here */
+void __init clk_init(void);
 void __init spear3xx_map_io(void);
 void __init spear3xx_init_irq(void);
 void __init spear3xx_init(void);
-void __init spear300_init(void);
-void __init spear310_init(void);
-void __init spear320_init(void);
-void __init clk_init(void);
+void spear_pmx_init(struct pmx_driver *pmx_driver, uint base, uint size);
 
-/* Add spear300 machine device structure declarations here */
+/* pad mux declarations */
+#define PMX_FIRDA_MASK		(1 << 14)
+#define PMX_I2C_MASK		(1 << 13)
+#define PMX_SSP_CS_MASK		(1 << 12)
+#define PMX_SSP_MASK		(1 << 11)
+#define PMX_MII_MASK		(1 << 10)
+#define PMX_GPIO_PIN0_MASK	(1 << 9)
+#define PMX_GPIO_PIN1_MASK	(1 << 8)
+#define PMX_GPIO_PIN2_MASK	(1 << 7)
+#define PMX_GPIO_PIN3_MASK	(1 << 6)
+#define PMX_GPIO_PIN4_MASK	(1 << 5)
+#define PMX_GPIO_PIN5_MASK	(1 << 4)
+#define PMX_UART0_MODEM_MASK	(1 << 3)
+#define PMX_UART0_MASK		(1 << 2)
+#define PMX_TIMER_3_4_MASK	(1 << 1)
+#define PMX_TIMER_1_2_MASK	(1 << 0)
+
+/* pad mux devices */
+extern struct pmx_dev pmx_firda;
+extern struct pmx_dev pmx_i2c;
+extern struct pmx_dev pmx_ssp_cs;
+extern struct pmx_dev pmx_ssp;
+extern struct pmx_dev pmx_mii;
+extern struct pmx_dev pmx_gpio_pin0;
+extern struct pmx_dev pmx_gpio_pin1;
+extern struct pmx_dev pmx_gpio_pin2;
+extern struct pmx_dev pmx_gpio_pin3;
+extern struct pmx_dev pmx_gpio_pin4;
+extern struct pmx_dev pmx_gpio_pin5;
+extern struct pmx_dev pmx_uart0_modem;
+extern struct pmx_dev pmx_uart0;
+extern struct pmx_dev pmx_timer_3_4;
+extern struct pmx_dev pmx_timer_1_2;
+
+#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
+/* padmux plgpio devices */
+extern struct pmx_dev pmx_plgpio_0_1;
+extern struct pmx_dev pmx_plgpio_2_3;
+extern struct pmx_dev pmx_plgpio_4_5;
+extern struct pmx_dev pmx_plgpio_6_9;
+extern struct pmx_dev pmx_plgpio_10_27;
+extern struct pmx_dev pmx_plgpio_28;
+extern struct pmx_dev pmx_plgpio_29;
+extern struct pmx_dev pmx_plgpio_30;
+extern struct pmx_dev pmx_plgpio_31;
+extern struct pmx_dev pmx_plgpio_32;
+extern struct pmx_dev pmx_plgpio_33;
+extern struct pmx_dev pmx_plgpio_34_36;
+extern struct pmx_dev pmx_plgpio_37_42;
+extern struct pmx_dev pmx_plgpio_43_44_47_48;
+extern struct pmx_dev pmx_plgpio_45_46_49_50;
+#endif
+
+extern struct pmx_driver pmx_driver;
+
+/* spear300 declarations */
 #ifdef CONFIG_MACH_SPEAR300
+/* Add spear300 machine device structure declarations here */
 extern struct amba_device gpio1_device;
+
+/* pad mux modes */
+extern struct pmx_mode nand_mode;
+extern struct pmx_mode nor_mode;
+extern struct pmx_mode photo_frame_mode;
+extern struct pmx_mode lend_ip_phone_mode;
+extern struct pmx_mode hend_ip_phone_mode;
+extern struct pmx_mode lend_wifi_phone_mode;
+extern struct pmx_mode hend_wifi_phone_mode;
+extern struct pmx_mode ata_pabx_wi2s_mode;
+extern struct pmx_mode ata_pabx_i2s_mode;
+extern struct pmx_mode caml_lcdw_mode;
+extern struct pmx_mode camu_lcd_mode;
+extern struct pmx_mode camu_wlcd_mode;
+extern struct pmx_mode caml_lcd_mode;
+
+/* pad mux devices */
+extern struct pmx_dev pmx_fsmc_2_chips;
+extern struct pmx_dev pmx_fsmc_4_chips;
+extern struct pmx_dev pmx_keyboard;
+extern struct pmx_dev pmx_clcd;
+extern struct pmx_dev pmx_telecom_gpio;
+extern struct pmx_dev pmx_telecom_tdm;
+extern struct pmx_dev pmx_telecom_spi_cs_i2c_clk;
+extern struct pmx_dev pmx_telecom_camera;
+extern struct pmx_dev pmx_telecom_dac;
+extern struct pmx_dev pmx_telecom_i2s;
+extern struct pmx_dev pmx_telecom_boot_pins;
+extern struct pmx_dev pmx_telecom_sdio_4bit;
+extern struct pmx_dev pmx_telecom_sdio_8bit;
+extern struct pmx_dev pmx_gpio1;
+
+void spear300_pmx_init(void);
+
+/* Add spear300 machine function declarations here */
+void __init spear300_init(void);
+
 #endif /* CONFIG_MACH_SPEAR300 */
 
-/* Add spear310 machine device structure declarations here */
+/* spear310 declarations */
 #ifdef CONFIG_MACH_SPEAR310
+/* Add spear310 machine device structure declarations here */
+
+/* pad mux devices */
+extern struct pmx_dev pmx_emi_cs_0_1_4_5;
+extern struct pmx_dev pmx_emi_cs_2_3;
+extern struct pmx_dev pmx_uart1;
+extern struct pmx_dev pmx_uart2;
+extern struct pmx_dev pmx_uart3_4_5;
+extern struct pmx_dev pmx_fsmc;
+extern struct pmx_dev pmx_rs485_0_1;
+extern struct pmx_dev pmx_tdm0;
+
+void spear310_pmx_init(void);
+
+/* Add spear310 machine function declarations here */
+void __init spear310_init(void);
+
 #endif /* CONFIG_MACH_SPEAR310 */
 
-/* Add spear320 machine device structure declarations here */
+/* spear320 declarations */
 #ifdef CONFIG_MACH_SPEAR320
+/* Add spear320 machine device structure declarations here */
+
+/* pad mux modes */
+extern struct pmx_mode auto_net_smii_mode;
+extern struct pmx_mode auto_net_mii_mode;
+extern struct pmx_mode auto_exp_mode;
+extern struct pmx_mode small_printers_mode;
+
+/* pad mux devices */
+extern struct pmx_dev pmx_clcd;
+extern struct pmx_dev pmx_emi;
+extern struct pmx_dev pmx_fsmc;
+extern struct pmx_dev pmx_spp;
+extern struct pmx_dev pmx_sdio;
+extern struct pmx_dev pmx_i2s;
+extern struct pmx_dev pmx_uart1;
+extern struct pmx_dev pmx_uart1_modem;
+extern struct pmx_dev pmx_uart2;
+extern struct pmx_dev pmx_touchscreen;
+extern struct pmx_dev pmx_can;
+extern struct pmx_dev pmx_sdio_led;
+extern struct pmx_dev pmx_pwm0;
+extern struct pmx_dev pmx_pwm1;
+extern struct pmx_dev pmx_pwm2;
+extern struct pmx_dev pmx_pwm3;
+extern struct pmx_dev pmx_ssp1;
+extern struct pmx_dev pmx_ssp2;
+extern struct pmx_dev pmx_mii1;
+extern struct pmx_dev pmx_smii0;
+extern struct pmx_dev pmx_smii1;
+extern struct pmx_dev pmx_i2c1;
+
+void spear320_pmx_init(void);
+
+/* Add spear320 machine function declarations here */
+void __init spear320_init(void);
+
 #endif /* CONFIG_MACH_SPEAR320 */
 
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 63aca8f..66e7fcd 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -18,6 +18,357 @@
 #include <mach/generic.h>
 #include <mach/spear.h>
 
+/* pad multiplexing support */
+/* muxing registers */
+#define PAD_MUX_CONFIG_REG	0x00
+#define MODE_CONFIG_REG		0x04
+
+/* modes */
+#define NAND_MODE			(1 << 0)
+#define NOR_MODE			(1 << 1)
+#define PHOTO_FRAME_MODE		(1 << 2)
+#define LEND_IP_PHONE_MODE		(1 << 3)
+#define HEND_IP_PHONE_MODE		(1 << 4)
+#define LEND_WIFI_PHONE_MODE		(1 << 5)
+#define HEND_WIFI_PHONE_MODE		(1 << 6)
+#define ATA_PABX_WI2S_MODE		(1 << 7)
+#define ATA_PABX_I2S_MODE		(1 << 8)
+#define CAML_LCDW_MODE			(1 << 9)
+#define CAMU_LCD_MODE			(1 << 10)
+#define CAMU_WLCD_MODE			(1 << 11)
+#define CAML_LCD_MODE			(1 << 12)
+#define ALL_MODES			0x1FFF
+
+struct pmx_mode nand_mode = {
+	.id = NAND_MODE,
+	.name = "nand mode",
+	.mask = 0x00,
+};
+
+struct pmx_mode nor_mode = {
+	.id = NOR_MODE,
+	.name = "nor mode",
+	.mask = 0x01,
+};
+
+struct pmx_mode photo_frame_mode = {
+	.id = PHOTO_FRAME_MODE,
+	.name = "photo frame mode",
+	.mask = 0x02,
+};
+
+struct pmx_mode lend_ip_phone_mode = {
+	.id = LEND_IP_PHONE_MODE,
+	.name = "lend ip phone mode",
+	.mask = 0x03,
+};
+
+struct pmx_mode hend_ip_phone_mode = {
+	.id = HEND_IP_PHONE_MODE,
+	.name = "hend ip phone mode",
+	.mask = 0x04,
+};
+
+struct pmx_mode lend_wifi_phone_mode = {
+	.id = LEND_WIFI_PHONE_MODE,
+	.name = "lend wifi phone mode",
+	.mask = 0x05,
+};
+
+struct pmx_mode hend_wifi_phone_mode = {
+	.id = HEND_WIFI_PHONE_MODE,
+	.name = "hend wifi phone mode",
+	.mask = 0x06,
+};
+
+struct pmx_mode ata_pabx_wi2s_mode = {
+	.id = ATA_PABX_WI2S_MODE,
+	.name = "ata pabx wi2s mode",
+	.mask = 0x07,
+};
+
+struct pmx_mode ata_pabx_i2s_mode = {
+	.id = ATA_PABX_I2S_MODE,
+	.name = "ata pabx i2s mode",
+	.mask = 0x08,
+};
+
+struct pmx_mode caml_lcdw_mode = {
+	.id = CAML_LCDW_MODE,
+	.name = "caml lcdw mode",
+	.mask = 0x0C,
+};
+
+struct pmx_mode camu_lcd_mode = {
+	.id = CAMU_LCD_MODE,
+	.name = "camu lcd mode",
+	.mask = 0x0D,
+};
+
+struct pmx_mode camu_wlcd_mode = {
+	.id = CAMU_WLCD_MODE,
+	.name = "camu wlcd mode",
+	.mask = 0x0E,
+};
+
+struct pmx_mode caml_lcd_mode = {
+	.id = CAML_LCD_MODE,
+	.name = "caml lcd mode",
+	.mask = 0x0F,
+};
+
+/* devices */
+struct pmx_dev_mode pmx_fsmc_2_chips_modes[] = {
+	{
+		.ids = NAND_MODE | NOR_MODE | PHOTO_FRAME_MODE |
+			ATA_PABX_WI2S_MODE | ATA_PABX_I2S_MODE,
+		.mask = PMX_FIRDA_MASK,
+	},
+};
+
+struct pmx_dev pmx_fsmc_2_chips = {
+	.name = "fsmc_2_chips",
+	.modes = pmx_fsmc_2_chips_modes,
+	.mode_count = ARRAY_SIZE(pmx_fsmc_2_chips_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_fsmc_4_chips_modes[] = {
+	{
+		.ids = NAND_MODE | NOR_MODE | PHOTO_FRAME_MODE |
+			ATA_PABX_WI2S_MODE | ATA_PABX_I2S_MODE,
+		.mask = PMX_FIRDA_MASK | PMX_UART0_MASK,
+	},
+};
+
+struct pmx_dev pmx_fsmc_4_chips = {
+	.name = "fsmc_4_chips",
+	.modes = pmx_fsmc_4_chips_modes,
+	.mode_count = ARRAY_SIZE(pmx_fsmc_4_chips_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_keyboard_modes[] = {
+	{
+		.ids = LEND_IP_PHONE_MODE | HEND_IP_PHONE_MODE |
+			LEND_WIFI_PHONE_MODE | HEND_WIFI_PHONE_MODE |
+			CAML_LCDW_MODE | CAMU_LCD_MODE | CAMU_WLCD_MODE |
+			CAML_LCD_MODE,
+		.mask = 0x0,
+	},
+};
+
+struct pmx_dev pmx_keyboard = {
+	.name = "keyboard",
+	.modes = pmx_keyboard_modes,
+	.mode_count = ARRAY_SIZE(pmx_keyboard_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_clcd_modes[] = {
+	{
+		.ids = PHOTO_FRAME_MODE,
+		.mask = PMX_TIMER_1_2_MASK | PMX_TIMER_3_4_MASK ,
+	}, {
+		.ids = HEND_IP_PHONE_MODE | HEND_WIFI_PHONE_MODE |
+			CAMU_LCD_MODE | CAML_LCD_MODE,
+		.mask = PMX_TIMER_3_4_MASK,
+	},
+};
+
+struct pmx_dev pmx_clcd = {
+	.name = "clcd",
+	.modes = pmx_clcd_modes,
+	.mode_count = ARRAY_SIZE(pmx_clcd_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_telecom_gpio_modes[] = {
+	{
+		.ids = PHOTO_FRAME_MODE | CAMU_LCD_MODE | CAML_LCD_MODE,
+		.mask = PMX_MII_MASK,
+	}, {
+		.ids = LEND_IP_PHONE_MODE | LEND_WIFI_PHONE_MODE,
+		.mask = PMX_MII_MASK | PMX_TIMER_1_2_MASK | PMX_TIMER_3_4_MASK,
+	}, {
+		.ids = ATA_PABX_I2S_MODE | CAML_LCDW_MODE | CAMU_WLCD_MODE,
+		.mask = PMX_MII_MASK | PMX_TIMER_3_4_MASK,
+	}, {
+		.ids = HEND_IP_PHONE_MODE | HEND_WIFI_PHONE_MODE,
+		.mask = PMX_MII_MASK | PMX_TIMER_1_2_MASK,
+	}, {
+		.ids = ATA_PABX_WI2S_MODE,
+		.mask = PMX_MII_MASK | PMX_TIMER_1_2_MASK | PMX_TIMER_3_4_MASK
+			| PMX_UART0_MODEM_MASK,
+	},
+};
+
+struct pmx_dev pmx_telecom_gpio = {
+	.name = "telecom_gpio",
+	.modes = pmx_telecom_gpio_modes,
+	.mode_count = ARRAY_SIZE(pmx_telecom_gpio_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_telecom_tdm_modes[] = {
+	{
+		.ids = PHOTO_FRAME_MODE | LEND_IP_PHONE_MODE |
+			HEND_IP_PHONE_MODE | LEND_WIFI_PHONE_MODE
+			| HEND_WIFI_PHONE_MODE | ATA_PABX_WI2S_MODE
+			| ATA_PABX_I2S_MODE | CAML_LCDW_MODE | CAMU_LCD_MODE
+			| CAMU_WLCD_MODE | CAML_LCD_MODE,
+		.mask = PMX_UART0_MODEM_MASK | PMX_SSP_CS_MASK,
+	},
+};
+
+struct pmx_dev pmx_telecom_tdm = {
+	.name = "telecom_tdm",
+	.modes = pmx_telecom_tdm_modes,
+	.mode_count = ARRAY_SIZE(pmx_telecom_tdm_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_telecom_spi_cs_i2c_clk_modes[] = {
+	{
+		.ids = LEND_IP_PHONE_MODE | HEND_IP_PHONE_MODE |
+			LEND_WIFI_PHONE_MODE | HEND_WIFI_PHONE_MODE
+			| ATA_PABX_WI2S_MODE | ATA_PABX_I2S_MODE |
+			CAML_LCDW_MODE | CAML_LCD_MODE,
+		.mask = PMX_TIMER_1_2_MASK | PMX_TIMER_3_4_MASK,
+	},
+};
+
+struct pmx_dev pmx_telecom_spi_cs_i2c_clk = {
+	.name = "telecom_spi_cs_i2c_clk",
+	.modes = pmx_telecom_spi_cs_i2c_clk_modes,
+	.mode_count = ARRAY_SIZE(pmx_telecom_spi_cs_i2c_clk_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_telecom_camera_modes[] = {
+	{
+		.ids = CAML_LCDW_MODE | CAML_LCD_MODE,
+		.mask = PMX_MII_MASK,
+	}, {
+		.ids = CAMU_LCD_MODE | CAMU_WLCD_MODE,
+		.mask = PMX_TIMER_1_2_MASK | PMX_TIMER_3_4_MASK | PMX_MII_MASK,
+	},
+};
+
+struct pmx_dev pmx_telecom_camera = {
+	.name = "telecom_camera",
+	.modes = pmx_telecom_camera_modes,
+	.mode_count = ARRAY_SIZE(pmx_telecom_camera_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_telecom_dac_modes[] = {
+	{
+		.ids = ATA_PABX_I2S_MODE | CAML_LCDW_MODE | CAMU_LCD_MODE
+			| CAMU_WLCD_MODE | CAML_LCD_MODE,
+		.mask = PMX_TIMER_1_2_MASK,
+	},
+};
+
+struct pmx_dev pmx_telecom_dac = {
+	.name = "telecom_dac",
+	.modes = pmx_telecom_dac_modes,
+	.mode_count = ARRAY_SIZE(pmx_telecom_dac_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_telecom_i2s_modes[] = {
+	{
+		.ids = LEND_IP_PHONE_MODE | HEND_IP_PHONE_MODE
+			| LEND_WIFI_PHONE_MODE | HEND_WIFI_PHONE_MODE |
+			ATA_PABX_I2S_MODE | CAML_LCDW_MODE | CAMU_LCD_MODE
+			| CAMU_WLCD_MODE | CAML_LCD_MODE,
+		.mask = PMX_UART0_MODEM_MASK,
+	},
+};
+
+struct pmx_dev pmx_telecom_i2s = {
+	.name = "telecom_i2s",
+	.modes = pmx_telecom_i2s_modes,
+	.mode_count = ARRAY_SIZE(pmx_telecom_i2s_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_telecom_boot_pins_modes[] = {
+	{
+		.ids = NAND_MODE | NOR_MODE,
+		.mask = PMX_UART0_MODEM_MASK | PMX_TIMER_1_2_MASK |
+			PMX_TIMER_3_4_MASK,
+	},
+};
+
+struct pmx_dev pmx_telecom_boot_pins = {
+	.name = "telecom_boot_pins",
+	.modes = pmx_telecom_boot_pins_modes,
+	.mode_count = ARRAY_SIZE(pmx_telecom_boot_pins_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_telecom_sdio_4bit_modes[] = {
+	{
+		.ids = PHOTO_FRAME_MODE | LEND_IP_PHONE_MODE |
+			HEND_IP_PHONE_MODE | LEND_WIFI_PHONE_MODE |
+			HEND_WIFI_PHONE_MODE | CAML_LCDW_MODE | CAMU_LCD_MODE |
+			CAMU_WLCD_MODE | CAML_LCD_MODE | ATA_PABX_WI2S_MODE |
+			ATA_PABX_I2S_MODE,
+		.mask = PMX_GPIO_PIN0_MASK | PMX_GPIO_PIN1_MASK |
+			PMX_GPIO_PIN2_MASK | PMX_GPIO_PIN3_MASK |
+			PMX_GPIO_PIN4_MASK | PMX_GPIO_PIN5_MASK,
+	},
+};
+
+struct pmx_dev pmx_telecom_sdio_4bit = {
+	.name = "telecom_sdio_4bit",
+	.modes = pmx_telecom_sdio_4bit_modes,
+	.mode_count = ARRAY_SIZE(pmx_telecom_sdio_4bit_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_telecom_sdio_8bit_modes[] = {
+	{
+		.ids = PHOTO_FRAME_MODE | LEND_IP_PHONE_MODE |
+			HEND_IP_PHONE_MODE | LEND_WIFI_PHONE_MODE |
+			HEND_WIFI_PHONE_MODE | CAML_LCDW_MODE | CAMU_LCD_MODE |
+			CAMU_WLCD_MODE | CAML_LCD_MODE,
+		.mask = PMX_GPIO_PIN0_MASK | PMX_GPIO_PIN1_MASK |
+			PMX_GPIO_PIN2_MASK | PMX_GPIO_PIN3_MASK |
+			PMX_GPIO_PIN4_MASK | PMX_GPIO_PIN5_MASK | PMX_MII_MASK,
+	},
+};
+
+struct pmx_dev pmx_telecom_sdio_8bit = {
+	.name = "telecom_sdio_8bit",
+	.modes = pmx_telecom_sdio_8bit_modes,
+	.mode_count = ARRAY_SIZE(pmx_telecom_sdio_8bit_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_gpio1_modes[] = {
+	{
+		.ids = PHOTO_FRAME_MODE,
+		.mask = PMX_UART0_MODEM_MASK | PMX_TIMER_1_2_MASK |
+			PMX_TIMER_3_4_MASK,
+	},
+};
+
+struct pmx_dev pmx_gpio1 = {
+	.name = "arm gpio1",
+	.modes = pmx_gpio1_modes,
+	.mode_count = ARRAY_SIZE(pmx_gpio1_modes),
+	.enb_on_reset = 1,
+};
+
+/* pmx driver structure */
+struct pmx_driver pmx_driver = {
+	.mode_reg = {.offset = MODE_CONFIG_REG, .mask = 0x0000000f},
+	.mux_reg = {.offset = PAD_MUX_CONFIG_REG, .mask = 0x00007fff},
+};
+
 /* Add spear300 specific devices here */
 /* arm gpio1 device registeration */
 static struct pl061_platform_data gpio1_plat_data = {
@@ -38,8 +389,15 @@ struct amba_device gpio1_device = {
 	.irq = {IRQ_GEN_RAS_1, NO_IRQ},
 };
 
+/* spear300 routines */
 void __init spear300_init(void)
 {
 	/* call spear3xx family common init function */
 	spear3xx_init();
 }
+
+void spear300_pmx_init(void)
+{
+	spear_pmx_init(&pmx_driver, SPEAR300_SOC_CONFIG_BASE,
+			SPEAR300_SOC_CONFIG_SIZE);
+}
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 1272a38..bb21db1 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -16,6 +16,22 @@
 #include <mach/generic.h>
 #include <mach/spear.h>
 
+/* padmux devices to enable */
+static struct pmx_dev *pmx_devs[] = {
+	/* spear3xx specific devices */
+	&pmx_i2c,
+	&pmx_ssp_cs,
+	&pmx_ssp,
+	&pmx_mii,
+	&pmx_uart0,
+
+	/* spear300 specific devices */
+	&pmx_fsmc_2_chips,
+	&pmx_clcd,
+	&pmx_telecom_sdio_4bit,
+	&pmx_gpio1,
+};
+
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
@@ -38,6 +54,12 @@ static void __init spear300_evb_init(void)
 	/* call spear300 machine init function */
 	spear300_init();
 
+	/* padmux initialization */
+	pmx_driver.mode = &photo_frame_mode;
+	pmx_driver.devs = pmx_devs;
+	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
+	spear300_pmx_init();
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 6eb62f9..dd5a572 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -16,10 +16,139 @@
 #include <mach/generic.h>
 #include <mach/spear.h>
 
+/* pad multiplexing support */
+/* muxing registers */
+#define PAD_MUX_CONFIG_REG	0x08
+
+/* devices */
+struct pmx_dev_mode pmx_emi_cs_0_1_4_5_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_TIMER_3_4_MASK,
+	},
+};
+
+struct pmx_dev pmx_emi_cs_0_1_4_5 = {
+	.name = "emi_cs_0_1_4_5",
+	.modes = pmx_emi_cs_0_1_4_5_modes,
+	.mode_count = ARRAY_SIZE(pmx_emi_cs_0_1_4_5_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_emi_cs_2_3_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_TIMER_1_2_MASK,
+	},
+};
+
+struct pmx_dev pmx_emi_cs_2_3 = {
+	.name = "emi_cs_2_3",
+	.modes = pmx_emi_cs_2_3_modes,
+	.mode_count = ARRAY_SIZE(pmx_emi_cs_2_3_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_uart1_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_FIRDA_MASK,
+	},
+};
+
+struct pmx_dev pmx_uart1 = {
+	.name = "uart1",
+	.modes = pmx_uart1_modes,
+	.mode_count = ARRAY_SIZE(pmx_uart1_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_uart2_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_TIMER_1_2_MASK,
+	},
+};
+
+struct pmx_dev pmx_uart2 = {
+	.name = "uart2",
+	.modes = pmx_uart2_modes,
+	.mode_count = ARRAY_SIZE(pmx_uart2_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_uart3_4_5_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_UART0_MODEM_MASK,
+	},
+};
+
+struct pmx_dev pmx_uart3_4_5 = {
+	.name = "uart3_4_5",
+	.modes = pmx_uart3_4_5_modes,
+	.mode_count = ARRAY_SIZE(pmx_uart3_4_5_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_fsmc_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_SSP_CS_MASK,
+	},
+};
+
+struct pmx_dev pmx_fsmc = {
+	.name = "fsmc",
+	.modes = pmx_fsmc_modes,
+	.mode_count = ARRAY_SIZE(pmx_fsmc_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_rs485_0_1_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_MII_MASK,
+	},
+};
+
+struct pmx_dev pmx_rs485_0_1 = {
+	.name = "rs485_0_1",
+	.modes = pmx_rs485_0_1_modes,
+	.mode_count = ARRAY_SIZE(pmx_rs485_0_1_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_tdm0_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_MII_MASK,
+	},
+};
+
+struct pmx_dev pmx_tdm0 = {
+	.name = "tdm0",
+	.modes = pmx_tdm0_modes,
+	.mode_count = ARRAY_SIZE(pmx_tdm0_modes),
+	.enb_on_reset = 1,
+};
+
+/* pmx driver structure */
+struct pmx_driver pmx_driver = {
+	.mux_reg = {.offset = PAD_MUX_CONFIG_REG, .mask = 0x00007fff},
+};
+
 /* Add spear310 specific devices here */
 
+/* spear310 routines */
 void __init spear310_init(void)
 {
 	/* call spear3xx family common init function */
 	spear3xx_init();
 }
+
+void spear310_pmx_init(void)
+{
+	spear_pmx_init(&pmx_driver, SPEAR310_SOC_CONFIG_BASE,
+			SPEAR310_SOC_CONFIG_SIZE);
+}
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index e781b2b..7facf66 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -16,6 +16,30 @@
 #include <mach/generic.h>
 #include <mach/spear.h>
 
+/* padmux devices to enable */
+static struct pmx_dev *pmx_devs[] = {
+	/* spear3xx specific devices */
+	&pmx_i2c,
+	&pmx_ssp,
+	&pmx_gpio_pin0,
+	&pmx_gpio_pin1,
+	&pmx_gpio_pin2,
+	&pmx_gpio_pin3,
+	&pmx_gpio_pin4,
+	&pmx_gpio_pin5,
+	&pmx_uart0,
+
+	/* spear310 specific devices */
+	&pmx_emi_cs_0_1_4_5,
+	&pmx_emi_cs_2_3,
+	&pmx_uart1,
+	&pmx_uart2,
+	&pmx_uart3_4_5,
+	&pmx_fsmc,
+	&pmx_rs485_0_1,
+	&pmx_tdm0,
+};
+
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
@@ -37,6 +61,12 @@ static void __init spear310_evb_init(void)
 	/* call spear310 machine init function */
 	spear310_init();
 
+	/* padmux initialization */
+	pmx_driver.mode = NULL;
+	pmx_driver.devs = pmx_devs;
+	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
+	spear310_pmx_init();
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 72d4548..2cedf5e 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -16,10 +16,384 @@
 #include <mach/generic.h>
 #include <mach/spear.h>
 
+/* pad multiplexing support */
+/* muxing registers */
+#define PAD_MUX_CONFIG_REG	0x0C
+#define MODE_CONFIG_REG		0x10
+
+/* modes */
+#define AUTO_NET_SMII_MODE	(1 << 0)
+#define AUTO_NET_MII_MODE	(1 << 1)
+#define AUTO_EXP_MODE		(1 << 2)
+#define SMALL_PRINTERS_MODE	(1 << 3)
+#define ALL_MODES		0xF
+
+struct pmx_mode auto_net_smii_mode = {
+	.id = AUTO_NET_SMII_MODE,
+	.name = "Automation Networking SMII Mode",
+	.mask = 0x00,
+};
+
+struct pmx_mode auto_net_mii_mode = {
+	.id = AUTO_NET_MII_MODE,
+	.name = "Automation Networking MII Mode",
+	.mask = 0x01,
+};
+
+struct pmx_mode auto_exp_mode = {
+	.id = AUTO_EXP_MODE,
+	.name = "Automation Expanded Mode",
+	.mask = 0x02,
+};
+
+struct pmx_mode small_printers_mode = {
+	.id = SMALL_PRINTERS_MODE,
+	.name = "Small Printers Mode",
+	.mask = 0x03,
+};
+
+/* devices */
+struct pmx_dev_mode pmx_clcd_modes[] = {
+	{
+		.ids = AUTO_NET_SMII_MODE,
+		.mask = 0x0,
+	},
+};
+
+struct pmx_dev pmx_clcd = {
+	.name = "clcd",
+	.modes = pmx_clcd_modes,
+	.mode_count = ARRAY_SIZE(pmx_clcd_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_emi_modes[] = {
+	{
+		.ids = AUTO_EXP_MODE,
+		.mask = PMX_TIMER_1_2_MASK | PMX_TIMER_3_4_MASK,
+	},
+};
+
+struct pmx_dev pmx_emi = {
+	.name = "emi",
+	.modes = pmx_emi_modes,
+	.mode_count = ARRAY_SIZE(pmx_emi_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_fsmc_modes[] = {
+	{
+		.ids = ALL_MODES,
+		.mask = 0x0,
+	},
+};
+
+struct pmx_dev pmx_fsmc = {
+	.name = "fsmc",
+	.modes = pmx_fsmc_modes,
+	.mode_count = ARRAY_SIZE(pmx_fsmc_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_spp_modes[] = {
+	{
+		.ids = SMALL_PRINTERS_MODE,
+		.mask = 0x0,
+	},
+};
+
+struct pmx_dev pmx_spp = {
+	.name = "spp",
+	.modes = pmx_spp_modes,
+	.mode_count = ARRAY_SIZE(pmx_spp_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_sdio_modes[] = {
+	{
+		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE |
+			SMALL_PRINTERS_MODE,
+		.mask = PMX_TIMER_1_2_MASK | PMX_TIMER_3_4_MASK,
+	},
+};
+
+struct pmx_dev pmx_sdio = {
+	.name = "sdio",
+	.modes = pmx_sdio_modes,
+	.mode_count = ARRAY_SIZE(pmx_sdio_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_i2s_modes[] = {
+	{
+		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE,
+		.mask = PMX_UART0_MODEM_MASK,
+	},
+};
+
+struct pmx_dev pmx_i2s = {
+	.name = "i2s",
+	.modes = pmx_i2s_modes,
+	.mode_count = ARRAY_SIZE(pmx_i2s_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_uart1_modes[] = {
+	{
+		.ids = ALL_MODES,
+		.mask = PMX_GPIO_PIN0_MASK | PMX_GPIO_PIN1_MASK,
+	},
+};
+
+struct pmx_dev pmx_uart1 = {
+	.name = "uart1",
+	.modes = pmx_uart1_modes,
+	.mode_count = ARRAY_SIZE(pmx_uart1_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_uart1_modem_modes[] = {
+	{
+		.ids = AUTO_EXP_MODE,
+		.mask = PMX_TIMER_1_2_MASK | PMX_TIMER_3_4_MASK |
+			PMX_SSP_CS_MASK,
+	}, {
+		.ids = SMALL_PRINTERS_MODE,
+		.mask = PMX_GPIO_PIN3_MASK | PMX_GPIO_PIN4_MASK |
+			PMX_GPIO_PIN5_MASK | PMX_SSP_CS_MASK,
+	},
+};
+
+struct pmx_dev pmx_uart1_modem = {
+	.name = "uart1_modem",
+	.modes = pmx_uart1_modem_modes,
+	.mode_count = ARRAY_SIZE(pmx_uart1_modem_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_uart2_modes[] = {
+	{
+		.ids = ALL_MODES,
+		.mask = PMX_FIRDA_MASK,
+	},
+};
+
+struct pmx_dev pmx_uart2 = {
+	.name = "uart2",
+	.modes = pmx_uart2_modes,
+	.mode_count = ARRAY_SIZE(pmx_uart2_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_touchscreen_modes[] = {
+	{
+		.ids = AUTO_NET_SMII_MODE,
+		.mask = PMX_SSP_CS_MASK,
+	},
+};
+
+struct pmx_dev pmx_touchscreen = {
+	.name = "touchscreen",
+	.modes = pmx_touchscreen_modes,
+	.mode_count = ARRAY_SIZE(pmx_touchscreen_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_can_modes[] = {
+	{
+		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE | AUTO_EXP_MODE,
+		.mask = PMX_GPIO_PIN2_MASK | PMX_GPIO_PIN3_MASK |
+			PMX_GPIO_PIN4_MASK | PMX_GPIO_PIN5_MASK,
+	},
+};
+
+struct pmx_dev pmx_can = {
+	.name = "can",
+	.modes = pmx_can_modes,
+	.mode_count = ARRAY_SIZE(pmx_can_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_sdio_led_modes[] = {
+	{
+		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE,
+		.mask = PMX_SSP_CS_MASK,
+	},
+};
+
+struct pmx_dev pmx_sdio_led = {
+	.name = "sdio_led",
+	.modes = pmx_sdio_led_modes,
+	.mode_count = ARRAY_SIZE(pmx_sdio_led_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_pwm0_modes[] = {
+	{
+		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE,
+		.mask = PMX_UART0_MODEM_MASK,
+	}, {
+		.ids = AUTO_EXP_MODE | SMALL_PRINTERS_MODE,
+		.mask = PMX_MII_MASK,
+	},
+};
+
+struct pmx_dev pmx_pwm0 = {
+	.name = "pwm0",
+	.modes = pmx_pwm0_modes,
+	.mode_count = ARRAY_SIZE(pmx_pwm0_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_pwm1_modes[] = {
+	{
+		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE,
+		.mask = PMX_UART0_MODEM_MASK,
+	}, {
+		.ids = AUTO_EXP_MODE | SMALL_PRINTERS_MODE,
+		.mask = PMX_MII_MASK,
+	},
+};
+
+struct pmx_dev pmx_pwm1 = {
+	.name = "pwm1",
+	.modes = pmx_pwm1_modes,
+	.mode_count = ARRAY_SIZE(pmx_pwm1_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_pwm2_modes[] = {
+	{
+		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE,
+		.mask = PMX_SSP_CS_MASK,
+	}, {
+		.ids = AUTO_EXP_MODE | SMALL_PRINTERS_MODE,
+		.mask = PMX_MII_MASK,
+	},
+};
+
+struct pmx_dev pmx_pwm2 = {
+	.name = "pwm2",
+	.modes = pmx_pwm2_modes,
+	.mode_count = ARRAY_SIZE(pmx_pwm2_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_pwm3_modes[] = {
+	{
+		.ids = AUTO_EXP_MODE | SMALL_PRINTERS_MODE | AUTO_NET_SMII_MODE,
+		.mask = PMX_MII_MASK,
+	},
+};
+
+struct pmx_dev pmx_pwm3 = {
+	.name = "pwm3",
+	.modes = pmx_pwm3_modes,
+	.mode_count = ARRAY_SIZE(pmx_pwm3_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_ssp1_modes[] = {
+	{
+		.ids = SMALL_PRINTERS_MODE | AUTO_NET_SMII_MODE,
+		.mask = PMX_MII_MASK,
+	},
+};
+
+struct pmx_dev pmx_ssp1 = {
+	.name = "ssp1",
+	.modes = pmx_ssp1_modes,
+	.mode_count = ARRAY_SIZE(pmx_ssp1_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_ssp2_modes[] = {
+	{
+		.ids = AUTO_NET_SMII_MODE,
+		.mask = PMX_MII_MASK,
+	},
+};
+
+struct pmx_dev pmx_ssp2 = {
+	.name = "ssp2",
+	.modes = pmx_ssp2_modes,
+	.mode_count = ARRAY_SIZE(pmx_ssp2_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_mii1_modes[] = {
+	{
+		.ids = AUTO_NET_MII_MODE,
+		.mask = 0x0,
+	},
+};
+
+struct pmx_dev pmx_mii1 = {
+	.name = "mii1",
+	.modes = pmx_mii1_modes,
+	.mode_count = ARRAY_SIZE(pmx_mii1_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_smii0_modes[] = {
+	{
+		.ids = AUTO_NET_SMII_MODE | AUTO_EXP_MODE | SMALL_PRINTERS_MODE,
+		.mask = PMX_MII_MASK,
+	},
+};
+
+struct pmx_dev pmx_smii0 = {
+	.name = "smii0",
+	.modes = pmx_smii0_modes,
+	.mode_count = ARRAY_SIZE(pmx_smii0_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_smii1_modes[] = {
+	{
+		.ids = AUTO_NET_SMII_MODE | SMALL_PRINTERS_MODE,
+		.mask = PMX_MII_MASK,
+	},
+};
+
+struct pmx_dev pmx_smii1 = {
+	.name = "smii1",
+	.modes = pmx_smii1_modes,
+	.mode_count = ARRAY_SIZE(pmx_smii1_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_i2c1_modes[] = {
+	{
+		.ids = AUTO_EXP_MODE,
+		.mask = 0x0,
+	},
+};
+
+struct pmx_dev pmx_i2c1 = {
+	.name = "i2c1",
+	.modes = pmx_i2c1_modes,
+	.mode_count = ARRAY_SIZE(pmx_i2c1_modes),
+	.enb_on_reset = 1,
+};
+
+/* pmx driver structure */
+struct pmx_driver pmx_driver = {
+	.mode_reg = {.offset = MODE_CONFIG_REG, .mask = 0x00000007},
+	.mux_reg = {.offset = PAD_MUX_CONFIG_REG, .mask = 0x00007fff},
+};
+
 /* Add spear320 specific devices here */
 
+/* spear320 routines */
 void __init spear320_init(void)
 {
 	/* call spear3xx family common init function */
 	spear3xx_init();
 }
+
+void spear320_pmx_init(void)
+{
+	spear_pmx_init(&pmx_driver, SPEAR320_SOC_CONFIG_BASE,
+			SPEAR320_SOC_CONFIG_SIZE);
+}
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 85bc4d2..62ac685 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -16,6 +16,27 @@
 #include <mach/generic.h>
 #include <mach/spear.h>
 
+/* padmux devices to enable */
+static struct pmx_dev *pmx_devs[] = {
+	/* spear3xx specific devices */
+	&pmx_i2c,
+	&pmx_ssp,
+	&pmx_mii,
+	&pmx_uart0,
+
+	/* spear320 specific devices */
+	&pmx_fsmc,
+	&pmx_sdio,
+	&pmx_i2s,
+	&pmx_uart1,
+	&pmx_uart2,
+	&pmx_can,
+	&pmx_pwm0,
+	&pmx_pwm1,
+	&pmx_pwm2,
+	&pmx_mii1,
+};
+
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
@@ -37,6 +58,12 @@ static void __init spear320_evb_init(void)
 	/* call spear320 machine init function */
 	spear320_init();
 
+	/* padmux initialization */
+	pmx_driver.mode = &auto_net_mii_mode;
+	pmx_driver.devs = pmx_devs;
+	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
+	spear320_pmx_init();
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 82ebcd3..e87313a 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -99,3 +99,450 @@ void __init spear3xx_map_io(void)
 	/* This will initialize clock framework */
 	clk_init();
 }
+
+/* pad multiplexing support */
+/* devices */
+struct pmx_dev_mode pmx_firda_modes[] = {
+	{
+		.ids = 0xffffffff,
+		.mask = PMX_FIRDA_MASK,
+	},
+};
+
+struct pmx_dev pmx_firda = {
+	.name = "firda",
+	.modes = pmx_firda_modes,
+	.mode_count = ARRAY_SIZE(pmx_firda_modes),
+	.enb_on_reset = 0,
+};
+
+struct pmx_dev_mode pmx_i2c_modes[] = {
+	{
+		.ids = 0xffffffff,
+		.mask = PMX_I2C_MASK,
+	},
+};
+
+struct pmx_dev pmx_i2c = {
+	.name = "i2c",
+	.modes = pmx_i2c_modes,
+	.mode_count = ARRAY_SIZE(pmx_i2c_modes),
+	.enb_on_reset = 0,
+};
+
+struct pmx_dev_mode pmx_ssp_cs_modes[] = {
+	{
+		.ids = 0xffffffff,
+		.mask = PMX_SSP_CS_MASK,
+	},
+};
+
+struct pmx_dev pmx_ssp_cs = {
+	.name = "ssp_chip_selects",
+	.modes = pmx_ssp_cs_modes,
+	.mode_count = ARRAY_SIZE(pmx_ssp_cs_modes),
+	.enb_on_reset = 0,
+};
+
+struct pmx_dev_mode pmx_ssp_modes[] = {
+	{
+		.ids = 0xffffffff,
+		.mask = PMX_SSP_MASK,
+	},
+};
+
+struct pmx_dev pmx_ssp = {
+	.name = "ssp",
+	.modes = pmx_ssp_modes,
+	.mode_count = ARRAY_SIZE(pmx_ssp_modes),
+	.enb_on_reset = 0,
+};
+
+struct pmx_dev_mode pmx_mii_modes[] = {
+	{
+		.ids = 0xffffffff,
+		.mask = PMX_MII_MASK,
+	},
+};
+
+struct pmx_dev pmx_mii = {
+	.name = "mii",
+	.modes = pmx_mii_modes,
+	.mode_count = ARRAY_SIZE(pmx_mii_modes),
+	.enb_on_reset = 0,
+};
+
+struct pmx_dev_mode pmx_gpio_pin0_modes[] = {
+	{
+		.ids = 0xffffffff,
+		.mask = PMX_GPIO_PIN0_MASK,
+	},
+};
+
+struct pmx_dev pmx_gpio_pin0 = {
+	.name = "gpio_pin0",
+	.modes = pmx_gpio_pin0_modes,
+	.mode_count = ARRAY_SIZE(pmx_gpio_pin0_modes),
+	.enb_on_reset = 0,
+};
+
+struct pmx_dev_mode pmx_gpio_pin1_modes[] = {
+	{
+		.ids = 0xffffffff,
+		.mask = PMX_GPIO_PIN1_MASK,
+	},
+};
+
+struct pmx_dev pmx_gpio_pin1 = {
+	.name = "gpio_pin1",
+	.modes = pmx_gpio_pin1_modes,
+	.mode_count = ARRAY_SIZE(pmx_gpio_pin1_modes),
+	.enb_on_reset = 0,
+};
+
+struct pmx_dev_mode pmx_gpio_pin2_modes[] = {
+	{
+		.ids = 0xffffffff,
+		.mask = PMX_GPIO_PIN2_MASK,
+	},
+};
+
+struct pmx_dev pmx_gpio_pin2 = {
+	.name = "gpio_pin2",
+	.modes = pmx_gpio_pin2_modes,
+	.mode_count = ARRAY_SIZE(pmx_gpio_pin2_modes),
+	.enb_on_reset = 0,
+};
+
+struct pmx_dev_mode pmx_gpio_pin3_modes[] = {
+	{
+		.ids = 0xffffffff,
+		.mask = PMX_GPIO_PIN3_MASK,
+	},
+};
+
+struct pmx_dev pmx_gpio_pin3 = {
+	.name = "gpio_pin3",
+	.modes = pmx_gpio_pin3_modes,
+	.mode_count = ARRAY_SIZE(pmx_gpio_pin3_modes),
+	.enb_on_reset = 0,
+};
+
+struct pmx_dev_mode pmx_gpio_pin4_modes[] = {
+	{
+		.ids = 0xffffffff,
+		.mask = PMX_GPIO_PIN4_MASK,
+	},
+};
+
+struct pmx_dev pmx_gpio_pin4 = {
+	.name = "gpio_pin4",
+	.modes = pmx_gpio_pin4_modes,
+	.mode_count = ARRAY_SIZE(pmx_gpio_pin4_modes),
+	.enb_on_reset = 0,
+};
+
+struct pmx_dev_mode pmx_gpio_pin5_modes[] = {
+	{
+		.ids = 0xffffffff,
+		.mask = PMX_GPIO_PIN5_MASK,
+	},
+};
+
+struct pmx_dev pmx_gpio_pin5 = {
+	.name = "gpio_pin5",
+	.modes = pmx_gpio_pin5_modes,
+	.mode_count = ARRAY_SIZE(pmx_gpio_pin5_modes),
+	.enb_on_reset = 0,
+};
+
+struct pmx_dev_mode pmx_uart0_modem_modes[] = {
+	{
+		.ids = 0xffffffff,
+		.mask = PMX_UART0_MODEM_MASK,
+	},
+};
+
+struct pmx_dev pmx_uart0_modem = {
+	.name = "uart0_modem",
+	.modes = pmx_uart0_modem_modes,
+	.mode_count = ARRAY_SIZE(pmx_uart0_modem_modes),
+	.enb_on_reset = 0,
+};
+
+struct pmx_dev_mode pmx_uart0_modes[] = {
+	{
+		.ids = 0xffffffff,
+		.mask = PMX_UART0_MASK,
+	},
+};
+
+struct pmx_dev pmx_uart0 = {
+	.name = "uart0",
+	.modes = pmx_uart0_modes,
+	.mode_count = ARRAY_SIZE(pmx_uart0_modes),
+	.enb_on_reset = 0,
+};
+
+struct pmx_dev_mode pmx_timer_3_4_modes[] = {
+	{
+		.ids = 0xffffffff,
+		.mask = PMX_TIMER_3_4_MASK,
+	},
+};
+
+struct pmx_dev pmx_timer_3_4 = {
+	.name = "timer_3_4",
+	.modes = pmx_timer_3_4_modes,
+	.mode_count = ARRAY_SIZE(pmx_timer_3_4_modes),
+	.enb_on_reset = 0,
+};
+
+struct pmx_dev_mode pmx_timer_1_2_modes[] = {
+	{
+		.ids = 0xffffffff,
+		.mask = PMX_TIMER_1_2_MASK,
+	},
+};
+
+struct pmx_dev pmx_timer_1_2 = {
+	.name = "timer_1_2",
+	.modes = pmx_timer_1_2_modes,
+	.mode_count = ARRAY_SIZE(pmx_timer_1_2_modes),
+	.enb_on_reset = 0,
+};
+
+#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
+/* plgpios devices */
+struct pmx_dev_mode pmx_plgpio_0_1_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_FIRDA_MASK,
+	},
+};
+
+struct pmx_dev pmx_plgpio_0_1 = {
+	.name = "plgpio 0 and 1",
+	.modes = pmx_plgpio_0_1_modes,
+	.mode_count = ARRAY_SIZE(pmx_plgpio_0_1_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_plgpio_2_3_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_UART0_MASK,
+	},
+};
+
+struct pmx_dev pmx_plgpio_2_3 = {
+	.name = "plgpio 2 and 3",
+	.modes = pmx_plgpio_2_3_modes,
+	.mode_count = ARRAY_SIZE(pmx_plgpio_2_3_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_plgpio_4_5_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_I2C_MASK,
+	},
+};
+
+struct pmx_dev pmx_plgpio_4_5 = {
+	.name = "plgpio 4 and 5",
+	.modes = pmx_plgpio_4_5_modes,
+	.mode_count = ARRAY_SIZE(pmx_plgpio_4_5_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_plgpio_6_9_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_SSP_MASK,
+	},
+};
+
+struct pmx_dev pmx_plgpio_6_9 = {
+	.name = "plgpio 6 to 9",
+	.modes = pmx_plgpio_6_9_modes,
+	.mode_count = ARRAY_SIZE(pmx_plgpio_6_9_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_plgpio_10_27_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_MII_MASK,
+	},
+};
+
+struct pmx_dev pmx_plgpio_10_27 = {
+	.name = "plgpio 10 to 27",
+	.modes = pmx_plgpio_10_27_modes,
+	.mode_count = ARRAY_SIZE(pmx_plgpio_10_27_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_plgpio_28_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_GPIO_PIN0_MASK,
+	},
+};
+
+struct pmx_dev pmx_plgpio_28 = {
+	.name = "plgpio 28",
+	.modes = pmx_plgpio_28_modes,
+	.mode_count = ARRAY_SIZE(pmx_plgpio_28_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_plgpio_29_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_GPIO_PIN1_MASK,
+	},
+};
+
+struct pmx_dev pmx_plgpio_29 = {
+	.name = "plgpio 29",
+	.modes = pmx_plgpio_29_modes,
+	.mode_count = ARRAY_SIZE(pmx_plgpio_29_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_plgpio_30_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_GPIO_PIN2_MASK,
+	},
+};
+
+struct pmx_dev pmx_plgpio_30 = {
+	.name = "plgpio 30",
+	.modes = pmx_plgpio_30_modes,
+	.mode_count = ARRAY_SIZE(pmx_plgpio_30_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_plgpio_31_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_GPIO_PIN3_MASK,
+	},
+};
+
+struct pmx_dev pmx_plgpio_31 = {
+	.name = "plgpio 31",
+	.modes = pmx_plgpio_31_modes,
+	.mode_count = ARRAY_SIZE(pmx_plgpio_31_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_plgpio_32_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_GPIO_PIN4_MASK,
+	},
+};
+
+struct pmx_dev pmx_plgpio_32 = {
+	.name = "plgpio 32",
+	.modes = pmx_plgpio_32_modes,
+	.mode_count = ARRAY_SIZE(pmx_plgpio_32_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_plgpio_33_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_GPIO_PIN5_MASK,
+	},
+};
+
+struct pmx_dev pmx_plgpio_33 = {
+	.name = "plgpio 33",
+	.modes = pmx_plgpio_33_modes,
+	.mode_count = ARRAY_SIZE(pmx_plgpio_33_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_plgpio_34_36_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_SSP_CS_MASK,
+	},
+};
+
+struct pmx_dev pmx_plgpio_34_36 = {
+	.name = "plgpio 34 to 36",
+	.modes = pmx_plgpio_34_36_modes,
+	.mode_count = ARRAY_SIZE(pmx_plgpio_34_36_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_plgpio_37_42_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_UART0_MODEM_MASK,
+	},
+};
+
+struct pmx_dev pmx_plgpio_37_42 = {
+	.name = "plgpio 37 to 42",
+	.modes = pmx_plgpio_37_42_modes,
+	.mode_count = ARRAY_SIZE(pmx_plgpio_37_42_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_plgpio_43_44_47_48_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_TIMER_1_2_MASK,
+	},
+};
+
+struct pmx_dev pmx_plgpio_43_44_47_48 = {
+	.name = "plgpio 43, 44, 47 and 48",
+	.modes = pmx_plgpio_43_44_47_48_modes,
+	.mode_count = ARRAY_SIZE(pmx_plgpio_43_44_47_48_modes),
+	.enb_on_reset = 1,
+};
+
+struct pmx_dev_mode pmx_plgpio_45_46_49_50_modes[] = {
+	{
+		.ids = 0x00,
+		.mask = PMX_TIMER_3_4_MASK,
+	},
+};
+
+struct pmx_dev pmx_plgpio_45_46_49_50 = {
+	.name = "plgpio 45, 46, 49 and 50",
+	.modes = pmx_plgpio_45_46_49_50_modes,
+	.mode_count = ARRAY_SIZE(pmx_plgpio_45_46_49_50_modes),
+	.enb_on_reset = 1,
+};
+
+#endif
+
+/* spear padmux initialization function */
+void spear_pmx_init(struct pmx_driver *pmx_driver, uint base, uint size)
+{
+	int ret = 0;
+
+	/* pad mux initialization */
+	pmx_driver->base = ioremap(base, size);
+	if (!pmx_driver->base) {
+		ret = -ENOMEM;
+		goto pmx_fail;
+	}
+
+	ret = pmx_register(pmx_driver);
+	iounmap(pmx_driver->base);
+
+pmx_fail:
+	if (ret)
+		printk(KERN_ERR "padmux: registeration failed. err no: %d\n",
+				ret);
+}
diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index 96f9ac3..6f4ad5e 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -3,4 +3,4 @@
 #
 
 # Common support
-obj-y	:= clock.o time.o
+obj-y	:= clock.o padmux.o time.o
diff --git a/arch/arm/plat-spear/include/plat/padmux.h b/arch/arm/plat-spear/include/plat/padmux.h
new file mode 100644
index 0000000..877f3ad
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/padmux.h
@@ -0,0 +1,92 @@
+/*
+ * arch/arm/plat-spear/include/plat/padmux.h
+ *
+ * SPEAr platform specific gpio pads muxing file
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_PADMUX_H
+#define __PLAT_PADMUX_H
+
+#include <linux/types.h>
+
+/*
+ * struct pmx_reg: configuration structure for mode reg and mux reg
+ *
+ * offset: offset of mode reg
+ * mask: mask of mode reg
+ */
+struct pmx_reg {
+	u32 offset;
+	u32 mask;
+};
+
+/*
+ * struct pmx_dev_mode: configuration structure every group of modes of a device
+ *
+ * ids: all modes for this configuration
+ * mask: mask for supported mode
+ */
+struct pmx_dev_mode {
+	u32 ids;
+	u32 mask;
+};
+
+/*
+ * struct pmx_mode: mode definition structure
+ *
+ * name: mode name
+ * mask: mode mask
+ */
+struct pmx_mode {
+	char *name;
+	u32 id;
+	u32 mask;
+};
+
+/*
+ * struct pmx_dev: device definition structure
+ *
+ * name: device name
+ * modes: device configuration array for different modes supported
+ * mode_count: size of modes array
+ * is_active: is peripheral active/enabled
+ * enb_on_reset: if 1, mask bits to be cleared in reg otherwise to be set in reg
+ */
+struct pmx_dev {
+	char *name;
+	struct pmx_dev_mode *modes;
+	u8 mode_count;
+	bool is_active;
+	bool enb_on_reset;
+};
+
+/*
+ * struct pmx_driver: driver definition structure
+ *
+ * mode: mode to be set
+ * devs: array of pointer to pmx devices
+ * devs_count: ARRAY_SIZE of devs
+ * base: base address of soc config registers
+ * mode_reg: structure of mode config register
+ * mux_reg: structure of device mux config register
+ */
+struct pmx_driver {
+	struct pmx_mode *mode;
+	struct pmx_dev **devs;
+	u8 devs_count;
+	u32 *base;
+	struct pmx_reg mode_reg;
+	struct pmx_reg mux_reg;
+};
+
+/* pmx functions */
+int pmx_register(struct pmx_driver *driver);
+
+#endif /* __PLAT_PADMUX_H */
diff --git a/arch/arm/plat-spear/padmux.c b/arch/arm/plat-spear/padmux.c
new file mode 100644
index 0000000..d2aab3a
--- /dev/null
+++ b/arch/arm/plat-spear/padmux.c
@@ -0,0 +1,164 @@
+/*
+ * arch/arm/plat-spear/include/plat/padmux.c
+ *
+ * SPEAr platform specific gpio pads muxing source file
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <plat/padmux.h>
+
+/*
+ * struct pmx: pmx definition structure
+ *
+ * base: base address of configuration registers
+ * mode_reg: mode configurations
+ * mux_reg: muxing configurations
+ * active_mode: pointer to current active mode
+ */
+struct pmx {
+	u32 base;
+	struct pmx_reg mode_reg;
+	struct pmx_reg mux_reg;
+	struct pmx_mode *active_mode;
+};
+
+static struct pmx *pmx;
+
+/**
+ * pmx_mode_set - Enables an multiplexing mode
+ * @mode - pointer to pmx mode
+ *
+ * It will set mode of operation in hardware.
+ * Returns -ve on Err otherwise 0
+ */
+static int pmx_mode_set(struct pmx_mode *mode)
+{
+	u32 val;
+
+	if (!mode->name)
+		return -EFAULT;
+
+	pmx->active_mode = mode;
+
+	val = readl(pmx->base + pmx->mode_reg.offset);
+	val &= ~pmx->mode_reg.mask;
+	val |= mode->mask & pmx->mode_reg.mask;
+	writel(val, pmx->base + pmx->mode_reg.offset);
+
+	return 0;
+}
+
+/**
+ * pmx_devs_enable - Enables list of devices
+ * @devs - pointer to pmx device array
+ * @count - number of devices to enable
+ *
+ * It will enable pads for all required peripherals once and only once.
+ * If peripheral is not supported by current mode then request is rejected.
+ * Conflicts between peripherals are not handled and peripherals will be
+ * enabled in the order they are present in pmx_dev array.
+ * In case of conflicts last peripheral enalbed will be present.
+ * Returns -ve on Err otherwise 0
+ */
+static int pmx_devs_enable(struct pmx_dev **devs, u8 count)
+{
+	u32 val, i, mask;
+
+	if (!count)
+		return -EINVAL;
+
+	val = readl(pmx->base + pmx->mux_reg.offset);
+	for (i = 0; i < count; i++) {
+		u8 j = 0;
+
+		if (!devs[i]->name || !devs[i]->modes) {
+			printk(KERN_ERR "padmux: dev name or modes is null\n");
+			continue;
+		}
+		/* check if peripheral exists in active mode */
+		if (pmx->active_mode) {
+			bool found = false;
+			for (j = 0; j < devs[i]->mode_count; j++) {
+				if (devs[i]->modes[j].ids &
+						pmx->active_mode->id) {
+					found = true;
+					break;
+				}
+			}
+			if (found == false) {
+				printk(KERN_ERR "%s device not available in %s"\
+						"mode\n", devs[i]->name,
+						pmx->active_mode->name);
+				continue;
+			}
+		}
+
+		/* enable peripheral */
+		mask = devs[i]->modes[j].mask & pmx->mux_reg.mask;
+		if (devs[i]->enb_on_reset)
+			val &= ~mask;
+		else
+			val |= mask;
+
+		devs[i]->is_active = true;
+	}
+	writel(val, pmx->base + pmx->mux_reg.offset);
+	kfree(pmx);
+
+	/* this will ensure that multiplexing can't be changed now */
+	pmx = (struct pmx *)-1;
+
+	return 0;
+}
+
+/**
+ * pmx_register - registers a platform requesting pad mux feature
+ * @driver - pointer to driver structure containing driver specific parameters
+ *
+ * Also this must be called only once. This will allocate memory for pmx
+ * structure, will call pmx_mode_set, will call pmx_devs_enable.
+ * Returns -ve on Err otherwise 0
+ */
+int pmx_register(struct pmx_driver *driver)
+{
+	int ret = 0;
+
+	if (pmx)
+		return -EPERM;
+	if (!driver->base || !driver->devs)
+		return -EFAULT;
+
+	pmx = kzalloc(sizeof(*pmx), GFP_KERNEL);
+	if (!pmx)
+		return -ENOMEM;
+
+	pmx->base = (u32)driver->base;
+	pmx->mode_reg.offset = driver->mode_reg.offset;
+	pmx->mode_reg.mask = driver->mode_reg.mask;
+	pmx->mux_reg.offset = driver->mux_reg.offset;
+	pmx->mux_reg.mask = driver->mux_reg.mask;
+
+	/* choose mode to enable */
+	if (driver->mode) {
+		ret = pmx_mode_set(driver->mode);
+		if (ret)
+			goto pmx_fail;
+	}
+	ret = pmx_devs_enable(driver->devs, driver->devs_count);
+	if (ret)
+		goto pmx_fail;
+
+	return 0;
+
+pmx_fail:
+	return ret;
+}
-- 
1.6.0.2
