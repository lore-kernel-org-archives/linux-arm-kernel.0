From: leo.yan@linaro.org (Leo Yan)
Date: Thu,  4 May 2017 08:36:30 +0800
Subject: [PATCH v2] coresight: use const for device_node structures
Message-ID: <1493858190-16451-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Almost low level functions from open firmware have used const to
qualify device_node structures, so add const for device_node
parameters in of_coresight related functions.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 7 ++++---
 include/linux/coresight.h                  | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 629e031..b101590 100644
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
@@ -101,8 +101,9 @@ static int of_coresight_alloc_memory(struct device *dev,
 	return 0;
 }
 
-struct coresight_platform_data *of_get_coresight_platform_data(
-				struct device *dev, struct device_node *node)
+struct coresight_platform_data *
+of_get_coresight_platform_data(struct device *dev,
+			       const struct device_node *node)
 {
 	int i = 0, ret = 0, cpu;
 	struct coresight_platform_data *pdata;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 2a5982c..b198168 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -263,11 +263,12 @@ static inline int coresight_timeout(void __iomem *addr, u32 offset,
 #endif
 
 #ifdef CONFIG_OF
-extern struct coresight_platform_data *of_get_coresight_platform_data(
-				struct device *dev, struct device_node *node);
+extern struct coresight_platform_data *
+of_get_coresight_platform_data(struct device *dev,
+			       const struct device_node *node);
 #else
 static inline struct coresight_platform_data *of_get_coresight_platform_data(
-	struct device *dev, struct device_node *node) { return NULL; }
+	struct device *dev, const struct device_node *node) { return NULL; }
 #endif
 
 #ifdef CONFIG_PID_NS
-- 
2.7.4
