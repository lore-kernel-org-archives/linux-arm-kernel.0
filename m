From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 Dec 2013 10:09:43 +0100
Subject: [PATCH 2/2] regulator: s5m8767: Fix driver probe fail on BUCK7/8
 regulators
In-Reply-To: <1386666583-3280-1-git-send-email-k.kozlowski@samsung.com>
References: <1386666583-3280-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1386666583-3280-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BUCK7 and BUCK8 were not supported by s5m8767 driver. If they were
configured in DTS then the driver probing would fail with EINVAL:
[    0.288474] VCC_SUB_1.35V: failed to apply 1350000uV constraint
[    0.288671] s5m8767-pmic s5m8767-pmic: regulator init failed for 35
[    0.294931] s5m8767-pmic: probe of s5m8767-pmic failed with error -22

This patch adds support for BUCK7 and BUCK8 regulators using standard
regmap get/set voltage sel functions.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/regulator/s5m8767.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 58eb7a6c45e6..397917611ecd 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -120,8 +120,8 @@ static const struct sec_voltage_desc *reg_voltage_map[] = {
 	[S5M8767_BUCK4] = &buck_voltage_val2,
 	[S5M8767_BUCK5] = &buck_voltage_val1,
 	[S5M8767_BUCK6] = &buck_voltage_val1,
-	[S5M8767_BUCK7] = NULL,
-	[S5M8767_BUCK8] = NULL,
+	[S5M8767_BUCK7] = &buck_voltage_val3,
+	[S5M8767_BUCK8] = &buck_voltage_val3,
 	[S5M8767_BUCK9] = &buck_voltage_val3,
 };
 
@@ -418,9 +418,12 @@ static struct regulator_ops s5m8767_ops = {
 };
 
 static struct regulator_ops s5m8767_buck78_ops = {
+	.list_voltage		= regulator_list_voltage_linear,
 	.is_enabled		= s5m8767_reg_is_enabled,
 	.enable			= s5m8767_reg_enable,
 	.disable		= s5m8767_reg_disable,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 };
 
 #define s5m8767_regulator_desc(_name) {		\
-- 
1.7.9.5
