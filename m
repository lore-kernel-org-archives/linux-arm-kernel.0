From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Tue,  2 May 2017 13:59:02 -0700
Subject: [PATCH 2/2] remoteproc: Rearrange code to avoid duplication
In-Reply-To: <1493758742-26148-1-git-send-email-spjoshi@codeaurora.org>
References: <1493758742-26148-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <1493758742-26148-2-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lot of code from rproc_fw_boot() and rproc_shutdown() has been
duplicated in rproc_start() and rproc_stop() respectively.
Refactor the code, so that rproc_start() and rproc_stop() can
be called from boot up and shutdown path directly, instead of
having the unnecessary duplication of code.

Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 58 +++---------------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 169abb3..a5b72b1 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -913,7 +913,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 {
 	struct device *dev = &rproc->dev;
 	const char *name = rproc->firmware;
-	struct resource_table *table, *loaded_table;
+	struct resource_table *table;
 	int ret, tablesz;
 
 	ret = rproc_fw_sanity_check(rproc, fw);
@@ -962,48 +962,12 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 		goto clean_up_resources;
 	}
 
-	/* load the ELF segments to memory */
-	ret = rproc_load_segments(rproc, fw);
-	if (ret) {
-		dev_err(dev, "Failed to load program segments: %d\n", ret);
-		goto clean_up_resources;
-	}
-
-	/*
-	 * The starting device has been given the rproc->table_ptr as the
-	 * resource table. The address of the vring along with the other
-	 * allocated resources (carveouts etc) is stored in table_ptr.
-	 * In order to pass this information to the remote device we must copy
-	 * this information to device memory. We also update the table_ptr so
-	 * that any subsequent changes will be applied to the loaded version.
-	 */
-	loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
-	if (loaded_table)
-		memcpy(loaded_table, rproc->table_ptr, tablesz);
-
-	/* power up the remote processor */
-	ret = rproc->ops->start(rproc);
-	if (ret) {
-		dev_err(dev, "can't start rproc %s: %d\n", rproc->name, ret);
+	ret = rproc_start(rproc, fw);
+	if (ret)
 		goto clean_up_resources;
-	}
-
-	/* probe any subdevices for the remote processor */
-	ret = rproc_probe_subdevices(rproc);
-	if (ret) {
-		dev_err(dev, "failed to probe subdevices for %s: %d\n",
-			rproc->name, ret);
-		goto stop_rproc;
-	}
-
-	rproc->state = RPROC_RUNNING;
-
-	dev_info(dev, "remote processor %s is now up\n", rproc->name);
 
 	return 0;
 
-stop_rproc:
-	rproc->ops->stop(rproc);
 clean_up_resources:
 	rproc_resource_cleanup(rproc);
 clean_up:
@@ -1265,14 +1229,9 @@ void rproc_shutdown(struct rproc *rproc)
 	if (!atomic_dec_and_test(&rproc->power))
 		goto out;
 
-	/* remove any subdevices for the remote processor */
-	rproc_remove_subdevices(rproc);
-
-	/* power off the remote processor */
-	ret = rproc->ops->stop(rproc);
+	ret = rproc_stop(rproc);
 	if (ret) {
 		atomic_inc(&rproc->power);
-		dev_err(dev, "can't stop rproc: %d\n", ret);
 		goto out;
 	}
 
@@ -1284,15 +1243,6 @@ void rproc_shutdown(struct rproc *rproc)
 	/* Free the copy of the resource table */
 	kfree(rproc->table_ptr);
 	rproc->table_ptr = NULL;
-
-	/* if in crash state, unlock crash handler */
-	if (rproc->state == RPROC_CRASHED)
-		complete_all(&rproc->crash_comp);
-
-	rproc->state = RPROC_OFFLINE;
-
-	dev_info(dev, "stopped remote processor %s\n", rproc->name);
-
 out:
 	mutex_unlock(&rproc->lock);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
