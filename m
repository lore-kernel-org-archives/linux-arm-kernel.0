From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 26 Mar 2017 02:23:13 +0800
Subject: [PATCH v5 5/9] coresight: use const for device_node structures
In-Reply-To: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1490466197-29163-6-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Almost low level functions from open firmware have used const to
qualify device_node structures, so add const for device_node
parameters in of_coresight related functions.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 6 +++---
 include/linux/coresight.h                  | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 78d2399..46eec0f 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -52,7 +52,7 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
 			       endpoint, of_dev_node_match);
 }
 
-static void of_coresight_get_ports(struct device_node *node,
+static void of_coresight_get_ports(const struct device_node *node,
 				   int *nr_inport, int *nr_outport)
 {
 	struct device_node *ep = NULL;
@@ -101,7 +101,7 @@ static int of_coresight_alloc_memory(struct device *dev,
 	return 0;
 }
 
-int of_coresight_get_cpu(struct device_node *node)
+int of_coresight_get_cpu(const struct device_node *node)
 {
 	int cpu;
 	bool found;
@@ -128,7 +128,7 @@ int of_coresight_get_cpu(struct device_node *node)
 EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
 
 struct coresight_platform_data *of_get_coresight_platform_data(
-				struct device *dev, struct device_node *node)
+			struct device *dev, const struct device_node *node)
 {
 	int i = 0, ret = 0;
 	struct coresight_platform_data *pdata;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index bf96678..4915254 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -263,13 +263,13 @@ static inline int coresight_timeout(void __iomem *addr, u32 offset,
 #endif
 
 #ifdef CONFIG_OF
-extern int of_coresight_get_cpu(struct device_node *node);
+extern int of_coresight_get_cpu(const struct device_node *node);
 extern struct coresight_platform_data *of_get_coresight_platform_data(
-				struct device *dev, struct device_node *node);
+	struct device *dev, const struct device_node *node);
 #else
-static inline int of_coresight_get_cpu(struct device_node *node) { return 0; }
+static inline int of_coresight_get_cpu(const struct device_node *node) { return 0; }
 static inline struct coresight_platform_data *of_get_coresight_platform_data(
-	struct device *dev, struct device_node *node) { return NULL; }
+	struct device *dev, const struct device_node *node) { return NULL; }
 #endif
 
 #ifdef CONFIG_PID_NS
-- 
2.7.4
