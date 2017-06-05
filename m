From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  5 Jun 2017 14:15:06 -0600
Subject: [PATCH 05/17] coresight: use const for device_node structures
In-Reply-To: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1496693718-9191-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

Almost low level functions from open firmware have used const to
qualify device_node structures, so add const for device_node
parameters in of_coresight related functions.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 7 ++++---
 include/linux/coresight.h                  | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 09142e99e915..2749853b9010 100644
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
index 035c16c9a505..bf0aa50880be 100644
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
