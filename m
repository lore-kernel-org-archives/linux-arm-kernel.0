From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Feb 2014 17:36:03 +0100
Subject: [PATCH v3 1/2] regulator: core: Replace direct ops->enable usage
In-Reply-To: <1392914164-28596-1-git-send-email-mpa@pengutronix.de>
References: <1392914164-28596-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1392914164-28596-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some direct ops->enable in the regulator core driver. This is
a potential issue as the function _regulator_do_enable() handles gpio
regulators and the normal ops->enable calls. These gpio regulators are
simply ignored when ops->enable is called directly.

One possible bug is that boot-on and always-on gpio regulators are not
enabled on registration.

This patch replaces all ops->enable calls by _regulator_do_enable.

Cc: <stable@vger.kernel.org> # 3.10+
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/regulator/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 16a309e..017f5cb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -953,6 +953,8 @@ static int machine_constraints_current(struct regulator_dev *rdev,
 	return 0;
 }
 
+static int _regulator_do_enable(struct regulator_dev *rdev);
+
 /**
  * set_machine_constraints - sets regulator constraints
  * @rdev: regulator source
@@ -1013,9 +1015,8 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 	/* If the constraints say the regulator should be on at this point
 	 * and we have control then make sure it is enabled.
 	 */
-	if ((rdev->constraints->always_on || rdev->constraints->boot_on) &&
-	    ops->enable) {
-		ret = ops->enable(rdev);
+	if (rdev->constraints->always_on || rdev->constraints->boot_on) {
+		ret = _regulator_do_enable(rdev);
 		if (ret < 0) {
 			rdev_err(rdev, "failed to enable\n");
 			goto out;
@@ -3633,9 +3634,8 @@ int regulator_suspend_finish(void)
 		struct regulator_ops *ops = rdev->desc->ops;
 
 		mutex_lock(&rdev->mutex);
-		if ((rdev->use_count > 0  || rdev->constraints->always_on) &&
-				ops->enable) {
-			error = ops->enable(rdev);
+		if (rdev->use_count > 0  || rdev->constraints->always_on) {
+			error = _regulator_do_enable(rdev);
 			if (error)
 				ret = error;
 		} else {
-- 
1.8.5.3
