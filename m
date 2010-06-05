From: ryan@bluewatersys.com (Ryan Mallon)
Date: Sat,  5 Jun 2010 18:05:53 +1200
Subject: [PATCH 3/5] SPEAr3xx: Rework pmx_dev code to remove conflicts
In-Reply-To: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
References: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1275717955-14545-4-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prefix the pmx_devs to remove naming conflicts between the three
SPEAr3xx platforms. Also make pmx_driver static to each platform and
rework the init code to pass the devices rather than export the
pmx_driver structure.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |  135 ++++++++++++-------------
 arch/arm/mach-spear3xx/spear300.c             |   39 ++++----
 arch/arm/mach-spear3xx/spear300_evb.c         |   26 ++---
 arch/arm/mach-spear3xx/spear310.c             |   29 +++---
 arch/arm/mach-spear3xx/spear310_evb.c         |   42 ++++-----
 arch/arm/mach-spear3xx/spear320.c             |   57 ++++++-----
 arch/arm/mach-spear3xx/spear320_evb.c         |   36 +++----
 arch/arm/mach-spear3xx/spear3xx.c             |   60 ++++++------
 8 files changed, 202 insertions(+), 222 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 48dfb9c..408d39f 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -60,21 +60,21 @@ void spear_pmx_init(struct pmx_driver *pmx_driver, uint base, uint size);
 #define PMX_TIMER_1_2_MASK	(1 << 0)
 
 /* pad mux devices */
-extern struct pmx_dev pmx_firda;
-extern struct pmx_dev pmx_i2c;
-extern struct pmx_dev pmx_ssp_cs;
-extern struct pmx_dev pmx_ssp;
-extern struct pmx_dev pmx_mii;
-extern struct pmx_dev pmx_gpio_pin0;
-extern struct pmx_dev pmx_gpio_pin1;
-extern struct pmx_dev pmx_gpio_pin2;
-extern struct pmx_dev pmx_gpio_pin3;
-extern struct pmx_dev pmx_gpio_pin4;
-extern struct pmx_dev pmx_gpio_pin5;
-extern struct pmx_dev pmx_uart0_modem;
-extern struct pmx_dev pmx_uart0;
-extern struct pmx_dev pmx_timer_3_4;
-extern struct pmx_dev pmx_timer_1_2;
+extern struct pmx_dev spear3xx_pmx_firda;
+extern struct pmx_dev spear3xx_pmx_i2c;
+extern struct pmx_dev spear3xx_pmx_ssp_cs;
+extern struct pmx_dev spear3xx_pmx_ssp;
+extern struct pmx_dev spear3xx_pmx_mii;
+extern struct pmx_dev spear3xx_pmx_gpio_pin0;
+extern struct pmx_dev spear3xx_pmx_gpio_pin1;
+extern struct pmx_dev spear3xx_pmx_gpio_pin2;
+extern struct pmx_dev spear3xx_pmx_gpio_pin3;
+extern struct pmx_dev spear3xx_pmx_gpio_pin4;
+extern struct pmx_dev spear3xx_pmx_gpio_pin5;
+extern struct pmx_dev spear3xx_pmx_uart0_modem;
+extern struct pmx_dev spear3xx_pmx_uart0;
+extern struct pmx_dev spear3xx_pmx_timer_3_4;
+extern struct pmx_dev spear3xx_pmx_timer_1_2;
 
 #if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
 /* padmux plgpio devices */
@@ -95,8 +95,6 @@ extern struct pmx_dev pmx_plgpio_43_44_47_48;
 extern struct pmx_dev pmx_plgpio_45_46_49_50;
 #endif
 
-extern struct pmx_driver pmx_driver;
-
 /* spear300 declarations */
 #ifdef CONFIG_MACH_SPEAR300
 /* Add spear300 machine device structure declarations here */
@@ -118,25 +116,24 @@ extern struct pmx_mode camu_wlcd_mode;
 extern struct pmx_mode caml_lcd_mode;
 
 /* pad mux devices */
-extern struct pmx_dev pmx_fsmc_2_chips;
-extern struct pmx_dev pmx_fsmc_4_chips;
-extern struct pmx_dev pmx_keyboard;
-extern struct pmx_dev pmx_clcd;
-extern struct pmx_dev pmx_telecom_gpio;
-extern struct pmx_dev pmx_telecom_tdm;
-extern struct pmx_dev pmx_telecom_spi_cs_i2c_clk;
-extern struct pmx_dev pmx_telecom_camera;
-extern struct pmx_dev pmx_telecom_dac;
-extern struct pmx_dev pmx_telecom_i2s;
-extern struct pmx_dev pmx_telecom_boot_pins;
-extern struct pmx_dev pmx_telecom_sdio_4bit;
-extern struct pmx_dev pmx_telecom_sdio_8bit;
-extern struct pmx_dev pmx_gpio1;
-
-void spear300_pmx_init(void);
+extern struct pmx_dev spear300_pmx_fsmc_2_chips;
+extern struct pmx_dev spear300_pmx_fsmc_4_chips;
+extern struct pmx_dev spear300_pmx_keyboard;
+extern struct pmx_dev spear300_pmx_clcd;
+extern struct pmx_dev spear300_pmx_telecom_gpio;
+extern struct pmx_dev spear300_pmx_telecom_tdm;
+extern struct pmx_dev spear300_pmx_telecom_spi_cs_i2c_clk;
+extern struct pmx_dev spear300_pmx_telecom_camera;
+extern struct pmx_dev spear300_pmx_telecom_dac;
+extern struct pmx_dev spear300_pmx_telecom_i2s;
+extern struct pmx_dev spear300_pmx_telecom_boot_pins;
+extern struct pmx_dev spear300_pmx_telecom_sdio_4bit;
+extern struct pmx_dev spear300_pmx_telecom_sdio_8bit;
+extern struct pmx_dev spear300_pmx_gpio1;
 
 /* Add spear300 machine function declarations here */
-void __init spear300_init(void);
+void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pxm_devs,
+			  u8 pmx_dev_count);
 
 #endif /* CONFIG_MACH_SPEAR300 */
 
@@ -145,19 +142,18 @@ void __init spear300_init(void);
 /* Add spear310 machine device structure declarations here */
 
 /* pad mux devices */
-extern struct pmx_dev pmx_emi_cs_0_1_4_5;
-extern struct pmx_dev pmx_emi_cs_2_3;
-extern struct pmx_dev pmx_uart1;
-extern struct pmx_dev pmx_uart2;
-extern struct pmx_dev pmx_uart3_4_5;
-extern struct pmx_dev pmx_fsmc;
-extern struct pmx_dev pmx_rs485_0_1;
-extern struct pmx_dev pmx_tdm0;
-
-void spear310_pmx_init(void);
+extern struct pmx_dev spear310_pmx_emi_cs_0_1_4_5;
+extern struct pmx_dev spear310_pmx_emi_cs_2_3;
+extern struct pmx_dev spear310_pmx_uart1;
+extern struct pmx_dev spear310_pmx_uart2;
+extern struct pmx_dev spear310_pmx_uart3_4_5;
+extern struct pmx_dev spear310_pmx_fsmc;
+extern struct pmx_dev spear310_pmx_rs485_0_1;
+extern struct pmx_dev spear310_pmx_tdm0;
 
 /* Add spear310 machine function declarations here */
-void __init spear310_init(void);
+void __init spear310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pxm_devs,
+			  u8 pmx_dev_count);
 
 #endif /* CONFIG_MACH_SPEAR310 */
 
@@ -172,33 +168,32 @@ extern struct pmx_mode auto_exp_mode;
 extern struct pmx_mode small_printers_mode;
 
 /* pad mux devices */
-extern struct pmx_dev pmx_clcd;
-extern struct pmx_dev pmx_emi;
-extern struct pmx_dev pmx_fsmc;
-extern struct pmx_dev pmx_spp;
-extern struct pmx_dev pmx_sdio;
-extern struct pmx_dev pmx_i2s;
-extern struct pmx_dev pmx_uart1;
-extern struct pmx_dev pmx_uart1_modem;
-extern struct pmx_dev pmx_uart2;
-extern struct pmx_dev pmx_touchscreen;
-extern struct pmx_dev pmx_can;
-extern struct pmx_dev pmx_sdio_led;
-extern struct pmx_dev pmx_pwm0;
-extern struct pmx_dev pmx_pwm1;
-extern struct pmx_dev pmx_pwm2;
-extern struct pmx_dev pmx_pwm3;
-extern struct pmx_dev pmx_ssp1;
-extern struct pmx_dev pmx_ssp2;
-extern struct pmx_dev pmx_mii1;
-extern struct pmx_dev pmx_smii0;
-extern struct pmx_dev pmx_smii1;
-extern struct pmx_dev pmx_i2c1;
-
-void spear320_pmx_init(void);
+extern struct pmx_dev spear320_pmx_clcd;
+extern struct pmx_dev spear320_pmx_emi;
+extern struct pmx_dev spear320_pmx_fsmc;
+extern struct pmx_dev spear320_pmx_spp;
+extern struct pmx_dev spear320_pmx_sdio;
+extern struct pmx_dev spear320_pmx_i2s;
+extern struct pmx_dev spear320_pmx_uart1;
+extern struct pmx_dev spear320_pmx_uart1_modem;
+extern struct pmx_dev spear320_pmx_uart2;
+extern struct pmx_dev spear320_pmx_touchscreen;
+extern struct pmx_dev spear320_pmx_can;
+extern struct pmx_dev spear320_pmx_sdio_led;
+extern struct pmx_dev spear320_pmx_pwm0;
+extern struct pmx_dev spear320_pmx_pwm1;
+extern struct pmx_dev spear320_pmx_pwm2;
+extern struct pmx_dev spear320_pmx_pwm3;
+extern struct pmx_dev spear320_pmx_ssp1;
+extern struct pmx_dev spear320_pmx_ssp2;
+extern struct pmx_dev spear320_pmx_mii1;
+extern struct pmx_dev spear320_pmx_smii0;
+extern struct pmx_dev spear320_pmx_smii1;
+extern struct pmx_dev spear320_pmx_i2c1;
 
 /* Add spear320 machine function declarations here */
-void __init spear320_init(void);
+void __init spear320_init(struct pmx_mode *pmx_mode, struct pmx_dev **pxm_devs,
+			  u8 pmx_dev_count);
 
 #endif /* CONFIG_MACH_SPEAR320 */
 
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 4afe4d4..11acd8e 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -127,7 +127,7 @@ static struct pmx_dev_mode pmx_fsmc_2_chips_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_fsmc_2_chips = {
+struct pmx_dev spear300_pmx_fsmc_2_chips = {
 	.name = "fsmc_2_chips",
 	.modes = pmx_fsmc_2_chips_modes,
 	.mode_count = ARRAY_SIZE(pmx_fsmc_2_chips_modes),
@@ -142,7 +142,7 @@ static struct pmx_dev_mode pmx_fsmc_4_chips_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_fsmc_4_chips = {
+struct pmx_dev spear300_pmx_fsmc_4_chips = {
 	.name = "fsmc_4_chips",
 	.modes = pmx_fsmc_4_chips_modes,
 	.mode_count = ARRAY_SIZE(pmx_fsmc_4_chips_modes),
@@ -159,7 +159,7 @@ static struct pmx_dev_mode pmx_keyboard_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_keyboard = {
+struct pmx_dev spear300_pmx_keyboard = {
 	.name = "keyboard",
 	.modes = pmx_keyboard_modes,
 	.mode_count = ARRAY_SIZE(pmx_keyboard_modes),
@@ -177,7 +177,7 @@ static struct pmx_dev_mode pmx_clcd_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_clcd = {
+struct pmx_dev spear300_pmx_clcd = {
 	.name = "clcd",
 	.modes = pmx_clcd_modes,
 	.mode_count = ARRAY_SIZE(pmx_clcd_modes),
@@ -222,7 +222,7 @@ static struct pmx_dev_mode pmx_telecom_tdm_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_tdm = {
+struct pmx_dev spear300_pmx_telecom_tdm = {
 	.name = "telecom_tdm",
 	.modes = pmx_telecom_tdm_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_tdm_modes),
@@ -239,7 +239,7 @@ static struct pmx_dev_mode pmx_telecom_spi_cs_i2c_clk_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_spi_cs_i2c_clk = {
+struct pmx_dev spear300_pmx_telecom_spi_cs_i2c_clk = {
 	.name = "telecom_spi_cs_i2c_clk",
 	.modes = pmx_telecom_spi_cs_i2c_clk_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_spi_cs_i2c_clk_modes),
@@ -256,7 +256,7 @@ static struct pmx_dev_mode pmx_telecom_camera_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_camera = {
+struct pmx_dev spear300_pmx_telecom_camera = {
 	.name = "telecom_camera",
 	.modes = pmx_telecom_camera_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_camera_modes),
@@ -271,7 +271,7 @@ static struct pmx_dev_mode pmx_telecom_dac_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_dac = {
+struct pmx_dev spear300_pmx_telecom_dac = {
 	.name = "telecom_dac",
 	.modes = pmx_telecom_dac_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_dac_modes),
@@ -288,7 +288,7 @@ static struct pmx_dev_mode pmx_telecom_i2s_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_i2s = {
+struct pmx_dev spear300_pmx_telecom_i2s = {
 	.name = "telecom_i2s",
 	.modes = pmx_telecom_i2s_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_i2s_modes),
@@ -303,7 +303,7 @@ static struct pmx_dev_mode pmx_telecom_boot_pins_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_boot_pins = {
+struct pmx_dev spear300_pmx_telecom_boot_pins = {
 	.name = "telecom_boot_pins",
 	.modes = pmx_telecom_boot_pins_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_boot_pins_modes),
@@ -323,7 +323,7 @@ static struct pmx_dev_mode pmx_telecom_sdio_4bit_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_sdio_4bit = {
+struct pmx_dev spear300_pmx_telecom_sdio_4bit = {
 	.name = "telecom_sdio_4bit",
 	.modes = pmx_telecom_sdio_4bit_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_sdio_4bit_modes),
@@ -342,7 +342,7 @@ static struct pmx_dev_mode pmx_telecom_sdio_8bit_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_sdio_8bit = {
+struct pmx_dev spear300_pmx_telecom_sdio_8bit = {
 	.name = "telecom_sdio_8bit",
 	.modes = pmx_telecom_sdio_8bit_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_sdio_8bit_modes),
@@ -357,7 +357,7 @@ static struct pmx_dev_mode pmx_gpio1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_gpio1 = {
+struct pmx_dev spear300_pmx_gpio1 = {
 	.name = "arm gpio1",
 	.modes = pmx_gpio1_modes,
 	.mode_count = ARRAY_SIZE(pmx_gpio1_modes),
@@ -365,7 +365,7 @@ struct pmx_dev pmx_gpio1 = {
 };
 
 /* pmx driver structure */
-struct pmx_driver pmx_driver = {
+static struct pmx_driver pmx_driver = {
 	.mode_reg = {.offset = MODE_CONFIG_REG, .mask = 0x0000000f},
 	.mux_reg = {.offset = PAD_MUX_CONFIG_REG, .mask = 0x00007fff},
 };
@@ -444,7 +444,8 @@ static struct spear_shirq shirq_ras1 = {
 };
 
 /* spear300 routines */
-void __init spear300_init(void)
+void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+			  u8 pmx_dev_count)
 {
 	int ret = 0;
 
@@ -459,10 +460,10 @@ void __init spear300_init(void)
 		if (ret)
 			printk(KERN_ERR "Error registering Shared IRQ\n");
 	}
-}
 
-void spear300_pmx_init(void)
-{
+	pmx_driver.mode = pmx_mode;
+	pmx_driver.devs = pmx_devs;
+	pmx_driver.devs_count = pmx_dev_count;
 	spear_pmx_init(&pmx_driver, SPEAR300_SOC_CONFIG_BASE,
-			SPEAR300_SOC_CONFIG_SIZE);
+		       SPEAR300_SOC_CONFIG_SIZE);
 }
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index bb21db1..5ae5f6a 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -19,17 +19,17 @@
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
 	/* spear3xx specific devices */
-	&pmx_i2c,
-	&pmx_ssp_cs,
-	&pmx_ssp,
-	&pmx_mii,
-	&pmx_uart0,
+	&spear3xx_pmx_i2c,
+	&spear3xx_pmx_ssp_cs,
+	&spear3xx_pmx_ssp,
+	&spear3xx_pmx_mii,
+	&spear3xx_pmx_uart0,
 
 	/* spear300 specific devices */
-	&pmx_fsmc_2_chips,
-	&pmx_clcd,
-	&pmx_telecom_sdio_4bit,
-	&pmx_gpio1,
+	&spear300_pmx_fsmc_2_chips,
+	&spear300_pmx_clcd,
+	&spear300_pmx_telecom_sdio_4bit,
+	&spear300_pmx_gpio1,
 };
 
 static struct amba_device *amba_devs[] __initdata = {
@@ -52,13 +52,7 @@ static void __init spear300_evb_init(void)
 	unsigned int i;
 
 	/* call spear300 machine init function */
-	spear300_init();
-
-	/* padmux initialization */
-	pmx_driver.mode = &photo_frame_mode;
-	pmx_driver.devs = pmx_devs;
-	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
-	spear300_pmx_init();
+	spear300_init(&photo_frame_mode, pmx_devs, ARRAY_SIZE(pmx_devs));
 
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 550f06f..0646170 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -29,7 +29,7 @@ struct pmx_dev_mode pmx_emi_cs_0_1_4_5_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_emi_cs_0_1_4_5 = {
+struct pmx_dev spear310_pmx_emi_cs_0_1_4_5 = {
 	.name = "emi_cs_0_1_4_5",
 	.modes = pmx_emi_cs_0_1_4_5_modes,
 	.mode_count = ARRAY_SIZE(pmx_emi_cs_0_1_4_5_modes),
@@ -43,7 +43,7 @@ struct pmx_dev_mode pmx_emi_cs_2_3_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_emi_cs_2_3 = {
+struct pmx_dev spear310_pmx_emi_cs_2_3 = {
 	.name = "emi_cs_2_3",
 	.modes = pmx_emi_cs_2_3_modes,
 	.mode_count = ARRAY_SIZE(pmx_emi_cs_2_3_modes),
@@ -57,7 +57,7 @@ struct pmx_dev_mode pmx_uart1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart1 = {
+struct pmx_dev spear310_pmx_uart1 = {
 	.name = "uart1",
 	.modes = pmx_uart1_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart1_modes),
@@ -71,7 +71,7 @@ struct pmx_dev_mode pmx_uart2_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart2 = {
+struct pmx_dev spear310_pmx_uart2 = {
 	.name = "uart2",
 	.modes = pmx_uart2_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart2_modes),
@@ -85,7 +85,7 @@ struct pmx_dev_mode pmx_uart3_4_5_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart3_4_5 = {
+struct pmx_dev spear310_pmx_uart3_4_5 = {
 	.name = "uart3_4_5",
 	.modes = pmx_uart3_4_5_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart3_4_5_modes),
@@ -99,7 +99,7 @@ struct pmx_dev_mode pmx_fsmc_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_fsmc = {
+struct pmx_dev spear310_pmx_fsmc = {
 	.name = "fsmc",
 	.modes = pmx_fsmc_modes,
 	.mode_count = ARRAY_SIZE(pmx_fsmc_modes),
@@ -113,7 +113,7 @@ struct pmx_dev_mode pmx_rs485_0_1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_rs485_0_1 = {
+struct pmx_dev spear310_pmx_rs485_0_1 = {
 	.name = "rs485_0_1",
 	.modes = pmx_rs485_0_1_modes,
 	.mode_count = ARRAY_SIZE(pmx_rs485_0_1_modes),
@@ -127,7 +127,7 @@ struct pmx_dev_mode pmx_tdm0_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_tdm0 = {
+struct pmx_dev spear310_pmx_tdm0 = {
 	.name = "tdm0",
 	.modes = pmx_tdm0_modes,
 	.mode_count = ARRAY_SIZE(pmx_tdm0_modes),
@@ -135,7 +135,7 @@ struct pmx_dev pmx_tdm0 = {
 };
 
 /* pmx driver structure */
-struct pmx_driver pmx_driver = {
+static struct pmx_driver pmx_driver = {
 	.mux_reg = {.offset = PAD_MUX_CONFIG_REG, .mask = 0x00007fff},
 };
 
@@ -258,7 +258,8 @@ static struct spear_shirq shirq_intrcomm_ras = {
 };
 
 /* spear310 routines */
-void __init spear310_init(void)
+void __init spear310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+			  u8 pmx_dev_count)
 {
 	void __iomem *base;
 	int ret = 0;
@@ -293,10 +294,10 @@ void __init spear310_init(void)
 		if (ret)
 			printk(KERN_ERR "Error registering Shared IRQ 4\n");
 	}
-}
 
-void spear310_pmx_init(void)
-{
+	pmx_driver.mode = pmx_mode;
+	pmx_driver.devs = pmx_devs;
+	pmx_driver.devs_count = pmx_dev_count;
 	spear_pmx_init(&pmx_driver, SPEAR310_SOC_CONFIG_BASE,
-			SPEAR310_SOC_CONFIG_SIZE);
+		       SPEAR310_SOC_CONFIG_SIZE);
 }
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 7facf66..c9e3f41 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -19,25 +19,25 @@
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
 	/* spear3xx specific devices */
-	&pmx_i2c,
-	&pmx_ssp,
-	&pmx_gpio_pin0,
-	&pmx_gpio_pin1,
-	&pmx_gpio_pin2,
-	&pmx_gpio_pin3,
-	&pmx_gpio_pin4,
-	&pmx_gpio_pin5,
-	&pmx_uart0,
+	&spear3xx_pmx_i2c,
+	&spear3xx_pmx_ssp,
+	&spear3xx_pmx_gpio_pin0,
+	&spear3xx_pmx_gpio_pin1,
+	&spear3xx_pmx_gpio_pin2,
+	&spear3xx_pmx_gpio_pin3,
+	&spear3xx_pmx_gpio_pin4,
+	&spear3xx_pmx_gpio_pin5,
+	&spear3xx_pmx_uart0,
 
 	/* spear310 specific devices */
-	&pmx_emi_cs_0_1_4_5,
-	&pmx_emi_cs_2_3,
-	&pmx_uart1,
-	&pmx_uart2,
-	&pmx_uart3_4_5,
-	&pmx_fsmc,
-	&pmx_rs485_0_1,
-	&pmx_tdm0,
+	&spear310_pmx_emi_cs_0_1_4_5,
+	&spear310_pmx_emi_cs_2_3,
+	&spear310_pmx_uart1,
+	&spear310_pmx_uart2,
+	&spear310_pmx_uart3_4_5,
+	&spear310_pmx_fsmc,
+	&spear310_pmx_rs485_0_1,
+	&spear310_pmx_tdm0,
 };
 
 static struct amba_device *amba_devs[] __initdata = {
@@ -59,13 +59,7 @@ static void __init spear310_evb_init(void)
 	unsigned int i;
 
 	/* call spear310 machine init function */
-	spear310_init();
-
-	/* padmux initialization */
-	pmx_driver.mode = NULL;
-	pmx_driver.devs = pmx_devs;
-	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
-	spear310_pmx_init();
+	spear310_init(NULL, pmx_devs, ARRAY_SIZE(pmx_devs));
 
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 768aa8c..ad3679c 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -61,7 +61,7 @@ static struct pmx_dev_mode pmx_clcd_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_clcd = {
+struct pmx_dev spear320_pmx_clcd = {
 	.name = "clcd",
 	.modes = pmx_clcd_modes,
 	.mode_count = ARRAY_SIZE(pmx_clcd_modes),
@@ -75,7 +75,7 @@ static struct pmx_dev_mode pmx_emi_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_emi = {
+struct pmx_dev spear320_pmx_emi = {
 	.name = "emi",
 	.modes = pmx_emi_modes,
 	.mode_count = ARRAY_SIZE(pmx_emi_modes),
@@ -89,7 +89,7 @@ static struct pmx_dev_mode pmx_fsmc_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_fsmc = {
+struct pmx_dev spear320_pmx_fsmc = {
 	.name = "fsmc",
 	.modes = pmx_fsmc_modes,
 	.mode_count = ARRAY_SIZE(pmx_fsmc_modes),
@@ -103,7 +103,7 @@ static struct pmx_dev_mode pmx_spp_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_spp = {
+struct pmx_dev spear320_pmx_spp = {
 	.name = "spp",
 	.modes = pmx_spp_modes,
 	.mode_count = ARRAY_SIZE(pmx_spp_modes),
@@ -118,7 +118,7 @@ static struct pmx_dev_mode pmx_sdio_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_sdio = {
+struct pmx_dev spear320_pmx_sdio = {
 	.name = "sdio",
 	.modes = pmx_sdio_modes,
 	.mode_count = ARRAY_SIZE(pmx_sdio_modes),
@@ -132,7 +132,7 @@ static struct pmx_dev_mode pmx_i2s_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_i2s = {
+struct pmx_dev spear320_pmx_i2s = {
 	.name = "i2s",
 	.modes = pmx_i2s_modes,
 	.mode_count = ARRAY_SIZE(pmx_i2s_modes),
@@ -146,7 +146,7 @@ static struct pmx_dev_mode pmx_uart1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart1 = {
+struct pmx_dev spear320_pmx_uart1 = {
 	.name = "uart1",
 	.modes = pmx_uart1_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart1_modes),
@@ -165,7 +165,7 @@ static struct pmx_dev_mode pmx_uart1_modem_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart1_modem = {
+struct pmx_dev spear320_pmx_uart1_modem = {
 	.name = "uart1_modem",
 	.modes = pmx_uart1_modem_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart1_modem_modes),
@@ -179,7 +179,7 @@ static struct pmx_dev_mode pmx_uart2_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart2 = {
+struct pmx_dev spear320_pmx_uart2 = {
 	.name = "uart2",
 	.modes = pmx_uart2_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart2_modes),
@@ -193,7 +193,7 @@ static struct pmx_dev_mode pmx_touchscreen_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_touchscreen = {
+struct pmx_dev spear320_pmx_touchscreen = {
 	.name = "touchscreen",
 	.modes = pmx_touchscreen_modes,
 	.mode_count = ARRAY_SIZE(pmx_touchscreen_modes),
@@ -208,7 +208,7 @@ static struct pmx_dev_mode pmx_can_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_can = {
+struct pmx_dev spear320_pmx_can = {
 	.name = "can",
 	.modes = pmx_can_modes,
 	.mode_count = ARRAY_SIZE(pmx_can_modes),
@@ -222,7 +222,7 @@ static struct pmx_dev_mode pmx_sdio_led_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_sdio_led = {
+struct pmx_dev spear320_pmx_sdio_led = {
 	.name = "sdio_led",
 	.modes = pmx_sdio_led_modes,
 	.mode_count = ARRAY_SIZE(pmx_sdio_led_modes),
@@ -239,7 +239,7 @@ static struct pmx_dev_mode pmx_pwm0_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_pwm0 = {
+struct pmx_dev spear320_pmx_pwm0 = {
 	.name = "pwm0",
 	.modes = pmx_pwm0_modes,
 	.mode_count = ARRAY_SIZE(pmx_pwm0_modes),
@@ -256,7 +256,7 @@ static struct pmx_dev_mode pmx_pwm1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_pwm1 = {
+struct pmx_dev spear320_pmx_pwm1 = {
 	.name = "pwm1",
 	.modes = pmx_pwm1_modes,
 	.mode_count = ARRAY_SIZE(pmx_pwm1_modes),
@@ -273,7 +273,7 @@ static struct pmx_dev_mode pmx_pwm2_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_pwm2 = {
+struct pmx_dev spear320_pmx_pwm2 = {
 	.name = "pwm2",
 	.modes = pmx_pwm2_modes,
 	.mode_count = ARRAY_SIZE(pmx_pwm2_modes),
@@ -287,7 +287,7 @@ static struct pmx_dev_mode pmx_pwm3_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_pwm3 = {
+struct pmx_dev spear320_pmx_pwm3 = {
 	.name = "pwm3",
 	.modes = pmx_pwm3_modes,
 	.mode_count = ARRAY_SIZE(pmx_pwm3_modes),
@@ -301,7 +301,7 @@ static struct pmx_dev_mode pmx_ssp1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_ssp1 = {
+struct pmx_dev spear320_pmx_ssp1 = {
 	.name = "ssp1",
 	.modes = pmx_ssp1_modes,
 	.mode_count = ARRAY_SIZE(pmx_ssp1_modes),
@@ -315,7 +315,7 @@ static struct pmx_dev_mode pmx_ssp2_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_ssp2 = {
+struct pmx_dev spear320_pmx_ssp2 = {
 	.name = "ssp2",
 	.modes = pmx_ssp2_modes,
 	.mode_count = ARRAY_SIZE(pmx_ssp2_modes),
@@ -329,7 +329,7 @@ static struct pmx_dev_mode pmx_mii1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_mii1 = {
+struct pmx_dev spear320_pmx_mii1 = {
 	.name = "mii1",
 	.modes = pmx_mii1_modes,
 	.mode_count = ARRAY_SIZE(pmx_mii1_modes),
@@ -343,7 +343,7 @@ static struct pmx_dev_mode pmx_smii0_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_smii0 = {
+struct pmx_dev spear320_pmx_smii0 = {
 	.name = "smii0",
 	.modes = pmx_smii0_modes,
 	.mode_count = ARRAY_SIZE(pmx_smii0_modes),
@@ -357,7 +357,7 @@ static struct pmx_dev_mode pmx_smii1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_smii1 = {
+struct pmx_dev spear320_pmx_smii1 = {
 	.name = "smii1",
 	.modes = pmx_smii1_modes,
 	.mode_count = ARRAY_SIZE(pmx_smii1_modes),
@@ -371,7 +371,7 @@ static struct pmx_dev_mode pmx_i2c1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_i2c1 = {
+struct pmx_dev spear320_pmx_i2c1 = {
 	.name = "i2c1",
 	.modes = pmx_i2c1_modes,
 	.mode_count = ARRAY_SIZE(pmx_i2c1_modes),
@@ -379,7 +379,7 @@ struct pmx_dev pmx_i2c1 = {
 };
 
 /* pmx driver structure */
-struct pmx_driver pmx_driver = {
+static struct pmx_driver pmx_driver = {
 	.mode_reg = {.offset = MODE_CONFIG_REG, .mask = 0x00000007},
 	.mux_reg = {.offset = PAD_MUX_CONFIG_REG, .mask = 0x00007fff},
 };
@@ -511,7 +511,8 @@ static struct spear_shirq shirq_intrcomm_ras = {
 };
 
 /* spear320 routines */
-void __init spear320_init(void)
+void __init spear320_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+			  u8 pmx_dev_count)
 {
 	void __iomem *base;
 	int ret = 0;
@@ -540,10 +541,10 @@ void __init spear320_init(void)
 		if (ret)
 			printk(KERN_ERR "Error registering Shared IRQ 4\n");
 	}
-}
 
-void spear320_pmx_init(void)
-{
+	pmx_driver.mode = pmx_mode;
+	pmx_driver.devs = pmx_devs;
+	pmx_driver.devs_count = pmx_dev_count;
 	spear_pmx_init(&pmx_driver, SPEAR320_SOC_CONFIG_BASE,
-			SPEAR320_SOC_CONFIG_SIZE);
+		       SPEAR320_SOC_CONFIG_SIZE);
 }
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 62ac685..4969fa9 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -19,22 +19,22 @@
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
 	/* spear3xx specific devices */
-	&pmx_i2c,
-	&pmx_ssp,
-	&pmx_mii,
-	&pmx_uart0,
+	&spear3xx_pmx_i2c,
+	&spear3xx_pmx_ssp,
+	&spear3xx_pmx_mii,
+	&spear3xx_pmx_uart0,
 
 	/* spear320 specific devices */
-	&pmx_fsmc,
-	&pmx_sdio,
-	&pmx_i2s,
-	&pmx_uart1,
-	&pmx_uart2,
-	&pmx_can,
-	&pmx_pwm0,
-	&pmx_pwm1,
-	&pmx_pwm2,
-	&pmx_mii1,
+	&spear320_pmx_fsmc,
+	&spear320_pmx_sdio,
+	&spear320_pmx_i2s,
+	&spear320_pmx_uart1,
+	&spear320_pmx_uart2,
+	&spear320_pmx_can,
+	&spear320_pmx_pwm0,
+	&spear320_pmx_pwm1,
+	&spear320_pmx_pwm2,
+	&spear320_pmx_mii1,
 };
 
 static struct amba_device *amba_devs[] __initdata = {
@@ -56,13 +56,7 @@ static void __init spear320_evb_init(void)
 	unsigned int i;
 
 	/* call spear320 machine init function */
-	spear320_init();
-
-	/* padmux initialization */
-	pmx_driver.mode = &auto_net_mii_mode;
-	pmx_driver.devs = pmx_devs;
-	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
-	spear320_pmx_init();
+	spear320_init(&auto_net_mii_mode, pmx_devs, ARRAY_SIZE(pmx_devs));
 
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 0efd8d7..545ac24 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -109,7 +109,7 @@ static struct pmx_dev_mode pmx_firda_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_firda = {
+struct pmx_dev spear3xx_pmx_firda = {
 	.name = "firda",
 	.modes = pmx_firda_modes,
 	.mode_count = ARRAY_SIZE(pmx_firda_modes),
@@ -123,7 +123,7 @@ static struct pmx_dev_mode pmx_i2c_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_i2c = {
+struct pmx_dev spear3xx_pmx_i2c = {
 	.name = "i2c",
 	.modes = pmx_i2c_modes,
 	.mode_count = ARRAY_SIZE(pmx_i2c_modes),
@@ -137,7 +137,7 @@ static struct pmx_dev_mode pmx_ssp_cs_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_ssp_cs = {
+struct pmx_dev spear3xx_pmx_ssp_cs = {
 	.name = "ssp_chip_selects",
 	.modes = pmx_ssp_cs_modes,
 	.mode_count = ARRAY_SIZE(pmx_ssp_cs_modes),
@@ -151,7 +151,7 @@ static struct pmx_dev_mode pmx_ssp_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_ssp = {
+struct pmx_dev spear3xx_pmx_ssp = {
 	.name = "ssp",
 	.modes = pmx_ssp_modes,
 	.mode_count = ARRAY_SIZE(pmx_ssp_modes),
@@ -165,7 +165,7 @@ static struct pmx_dev_mode pmx_mii_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_mii = {
+struct pmx_dev spear3xx_pmx_mii = {
 	.name = "mii",
 	.modes = pmx_mii_modes,
 	.mode_count = ARRAY_SIZE(pmx_mii_modes),
@@ -179,7 +179,7 @@ static struct pmx_dev_mode pmx_gpio_pin0_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_gpio_pin0 = {
+struct pmx_dev spear3xx_pmx_gpio_pin0 = {
 	.name = "gpio_pin0",
 	.modes = pmx_gpio_pin0_modes,
 	.mode_count = ARRAY_SIZE(pmx_gpio_pin0_modes),
@@ -193,7 +193,7 @@ static struct pmx_dev_mode pmx_gpio_pin1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_gpio_pin1 = {
+struct pmx_dev spear3xx_pmx_gpio_pin1 = {
 	.name = "gpio_pin1",
 	.modes = pmx_gpio_pin1_modes,
 	.mode_count = ARRAY_SIZE(pmx_gpio_pin1_modes),
@@ -207,7 +207,7 @@ static struct pmx_dev_mode pmx_gpio_pin2_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_gpio_pin2 = {
+struct pmx_dev spear3xx_pmx_gpio_pin2 = {
 	.name = "gpio_pin2",
 	.modes = pmx_gpio_pin2_modes,
 	.mode_count = ARRAY_SIZE(pmx_gpio_pin2_modes),
@@ -221,7 +221,7 @@ static struct pmx_dev_mode pmx_gpio_pin3_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_gpio_pin3 = {
+struct pmx_dev spear3xx_pmx_gpio_pin3 = {
 	.name = "gpio_pin3",
 	.modes = pmx_gpio_pin3_modes,
 	.mode_count = ARRAY_SIZE(pmx_gpio_pin3_modes),
@@ -235,7 +235,7 @@ static struct pmx_dev_mode pmx_gpio_pin4_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_gpio_pin4 = {
+struct pmx_dev spear3xx_pmx_gpio_pin4 = {
 	.name = "gpio_pin4",
 	.modes = pmx_gpio_pin4_modes,
 	.mode_count = ARRAY_SIZE(pmx_gpio_pin4_modes),
@@ -249,7 +249,7 @@ static struct pmx_dev_mode pmx_gpio_pin5_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_gpio_pin5 = {
+struct pmx_dev spear3xx_pmx_gpio_pin5 = {
 	.name = "gpio_pin5",
 	.modes = pmx_gpio_pin5_modes,
 	.mode_count = ARRAY_SIZE(pmx_gpio_pin5_modes),
@@ -263,7 +263,7 @@ static struct pmx_dev_mode pmx_uart0_modem_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart0_modem = {
+struct pmx_dev spear3xx_pmx_uart0_modem = {
 	.name = "uart0_modem",
 	.modes = pmx_uart0_modem_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart0_modem_modes),
@@ -277,7 +277,7 @@ static struct pmx_dev_mode pmx_uart0_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart0 = {
+struct pmx_dev spear3xx_pmx_uart0 = {
 	.name = "uart0",
 	.modes = pmx_uart0_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart0_modes),
@@ -291,7 +291,7 @@ static struct pmx_dev_mode pmx_timer_3_4_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_timer_3_4 = {
+struct pmx_dev spear3xx_pmx_timer_3_4 = {
 	.name = "timer_3_4",
 	.modes = pmx_timer_3_4_modes,
 	.mode_count = ARRAY_SIZE(pmx_timer_3_4_modes),
@@ -305,7 +305,7 @@ static struct pmx_dev_mode pmx_timer_1_2_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_timer_1_2 = {
+struct pmx_dev spear3xx_pmx_timer_1_2 = {
 	.name = "timer_1_2",
 	.modes = pmx_timer_1_2_modes,
 	.mode_count = ARRAY_SIZE(pmx_timer_1_2_modes),
@@ -321,7 +321,7 @@ static struct pmx_dev_mode pmx_plgpio_0_1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_0_1 = {
+struct pmx_dev spear3xx_pmx_plgpio_0_1 = {
 	.name = "plgpio 0 and 1",
 	.modes = pmx_plgpio_0_1_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_0_1_modes),
@@ -335,7 +335,7 @@ static struct pmx_dev_mode pmx_plgpio_2_3_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_2_3 = {
+struct pmx_dev spear3xx_pmx_plgpio_2_3 = {
 	.name = "plgpio 2 and 3",
 	.modes = pmx_plgpio_2_3_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_2_3_modes),
@@ -349,7 +349,7 @@ static struct pmx_dev_mode pmx_plgpio_4_5_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_4_5 = {
+struct pmx_dev spear3xx_pmx_plgpio_4_5 = {
 	.name = "plgpio 4 and 5",
 	.modes = pmx_plgpio_4_5_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_4_5_modes),
@@ -363,7 +363,7 @@ static struct pmx_dev_mode pmx_plgpio_6_9_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_6_9 = {
+struct pmx_dev spear3xx_pmx_plgpio_6_9 = {
 	.name = "plgpio 6 to 9",
 	.modes = pmx_plgpio_6_9_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_6_9_modes),
@@ -377,7 +377,7 @@ static struct pmx_dev_mode pmx_plgpio_10_27_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_10_27 = {
+struct pmx_dev spear3xx_pmx_plgpio_10_27 = {
 	.name = "plgpio 10 to 27",
 	.modes = pmx_plgpio_10_27_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_10_27_modes),
@@ -391,7 +391,7 @@ static struct pmx_dev_mode pmx_plgpio_28_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_28 = {
+struct pmx_dev spear3xx_pmx_plgpio_28 = {
 	.name = "plgpio 28",
 	.modes = pmx_plgpio_28_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_28_modes),
@@ -405,7 +405,7 @@ static struct pmx_dev_mode pmx_plgpio_29_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_29 = {
+struct pmx_dev spear3xx_pmx_plgpio_29 = {
 	.name = "plgpio 29",
 	.modes = pmx_plgpio_29_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_29_modes),
@@ -419,7 +419,7 @@ static struct pmx_dev_mode pmx_plgpio_30_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_30 = {
+struct pmx_dev spear3xx_pmx_plgpio_30 = {
 	.name = "plgpio 30",
 	.modes = pmx_plgpio_30_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_30_modes),
@@ -433,7 +433,7 @@ static struct pmx_dev_mode pmx_plgpio_31_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_31 = {
+struct pmx_dev spear3xx_pmx_plgpio_31 = {
 	.name = "plgpio 31",
 	.modes = pmx_plgpio_31_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_31_modes),
@@ -447,7 +447,7 @@ static struct pmx_dev_mode pmx_plgpio_32_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_32 = {
+struct pmx_dev spear3xx_pmx_plgpio_32 = {
 	.name = "plgpio 32",
 	.modes = pmx_plgpio_32_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_32_modes),
@@ -461,7 +461,7 @@ static struct pmx_dev_mode pmx_plgpio_33_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_33 = {
+struct pmx_dev spear3xx_pmx_plgpio_33 = {
 	.name = "plgpio 33",
 	.modes = pmx_plgpio_33_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_33_modes),
@@ -475,7 +475,7 @@ static struct pmx_dev_mode pmx_plgpio_34_36_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_34_36 = {
+struct pmx_dev spear3xx_pmx_plgpio_34_36 = {
 	.name = "plgpio 34 to 36",
 	.modes = pmx_plgpio_34_36_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_34_36_modes),
@@ -489,7 +489,7 @@ static struct pmx_dev_mode pmx_plgpio_37_42_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_37_42 = {
+struct pmx_dev spear3xx_pmx_plgpio_37_42 = {
 	.name = "plgpio 37 to 42",
 	.modes = pmx_plgpio_37_42_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_37_42_modes),
@@ -503,7 +503,7 @@ static struct pmx_dev_mode pmx_plgpio_43_44_47_48_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_43_44_47_48 = {
+struct pmx_dev spear3xx_pmx_plgpio_43_44_47_48 = {
 	.name = "plgpio 43, 44, 47 and 48",
 	.modes = pmx_plgpio_43_44_47_48_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_43_44_47_48_modes),
@@ -517,7 +517,7 @@ static struct pmx_dev_mode pmx_plgpio_45_46_49_50_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_45_46_49_50 = {
+struct pmx_dev spear3xx_pmx_plgpio_45_46_49_50 = {
 	.name = "plgpio 45, 46, 49 and 50",
 	.modes = pmx_plgpio_45_46_49_50_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_45_46_49_50_modes),
-- 
1.5.5
