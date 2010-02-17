From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 17 Feb 2010 18:19:29 +0000
Subject: [PATCH 1/3] ARM: SMDK6410: Add initial support for WM1192-EV1 PMIC
	board
Message-ID: <1266430771-6037-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Wolfson Microelectronics 1192-EV1 is a plug in module for the
SMDK6410 providing power using a WM8312 PMIC. This patch provides
initial hookup sufficient to initialise the board, though not all
features are fully described yet.

As part of this supplies for the system that are provided as a
single supply by one of the currently merged PMIC boards are
factored out so they can be reused between different regulators.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c6410/Kconfig             |   15 ++
 arch/arm/mach-s3c6410/mach-smdk6410.c     |  256 ++++++++++++++++++++++------
 arch/arm/plat-s3c64xx/include/plat/irqs.h |    2 +
 3 files changed, 218 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-s3c6410/Kconfig b/arch/arm/mach-s3c6410/Kconfig
index 162f456..eab5dc3 100644
--- a/arch/arm/mach-s3c6410/Kconfig
+++ b/arch/arm/mach-s3c6410/Kconfig
@@ -88,6 +88,21 @@ config SMDK6410_WM1190_EV1
 	  detected at runtime so the the resulting kernel can be used
 	  with or without the 1190-EV1 fitted.
 
+config SMDK6410_WM1192_EV1
+	bool "Support Wolfson Microelectronics 1192-EV1 PMIC card"
+	depends on MACH_SMDK6410
+	select REGULATOR
+	select REGULATOR_WM831X
+	select S3C24XX_GPIO_EXTRA64
+	select MFD_WM831X
+	help
+	  The Wolfson Microelectronics 1192-EV1 is a WM831x based PMIC
+	  daughtercard for the Samsung SMDK6410 reference platform.
+	  Enabling this option will build support for this module into
+	  the kernel.  The presence of the daughtercard will be
+	  detected at runtime so the the resulting kernel can be used
+	  with or without the 1192-EV1 fitted.
+
 config MACH_NCP
 	bool "NCP"
 	select CPU_S3C6410
diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index 8c80fa9..b397ad8 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -32,6 +32,10 @@
 #include <linux/mfd/wm8350/pmic.h>
 #endif
 
+#ifdef CONFIG_SMDK6410_WM1192_EV1
+#include <linux/mfd/wm831x/pdata.h>
+#endif
+
 #include <video/platform_lcd.h>
 
 #include <asm/mach/arch.h>
@@ -259,77 +263,124 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&smdk6410_smsc911x,
 };
 
-#ifdef CONFIG_SMDK6410_WM1190_EV1
-/* S3C64xx internal logic & PLL */
-static struct regulator_init_data wm8350_dcdc1_data = {
+#ifdef CONFIG_REGULATOR
+/* ARM core */
+static struct regulator_consumer_supply smdk6410_vddarm_consumers[] = {
+	{
+		.supply = "vddarm",
+	}
+};
+
+/* VDDARM, BUCK1 on J5 */
+static struct regulator_init_data smdk6410_vddarm = {
 	.constraints = {
-		.name = "PVDD_INT/PVDD_PLL",
-		.min_uV = 1200000,
+		.name = "PVDD_ARM",
+		.min_uV = 1000000,
+		.max_uV = 1300000,
+		.always_on = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(smdk6410_vddarm_consumers),
+	.consumer_supplies = smdk6410_vddarm_consumers,
+};
+
+/* VDD_INT, BUCK2 on J5 */
+static struct regulator_init_data smdk6410_vddint = {
+	.constraints = {
+		.name = "PVDD_INT",
+		.min_uV = 1000000,
 		.max_uV = 1200000,
 		.always_on = 1,
-		.apply_uV = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
 	},
 };
 
-/* Memory */
-static struct regulator_init_data wm8350_dcdc3_data = {
+/* VDD_HI, LDO3 on J5 */
+static struct regulator_init_data smdk6410_vddhi = {
 	.constraints = {
-		.name = "PVDD_MEM",
-		.min_uV = 1800000,
-		.max_uV = 1800000,
+		.name = "PVDD_HI",
 		.always_on = 1,
-		.state_mem = {
-			 .uV = 1800000,
-			 .mode = REGULATOR_MODE_NORMAL,
-			 .enabled = 1,
-		 },
-		.initial_state = PM_SUSPEND_MEM,
 	},
 };
 
-/* USB, EXT, PCM, ADC/DAC, USB, MMC */
-static struct regulator_consumer_supply wm8350_dcdc4_consumers[] = {
-	{
-		/* WM8580 */
-		.supply = "DVDD",
-		.dev_name = "0-001b",
+/* VDD_PLL, LDO2 on J5 */
+static struct regulator_init_data smdk6410_vddpll = {
+	.constraints = {
+		.name = "PVDD_PLL",
+		.always_on = 1,
 	},
 };
 
-static struct regulator_init_data wm8350_dcdc4_data = {
+/* VDD_UH_MMC, LDO5 on J5 */
+static struct regulator_init_data smdk6410_vdduh_mmc = {
 	.constraints = {
-		.name = "PVDD_HI/PVDD_EXT/PVDD_SYS/PVCCM2MTV",
-		.min_uV = 3000000,
-		.max_uV = 3000000,
+		.name = "PVDD_UH/PVDD_MMC",
 		.always_on = 1,
 	},
-	.num_consumer_supplies = ARRAY_SIZE(wm8350_dcdc4_consumers),
-	.consumer_supplies = wm8350_dcdc4_consumers,
 };
 
-/* ARM core */
-static struct regulator_consumer_supply dcdc6_consumers[] = {
-	{
-		.supply = "vddarm",
-	}
+/* VCCM3BT, LDO8 on J5 */
+static struct regulator_init_data smdk6410_vccmc3bt = {
+	.constraints = {
+		.name = "PVCCM3BT",
+		.always_on = 1,
+	},
 };
 
-static struct regulator_init_data wm8350_dcdc6_data = {
+/* VCCM2MTV, LDO11 on J5 */
+static struct regulator_init_data smdk6410_vccm2mtv = {
 	.constraints = {
-		.name = "PVDD_ARM",
-		.min_uV = 1000000,
-		.max_uV = 1300000,
+		.name = "PVCCM2MTV",
+		.always_on = 1,
+	},
+};
+
+/* VDD_LCD, LDO12 on J5 */
+static struct regulator_init_data smdk6410_vddlcd = {
+	.constraints = {
+		.name = "PVDD_LCD",
+		.always_on = 1,
+	},
+};
+
+/* VDD_OTGI, LDO9 on J5 */
+static struct regulator_init_data smdk6410_vddotgi = {
+	.constraints = {
+		.name = "PVDD_OTGI",
+		.always_on = 1,
+	},
+};
+
+/* VDD_OTG, LDO14 on J5 */
+static struct regulator_init_data smdk6410_vddotg = {
+	.constraints = {
+		.name = "PVDD_OTG",
 		.always_on = 1,
-		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
 	},
-	.num_consumer_supplies = ARRAY_SIZE(dcdc6_consumers),
-	.consumer_supplies = dcdc6_consumers,
 };
 
-/* Alive */
-static struct regulator_init_data wm8350_ldo1_data = {
+/* VDD_ALIVE, LDO15 on J5 */
+static struct regulator_init_data smdk6410_vddalive = {
 	.constraints = {
 		.name = "PVDD_ALIVE",
+		.always_on = 1,
+	},
+};
+
+/* VDD_AUDIO, VLDO_AUDIO on J5 */
+static struct regulator_init_data smdk6410_vddaudio = {
+	.constraints = {
+		.name = "PVDD_AUDIO",
+		.always_on = 1,
+	},
+};
+#endif
+
+#ifdef CONFIG_SMDK6410_WM1190_EV1
+/* S3C64xx internal logic & PLL */
+static struct regulator_init_data wm8350_dcdc1_data = {
+	.constraints = {
+		.name = "PVDD_INT/PVDD_PLL",
 		.min_uV = 1200000,
 		.max_uV = 1200000,
 		.always_on = 1,
@@ -337,24 +388,40 @@ static struct regulator_init_data wm8350_ldo1_data = {
 	},
 };
 
-/* OTG */
-static struct regulator_init_data wm8350_ldo2_data = {
+/* Memory */
+static struct regulator_init_data wm8350_dcdc3_data = {
 	.constraints = {
-		.name = "PVDD_OTG",
-		.min_uV = 3300000,
-		.max_uV = 3300000,
+		.name = "PVDD_MEM",
+		.min_uV = 1800000,
+		.max_uV = 1800000,
 		.always_on = 1,
+		.state_mem = {
+			 .uV = 1800000,
+			 .mode = REGULATOR_MODE_NORMAL,
+			 .enabled = 1,
+		},
+		.initial_state = PM_SUSPEND_MEM,
 	},
 };
 
-/* LCD */
-static struct regulator_init_data wm8350_ldo3_data = {
+/* USB, EXT, PCM, ADC/DAC, USB, MMC */
+static struct regulator_consumer_supply wm8350_dcdc4_consumers[] = {
+	{
+		/* WM8580 */
+		.supply = "DVDD",
+		.dev_name = "0-001b",
+	},
+};
+
+static struct regulator_init_data wm8350_dcdc4_data = {
 	.constraints = {
-		.name = "PVDD_LCD",
+		.name = "PVDD_HI/PVDD_EXT/PVDD_SYS/PVCCM2MTV",
 		.min_uV = 3000000,
 		.max_uV = 3000000,
 		.always_on = 1,
 	},
+	.num_consumer_supplies = ARRAY_SIZE(wm8350_dcdc4_consumers),
+	.consumer_supplies = wm8350_dcdc4_consumers,
 };
 
 /* OTGi/1190-EV1 HPVDD & AVDD */
@@ -375,10 +442,10 @@ static struct {
 	{ WM8350_DCDC_1, &wm8350_dcdc1_data },
 	{ WM8350_DCDC_3, &wm8350_dcdc3_data },
 	{ WM8350_DCDC_4, &wm8350_dcdc4_data },
-	{ WM8350_DCDC_6, &wm8350_dcdc6_data },
-	{ WM8350_LDO_1, &wm8350_ldo1_data },
-	{ WM8350_LDO_2, &wm8350_ldo2_data },
-	{ WM8350_LDO_3, &wm8350_ldo3_data },
+	{ WM8350_DCDC_6, &smdk6410_vddarm },
+	{ WM8350_LDO_1, &smdk6410_vddalive },
+	{ WM8350_LDO_2, &smdk6410_vddotg },
+	{ WM8350_LDO_3, &smdk6410_vddlcd },
 	{ WM8350_LDO_4, &wm8350_ldo4_data },
 };
 
@@ -405,10 +472,89 @@ static struct wm8350_platform_data __initdata smdk6410_wm8350_pdata = {
 };
 #endif
 
+#ifdef CONFIG_SMDK6410_WM1192_EV1
+static int wm1192_pre_init(struct wm831x *wm831x)
+{
+	/* Configure the IRQ line */
+	s3c_gpio_setpull(S3C64XX_GPN(12), S3C_GPIO_PULL_UP);
+
+	return 0;
+}
+
+static struct wm831x_backlight_pdata wm1192_backlight_pdata = {
+	.isink = 1,
+	.max_uA = 27554,
+};
+
+static struct regulator_init_data wm1192_dcdc3 = {
+	.constraints = {
+		.name = "PVDD_MEM/PVDD_GPS",
+		.always_on = 1,
+	},
+};
+
+static struct regulator_consumer_supply wm1192_ldo1_consumers[] = {
+	{ .supply = "DVDD", .dev_name = "0-001b", },   /* WM8580 */
+};
+
+static struct regulator_init_data wm1192_ldo1 = {
+	.constraints = {
+		.name = "PVDD_LCD/PVDD_EXT",
+		.always_on = 1,
+	},
+	.consumer_supplies = wm1192_ldo1_consumers,
+	.num_consumer_supplies = ARRAY_SIZE(wm1192_ldo1_consumers),
+};
+
+static struct wm831x_status_pdata wm1192_led7_pdata = {
+	.name = "LED7:green:",
+};
+
+static struct wm831x_status_pdata wm1192_led8_pdata = {
+	.name = "LED8:green:",
+};
+
+static struct wm831x_pdata smdk6410_wm1192_pdata = {
+	.pre_init = wm1192_pre_init,
+	.irq_base = IRQ_BOARD_START,
+
+	.backlight = &wm1192_backlight_pdata,
+	.dcdc = {
+		&smdk6410_vddarm,  /* DCDC1 */
+		&smdk6410_vddint,  /* DCDC2 */
+		&wm1192_dcdc3,
+	},
+	.ldo = {
+		 &wm1192_ldo1,        /* LDO1 */
+		 &smdk6410_vdduh_mmc, /* LDO2 */
+		 NULL,                /* LDO3 NC */
+		 &smdk6410_vddotgi,   /* LDO4 */
+		 &smdk6410_vddotg,    /* LDO5 */
+		 &smdk6410_vddhi,     /* LDO6 */
+		 &smdk6410_vddaudio,  /* LDO7 */
+		 &smdk6410_vccm2mtv,  /* LDO8 */
+		 &smdk6410_vddpll,    /* LDO9 */
+		 &smdk6410_vccmc3bt,  /* LDO10 */
+		 &smdk6410_vddalive,  /* LDO11 */
+	},
+	.status = {
+		&wm1192_led7_pdata,
+		&wm1192_led8_pdata,
+	},
+};
+#endif
+
 static struct i2c_board_info i2c_devs0[] __initdata = {
 	{ I2C_BOARD_INFO("24c08", 0x50), },
 	{ I2C_BOARD_INFO("wm8580", 0x1b), },
 
+#ifdef CONFIG_SMDK6410_WM1192_EV1
+	{ I2C_BOARD_INFO("wm8312", 0x34),
+	  .platform_data = &smdk6410_wm1192_pdata,
+	  .irq = S3C_EINT(12),
+	},
+#endif
+
 #ifdef CONFIG_SMDK6410_WM1190_EV1
 	{ I2C_BOARD_INFO("wm8350", 0x1a),
 	  .platform_data = &smdk6410_wm8350_pdata,
diff --git a/arch/arm/plat-s3c64xx/include/plat/irqs.h b/arch/arm/plat-s3c64xx/include/plat/irqs.h
index a227581..ce40364 100644
--- a/arch/arm/plat-s3c64xx/include/plat/irqs.h
+++ b/arch/arm/plat-s3c64xx/include/plat/irqs.h
@@ -200,6 +200,8 @@
 
 #ifdef CONFIG_SMDK6410_WM1190_EV1
 #define IRQ_BOARD_NR 64
+#elif defined(CONFIG_SMDK6410_WM1192_EV1)
+#define IRQ_BOARD_NR 64
 #else
 #define IRQ_BOARD_NR 16
 #endif
-- 
1.6.6.1
