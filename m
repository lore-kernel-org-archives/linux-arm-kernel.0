From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Tue,  3 Feb 2015 11:52:56 -0700
Subject: [PATCH] coresight: making cpu index lookup arm64 compliant
Message-ID: <1422989576-23277-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Function "get_logical_index()" is not available on arm64.
Instead of adding the function simply using "of_get_cpu_node()" and
comparing the return value with cpu handles yields the same
result.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/of_coresight.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/coresight/of_coresight.c b/drivers/coresight/of_coresight.c
index c3efa418a86d..f3cc8e97a0f8 100644
--- a/drivers/coresight/of_coresight.c
+++ b/drivers/coresight/of_coresight.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
 #include <linux/coresight.h>
+#include <linux/cpumask.h>
 #include <asm/smp_plat.h>
 
 
@@ -113,7 +114,7 @@ static int of_coresight_alloc_memory(struct device *dev,
 struct coresight_platform_data *of_get_coresight_platform_data(
 				struct device *dev, struct device_node *node)
 {
-	int i = 0, ret = 0;
+	int i = 0, ret = 0, cpu;
 	struct coresight_platform_data *pdata;
 	struct of_endpoint endpoint, rendpoint;
 	struct device *rdev;
@@ -187,17 +188,10 @@ struct coresight_platform_data *of_get_coresight_platform_data(
 	/* Affinity defaults to CPU0 */
 	pdata->cpu = 0;
 	dn = of_parse_phandle(node, "cpu", 0);
-	if (dn) {
-		const u32 *cell;
-		int len, index;
-		u64 hwid;
-
-		cell = of_get_property(dn, "reg", &len);
-		if (cell) {
-			hwid = of_read_number(cell, of_n_addr_cells(dn));
-			index = get_logical_index(hwid);
-			if (index != -EINVAL)
-				pdata->cpu = index;
+	for (cpu = 0; dn && cpu < nr_cpu_ids; cpu++) {
+		if (dn == of_get_cpu_node(cpu, NULL)) {
+			pdata->cpu = cpu;
+			break;
 		}
 	}
 
-- 
1.9.1
