From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Jun 2013 17:11:25 +0100
Subject: [PATCH 07/10] regulator: ab8500-ext: Provide a set_voltage call-back
 operation
In-Reply-To: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
References: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370621488-18130-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When registering regulators which have a single voltage through Device
Tree, the framework insists that the specified voltage is actually set.
Well in order to do that we need to provide this call-back, where we
check that the value is sane and return without error. Not that the
selector isn't populated, but in our case list_voltage doesn't actually
use it, so we're good.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/ab8500-ext.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
index b4d4547..e4975bc 100644
--- a/drivers/regulator/ab8500-ext.c
+++ b/drivers/regulator/ab8500-ext.c
@@ -229,6 +229,28 @@ static unsigned int ab8500_ext_regulator_get_mode(struct regulator_dev *rdev)
 	return ret;
 }
 
+static int ab8500_ext_set_voltage(struct regulator_dev *rdev, int min_uV,
+				  int max_uV, unsigned *selector)
+{
+	struct regulation_constraints *regu_constraints = rdev->constraints;
+
+	if (!regu_constraints) {
+		dev_err(rdev_get_dev(rdev), "No regulator constraints\n");
+		return -EINVAL;
+	}
+
+	if (regu_constraints->min_uV == min_uV &&
+	    regu_constraints->max_uV == max_uV)
+		return 0;
+
+	dev_err(rdev_get_dev(rdev),
+		"Requested min %duV max %duV != constrained min %duV max %duV\n",
+		min_uV, max_uV,
+		regu_constraints->min_uV, regu_constraints->max_uV);
+
+	return -EINVAL;
+}
+
 static int ab8500_ext_list_voltage(struct regulator_dev *rdev,
 				   unsigned selector)
 {
@@ -252,6 +274,7 @@ static struct regulator_ops ab8500_ext_regulator_ops = {
 	.is_enabled		= ab8500_ext_regulator_is_enabled,
 	.set_mode		= ab8500_ext_regulator_set_mode,
 	.get_mode		= ab8500_ext_regulator_get_mode,
+	.set_voltage		= ab8500_ext_set_voltage,
 	.list_voltage		= ab8500_ext_list_voltage,
 };
 
-- 
1.7.10.4
