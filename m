From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 01 Dec 2011 18:05:17 +0900
Subject: [PATCH 4/4] ARM Exynos4210-Nuri: support Exynos4210-bus Devfreq
 driver.
In-Reply-To: <1322730317-8171-1-git-send-email-myungjoo.ham@samsung.com>
References: <1322730317-8171-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1322730317-8171-5-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support varying voltages:
- GPIODVS for Buck2 is removed.
- Voltage ragne for Buck2 is widen.

Support Buck2 regulator for Exynos4210-bus devfreq driver:
- Added device name for buck2 regulator
- Added exynos4210-busfreq platform device fro Nuri board.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/mach-nuri.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 4cef1fb..dc4cc1d 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -436,7 +436,7 @@ static struct regulator_consumer_supply __initdata max8997_buck1_[] = {
 	REGULATOR_SUPPLY("vdd_arm", NULL), /* CPUFREQ */
 };
 static struct regulator_consumer_supply __initdata max8997_buck2_[] = {
-	REGULATOR_SUPPLY("vdd_int", NULL), /* CPUFREQ */
+	REGULATOR_SUPPLY("vdd_int", "exynos4210-busfreq.0"), /* CPUFREQ */
 };
 static struct regulator_consumer_supply __initdata max8997_buck3_[] = {
 	REGULATOR_SUPPLY("vdd", "mali_dev.0"), /* G3D of Exynos 4 */
@@ -747,7 +747,7 @@ static struct regulator_init_data __initdata max8997_buck2_data = {
 	.constraints	= {
 		.name		= "VINT_1.1V_C210",
 		.min_uV		= 900000,
-		.max_uV		= 1100000,
+		.max_uV		= 1200000,
 		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
 		.always_on	= 1,
 		.state_mem	= {
@@ -962,7 +962,6 @@ static struct max8997_platform_data __initdata nuri_max8997_pdata = {
 	.regulators		= nuri_max8997_regulators,
 
 	.buck125_gpios = { EXYNOS4_GPX0(5), EXYNOS4_GPX0(6), EXYNOS4_GPL0(0) },
-	.buck2_gpiodvs = true,
 
 	.buck1_voltage[0] = 1350000, /* 1.35V */
 	.buck1_voltage[1] = 1300000, /* 1.3V */
@@ -1244,6 +1243,11 @@ static struct s3c2410_platform_i2c nuri_i2c0_platdata __initdata = {
 	.sda_delay	= 200,
 };
 
+/* DEVFREQ controlling memory/bus */
+static struct platform_device exynos4_bus_devfreq = {
+	.name			= "exynos4210-busfreq",
+};
+
 static struct platform_device *nuri_devices[] __initdata = {
 	/* Samsung Platform Devices */
 	&s3c_device_i2c5, /* PMIC should initialize first */
@@ -1281,6 +1285,7 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&nuri_max8903_device,
 	&cam_vdda_fixed_rdev,
 	&cam_8m_12v_fixed_rdev,
+	&exynos4_bus_devfreq,
 };
 
 static void __init nuri_map_io(void)
-- 
1.7.4.1
