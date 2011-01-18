From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 18 Jan 2011 23:42:54 +0100
Subject: [PATCH] ux500: add a few AB8500 regulator consumers v2
Message-ID: <1295390574-8969-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Try to make the regulators a little bit more useful by adding some
of the most basic consumers we're going to have in the end.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Rabin Vincent <rabin@rab.in>
Cc: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
Cc: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
Changes v1->v2:
- Looked up the proper device names
- Looked up proper names for supply pins on consumers - note that
  this will affect Naveens pending BU21013 regulator patch, this
  one should ask for "avdd" as it is named in the datasheet.
- Use REGULATOR_SUPPLY() macro for readability
---
 arch/arm/mach-ux500/board-mop500-regulators.c |   62 +++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 533967c..87bca3b 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -11,6 +11,56 @@
 #include <linux/kernel.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/ab8500.h>
+#include "board-mop500-regulators.h"
+
+static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
+	/* External displays, connector on board 2v5 power supply */
+	REGULATOR_SUPPLY("vaux12v5", "mcde.0"),
+	/* SFH7741 proximity sensor */
+	REGULATOR_SUPPLY("vcc", "gpio-keys.0"),
+	/* BH1780GLS ambient light sensor */
+	REGULATOR_SUPPLY("vcc", "2-0029"),
+	/* lsm303dlh accelerometer */
+	REGULATOR_SUPPLY("vdd", "3-0018"),
+	/* lsm303dlh magnetometer */
+	REGULATOR_SUPPLY("avdd", "3-001e"),
+	/* Rohm BU21013 Touchscreen devices */
+	REGULATOR_SUPPLY("avdd", "3-005c"),
+	REGULATOR_SUPPLY("avdd", "3-005d"),
+	/* Synaptics RMI4 Touchscreen device */
+	REGULATOR_SUPPLY("avdd", "3-004b"),
+};
+
+static struct regulator_consumer_supply ab8500_vaux2_consumers[] = {
+	/* On-board eMMC power */
+	REGULATOR_SUPPLY("vmmc", "sdi4"),
+	/* AB8500 audio codec */
+	REGULATOR_SUPPLY("vcc-N2158", "ab8500-codec.0"),
+};
+
+static struct regulator_consumer_supply ab8500_vaux3_consumers[] = {
+	/* External MMC slot power */
+	REGULATOR_SUPPLY("vmmc", "sdi0"),
+};
+
+static struct regulator_consumer_supply ab8500_vtvout_consumers[] = {
+	/* TV-out DENC supply */
+	REGULATOR_SUPPLY("vtvout", "ab8500-denc.0"),
+	/* Internal general-purpose ADC */
+	REGULATOR_SUPPLY("vddadc", "ab8500-gpadc.0"),
+};
+
+static struct regulator_consumer_supply ab8500_vintcore_consumers[] = {
+	/* SoC core supply, no device */
+	REGULATOR_SUPPLY("v-intcore", NULL),
+	/* USB Transciever */
+	REGULATOR_SUPPLY("vddulpivio18", "ab8500-usb.0"),
+};
+
+static struct regulator_consumer_supply ab8500_vana_consumers[] = {
+	/* External displays, connector on board, 1v8 power supply */
+	REGULATOR_SUPPLY("vsmps2", "mcde.0"),
+};
 
 /* AB8500 regulators */
 struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
@@ -23,6 +73,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
 					  REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux1_consumers),
+		.consumer_supplies = ab8500_vaux1_consumers,
 	},
 	/* supplies to the on-board eMMC */
 	[AB8500_LDO_AUX2] = {
@@ -33,6 +85,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
 					  REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux2_consumers),
+		.consumer_supplies = ab8500_vaux2_consumers,
 	},
 	/* supply for VAUX3, supplies to SDcard slots */
 	[AB8500_LDO_AUX3] = {
@@ -43,6 +97,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
 					  REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaux3_consumers),
+		.consumer_supplies = ab8500_vaux3_consumers,
 	},
 	/* supply for tvout, gpadc, TVOUT LDO */
 	[AB8500_LDO_TVOUT] = {
@@ -50,6 +106,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.name = "V-TVOUT",
 			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vtvout_consumers),
+		.consumer_supplies = ab8500_vtvout_consumers,
 	},
 	/* supply for ab8500-vaudio, VAUDIO LDO */
 	[AB8500_LDO_AUDIO] = {
@@ -85,6 +143,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.name = "V-INTCORE",
 			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vintcore_consumers),
+		.consumer_supplies = ab8500_vintcore_consumers,
 	},
 	/* supply for U8500 CSI/DSI, VANA LDO */
 	[AB8500_LDO_ANA] = {
@@ -92,5 +152,7 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.name = "V-CSI/DSI",
 			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vana_consumers),
+		.consumer_supplies = ab8500_vana_consumers,
 	},
 };
-- 
1.7.3.2
