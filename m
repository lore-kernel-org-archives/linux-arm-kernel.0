From: leo.yan@linaro.org (Leo Yan)
Date: Tue,  2 May 2017 18:08:34 +0800
Subject: [PATCH v8 4/7] coresight: refactor with function of_coresight_get_cpu
In-Reply-To: <1493719717-27698-1-git-send-email-leo.yan@linaro.org>
References: <1493719717-27698-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1493719717-27698-5-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is refactor to add function of_coresight_get_cpu(), so it's used to
retrieve CPU id for coresight component. Finally can use it as a common
function for multiple places.

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 43 +++++++++++++++++++-----------
 include/linux/coresight.h                  |  2 ++
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index de7e8ce..46eec0f 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -101,15 +101,39 @@ static int of_coresight_alloc_memory(struct device *dev,
 	return 0;
 }
 
+int of_coresight_get_cpu(const struct device_node *node)
+{
+	int cpu;
+	bool found;
+	struct device_node *dn, *np;
+
+	dn = of_parse_phandle(node, "cpu", 0);
+
+	/* Affinity defaults to CPU0 */
+	if (!dn)
+		return 0;
+
+	for_each_possible_cpu(cpu) {
+		np = of_cpu_device_node_get(cpu);
+		found = (dn == np);
+		of_node_put(np);
+		if (found)
+			break;
+	}
+	of_node_put(dn);
+
+	/* Affinity to CPU0 if no cpu nodes are found */
+	return found ? cpu : 0;
+}
+EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
+
 struct coresight_platform_data *of_get_coresight_platform_data(
 			struct device *dev, const struct device_node *node)
 {
-	int i = 0, ret = 0, cpu;
+	int i = 0, ret = 0;
 	struct coresight_platform_data *pdata;
 	struct of_endpoint endpoint, rendpoint;
 	struct device *rdev;
-	bool found;
-	struct device_node *dn, *np;
 	struct device_node *ep = NULL;
 	struct device_node *rparent = NULL;
 	struct device_node *rport = NULL;
@@ -176,18 +200,7 @@ struct coresight_platform_data *of_get_coresight_platform_data(
 		} while (ep);
 	}
 
-	dn = of_parse_phandle(node, "cpu", 0);
-	for_each_possible_cpu(cpu) {
-		np = of_cpu_device_node_get(cpu);
-		found = (dn == np);
-		of_node_put(np);
-		if (found)
-			break;
-	}
-	of_node_put(dn);
-
-	/* Affinity to CPU0 if no cpu nodes are found */
-	pdata->cpu = found ? cpu : 0;
+	pdata->cpu = of_coresight_get_cpu(node);
 
 	return pdata;
 }
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 769f2c8..4915254 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -263,9 +263,11 @@ static inline int coresight_timeout(void __iomem *addr, u32 offset,
 #endif
 
 #ifdef CONFIG_OF
+extern int of_coresight_get_cpu(const struct device_node *node);
 extern struct coresight_platform_data *of_get_coresight_platform_data(
 	struct device *dev, const struct device_node *node);
 #else
+static inline int of_coresight_get_cpu(const struct device_node *node) { return 0; }
 static inline struct coresight_platform_data *of_get_coresight_platform_data(
 	struct device *dev, const struct device_node *node) { return NULL; }
 #endif
-- 
2.7.4
