From: leo.yan@linaro.org (Leo Yan)
Date: Tue,  9 May 2017 10:49:59 +0800
Subject: [PATCH v9 6/9] coresight: refactor with function of_coresight_get_cpu
In-Reply-To: <1494298202-6739-1-git-send-email-leo.yan@linaro.org>
References: <1494298202-6739-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1494298202-6739-7-git-send-email-leo.yan@linaro.org>
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
 include/linux/coresight.h                  |  3 +++
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 225b2dd..a187941 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -101,16 +101,40 @@ static int of_coresight_alloc_memory(struct device *dev,
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
 struct coresight_platform_data *
 of_get_coresight_platform_data(struct device *dev,
 			       const struct device_node *node)
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
@@ -177,18 +201,7 @@ of_get_coresight_platform_data(struct device *dev,
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
index bf0aa50..d950dad 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -263,10 +263,13 @@ static inline int coresight_timeout(void __iomem *addr, u32 offset,
 #endif
 
 #ifdef CONFIG_OF
+extern int of_coresight_get_cpu(const struct device_node *node);
 extern struct coresight_platform_data *
 of_get_coresight_platform_data(struct device *dev,
 			       const struct device_node *node);
 #else
+static inline int of_coresight_get_cpu(const struct device_node *node)
+{ return 0; }
 static inline struct coresight_platform_data *of_get_coresight_platform_data(
 	struct device *dev, const struct device_node *node) { return NULL; }
 #endif
-- 
2.7.4
