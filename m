From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 28 May 2014 19:11:05 +0200
Subject: [PATCH 1/5] regulator: Allow to pass the device node to
 regulator_dev_lookup
In-Reply-To: <1401297069-7423-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1401297069-7423-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1401297069-7423-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now, regulator_dev_lookup only cares about the of_node field of the struct
device that is passed as as argument.

This is actually an issue whenever we have several regulators subnodes in the
DT, that all belong to the same device, which is usually the case.

Add an extra of_node field that is used first in regulator_dev_lookup that
allows to first lookup in the regulator node itself, and then fallback to the
old behaviour.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/regulator/core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 8b6b28b5cfda..3e3954252a23 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -154,7 +154,7 @@ static struct regulator_dev *of_get_regulator(struct device *dev,
 	}
 
 	list_for_each_entry(r, &regulator_list, list)
-		if (r->dev.parent && node == r->dev.of_node)
+		if (r->dev.parent && regnode == r->dev.of_node)
 			return r;
 
 	return ERR_PTR(-EPROBE_DEFER);
@@ -1264,6 +1264,7 @@ static void regulator_supply_alias(struct device **dev, const char **supply)
 }
 
 static struct regulator_dev *regulator_dev_lookup(struct device *dev,
+						  struct device_node *of_node,
 						  const char *supply,
 						  int *ret)
 {
@@ -1273,7 +1274,14 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 
 	regulator_supply_alias(&dev, &supply);
 
-	/* first do a dt based lookup */
+	/* First, do a lookup against the provided of_node */
+	if (of_node) {
+		r = of_get_regulator(dev, of_node, supply);
+		if (!IS_ERR(r))
+			return r;
+	}
+
+	/* Then, do a lookup based on the device of_node */
 	if (dev && dev->of_node) {
 		r = of_get_regulator(dev, dev->of_node, supply);
 		if (IS_ERR(r)) {
@@ -1332,7 +1340,7 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 
 	mutex_lock(&regulator_list_mutex);
 
-	rdev = regulator_dev_lookup(dev, id, &ret);
+	rdev = regulator_dev_lookup(dev, NULL, id, &ret);
 	if (rdev)
 		goto found;
 
@@ -3495,7 +3503,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	if (supply) {
 		struct regulator_dev *r;
 
-		r = regulator_dev_lookup(dev, supply, &ret);
+		r = regulator_dev_lookup(dev, NULL, supply, &ret);
 
 		if (ret == -ENODEV) {
 			/*
-- 
1.9.3
