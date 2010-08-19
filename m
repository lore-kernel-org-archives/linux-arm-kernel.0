From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 19 Aug 2010 15:54:56 +0900
Subject: [PATCH] ARM: S5PC110: GONI: Fixed voltage support for eMMC
Message-ID: <20100819065456.GA29764@july>
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
index 48b455e..c1f0e21 100644
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
@@ -38,6 +40,11 @@
 #include <plat/fb.h>
 #include <plat/sdhci.h>
 
+static inline int hwrevision(int hwrev)
+{
+	return (system_rev & 0xff) == hwrev;
+}
+
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define GONI_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
@@ -481,11 +488,49 @@ static struct s3c_sdhci_platdata goni_hsmmc2_data __initdata = {
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
@@ -499,6 +544,7 @@ static struct platform_device *goni_devices[] __initdata = {
 	&s5p_device_fimc0,
 	&s5p_device_fimc1,
 	&s5p_device_fimc2,
+	&mmc0_fixed_voltage,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
-- 
1.5.3.3
