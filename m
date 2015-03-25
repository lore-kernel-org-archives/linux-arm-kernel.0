From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 24 Mar 2015 18:56:05 -0700
Subject: [PATCH] regulator: Defer lookup of supply to regulator_get
Message-ID: <1427248565-9680-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of resolving regulator supplies during registration move this to
the time of a consumer retrieving a handle. The benefit is that it's
possible for one driver to register regulators with internal
dependencies out of order.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 drivers/regulator/core.c         | 92 ++++++++++++++++++++++++----------------
 include/linux/regulator/driver.h |  1 +
 2 files changed, 57 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f245214..52ddb73 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1325,6 +1325,54 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	return NULL;
 }
 
+static int regulator_resolve_supply(struct regulator_dev *rdev)
+{
+	struct regulator_dev *r;
+	struct device *dev = rdev->dev.parent;
+	int ret;
+
+	/* No supply to resovle? */
+	if (!rdev->supply_name)
+		return 0;
+
+	/* Supply already resolved? */
+	if (rdev->supply)
+		return 0;
+
+	r = regulator_dev_lookup(dev, rdev->supply_name, &ret);
+	if (ret == -ENODEV) {
+		/*
+		 * No supply was specified for this regulator and
+		 * there will never be one.
+		 */
+		return 0;
+	}
+
+	if (!r) {
+		dev_err(dev, "Failed to resolve %s-supply for %s\n",
+			rdev->supply_name, rdev->desc->name);
+		return -EPROBE_DEFER;
+	}
+
+	/* Recursively resolve the supply of the supply */
+	ret = regulator_resolve_supply(r);
+	if (ret < 0)
+		return ret;
+
+	ret = set_supply(rdev, r);
+	if (ret < 0)
+		return ret;
+
+	/* Cascade always-on state to supply */
+	if (_regulator_is_enabled(rdev)) {
+		ret = regulator_enable(rdev->supply);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 /* Internal regulator request function */
 static struct regulator *_regulator_get(struct device *dev, const char *id,
 					bool exclusive, bool allow_dummy)
@@ -1394,6 +1442,12 @@ found:
 		goto out;
 	}
 
+	ret = regulator_resolve_supply(rdev);
+	if (ret < 0) {
+		regulator = ERR_PTR(ret);
+		goto out;
+	}
+
 	if (!try_module_get(rdev->owner))
 		goto out;
 
@@ -3545,7 +3599,6 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	struct regulator_dev *rdev;
 	struct device *dev;
 	int ret, i;
-	const char *supply = NULL;
 
 	if (regulator_desc == NULL || cfg == NULL)
 		return ERR_PTR(-EINVAL);
@@ -3659,41 +3712,10 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		goto scrub;
 
 	if (init_data && init_data->supply_regulator)
-		supply = init_data->supply_regulator;
+		rdev->supply_name = init_data->supply_regulator;
 	else if (regulator_desc->supply_name)
-		supply = regulator_desc->supply_name;
-
-	if (supply) {
-		struct regulator_dev *r;
-
-		r = regulator_dev_lookup(dev, supply, &ret);
+		rdev->supply_name = regulator_desc->supply_name;
 
-		if (ret == -ENODEV) {
-			/*
-			 * No supply was specified for this regulator and
-			 * there will never be one.
-			 */
-			ret = 0;
-			goto add_dev;
-		} else if (!r) {
-			dev_err(dev, "Failed to find supply %s\n", supply);
-			ret = -EPROBE_DEFER;
-			goto scrub;
-		}
-
-		ret = set_supply(rdev, r);
-		if (ret < 0)
-			goto scrub;
-
-		/* Enable supply if rail is enabled */
-		if (_regulator_is_enabled(rdev)) {
-			ret = regulator_enable(rdev->supply);
-			if (ret < 0)
-				goto scrub;
-		}
-	}
-
-add_dev:
 	/* add consumers devices */
 	if (init_data) {
 		for (i = 0; i < init_data->num_consumer_supplies; i++) {
@@ -3720,8 +3742,6 @@ unset_supplies:
 	unset_regulator_supplies(rdev);
 
 scrub:
-	if (rdev->supply)
-		_regulator_put(rdev->supply);
 	regulator_ena_gpio_free(rdev);
 	kfree(rdev->constraints);
 wash:
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 0f86a182..a15c59d 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -371,6 +371,7 @@ struct regulator_dev {
 	struct device dev;
 	struct regulation_constraints *constraints;
 	struct regulator *supply;	/* for tree */
+	const char *supply_name;
 	struct regmap *regmap;
 
 	struct delayed_work disable_work;
-- 
1.8.2.2
