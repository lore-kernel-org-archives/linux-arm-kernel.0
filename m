From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  3 Aug 2012 17:45:21 -0600
Subject: [PATCH] ARM: tegra: more regulator fixes for Harmony
Message-ID: <1344037521-6157-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Commit 3d55c29 "ARM: tegra: harmony: add regulator supply name and its
input supply" was supposed to fix all the problems with regulators on
Harmony. However, it appears that I only tested it when booting using
board files, not when booting using device tree. This change fixes two
problems with regulators when booting using device tree:

1) That patch only created the vdd_sys regulator when booting using a
   board file. Since this is the root of the whole regulator tree, this
   caused no regulators to successfully initialize when booting using
   device tree. The registration of vdd_sys is moved to fix this.

2) When booting use DT, the regulator core sets has_full_constraints,
   which in turn causes the core to turn off any regulators not marked
   as always on. Some of the affected regulators are required for basic
   system operation. To solve this, add always on constraints to all
   relevant regulators. This doesn't affect booting using a board file
   since nothing sets has_full_constraints in that case.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This is a fix for v3.6.

I wrote and tested this patch on top of v3.6-rc1, and also tested it with
both next-20120803 and next-20120803 plus a bunch of local patches.

 arch/arm/mach-tegra/board-harmony-power.c |   32 +++++++++++++++-------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony-power.c b/arch/arm/mach-tegra/board-harmony-power.c
index 8fd387b..b7344be 100644
--- a/arch/arm/mach-tegra/board-harmony-power.c
+++ b/arch/arm/mach-tegra/board-harmony-power.c
@@ -51,7 +51,7 @@ static struct regulator_init_data ldo0_data = {
 	.consumer_supplies = tps658621_ldo0_supply,
 };
 
-#define HARMONY_REGULATOR_INIT(_id, _name, _supply, _minmv, _maxmv)	\
+#define HARMONY_REGULATOR_INIT(_id, _name, _supply, _minmv, _maxmv, _on)\
 	static struct regulator_init_data _id##_data = {		\
 		.supply_regulator = _supply,				\
 		.constraints = {					\
@@ -63,21 +63,22 @@ static struct regulator_init_data ldo0_data = {
 			.valid_ops_mask = (REGULATOR_CHANGE_MODE |	\
 					   REGULATOR_CHANGE_STATUS |	\
 					   REGULATOR_CHANGE_VOLTAGE),	\
+			.always_on = _on,				\
 		},							\
 	}
 
-HARMONY_REGULATOR_INIT(sm0,  "vdd_sm0",  "vdd_sys", 725, 1500);
-HARMONY_REGULATOR_INIT(sm1,  "vdd_sm1",  "vdd_sys", 725, 1500);
-HARMONY_REGULATOR_INIT(sm2,  "vdd_sm2",  "vdd_sys", 3000, 4550);
-HARMONY_REGULATOR_INIT(ldo1, "vdd_ldo1", "vdd_sm2", 725, 1500);
-HARMONY_REGULATOR_INIT(ldo2, "vdd_ldo2", "vdd_sm2", 725, 1500);
-HARMONY_REGULATOR_INIT(ldo3, "vdd_ldo3", "vdd_sm2", 1250, 3300);
-HARMONY_REGULATOR_INIT(ldo4, "vdd_ldo4", "vdd_sm2", 1700, 2475);
-HARMONY_REGULATOR_INIT(ldo5, "vdd_ldo5", NULL,	    1250, 3300);
-HARMONY_REGULATOR_INIT(ldo6, "vdd_ldo6", "vdd_sm2", 1250, 3300);
-HARMONY_REGULATOR_INIT(ldo7, "vdd_ldo7", "vdd_sm2", 1250, 3300);
-HARMONY_REGULATOR_INIT(ldo8, "vdd_ldo8", "vdd_sm2", 1250, 3300);
-HARMONY_REGULATOR_INIT(ldo9, "vdd_ldo9", "vdd_sm2", 1250, 3300);
+HARMONY_REGULATOR_INIT(sm0,  "vdd_sm0",  "vdd_sys", 725, 1500, 1);
+HARMONY_REGULATOR_INIT(sm1,  "vdd_sm1",  "vdd_sys", 725, 1500, 1);
+HARMONY_REGULATOR_INIT(sm2,  "vdd_sm2",  "vdd_sys", 3000, 4550, 1);
+HARMONY_REGULATOR_INIT(ldo1, "vdd_ldo1", "vdd_sm2", 725, 1500, 1);
+HARMONY_REGULATOR_INIT(ldo2, "vdd_ldo2", "vdd_sm2", 725, 1500, 0);
+HARMONY_REGULATOR_INIT(ldo3, "vdd_ldo3", "vdd_sm2", 1250, 3300, 1);
+HARMONY_REGULATOR_INIT(ldo4, "vdd_ldo4", "vdd_sm2", 1700, 2475, 1);
+HARMONY_REGULATOR_INIT(ldo5, "vdd_ldo5", NULL,	    1250, 3300, 1);
+HARMONY_REGULATOR_INIT(ldo6, "vdd_ldo6", "vdd_sm2", 1250, 3300, 0);
+HARMONY_REGULATOR_INIT(ldo7, "vdd_ldo7", "vdd_sm2", 1250, 3300, 0);
+HARMONY_REGULATOR_INIT(ldo8, "vdd_ldo8", "vdd_sm2", 1250, 3300, 0);
+HARMONY_REGULATOR_INIT(ldo9, "vdd_ldo9", "vdd_sm2", 1250, 3300, 1);
 
 #define TPS_REG(_id, _data)			\
 	{					\
@@ -119,9 +120,10 @@ static struct i2c_board_info __initdata harmony_regulators[] = {
 
 int __init harmony_regulator_init(void)
 {
+	regulator_register_always_on(0, "vdd_sys",
+		NULL, 0, 5000000);
+
 	if (machine_is_harmony()) {
-		regulator_register_always_on(0, "vdd_sys",
-			NULL, 0, 5000000);
 		i2c_register_board_info(3, harmony_regulators, 1);
 	} else { /* Harmony, booted using device tree */
 		struct device_node *np;
-- 
1.7.0.4
