From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 23 Jan 2015 12:35:41 -0700
Subject: [PATCH] coresight: fixing CPU hwid lookup in device tree
Message-ID: <1422041741-26803-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Some DT specification will represent CPU nodes with address
cells greater than one, making the current code fail.  Using
the proper retrieval helper function ensure the correct hwid
for CPUs is read properly with different address cell size.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/of_coresight.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/coresight/of_coresight.c b/drivers/coresight/of_coresight.c
index 9a5ff56f34d9..c3efa418a86d 100644
--- a/drivers/coresight/of_coresight.c
+++ b/drivers/coresight/of_coresight.c
@@ -117,7 +117,7 @@ struct coresight_platform_data *of_get_coresight_platform_data(
 	struct coresight_platform_data *pdata;
 	struct of_endpoint endpoint, rendpoint;
 	struct device *rdev;
-	struct device_node *cpu;
+	struct device_node *dn;
 	struct device_node *ep = NULL;
 	struct device_node *rparent = NULL;
 	struct device_node *rport = NULL;
@@ -186,14 +186,16 @@ struct coresight_platform_data *of_get_coresight_platform_data(
 
 	/* Affinity defaults to CPU0 */
 	pdata->cpu = 0;
-	cpu = of_parse_phandle(node, "cpu", 0);
-	if (cpu) {
-		const u32 *mpidr;
+	dn = of_parse_phandle(node, "cpu", 0);
+	if (dn) {
+		const u32 *cell;
 		int len, index;
+		u64 hwid;
 
-		mpidr = of_get_property(cpu, "reg", &len);
-		if (mpidr && len == 4) {
-			index = get_logical_index(be32_to_cpup(mpidr));
+		cell = of_get_property(dn, "reg", &len);
+		if (cell) {
+			hwid = of_read_number(cell, of_n_addr_cells(dn));
+			index = get_logical_index(hwid);
 			if (index != -EINVAL)
 				pdata->cpu = index;
 		}
-- 
1.9.1
