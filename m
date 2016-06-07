From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue,  7 Jun 2016 17:18:55 +0100
Subject: [PATCH v5 01/18] remoteproc: make rsc table support optional
In-Reply-To: <1465316352-20691-1-git-send-email-peter.griffin@linaro.org>
References: <1465316352-20691-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1465316352-20691-2-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some firmware and rproc drivers such as slim core don't have a
resource table. To avoid having to fudge an empty table
in the rproc driver this patch introduces a new has_rsctable
flag. rproc drivers which don't require a rsc table can set
this flag to false, and it avoids doing the initial async
firmware load in rproc_add_virtio_devices() to parse the
rsc table during rproc_add(), and also optimises rproc_fw_boot()
code path to avoid unnecessary rsc table processing of an
empty table.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/remoteproc/da8xx_remoteproc.c |  1 +
 drivers/remoteproc/remoteproc_core.c  | 87 ++++++++++++++++++++++-------------
 drivers/remoteproc/st_remoteproc.c    |  2 +
 drivers/remoteproc/ste_modem_rproc.c  |  2 +
 drivers/remoteproc/wkup_m3_rproc.c    |  1 +
 include/linux/remoteproc.h            |  1 +
 6 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index 009e56f..6e1d9be 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -224,6 +224,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	drproc = rproc->priv;
 	drproc->rproc = rproc;
 	rproc->has_iommu = false;
+	rproc->has_rsctable = true;
 
 	platform_set_drvdata(pdev, rproc);
 
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index db3958b..bef85fb 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -716,6 +716,8 @@ static int rproc_handle_resources(struct rproc *rproc, int len,
 	rproc_handle_resource_t handler;
 	int ret = 0, i;
 
+	WARN_ON(!rproc->has_rsctable);
+
 	for (i = 0; i < rproc->table_ptr->num; i++) {
 		int offset = rproc->table_ptr->offset[i];
 		struct fw_rsc_hdr *hdr = (void *)rproc->table_ptr + offset;
@@ -801,7 +803,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	struct resource_table *table, *loaded_table;
 	int ret, tablesz;
 
-	if (!rproc->table_ptr)
+	if (!rproc->table_ptr && rproc->has_rsctable)
 		return -ENOMEM;
 
 	ret = rproc_fw_sanity_check(rproc, fw);
@@ -823,24 +825,27 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
 	ret = -EINVAL;
 
-	/* look for the resource table */
-	table = rproc_find_rsc_table(rproc, fw, &tablesz);
-	if (!table) {
-		dev_err(dev, "Failed to find resource table\n");
-		goto clean_up;
-	}
+	if (rproc->has_rsctable) {
+		/* look for the resource table */
+		table = rproc_find_rsc_table(rproc, fw, &tablesz);
+		if (!table) {
+			dev_err(dev, "Failed to find resource table\n");
+			goto clean_up;
+		}
 
-	/* Verify that resource table in loaded fw is unchanged */
-	if (rproc->table_csum != crc32(0, table, tablesz)) {
-		dev_err(dev, "resource checksum failed, fw changed?\n");
-		goto clean_up;
-	}
+		/* Verify that resource table in loaded fw is unchanged */
+		if (rproc->table_csum != crc32(0, table, tablesz)) {
+			dev_err(dev, "resource checksum failed, fw changed?\n");
+			goto clean_up;
+		}
 
-	/* handle fw resources which are required to boot rproc */
-	ret = rproc_handle_resources(rproc, tablesz, rproc_loading_handlers);
-	if (ret) {
-		dev_err(dev, "Failed to process resources: %d\n", ret);
-		goto clean_up;
+		/* handle fw resources which are required to boot rproc */
+		ret = rproc_handle_resources(rproc, tablesz,
+					rproc_loading_handlers);
+		if (ret) {
+			dev_err(dev, "Failed to process resources: %d\n", ret);
+			goto clean_up;
+		}
 	}
 
 	/* load the ELF segments to memory */
@@ -850,16 +855,20 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 		goto clean_up;
 	}
 
-	/*
-	 * The starting device has been given the rproc->cached_table as the
-	 * resource table. The address of the vring along with the other
-	 * allocated resources (carveouts etc) is stored in cached_table.
-	 * In order to pass this information to the remote device we must
-	 * copy this information to device memory.
-	 */
-	loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
-	if (loaded_table)
-		memcpy(loaded_table, rproc->cached_table, tablesz);
+	if (rproc->has_rsctable) {
+		/*
+		 * The starting device has been given the rproc->cached_table as
+		 * the resource table. The address of the vring along with the
+		 * other allocated resources (carveouts etc) is stored in
+		 * cached_table. In order to pass this information to the remote
+		 * device we must copy this information to device memory.
+		 */
+
+		loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
+		if (loaded_table)
+			memcpy(loaded_table, rproc->cached_table, tablesz);
+
+	}
 
 	/* power up the remote processor */
 	ret = rproc->ops->start(rproc);
@@ -868,12 +877,14 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 		goto clean_up;
 	}
 
+
 	/*
 	 * Update table_ptr so that all subsequent vring allocations and
 	 * virtio fields manipulation update the actual loaded resource table
 	 * in device memory.
 	 */
-	rproc->table_ptr = loaded_table;
+	if (rproc->has_rsctable)
+		rproc->table_ptr = loaded_table;
 
 	rproc->state = RPROC_RUNNING;
 
@@ -978,6 +989,7 @@ static int rproc_add_virtio_devices(struct rproc *rproc)
 int rproc_trigger_recovery(struct rproc *rproc)
 {
 	struct rproc_vdev *rvdev, *rvtmp;
+	int ret;
 
 	dev_err(&rproc->dev, "recovering %s\n", rproc->name);
 
@@ -992,8 +1004,12 @@ int rproc_trigger_recovery(struct rproc *rproc)
 
 	/* Free the copy of the resource table */
 	kfree(rproc->cached_table);
+	rproc->cached_table = NULL;
 
-	return rproc_add_virtio_devices(rproc);
+	if (rproc->has_rsctable)
+		ret = rproc_add_virtio_devices(rproc);
+
+	return ret;
 }
 
 /**
@@ -1088,7 +1104,7 @@ static int __rproc_boot(struct rproc *rproc, bool wait)
 	}
 
 	/* if rproc virtio is not yet configured, wait */
-	if (wait)
+	if (wait && rproc->has_rsctable)
 		wait_for_completion(&rproc->firmware_loading_complete);
 
 	ret = rproc_fw_boot(rproc, firmware_p);
@@ -1169,12 +1185,14 @@ void rproc_shutdown(struct rproc *rproc)
 	}
 
 	/* clean up all acquired resources */
-	rproc_resource_cleanup(rproc);
+	if (rproc->has_rsctable)
+		rproc_resource_cleanup(rproc);
 
 	rproc_disable_iommu(rproc);
 
 	/* Give the next start a clean resource table */
-	rproc->table_ptr = rproc->cached_table;
+	if (rproc->has_rsctable)
+		rproc->table_ptr = rproc->cached_table;
 
 	/* if in crash state, unlock crash handler */
 	if (rproc->state == RPROC_CRASHED)
@@ -1277,7 +1295,10 @@ int rproc_add(struct rproc *rproc)
 	/* create debugfs entries */
 	rproc_create_debug_dir(rproc);
 
-	return rproc_add_virtio_devices(rproc);
+	if (rproc->has_rsctable)
+		ret = rproc_add_virtio_devices(rproc);
+
+	return ret;
 }
 EXPORT_SYMBOL(rproc_add);
 
diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
index 6f056ca..2aaf0f8 100644
--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -235,6 +235,8 @@ static int st_rproc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	rproc->has_iommu = false;
+	rproc->has_rsctable = true;
+
 	ddata = rproc->priv;
 	ddata->config = (struct st_rproc_config *)match->data;
 
diff --git a/drivers/remoteproc/ste_modem_rproc.c b/drivers/remoteproc/ste_modem_rproc.c
index 53dc17b..0256dff 100644
--- a/drivers/remoteproc/ste_modem_rproc.c
+++ b/drivers/remoteproc/ste_modem_rproc.c
@@ -290,6 +290,8 @@ static int sproc_probe(struct platform_device *pdev)
 	sproc->mdev = mdev;
 	sproc->rproc = rproc;
 	rproc->has_iommu = false;
+	rproc->has_rsctable = true;
+
 	mdev->drv_data = sproc;
 
 	/* Provide callback functions to modem device */
diff --git a/drivers/remoteproc/wkup_m3_rproc.c b/drivers/remoteproc/wkup_m3_rproc.c
index 02d271d..27e808a 100644
--- a/drivers/remoteproc/wkup_m3_rproc.c
+++ b/drivers/remoteproc/wkup_m3_rproc.c
@@ -170,6 +170,7 @@ static int wkup_m3_rproc_probe(struct platform_device *pdev)
 	wkupm3 = rproc->priv;
 	wkupm3->rproc = rproc;
 	wkupm3->pdev = pdev;
+	rproc->has_rsctable = true;
 
 	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 1c457a8..cfa180d 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -443,6 +443,7 @@ struct rproc {
 	struct resource_table *cached_table;
 	u32 table_csum;
 	bool has_iommu;
+	bool has_rsctable;
 };
 
 /* we currently support only two vrings per rvdev */
-- 
1.9.1
