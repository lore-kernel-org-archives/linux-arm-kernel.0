From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 29 Apr 2016 12:59:51 +0200
Subject: [PATCH 3/3] regulator: max77686: Configure enable time to properly
 handle regulator enable
In-Reply-To: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
References: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1461927591-7864-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable time for buck regulators was not configured but actually is
essential: consumers, like usb3503, doing hard reset (regulator off/on)
should wait for the regulator to settle.

Configure the enable time according to datasheet.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/max77686-regulator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index d1ab6a4da88f..ac4fa581e0a5 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -41,6 +41,8 @@
 #define MAX77686_LDO_LOW_UVSTEP	25000
 #define MAX77686_BUCK_MINUV	750000
 #define MAX77686_BUCK_UVSTEP	50000
+#define MAX77686_BUCK_ENABLE_TIME	40		/* us */
+#define MAX77686_DVS_ENABLE_TIME	22		/* us */
 #define MAX77686_RAMP_DELAY	100000			/* uV/us */
 #define MAX77686_DVS_RAMP_DELAY	27500			/* uV/us */
 #define MAX77686_DVS_MINUV	600000
@@ -422,6 +424,7 @@ static struct regulator_ops max77686_buck_dvs_ops = {
 	.min_uV		= MAX77686_BUCK_MINUV,				\
 	.uV_step	= MAX77686_BUCK_UVSTEP,				\
 	.ramp_delay	= MAX77686_RAMP_DELAY,				\
+	.enable_time	= MAX77686_BUCK_ENABLE_TIME,			\
 	.n_voltages	= MAX77686_VSEL_MASK + 1,			\
 	.vsel_reg	= MAX77686_REG_BUCK5OUT + (num - 5) * 2,	\
 	.vsel_mask	= MAX77686_VSEL_MASK,				\
@@ -439,6 +442,7 @@ static struct regulator_ops max77686_buck_dvs_ops = {
 	.min_uV		= MAX77686_BUCK_MINUV,				\
 	.uV_step	= MAX77686_BUCK_UVSTEP,				\
 	.ramp_delay	= MAX77686_RAMP_DELAY,				\
+	.enable_time	= MAX77686_BUCK_ENABLE_TIME,			\
 	.n_voltages	= MAX77686_VSEL_MASK + 1,			\
 	.vsel_reg	= MAX77686_REG_BUCK1OUT,			\
 	.vsel_mask	= MAX77686_VSEL_MASK,				\
@@ -456,6 +460,7 @@ static struct regulator_ops max77686_buck_dvs_ops = {
 	.min_uV		= MAX77686_DVS_MINUV,				\
 	.uV_step	= MAX77686_DVS_UVSTEP,				\
 	.ramp_delay	= MAX77686_DVS_RAMP_DELAY,			\
+	.enable_time	= MAX77686_DVS_ENABLE_TIME,			\
 	.n_voltages	= MAX77686_DVS_VSEL_MASK + 1,			\
 	.vsel_reg	= MAX77686_REG_BUCK2DVS1 + (num - 2) * 10,	\
 	.vsel_mask	= MAX77686_DVS_VSEL_MASK,			\
-- 
1.9.1
