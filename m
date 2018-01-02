From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  2 Jan 2018 11:25:28 +0000
Subject: [PATCH v11 3/8] coresight: of: Use of_cpu_node_to_id helper
In-Reply-To: <20180102112533.13640-1-suzuki.poulose@arm.com>
References: <20180102112533.13640-1-suzuki.poulose@arm.com>
Message-ID: <20180102112533.13640-4-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reuse the new generic helper, of_cpu_node_to_id() to map a
given CPU phandle to a logical CPU number.

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V4:
 - Fix a regression introduced in v4, reported by bugrobot
Changes since V3:
 - Reflect the renaming of the helper and return value changes
---
 drivers/hwtracing/coresight/of_coresight.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index a18794128bf8..7c375443ede6 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -104,26 +104,17 @@ static int of_coresight_alloc_memory(struct device *dev,
 int of_coresight_get_cpu(const struct device_node *node)
 {
 	int cpu;
-	bool found;
-	struct device_node *dn, *np;
+	struct device_node *dn;
 
 	dn = of_parse_phandle(node, "cpu", 0);
-
 	/* Affinity defaults to CPU0 */
 	if (!dn)
 		return 0;
-
-	for_each_possible_cpu(cpu) {
-		np = of_cpu_device_node_get(cpu);
-		found = (dn == np);
-		of_node_put(np);
-		if (found)
-			break;
-	}
+	cpu = of_cpu_node_to_id(dn);
 	of_node_put(dn);
 
 	/* Affinity to CPU0 if no cpu nodes are found */
-	return found ? cpu : 0;
+	return (cpu < 0) ? 0 : cpu;
 }
 EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
 
-- 
2.13.6
