From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  4 Aug 2016 10:21:53 +0100
Subject: [PATCH 9/9] remoteproc: core: Support empty resource tables
In-Reply-To: <20160804092153.23032-1-lee.jones@linaro.org>
References: <20160804092153.23032-1-lee.jones@linaro.org>
Message-ID: <20160804092153.23032-10-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, when a remote processor does not require resources, the
platform-specific remoteproc driver has to create a fake resource
table in order to by-pass the strict checking.  But there is no hard
requirement for a remote processor so require or support shared
resources.  This patch removes the strict checking and skips
resource table related operations if one is not provided.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 9a077e4..366e197 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1104,9 +1104,6 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	struct resource_table *table, *loaded_table;
 	int ret, tablesz;
 
-	if (!rproc->table_ptr)
-		return -ENOMEM;
-
 	ret = rproc_fw_sanity_check(rproc, fw);
 	if (ret)
 		return ret;
@@ -1130,12 +1127,10 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	if (!list_empty(&rproc->override_resources))
 		goto skip_table_check;
 
-	/* look for the resource table */
+	/* Resource tables aren't compulsory. */
 	table = rproc_find_rsc_table(rproc, fw, &tablesz);
-	if (!table) {
-		dev_err(dev, "Failed to find resource table\n");
-		goto clean_up;
-	}
+	if (!table)
+		goto skip_resources;
 
 	/* Verify that resource table in loaded fw is unchanged */
 	if (rproc->table_csum != crc32(0, table, tablesz)) {
@@ -1152,6 +1147,8 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 		goto clean_up;
 	}
 
+ skip_resources:
+
 	/* load the ELF segments to memory */
 	ret = rproc_load_segments(rproc, fw);
 	if (ret) {
@@ -1213,8 +1210,12 @@ static void rproc_fw_config_virtio(const struct firmware *fw, void *context)
 	if (rproc_fw_sanity_check(rproc, fw) < 0)
 		goto out;
 
-	/* look for the resource table */
 	table = rproc_find_rsc_table(rproc, fw,  &tablesz);
+	if (IS_ERR(table)) {
+		dev_err(&rproc->dev, "Resource table expected, but failed\n");
+		goto out;
+	}
+
 	if (!table)
 		goto out;
 
-- 
2.9.0
