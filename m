From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 19 Aug 2010 17:50:46 +0900
Subject: [PATCH 4/4] ARM: S5PC110: GONI: Fixed voltage support for eMMC
In-Reply-To: <1282207846-4578-1-git-send-email-jy0922.shim@samsung.com>
References: <1282207846-4578-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <1282207846-4578-4-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Add the fixed voltage regulator for eMMC (connected with mmc0)
Also add the 8-bit mmc support when use the board revision 6

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/mach-goni.c |   46 +++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 21a1bfc..25cee00 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -20,6 +20,8 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
+#include <linux/mmc/host.h>
+#include <linux/regulator/fixed.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -40,6 +42,11 @@
 #include <plat/keypad.h>
 #include <plat/sdhci.h>
 
+static inline int hwrevision(int hwrev)
+{
+	return (system_rev & 0xff) == hwrev;
+}
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define GONI_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -534,11 +541,49 @@ static struct s3c_sdhci_platdata goni_hsmmc2_data __initdata = {
 	.ext_cd_gpio_invert	= 1,
 };
 
+static struct regulator_consumer_supply eMMC_supplies[] = {
+	{
+		.dev		= &s3c_device_hsmmc0.dev,
+		.supply		= "vmmc",
+	},
+};
+
+static struct regulator_init_data mmc0_fixed_voltage_init_data = {
+	.constraints		= {
+		.name		= "VMEM_2.8V",
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(eMMC_supplies),
+	.consumer_supplies	= eMMC_supplies,
+};
+
+static struct fixed_voltage_config mmc0_fixed_voltage_config = {
+	.supply_name		= "eMMC",
+	.microvolts		= 2800000,
+	.gpio			= S5PV210_GPJ2(7),      /* XMSMDATA_7 */
+	.enable_high		= true,
+	.enabled_at_boot	= true,
+	.init_data		= &mmc0_fixed_voltage_init_data,
+};
+
+static struct platform_device mmc0_fixed_voltage = {
+	.name			= "reg-fixed-voltage",
+	.id			= 2,
+	.dev			= {
+		.platform_data	= &mmc0_fixed_voltage_config,
+	},
+};
+
 static void goni_setup_sdhci(void)
 {
 	gpio_request(GONI_EXT_FLASH_EN, "FLASH_EN");
 	gpio_direction_output(GONI_EXT_FLASH_EN, 1);
 
+	if (hwrevision(6)) {
+		goni_hsmmc0_data.max_width = 8;
+		goni_hsmmc0_data.host_caps |= MMC_CAP_8_BIT_DATA;
+	}
+
 	s3c_sdhci0_set_platdata(&goni_hsmmc0_data);
 	s3c_sdhci1_set_platdata(&goni_hsmmc1_data);
 	s3c_sdhci2_set_platdata(&goni_hsmmc2_data);
@@ -552,6 +597,7 @@ static struct platform_device *goni_devices[] __initdata = {
 	&s5p_device_fimc0,
 	&s5p_device_fimc1,
 	&s5p_device_fimc2,
+	&mmc0_fixed_voltage,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
-- 
1.7.0.4
