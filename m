From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 20 Dec 2010 14:37:35 +0900
Subject: [PATCH] S5PC210: Universal: SDHCI devices support
Message-ID: <20101220053735.GA892@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Universal (C21) board has 3 SDHCI devices.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index 1150b36..c6d735c 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -82,6 +82,10 @@ config MACH_UNIVERSAL_C210
 	bool "Mobile UNIVERSAL_C210 Board"
 	select CPU_S5PV310
 	select S5P_DEV_ONENAND
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC2
+	select S3C_DEV_HSMMC3
+	select S5PV310_SETUP_SDHCI
 	select S3C_DEV_I2C1
 	select S5PV310_SETUP_I2C1
 	help
diff --git a/arch/arm/mach-s5pv310/mach-universal_c210.c b/arch/arm/mach-s5pv310/mach-universal_c210.c
index 16d8fc0..36bc3cf 100644
--- a/arch/arm/mach-s5pv310/mach-universal_c210.c
+++ b/arch/arm/mach-s5pv310/mach-universal_c210.c
@@ -13,6 +13,9 @@
 #include <linux/i2c.h>
 #include <linux/gpio_keys.h>
 #include <linux/gpio.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
+#include <linux/mmc/host.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -21,6 +24,7 @@
 #include <plat/s5pv310.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
+#include <plat/sdhci.h>
 
 #include <mach/map.h>
 
@@ -116,6 +120,73 @@ static struct platform_device universal_gpio_keys = {
 	},
 };
 
+/* eMMC */
+static struct s3c_sdhci_platdata universal_hsmmc0_data __initdata = {
+	.max_width		= 8,
+	.host_caps		= (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA |
+				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
+				MMC_CAP_DISABLE),
+	.cd_type		= S3C_SDHCI_CD_PERMANENT,
+	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
+};
+
+static struct regulator_consumer_supply mmc0_supplies[] = {
+	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.0"),
+};
+
+static struct regulator_init_data mmc0_fixed_voltage_init_data = {
+	.constraints		= {
+		.name		= "VMEM_VDD_2.8V",
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(mmc0_supplies),
+	.consumer_supplies	= mmc0_supplies,
+};
+
+static struct fixed_voltage_config mmc0_fixed_voltage_config = {
+	.supply_name		= "MASSMEMORY_EN",
+	.microvolts		= 2800000,
+	.gpio			= S5PV310_GPE1(3),
+	.enable_high		= true,
+	.init_data		= &mmc0_fixed_voltage_init_data,
+};
+
+static struct platform_device mmc0_fixed_voltage = {
+	.name			= "reg-fixed-voltage",
+	.id			= 0,
+	.dev			= {
+		.platform_data	= &mmc0_fixed_voltage_config,
+	},
+};
+
+/* SD */
+static struct s3c_sdhci_platdata universal_hsmmc2_data __initdata = {
+	.max_width		= 4,
+	.host_caps		= MMC_CAP_4_BIT_DATA |
+				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
+				MMC_CAP_DISABLE,
+	.ext_cd_gpio		= S5PV310_GPX3(4),      /* XEINT_28 */
+	.ext_cd_gpio_invert	= 1,
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
+};
+
+/* WiFi */
+static struct s3c_sdhci_platdata universal_hsmmc3_data __initdata = {
+	.max_width		= 4,
+	.host_caps		= MMC_CAP_4_BIT_DATA |
+				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
+				MMC_CAP_DISABLE,
+	.cd_type		= S3C_SDHCI_CD_EXTERNAL,
+};
+
+static void __init universal_sdhci_init(void)
+{
+	s3c_sdhci0_set_platdata(&universal_hsmmc0_data);
+	s3c_sdhci2_set_platdata(&universal_hsmmc2_data);
+	s3c_sdhci3_set_platdata(&universal_hsmmc3_data);
+}
+
 /* I2C0 */
 static struct i2c_board_info i2c0_devs[] __initdata = {
 	/* Camera, To be updated */
@@ -127,6 +198,13 @@ static struct i2c_board_info i2c1_devs[] __initdata = {
 };
 
 static struct platform_device *universal_devices[] __initdata = {
+	/* Samsung Platform Devices */
+	&mmc0_fixed_voltage,
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc2,
+	&s3c_device_hsmmc3,
+
+	/* Universal Devices */
 	&universal_gpio_keys,
 	&s5p_device_onenand,
 };
@@ -140,6 +218,8 @@ static void __init universal_map_io(void)
 
 static void __init universal_machine_init(void)
 {
+	universal_sdhci_init();
+
 	i2c_register_board_info(0, i2c0_devs, ARRAY_SIZE(i2c0_devs));
 	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
 
