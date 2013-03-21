From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Mar 2013 15:59:33 +0000
Subject: [PATCH 36/46] regulator: ab8500: Update vdmic,
 vamic[1|2] parameters for AB8540
In-Reply-To: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1363881583-15234-37-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add voltage setting for vdmic; add LP mode setting for vamic1,2.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/ab8500.c |   45 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 7265a24..200005e 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -214,9 +214,18 @@ static const unsigned int ldo_vaudio_voltages[] = {
 	2600000,	/* Duplicated in Vaudio and IsoUicc Control register. */
 };
 
+static const unsigned int ldo_vdmic_voltages[] = {
+	1800000,
+	1900000,
+	2000000,
+	2850000,
+};
+
 static DEFINE_MUTEX(shared_mode_mutex);
 static struct ab8500_shared_mode ldo_anamic1_shared;
 static struct ab8500_shared_mode ldo_anamic2_shared;
+static struct ab8500_shared_mode ab8540_ldo_anamic1_shared;
+static struct ab8500_shared_mode ab8540_ldo_anamic2_shared;
 
 static int ab8500_regulator_enable(struct regulator_dev *rdev)
 {
@@ -1132,7 +1141,7 @@ static struct ab8500_regulator_info
 			.n_voltages	= 1,
 			.volt_table	= fixed_2050000_voltage,
 		},
-		.shared_mode = &ldo_anamic1_shared,
+		.shared_mode		= &ldo_anamic1_shared,
 		.update_bank		= 0x03,
 		.update_reg		= 0x83,
 		.update_mask		= 0x08,
@@ -1616,46 +1625,64 @@ static struct ab8500_regulator_info
 	[AB8540_LDO_ANAMIC1] = {
 		.desc = {
 			.name		= "LDO-ANAMIC1",
-			.ops		= &ab8500_regulator_ops,
+			.ops		= &ab8500_regulator_anamic_mode_ops,
 			.type		= REGULATOR_VOLTAGE,
 			.id		= AB8540_LDO_ANAMIC1,
 			.owner		= THIS_MODULE,
 			.n_voltages	= 1,
 			.volt_table	= fixed_2050000_voltage,
 		},
+		.shared_mode		= &ab8540_ldo_anamic1_shared,
 		.update_bank		= 0x03,
 		.update_reg		= 0x83,
 		.update_mask		= 0x08,
 		.update_val		= 0x08,
+		.mode_bank		= 0x03,
+		.mode_reg		= 0x83,
+		.mode_mask		= 0x20,
+		.mode_val_idle		= 0x20,
+		.mode_val_normal	= 0x00,
 	},
 	[AB8540_LDO_ANAMIC2] = {
 		.desc = {
 			.name		= "LDO-ANAMIC2",
-			.ops		= &ab8500_regulator_ops,
+			.ops		= &ab8500_regulator_anamic_mode_ops,
 			.type		= REGULATOR_VOLTAGE,
 			.id		= AB8540_LDO_ANAMIC2,
 			.owner		= THIS_MODULE,
 			.n_voltages	= 1,
 			.volt_table	= fixed_2050000_voltage,
 		},
+		.shared_mode		= &ab8540_ldo_anamic2_shared,
 		.update_bank		= 0x03,
 		.update_reg		= 0x83,
 		.update_mask		= 0x10,
 		.update_val		= 0x10,
+		.mode_bank		= 0x03,
+		.mode_reg		= 0x83,
+		.mode_mask		= 0x20,
+		.mode_val_idle		= 0x20,
+		.mode_val_normal	= 0x00,
 	},
 	[AB8540_LDO_DMIC] = {
 		.desc = {
 			.name		= "LDO-DMIC",
-			.ops		= &ab8500_regulator_ops,
+			.ops		= &ab8500_regulator_volt_mode_ops,
 			.type		= REGULATOR_VOLTAGE,
 			.id		= AB8540_LDO_DMIC,
 			.owner		= THIS_MODULE,
-			.n_voltages	= 1,
+			.n_voltages	= ARRAY_SIZE(ldo_vdmic_voltages),
 		},
+		.load_lp_uA		= 1000,
 		.update_bank		= 0x03,
 		.update_reg		= 0x83,
 		.update_mask		= 0x04,
 		.update_val		= 0x04,
+		.voltage_bank		= 0x03,
+		.voltage_reg		= 0x83,
+		.voltage_mask		= 0xc0,
+		.voltages		= ldo_vdmic_voltages,
+		.voltages_len		= ARRAY_SIZE(ldo_vdmic_voltages),
 	},
 
 	/*
@@ -1710,6 +1737,14 @@ static struct ab8500_shared_mode ldo_anamic2_shared = {
 	.shared_regulator = &ab8505_regulator_info[AB8505_LDO_ANAMIC1],
 };
 
+static struct ab8500_shared_mode ab8540_ldo_anamic1_shared = {
+	.shared_regulator = &ab8540_regulator_info[AB8540_LDO_ANAMIC2],
+};
+
+static struct ab8500_shared_mode ab8540_ldo_anamic2_shared = {
+	.shared_regulator = &ab8540_regulator_info[AB8540_LDO_ANAMIC1],
+};
+
 struct ab8500_reg_init {
 	u8 bank;
 	u8 addr;
-- 
1.7.10.4
