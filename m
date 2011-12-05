From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon,  5 Dec 2011 17:23:37 +0000
Subject: [PATCH] ARM: S3C64XX: Hook up VDDINT on Cragganmore
Message-ID: <1323105817-5638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basic hookup, we do have a GPIO to use to control the voltage but we don't
currently use it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 47a36c4..879d949 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -381,6 +381,10 @@ static struct regulator_init_data vddarm __initdata = {
 	.driver_data = &vddarm_pdata,
 };
 
+static struct regulator_consumer_supply vddint_consumers[] __initdata = {
+	REGULATOR_SUPPLY("vddint", NULL),
+};
+
 static struct regulator_init_data vddint __initdata = {
 	.constraints = {
 		.name = "VDDINT",
@@ -389,6 +393,9 @@ static struct regulator_init_data vddint __initdata = {
 		.always_on = 1,
 		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
 	},
+	.num_consumer_supplies = ARRAY_SIZE(vddint_consumers),
+	.consumer_supplies = vddint_consumers,
+	.supply_regulator = "WALLVDD",
 };
 
 static struct regulator_init_data vddmem __initdata = {
-- 
1.7.7.3
