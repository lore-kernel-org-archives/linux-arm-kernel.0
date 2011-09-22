From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 22 Sep 2011 17:51:10 +0530
Subject: [PATCH 5/5] regulator: map consumer regulator based on device tree
Message-ID: <mailman.179.1318316940.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device nodes in DT can associate themselves with one or more
regulators/supply by providing a list of phandles (to regulator nodes)
and corresponding supply names.

For Example:
	devicenode: node at 0x0 {
		...
		...
		vmmc-supply =3D <&regulator1>;
		vpll-supply =3D <&regulator1>;
	};

The driver would then do a regulator_get(dev, "vmmc"); to get
regulator1 and do a regulator_get(dev, "vpll"); to get
regulator2.

of_get_regulator() extracts the regulator node for a given
device, based on the supply name.

Use it to look up the regulator for a given consumer from device tree, duri=
ng
a regulator_get(). If not found fallback and lookup through
the regulator_map_list instead.

Also, since the regulator dt nodes can use the same binding to
associate with a parent regulator/supply, allow the drivers to
specify a supply_name, which can then be used to lookup dt
to find the parent phandle.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/regulator/core.c         |   91 +++++++++++++++++++++++++++++++---=
---
 include/linux/regulator/driver.h |    2 +
 2 files changed, 78 insertions(+), 15 deletions(-)

Index: linux/drivers/regulator/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/regulator/core.c	2011-10-11 11:43:27.944140106 +0530
+++ linux/drivers/regulator/core.c	2011-10-11 12:25:53.540418748 +0530
@@ -25,9 +25,11 @@
 #include <linux/mutex.h>
 #include <linux/suspend.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>

 #define CREATE_TRACE_POINTS
 #include <trace/events/regulator.h>
@@ -131,6 +133,33 @@
 	return NULL;
 }

+/**
+ * of_get_regulator - get a regulator device node based on supply name
+ * @dev: Device pointer for the consumer (of regulator) device
+ * @supply: regulator supply name
+ *
+ * Extract the regulator device node corresponding to the supply name.
+ * retruns the device node corresponding to the regulator if found, else
+ * returns NULL.
+ */
+static struct device_node *of_get_regulator(struct device *dev, const
char *supply)
+{
+	struct device_node *regnode =3D NULL;
+	char prop_name[32]; /* 32 is max size of property name */
+
+	dev_dbg(dev, "Looking up %s-supply from device tree\n", supply);
+
+	snprintf(prop_name, 32, "%s-supply", supply);
+	regnode =3D of_parse_phandle(dev->of_node, prop_name, 0);
+
+	if (!regnode) {
+		pr_warn("%s: %s property in node %s references invalid phandle",
+			__func__, prop_name, dev->of_node->full_name);
+		return NULL;
+	}
+	return regnode;
+}
+
 /* Platform voltage constraint check */
 static int regulator_check_voltage(struct regulator_dev *rdev,
 				   int *min_uV, int *max_uV)
@@ -1147,6 +1176,28 @@
 	return rdev->desc->ops->enable_time(rdev);
 }

+static struct regulator_dev *regulator_dev_lookup(struct device *dev,
+							 const char *supply)
+{
+	struct regulator_dev *r;
+	struct device_node *node;
+
+	/* first do a dt based lookup */
+	if (dev && dev->of_node)
+		node =3D of_get_regulator(dev, supply);
+		if (node)
+			list_for_each_entry(r, &regulator_list, list)
+				if (node =3D=3D r->dev.parent->of_node)
+					return r;
+
+	/* if not found, try doing it non-dt way */
+	list_for_each_entry(r, &regulator_list, list)
+		if (strcmp(rdev_get_name(r), supply) =3D=3D 0)
+			return r;
+
+	return NULL;
+}
+
 /* Internal regulator request function */
 static struct regulator *_regulator_get(struct device *dev, const char *id=
,
 					int exclusive)
@@ -1155,6 +1206,7 @@
 	struct regulator_map *map;
 	struct regulator *regulator =3D ERR_PTR(-ENODEV);
 	const char *devname =3D NULL;
+	struct device_node *node;
 	int ret;

 	if (id =3D=3D NULL) {
@@ -1167,6 +1219,10 @@

 	mutex_lock(&regulator_list_mutex);

+	rdev =3D regulator_dev_lookup(dev, id);
+	if (rdev)
+		goto found;
+
 	list_for_each_entry(map, &regulator_map_list, list) {
 		/* If the mapping has a device set up it must match */
 		if (map->dev_name &&
@@ -2579,6 +2635,7 @@
 	static atomic_t regulator_no =3D ATOMIC_INIT(0);
 	struct regulator_dev *rdev;
 	int ret, i;
+	const char *supply;

 	if (regulator_desc =3D=3D NULL)
 		return ERR_PTR(-EINVAL);
@@ -2653,21 +2710,18 @@
 	if (ret < 0)
 		goto scrub;

-	if (init_data->supply_regulator) {
+	if (init_data->supply_regulator)
+		supply =3D init_data->supply_regulator;
+	else if (regulator_desc->supply_name);
+		supply =3D regulator_desc->supply_name;
+
+	if (supply) {
 		struct regulator_dev *r;
-		int found =3D 0;

-		list_for_each_entry(r, &regulator_list, list) {
-			if (strcmp(rdev_get_name(r),
-				   init_data->supply_regulator) =3D=3D 0) {
-				found =3D 1;
-				break;
-			}
-		}
+		r =3D regulator_dev_lookup(dev, supply);

-		if (!found) {
-			dev_err(dev, "Failed to find supply %s\n",
-				init_data->supply_regulator);
+		if (!r) {
+			dev_err(dev, "Failed to find supply %s\n", supply);
 			ret =3D -ENODEV;
 			goto scrub;
 		}
Index: linux/include/linux/regulator/driver.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/include/linux/regulator/driver.h	2011-10-11
11:43:27.936139476 +0530
+++ linux/include/linux/regulator/driver.h	2011-10-11 11:43:43.485351850 +0=
530
@@ -153,6 +153,7 @@
  * this type.
  *
  * @name: Identifying name for the regulator.
+ * @supply_name: Identifying the regulator supply
  * @id: Numerical identifier for the regulator.
  * @n_voltages: Number of selectors available for ops.list_voltage().
  * @ops: Regulator operations table.
@@ -162,6 +163,7 @@
  */
 struct regulator_desc {
 	const char *name;
+	const char *supply_name;
 	int id;
 	unsigned n_voltages;
 	struct regulator_ops *ops;
