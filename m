From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Mar 2013 15:59:38 +0000
Subject: [PATCH 41/46] regulator: ab8500: Remove the need for a 'delay'
 property
In-Reply-To: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1363881583-15234-42-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulator framework now has provisions to read a regulator's
start-up time via the 'enable_time' attribute. So let's remove all
'enable_time'/'delay' duplication and just stick with 'enable_time'
from now on.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/ab8500.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 324444e..13948c8 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -63,7 +63,6 @@ struct ab8500_shared_mode {
  * @voltage_reg: register to control regulator voltage
  * @voltage_mask: mask to control regulator voltage
  * @voltage_shift: shift to control regulator voltage
- * @delay: startup/set voltage delay in us
  */
 struct ab8500_regulator_info {
 	struct device		*dev;
@@ -87,7 +86,6 @@ struct ab8500_regulator_info {
 	u8 voltage_reg;
 	u8 voltage_mask;
 	u8 voltage_shift;
-	unsigned int delay;
 	struct {
 		u8 voltage_limit;
 		u8 voltage_bank;
@@ -652,7 +650,7 @@ static int ab8500_regulator_set_voltage_time_sel(struct regulator_dev *rdev,
 {
 	struct ab8500_regulator_info *info = rdev_get_drvdata(rdev);
 
-	return info->delay;
+	return info->desc.enable_time;
 }
 
 static struct regulator_ops ab8500_regulator_volt_mode_ops = {
@@ -829,7 +827,6 @@ static struct ab8500_regulator_info
 			.volt_table	= fixed_2000000_voltage,
 			.enable_time	= 500,
 		},
-		.delay			= 500,
 		.load_lp_uA		= 1000,
 		.update_bank		= 0x03,
 		.update_reg		= 0x80,
@@ -1100,7 +1097,6 @@ static struct ab8500_regulator_info
 			.volt_table	= fixed_2000000_voltage,
 			.enable_time	= 10000,
 		},
-		.delay			= 10000,
 		.load_lp_uA		= 1000,
 		.update_bank		= 0x03,
 		.update_reg		= 0x80,
@@ -1366,7 +1362,6 @@ static struct ab8500_regulator_info
 			.volt_table	= fixed_2000000_voltage,
 			.enable_time	= 10000,
 		},
-		.delay			= 10000,
 		.load_lp_uA		= 1000,
 		.update_bank		= 0x03,
 		.update_reg		= 0x80,
@@ -1664,7 +1659,6 @@ static struct ab8500_regulator_info
 			.n_voltages	= 1,
 			.enable_time	= 10000,
 		},
-		.delay			= 10000,
 		.load_lp_uA		= 1000,
 		.update_bank		= 0x03,
 		.update_reg		= 0x80,
-- 
1.7.10.4
