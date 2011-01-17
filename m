From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 17 Jan 2011 14:04:51 +0100
Subject: [PATCH] ux500: add a few AB8500 regulator consumers
Message-ID: <1295269491-12107-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Try to make the regulators a little bit more useful by adding some
of the most basic consumers we're going to have in the end.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500-regulators.c |   93 +++++++++++++++++++++++++
 1 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 533967c..b6b9399 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -11,6 +11,87 @@
 #include <linux/kernel.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/ab8500.h>
+#include "board-mop500-regulators.h"
+
+static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
+	{
+		.dev = NULL,
+		.supply = "v-display",
+	},
+	{
+		.dev_name = "bh1780",
+		.supply = "v-als",
+	},
+	{
+		.dev_name = "lsm303dlh.0",
+		.supply = "v-accel",
+	},
+	{
+		.dev_name = "lsm303dlh.1",
+		.supply = "v-mag",
+	},
+	{
+		.dev = NULL,
+		.supply = "v-mmio-camera",
+	},
+	{
+		.dev_name = "bu21013_ts.0",
+		.supply = "v-touch",
+	},
+	{
+		.dev_name = "bu21013_ts.1",
+		.supply = "v-touch",
+	},
+	{
+		.dev_name = "synaptics_rmi4_i2c0",
+		.supply = "v-touch",
+	},
+};
+
+static struct regulator_consumer_supply ab8500_vaux2_consumers[] = {
+	{
+		.dev_name = "sdi4",
+		.supply = "vmmc",
+	},
+	{
+		.dev_name = "ab8500-codec.0",
+		.supply = "vcc-N2158",
+	},
+};
+
+static struct regulator_consumer_supply ab8500_vaux3_consumers[] = {
+	{
+		.dev_name = "sdi0",
+		.supply = "vmmc"
+	},
+};
+
+static struct regulator_consumer_supply ab8500_vtvout_consumers[] = {
+	{
+		.supply = "v-tvout",
+	},
+	{
+		.supply = "ab8500-gpadc",
+	},
+};
+
+static struct regulator_consumer_supply ab8500_vintcore_consumers[] = {
+	{
+		.supply = "v-intcore",
+	},
+	{
+		.dev_name = "ab8500-usb.0",
+		.supply = "v-intcore",
+	},
+
+};
+
+static struct regulator_consumer_supply ab8500_vana_consumers[] = {
+	{
+		.dev_name = "mcde",
+		.supply = "v-ana",
+	},
+};
 
 /* AB8500 regulators */
 struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
@@ -23,6 +104,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
 					  REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux1_consumers),
+		.consumer_supplies = ab8500_vaux1_consumers,
 	},
 	/* supplies to the on-board eMMC */
 	[AB8500_LDO_AUX2] = {
@@ -33,6 +116,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
 					  REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux2_consumers),
+		.consumer_supplies = ab8500_vaux2_consumers,
 	},
 	/* supply for VAUX3, supplies to SDcard slots */
 	[AB8500_LDO_AUX3] = {
@@ -43,6 +128,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
 					  REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux3_consumers),
+		.consumer_supplies = ab8500_vaux3_consumers,
 	},
 	/* supply for tvout, gpadc, TVOUT LDO */
 	[AB8500_LDO_TVOUT] = {
@@ -50,6 +137,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.name = "V-TVOUT",
 			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vtvout_consumers),
+		.consumer_supplies = ab8500_vtvout_consumers,
 	},
 	/* supply for ab8500-vaudio, VAUDIO LDO */
 	[AB8500_LDO_AUDIO] = {
@@ -85,6 +174,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.name = "V-INTCORE",
 			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vintcore_consumers),
+		.consumer_supplies = ab8500_vintcore_consumers,
 	},
 	/* supply for U8500 CSI/DSI, VANA LDO */
 	[AB8500_LDO_ANA] = {
@@ -92,5 +183,7 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.name = "V-CSI/DSI",
 			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vana_consumers),
+		.consumer_supplies = ab8500_vana_consumers,
 	},
 };
-- 
1.7.3.2
