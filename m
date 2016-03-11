From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 11 Mar 2016 22:01:07 +0100
Subject: [PATCH 1/3] regulator: core: Allow use of "status = disabled" in
 regulator dts nodes
Message-ID: <1457730069-31760-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The axp20x and axp22x pmics have ldo regulators which are muxed to the
outside via gpio pins. Unfortunately regulator enable / disable is
implemented in the hardware via selecting a specific pin-mux option.

So if we want to use these pins as gpio pins we must not register
a regulator for these pins at all, otherwise any gpio use (switching
to input, or writing a value) gets undone when the regulator subsys
disables unused regulators at the end of kernel-init.

This commits allows the use of  "status = disabled" in regulator dts
nodes and makes regulator_register return ENODEV when this is set.

Note that this commit changes the loop to find the of-node in
regulator_of_get_init_data from using for_each_available_child_of_node
to using for_each_child_of_node. regulator_register is the only user
of regulator_of_get_init_data and the use of for_each_available_child...
makes little sense there since this will only cause the constraints
from regulator dts nodes marked as disabled to not be used, the
actual registration of the regulator would still continue.

So in a way this patch could be seen as a bugfix as it actually makes
regulators with an of_node which is marked as not available not register,
but this behavior change may cause some issues in some places.

Note that individual regulator drivers / callers of regulator_register
which may encounter disabled regulator (child) nodes need to be patched to
handle ENODEV (to not make it fail their probe method).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/regulator/core.c         | 6 ++++++
 drivers/regulator/of_regulator.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 744c988..5589203 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3894,6 +3894,12 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		rdev->dev.of_node = of_node_get(config->of_node);
 	}
 
+	if (rdev->dev.of_node && !of_device_is_available(rdev->dev.of_node)) {
+		kfree(config);
+		kfree(rdev);
+		return ERR_PTR(-ENODEV);
+	}
+
 	mutex_lock(&regulator_list_mutex);
 
 	mutex_init(&rdev->mutex);
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 499e437..06ad766 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -310,7 +310,7 @@ struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 		return NULL;
 	}
 
-	for_each_available_child_of_node(search, child) {
+	for_each_child_of_node(search, child) {
 		name = of_get_property(child, "regulator-compatible", NULL);
 		if (!name)
 			name = child->name;
-- 
2.7.2
