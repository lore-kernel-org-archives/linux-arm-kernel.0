From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 17 Jan 2017 07:18:05 -0600
Subject: [PATCH v4 1/4] PM / OPP: Expose _of_get_opp_desc_node as dev_pm_opp
 API
In-Reply-To: <20170117131808.29798-1-d-gerlach@ti.com>
References: <20170117131808.29798-1-d-gerlach@ti.com>
Message-ID: <20170117131808.29798-2-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename _of_get_opp_desc_node to dev_pm_opp_of_get_opp_desc_node and add it
to include/linux/pm_opp.h to allow other drivers, such as platform OPP
and cpufreq drivers, to make use of it.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
v3->v4:
	Export dev_pm_opp_of_get_opp_desc_node for use in modules.
	
 drivers/base/power/opp/of.c | 9 +++++----
 include/linux/pm_opp.h      | 6 ++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 3f7d2591b173..fe14d231f1db 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -243,7 +243,7 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
 /* Returns opp descriptor node for a device, caller must do of_node_put() */
-static struct device_node *_of_get_opp_desc_node(struct device *dev)
+struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
 {
 	/*
 	 * TODO: Support for multiple OPP tables.
@@ -254,6 +254,7 @@ static struct device_node *_of_get_opp_desc_node(struct device *dev)
 
 	return of_parse_phandle(dev->of_node, "operating-points-v2", 0);
 }
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
 
 /**
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
@@ -495,7 +496,7 @@ int dev_pm_opp_of_add_table(struct device *dev)
 	 * OPPs have two version of bindings now. The older one is deprecated,
 	 * try for the new binding first.
 	 */
-	opp_np = _of_get_opp_desc_node(dev);
+	opp_np = dev_pm_opp_of_get_opp_desc_node(dev);
 	if (!opp_np) {
 		/*
 		 * Try old-deprecated bindings for backward compatibility with
@@ -605,7 +606,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 	int cpu, ret = 0;
 
 	/* Get OPP descriptor node */
-	np = _of_get_opp_desc_node(cpu_dev);
+	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
 	if (!np) {
 		dev_dbg(cpu_dev, "%s: Couldn't find opp node.\n", __func__);
 		return -ENOENT;
@@ -630,7 +631,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 		}
 
 		/* Get OPP descriptor node */
-		tmp_np = _of_get_opp_desc_node(tcpu_dev);
+		tmp_np = dev_pm_opp_of_get_opp_desc_node(tcpu_dev);
 		if (!tmp_np) {
 			dev_err(tcpu_dev, "%s: Couldn't find opp node.\n",
 				__func__);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0edd88f93904..a5b1aaeae229 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -270,6 +270,7 @@ void dev_pm_opp_of_remove_table(struct device *dev);
 int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
+struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -293,6 +294,11 @@ static inline int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct
 {
 	return -ENOTSUPP;
 }
+
+static inline struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
+{
+	return NULL;
+}
 #endif
 
 #endif		/* __LINUX_OPP_H__ */
-- 
2.11.0
