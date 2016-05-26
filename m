From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 26 May 2016 11:38:11 +0200
Subject: [RFC PATCH 2/2] firmware: scpi: Switch scpi drivers to use new
 Framework calls
In-Reply-To: <1464255491-18503-1-git-send-email-narmstrong@baylibre.com>
References: <1464255491-18503-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1464255491-18503-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the include/linux/scpi_protocol.h with the new registry calls.

Switch following drivers to use the new SCPI registry layer :
 - drivers/clk/clk-scpi.c
 - drivers/cpufreq/scpi-cpufreq.c
 - drivers/hwmon/scpi-hwmon.c

And finally switch drivers/firmware/arm_scpi.c to use scpi_driver_register().

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/clk-scpi.c         | 18 +++++++++++-------
 drivers/cpufreq/scpi-cpufreq.c |  7 ++++---
 drivers/firmware/arm_scpi.c    | 18 +++++++++---------
 drivers/hwmon/scpi-hwmon.c     |  6 +++---
 include/linux/scpi_protocol.h  | 33 +++++++++++++++++++++++++++++++--
 5 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
index 6962ee5..18ffaf5 100644
--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -148,7 +148,8 @@ static const struct of_device_id scpi_clk_match[] = {
 
 static struct clk *
 scpi_clk_ops_init(struct device *dev, const struct of_device_id *match,
-		  struct scpi_clk *sclk, const char *name)
+		  struct scpi_clk *sclk, const char *name,
+		  struct scpi_ops *scpi_ops)
 {
 	struct clk_init_data init;
 	struct clk *clk;
@@ -159,7 +160,7 @@ scpi_clk_ops_init(struct device *dev, const struct of_device_id *match,
 	init.num_parents = 0;
 	init.ops = match->data;
 	sclk->hw.init = &init;
-	sclk->scpi_ops = get_scpi_ops();
+	sclk->scpi_ops = scpi_ops;
 
 	if (init.ops == &scpi_dvfs_ops) {
 		sclk->info = sclk->scpi_ops->dvfs_get_info(sclk->id);
@@ -200,7 +201,8 @@ scpi_of_clk_src_get(struct of_phandle_args *clkspec, void *data)
 }
 
 static int scpi_clk_add(struct device *dev, struct device_node *np,
-			const struct of_device_id *match)
+			const struct of_device_id *match,
+			struct scpi_ops *scpi_ops)
 {
 	struct clk **clks;
 	int idx, count;
@@ -249,7 +251,7 @@ static int scpi_clk_add(struct device *dev, struct device_node *np,
 
 		sclk->id = val;
 
-		clks[idx] = scpi_clk_ops_init(dev, match, sclk, name);
+		clks[idx] = scpi_clk_ops_init(dev, match, sclk, name, scpi_ops);
 		if (IS_ERR_OR_NULL(clks[idx]))
 			dev_err(dev, "failed to register clock '%s'\n", name);
 		else
@@ -281,15 +283,17 @@ static int scpi_clocks_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *child, *np = dev->of_node;
 	const struct of_device_id *match;
+	struct scpi_ops *scpi_ops;
 
-	if (!get_scpi_ops())
-		return -ENXIO;
+	scpi_ops = of_scpi_ops_get(of_get_parent(np));
+	if (IS_ERR(scpi_ops))
+		return PTR_ERR(scpi_ops);
 
 	for_each_available_child_of_node(np, child) {
 		match = of_match_node(scpi_clk_match, child);
 		if (!match)
 			continue;
-		ret = scpi_clk_add(dev, child, match);
+		ret = scpi_clk_add(dev, child, match, scpi_ops);
 		if (ret) {
 			scpi_clocks_remove(pdev);
 			of_node_put(child);
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index e8a7bf5..158f1d80 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -25,6 +25,7 @@
 #include <linux/pm_opp.h>
 #include <linux/scpi_protocol.h>
 #include <linux/types.h>
+#include <linux/of.h>
 
 #include "arm_big_little.h"
 
@@ -88,9 +89,9 @@ static struct cpufreq_arm_bL_ops scpi_cpufreq_ops = {
 
 static int scpi_cpufreq_probe(struct platform_device *pdev)
 {
-	scpi_ops = get_scpi_ops();
-	if (!scpi_ops)
-		return -EIO;
+	scpi_ops = of_scpi_ops_get(of_get_parent(pdev->dev.of_node));
+	if (IS_ERR(scpi_ops))
+		return PTR_ERR(scpi_ops);
 
 	return bL_cpufreq_register(&scpi_cpufreq_ops);
 }
diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 7e3e595..00fc849 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -162,9 +162,9 @@ struct scpi_drvinfo {
 	u32 firmware_version;
 	int num_chans;
 	atomic_t next_chan;
-	struct scpi_ops *scpi_ops;
 	struct scpi_chan *channels;
 	struct scpi_dvfs_info *dvfs[MAX_DVFS_DOMAINS];
+	struct scpi_driver drv;
 };
 
 /*
@@ -526,7 +526,7 @@ static int scpi_sensor_get_info(u16 sensor_id, struct scpi_sensor_info *info)
 	return ret;
 }
 
-int scpi_sensor_get_value(u16 sensor, u64 *val)
+static int scpi_sensor_get_value(u16 sensor, u64 *val)
 {
 	__le16 id = cpu_to_le16(sensor);
 	struct sensor_value buf;
@@ -554,12 +554,6 @@ static struct scpi_ops scpi_ops = {
 	.sensor_get_value = scpi_sensor_get_value,
 };
 
-struct scpi_ops *get_scpi_ops(void)
-{
-	return scpi_info ? scpi_info->scpi_ops : NULL;
-}
-EXPORT_SYMBOL_GPL(get_scpi_ops);
-
 static int scpi_init_versions(struct scpi_drvinfo *info)
 {
 	int ret;
@@ -743,7 +737,13 @@ err:
 		  FW_REV_MAJOR(scpi_info->firmware_version),
 		  FW_REV_MINOR(scpi_info->firmware_version),
 		  FW_REV_PATCH(scpi_info->firmware_version));
-	scpi_info->scpi_ops = &scpi_ops;
+
+	scpi_info->drv.node = dev->of_node;
+	scpi_info->drv.ops = &scpi_ops;
+
+	ret = devm_scpi_driver_register(dev, &scpi_info->drv);
+	if (ret)
+		return ret;
 
 	ret = sysfs_create_groups(&dev->kobj, versions_groups);
 	if (ret)
diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 912b449..45d36d1 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -120,9 +120,9 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 	struct scpi_sensors *scpi_sensors;
 	int ret, idx;
 
-	scpi_ops = get_scpi_ops();
-	if (!scpi_ops)
-		return -EPROBE_DEFER;
+	scpi_ops = of_scpi_ops_get(of_get_parent(dev.of_node));
+	if (IS_ERR(scpi_ops))
+		return PTR_ERR(scpi_ops);
 
 	ret = scpi_ops->sensor_get_capability(&nr_sensors);
 	if (ret)
diff --git a/include/linux/scpi_protocol.h b/include/linux/scpi_protocol.h
index 35de50a..fc27034 100644
--- a/include/linux/scpi_protocol.h
+++ b/include/linux/scpi_protocol.h
@@ -72,8 +72,37 @@ struct scpi_ops {
 	int (*sensor_get_value)(u16, u64 *);
 };
 
+struct scpi_driver {
+	struct device_node *node;
+	struct scpi_ops *ops;
+	struct list_head list;
+};
+
 #if IS_REACHABLE(CONFIG_ARM_SCPI_PROTOCOL)
-struct scpi_ops *get_scpi_ops(void);
+struct scpi_ops *of_scpi_ops_get(struct device_node *node);
+
+int scpi_driver_register(struct scpi_driver *drv);
+
+void scpi_driver_unregister(struct scpi_driver *drv);
+
+int devm_scpi_driver_register(struct device *dev,
+				struct scpi_driver *drv);
 #else
-static inline struct scpi_ops *get_scpi_ops(void) { return NULL; }
+struct scpi_ops *of_scpi_ops_get(struct device_node *node)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+int scpi_driver_register(struct scpi_driver *drv)
+{
+	return -ENOTSUPP;
+}
+
+void scpi_driver_unregister(struct scpi_driver *drv) { }
+
+int devm_scpi_driver_register(struct device *dev,
+				struct scpi_driver *drv)
+{
+	return -ENOTSUPP;
+}
 #endif
-- 
2.7.0
