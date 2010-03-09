From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue,  9 Mar 2010 11:43:51 +0200
Subject: [PATCH 4/5] [ARM] pxa/cm-x300: add regulator on vcc_core
In-Reply-To: <1268127832-20563-3-git-send-email-grinberg@compulab.co.il>
References: <1268127832-20563-1-git-send-email-grinberg@compulab.co.il>
	<1268127832-20563-2-git-send-email-grinberg@compulab.co.il>
	<1268127832-20563-3-git-send-email-grinberg@compulab.co.il>
Message-ID: <1268127832-20563-4-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 6fba9a0..2012588 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -30,6 +30,7 @@
 #include <linux/i2c/pca953x.h>
 
 #include <linux/mfd/da903x.h>
+#include <linux/regulator/machine.h>
 #include <linux/power_supply.h>
 #include <linux/apm-emulation.h>
 
@@ -634,6 +635,27 @@ struct da9030_battery_info cm_x300_battery_info = {
 	.battery_critical = cm_x300_battery_critical,
 };
 
+static struct regulator_consumer_supply buck2_consumers[] = {
+	{
+		.dev = NULL,
+		.supply = "vcc_core",
+	},
+};
+
+static struct regulator_init_data buck2_data = {
+	.constraints = {
+		.min_uV = 1375000,
+		.max_uV = 1375000,
+		.state_mem = {
+			.enabled = 0,
+		},
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
+		.apply_uV = 1,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(buck2_consumers),
+	.consumer_supplies = buck2_consumers,
+};
+
 /* DA9030 */
 struct da903x_subdev_info cm_x300_da9030_subdevs[] = {
 	{
@@ -641,6 +663,11 @@ struct da903x_subdev_info cm_x300_da9030_subdevs[] = {
 		.id = DA9030_ID_BAT,
 		.platform_data = &cm_x300_battery_info,
 	},
+	{
+		.name = "da903x-regulator",
+		.id = DA9030_ID_BUCK2,
+		.platform_data = &buck2_data,
+	},
 };
 
 static struct da903x_platform_data cm_x300_da9030_info = {
-- 
1.6.4.4
