From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 24 Jul 2012 10:36:23 -0600
Subject: [PATCH] ARM: tegra: harmony: add regulator supply name and its input
 supply
Message-ID: <1343147783-24948-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laxman Dewangan <ldewangan@nvidia.com>

Name the regulator as per board schematics and adds its
supply name info in regulator data.
Add the always on fixed regulator to refer the battery supply.

Use this fixed regulator for input supply of some of PMIC
regulator

This patch was originally part of a 2-patch series. Patch 2 got applied
to the regulator tree as 7c7fac3 "regulator: tps6586x: add support for
input supply" without this patch. This broke regulator support on
Harmony.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
[swarren: added dependency info to commit description]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-harmony-power.c |   33 +++++++++++++++++-----------
 1 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony-power.c b/arch/arm/mach-tegra/board-harmony-power.c
index 44dcb2e..8fd387b 100644
--- a/arch/arm/mach-tegra/board-harmony-power.c
+++ b/arch/arm/mach-tegra/board-harmony-power.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/mfd/tps6586x.h>
 #include <linux/of.h>
 #include <linux/of_i2c.h>
@@ -34,7 +35,9 @@ static struct regulator_consumer_supply tps658621_ldo0_supply[] = {
 };
 
 static struct regulator_init_data ldo0_data = {
+	.supply_regulator = "vdd_sm2",
 	.constraints = {
+		.name = "vdd_ldo0",
 		.min_uV = 3300 * 1000,
 		.max_uV = 3300 * 1000,
 		.valid_modes_mask = (REGULATOR_MODE_NORMAL |
@@ -48,9 +51,11 @@ static struct regulator_init_data ldo0_data = {
 	.consumer_supplies = tps658621_ldo0_supply,
 };
 
-#define HARMONY_REGULATOR_INIT(_id, _minmv, _maxmv)			\
+#define HARMONY_REGULATOR_INIT(_id, _name, _supply, _minmv, _maxmv)	\
 	static struct regulator_init_data _id##_data = {		\
+		.supply_regulator = _supply,				\
 		.constraints = {					\
+			.name = _name,					\
 			.min_uV = (_minmv)*1000,			\
 			.max_uV = (_maxmv)*1000,			\
 			.valid_modes_mask = (REGULATOR_MODE_NORMAL |	\
@@ -61,18 +66,18 @@ static struct regulator_init_data ldo0_data = {
 		},							\
 	}
 
-HARMONY_REGULATOR_INIT(sm0, 725, 1500);
-HARMONY_REGULATOR_INIT(sm1, 725, 1500);
-HARMONY_REGULATOR_INIT(sm2, 3000, 4550);
-HARMONY_REGULATOR_INIT(ldo1, 725, 1500);
-HARMONY_REGULATOR_INIT(ldo2, 725, 1500);
-HARMONY_REGULATOR_INIT(ldo3, 1250, 3300);
-HARMONY_REGULATOR_INIT(ldo4, 1700, 2475);
-HARMONY_REGULATOR_INIT(ldo5, 1250, 3300);
-HARMONY_REGULATOR_INIT(ldo6, 1250, 3300);
-HARMONY_REGULATOR_INIT(ldo7, 1250, 3300);
-HARMONY_REGULATOR_INIT(ldo8, 1250, 3300);
-HARMONY_REGULATOR_INIT(ldo9, 1250, 3300);
+HARMONY_REGULATOR_INIT(sm0,  "vdd_sm0",  "vdd_sys", 725, 1500);
+HARMONY_REGULATOR_INIT(sm1,  "vdd_sm1",  "vdd_sys", 725, 1500);
+HARMONY_REGULATOR_INIT(sm2,  "vdd_sm2",  "vdd_sys", 3000, 4550);
+HARMONY_REGULATOR_INIT(ldo1, "vdd_ldo1", "vdd_sm2", 725, 1500);
+HARMONY_REGULATOR_INIT(ldo2, "vdd_ldo2", "vdd_sm2", 725, 1500);
+HARMONY_REGULATOR_INIT(ldo3, "vdd_ldo3", "vdd_sm2", 1250, 3300);
+HARMONY_REGULATOR_INIT(ldo4, "vdd_ldo4", "vdd_sm2", 1700, 2475);
+HARMONY_REGULATOR_INIT(ldo5, "vdd_ldo5", NULL,	    1250, 3300);
+HARMONY_REGULATOR_INIT(ldo6, "vdd_ldo6", "vdd_sm2", 1250, 3300);
+HARMONY_REGULATOR_INIT(ldo7, "vdd_ldo7", "vdd_sm2", 1250, 3300);
+HARMONY_REGULATOR_INIT(ldo8, "vdd_ldo8", "vdd_sm2", 1250, 3300);
+HARMONY_REGULATOR_INIT(ldo9, "vdd_ldo9", "vdd_sm2", 1250, 3300);
 
 #define TPS_REG(_id, _data)			\
 	{					\
@@ -115,6 +120,8 @@ static struct i2c_board_info __initdata harmony_regulators[] = {
 int __init harmony_regulator_init(void)
 {
 	if (machine_is_harmony()) {
+		regulator_register_always_on(0, "vdd_sys",
+			NULL, 0, 5000000);
 		i2c_register_board_info(3, harmony_regulators, 1);
 	} else { /* Harmony, booted using device tree */
 		struct device_node *np;
-- 
1.7.0.4
