From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 24 May 2017 08:02:53 +0800
Subject: [PATCH v12 5/9] coresight: of_get_coresight_platform_data: Add
 missing of_node_put
In-Reply-To: <1495584177-32193-1-git-send-email-leo.yan@linaro.org>
References: <1495584177-32193-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1495584177-32193-6-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

The of_get_coresight_platform_data iterates over the possible CPU nodes
to find a given cpu phandle. However it does not drop the reference
to the node pointer returned by the of_get_coresight_platform_data.

This patch also introduces another minor fix is to use
of_cpu_device_node_get() to replace of_get_cpu_node().

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
[Leo: minor tweaks for of_get_coresight_platform_data]
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 2749853..225b2dd 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -109,7 +109,8 @@ of_get_coresight_platform_data(struct device *dev,
 	struct coresight_platform_data *pdata;
 	struct of_endpoint endpoint, rendpoint;
 	struct device *rdev;
-	struct device_node *dn;
+	bool found;
+	struct device_node *dn, *np;
 	struct device_node *ep = NULL;
 	struct device_node *rparent = NULL;
 	struct device_node *rport = NULL;
@@ -176,17 +177,19 @@ of_get_coresight_platform_data(struct device *dev,
 		} while (ep);
 	}
 
-	/* Affinity defaults to CPU0 */
-	pdata->cpu = 0;
 	dn = of_parse_phandle(node, "cpu", 0);
-	for (cpu = 0; dn && cpu < nr_cpu_ids; cpu++) {
-		if (dn == of_get_cpu_node(cpu, NULL)) {
-			pdata->cpu = cpu;
+	for_each_possible_cpu(cpu) {
+		np = of_cpu_device_node_get(cpu);
+		found = (dn == np);
+		of_node_put(np);
+		if (found)
 			break;
-		}
 	}
 	of_node_put(dn);
 
+	/* Affinity to CPU0 if no cpu nodes are found */
+	pdata->cpu = found ? cpu : 0;
+
 	return pdata;
 }
 EXPORT_SYMBOL_GPL(of_get_coresight_platform_data);
-- 
2.7.4
