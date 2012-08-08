From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 16:47:26 +0200
Subject: [PATCH 09/11] regulator/twl: remove fixed resource handling
In-Reply-To: <1344437248-20560-1-git-send-email-arnd@arndb.de>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
Message-ID: <1344437248-20560-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent patch 0e8e5c34cf "regulator: twl: Remove references to
32kHz clock from DT bindings" removed the only use of the fake
"CLK32KG" regulator but not the TWL6030_FIXED_RESOURCE and
twl6030_fixed_resource definitions that are unused otherwise.

Without this patch, building omap2plus_defconfig results in:

drivers/regulator/twl-regulator.c:1051:27: warning: 'TWLRES_INFO_CLK32KG' defined but not used [-Wunused-variable]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/twl-regulator.c |   21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 242fe90..514a84b 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -659,13 +659,6 @@ static struct regulator_ops twl6030fixed_ops = {
 	.get_status	= twl6030reg_get_status,
 };
 
-static struct regulator_ops twl6030_fixed_resource = {
-	.enable		= twl6030reg_enable,
-	.disable	= twl6030reg_disable,
-	.is_enabled	= twl6030reg_is_enabled,
-	.get_status	= twl6030reg_get_status,
-};
-
 /*
  * SMPS status and control
  */
@@ -967,19 +960,6 @@ static struct twlreg_info TWLFIXED_INFO_##label = { \
 		}, \
 	}
 
-#define TWL6030_FIXED_RESOURCE(label, offset, turnon_delay) \
-static struct twlreg_info TWLRES_INFO_##label = { \
-	.base = offset, \
-	.desc = { \
-		.name = #label, \
-		.id = TWL6030_REG_##label, \
-		.ops = &twl6030_fixed_resource, \
-		.type = REGULATOR_VOLTAGE, \
-		.owner = THIS_MODULE, \
-		.enable_time = turnon_delay, \
-		}, \
-	}
-
 #define TWL6025_ADJUSTABLE_SMPS(label, offset) \
 static struct twlreg_info TWLSMPS_INFO_##label = { \
 	.base = offset, \
@@ -1048,7 +1028,6 @@ TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 0);
 TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 0);
 TWL6030_FIXED_LDO(V1V8, 0x16, 1800, 0);
 TWL6030_FIXED_LDO(V2V1, 0x1c, 2100, 0);
-TWL6030_FIXED_RESOURCE(CLK32KG, 0x8C, 0);
 TWL6025_ADJUSTABLE_SMPS(SMPS3, 0x34);
 TWL6025_ADJUSTABLE_SMPS(SMPS4, 0x10);
 TWL6025_ADJUSTABLE_SMPS(VIO, 0x16);
-- 
1.7.10
