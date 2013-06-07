From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Jun 2013 17:11:22 +0100
Subject: [PATCH 04/10] ARM: ux500: Provide the supply regulator through
 consumers
In-Reply-To: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
References: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370621488-18130-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The supply name is now provided through the regulator descriptor, so
instead of applying a supply_regulator name for each subordinate
regulator requiring it, we can just register a link between the chip
and supply name to achieve the same thing. This reduces platform data
code and standardises the semantics between ATAG and DT boots.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-regulators.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 0dc44c6..70111d5 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -374,7 +374,6 @@ static struct ab8500_regulator_reg_init ab8500_reg_init[] = {
 static struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 	/* supplies to the display/camera */
 	[AB8500_LDO_AUX1] = {
-		.supply_regulator = "ab8500-ext-supply3",
 		.constraints = {
 			.name = "V-DISPLAY",
 			.min_uV = 2800000,
@@ -388,7 +387,6 @@ static struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 	},
 	/* supplies to the on-board eMMC */
 	[AB8500_LDO_AUX2] = {
-		.supply_regulator = "ab8500-ext-supply3",
 		.constraints = {
 			.name = "V-eMMC1",
 			.min_uV = 1100000,
@@ -404,7 +402,6 @@ static struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 	},
 	/* supply for VAUX3, supplies to SDcard slots */
 	[AB8500_LDO_AUX3] = {
-		.supply_regulator = "ab8500-ext-supply3",
 		.constraints = {
 			.name = "V-MMC-SD",
 			.min_uV = 1100000,
@@ -495,6 +492,7 @@ static struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 static struct regulator_consumer_supply ab8500_ext_supply3_consumers[] = {
 	/* SIM supply for 3 V SIM cards */
 	REGULATOR_SUPPLY("vinvsim", "sim-detect.0"),
+	REGULATOR_SUPPLY("vin", "ab8500-regulator.0"),
 };
 
 /* extended configuration for VextSupply2, only used for HREFP_V20 boards */
-- 
1.7.10.4
