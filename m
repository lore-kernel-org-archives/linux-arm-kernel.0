From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:41 -0700
Subject: [PATCH 37/46] davinci: DA850/OMAP-L138 EVM: add support for TPS65070
	PMIC
In-Reply-To: <1255720190-7452-38-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-22-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-23-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-24-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-25-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-26-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-27-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-28-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-29-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-30-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-31-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-32-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-33-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-34-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-35-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-36-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-37-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-38-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-39-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

This patch adds support for using the TPS65070 PMIC found
on the DA850/OMAP-L138 EVM.

It defines the power rail consumer mapping and registers the
the I2C based PMIC as a board device.

The power rail constraints are derived from the maxmimum and
minimum recommended operating condition values of the respective
consumers derived from section 5.2 of the OMAP-L138 datasheet.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da850-evm.c |  153 +++++++++++++++++++++++++++++++
 1 files changed, 153 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 16c8cce..a34df64 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -23,6 +23,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/regulator/machine.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -251,6 +252,153 @@ static void __init da850_evm_init_nor(void)
 	iounmap(aemif_addr);
 }
 
+/* TPS65070 voltage regulator support */
+
+/* 3.3V */
+struct regulator_consumer_supply tps65070_dcdc1_consumers[] = {
+	{
+		.supply = "usb0_vdda33",
+	},
+	{
+		.supply = "usb1_vdda33",
+	},
+};
+
+/* 3.3V or 1.8V */
+struct regulator_consumer_supply tps65070_dcdc2_consumers[] = {
+	{
+		.supply = "dvdd3318_a",
+	},
+	{
+		.supply = "dvdd3318_b",
+	},
+	{
+		.supply = "dvdd3318_c",
+	},
+};
+
+/* 1.2V */
+struct regulator_consumer_supply tps65070_dcdc3_consumers[] = {
+	{
+		.supply = "cvdd",
+	},
+};
+
+/* 1.8V LDO */
+struct regulator_consumer_supply tps65070_ldo1_consumers[] = {
+	{
+		.supply = "sata_vddr",
+	},
+	{
+		.supply = "usb0_vdda18",
+	},
+	{
+		.supply = "usb1_vdda18",
+	},
+	{
+		.supply = "ddr_dvdd18",
+	},
+};
+
+/* 1.2V LDO */
+struct regulator_consumer_supply tps65070_ldo2_consumers[] = {
+	{
+		.supply = "sata_vdd",
+	},
+	{
+		.supply = "pll0_vdda",
+	},
+	{
+		.supply = "pll1_vdda",
+	},
+	{
+		.supply = "usbs_cvdd",
+	},
+	{
+		.supply = "vddarnwa1",
+	},
+};
+
+struct regulator_init_data tps65070_regulator_data[] = {
+	/* dcdc1 */
+	{
+		.constraints = {
+			.min_uV = 3150000,
+			.max_uV = 3450000,
+			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+				REGULATOR_CHANGE_STATUS),
+			.boot_on = 1,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(tps65070_dcdc1_consumers),
+		.consumer_supplies = tps65070_dcdc1_consumers,
+	},
+
+	/* dcdc2 */
+	{
+		.constraints = {
+			.min_uV = 1710000,
+			.max_uV = 3450000,
+			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+				REGULATOR_CHANGE_STATUS),
+			.boot_on = 1,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(tps65070_dcdc2_consumers),
+		.consumer_supplies = tps65070_dcdc2_consumers,
+	},
+
+	/* dcdc3 */
+	{
+		.constraints = {
+			.min_uV = 950000,
+			.max_uV = 1320000,
+			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+				REGULATOR_CHANGE_STATUS),
+			.boot_on = 1,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(tps65070_dcdc3_consumers),
+		.consumer_supplies = tps65070_dcdc3_consumers,
+	},
+
+	/* ldo1 */
+	{
+		.constraints = {
+			.min_uV = 1710000,
+			.max_uV = 1890000,
+			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+				REGULATOR_CHANGE_STATUS),
+			.boot_on = 1,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(tps65070_ldo1_consumers),
+		.consumer_supplies = tps65070_ldo1_consumers,
+	},
+
+	/* ldo2 */
+	{
+		.constraints = {
+			.min_uV = 1140000,
+			.max_uV = 1320000,
+			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
+				REGULATOR_CHANGE_STATUS),
+			.boot_on = 1,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(tps65070_ldo2_consumers),
+		.consumer_supplies = tps65070_ldo2_consumers,
+	},
+};
+
+static struct i2c_board_info __initdata da850evm_tps65070_info[] = {
+	{
+		I2C_BOARD_INFO("tps6507x", 0x48),
+		.platform_data = &tps65070_regulator_data[0],
+	},
+};
+
+static int __init pmic_tps65070_init(void)
+{
+	return i2c_register_board_info(1, da850evm_tps65070_info,
+					ARRAY_SIZE(da850evm_tps65070_info));
+}
+
 #if defined(CONFIG_MTD_PHYSMAP) || \
     defined(CONFIG_MTD_PHYSMAP_MODULE)
 #define HAS_NOR 1
@@ -275,6 +423,11 @@ static __init void da850_evm_init(void)
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 	int ret;
 
+	ret = pmic_tps65070_init();
+	if (ret)
+		pr_warning("da850_evm_init: TPS65070 PMIC init failed: %d\n",
+				ret);
+
 	ret = da8xx_pinmux_setup(da850_nand_pins);
 	if (ret)
 		pr_warning("da850_evm_init: nand mux setup failed: %d\n",
-- 
1.6.4.3
