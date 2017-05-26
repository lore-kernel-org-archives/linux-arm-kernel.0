From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Thu, 25 May 2017 17:40:00 -0700
Subject: [PATCH v2 2/2] remoteproc: Modify recovery path to use rproc_{start,
 stop}()
In-Reply-To: <1495759200-5575-1-git-send-email-spjoshi@codeaurora.org>
References: <1495759200-5575-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <1495759200-5575-2-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace rproc_shutdown() by rproc_stop() and rproc_boot() by
rproc_start() in the recovery path, in order to avoid remoteproc
resources re-allocation overhead and to assist with extracting the
coredumps after stopping the remote processor.

Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---

Changes from v1:

* Separate modification in recovery path
* Call release_firmware() when rproc_start() fails

 drivers/remoteproc/remoteproc_core.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index aeb7bdd..9830a1d 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1050,23 +1050,40 @@ static int rproc_stop(struct rproc *rproc)
  */
 int rproc_trigger_recovery(struct rproc *rproc)
 {
-	dev_err(&rproc->dev, "recovering %s\n", rproc->name);
+	const struct firmware *firmware_p;
+	struct device *dev = &rproc->dev;
+	int ret;
+
+	dev_err(dev, "recovering %s\n", rproc->name);
 
 	init_completion(&rproc->crash_comp);
 
-	/* shut down the remote */
-	/* TODO: make sure this works with rproc->power > 1 */
-	rproc_shutdown(rproc);
+	ret = mutex_lock_interruptible(&rproc->lock);
+	if (ret)
+		return ret;
+
+	ret = rproc_stop(rproc);
+	if (ret)
+		goto unlock_mutex;
 
 	/* wait until there is no more rproc users */
 	wait_for_completion(&rproc->crash_comp);
 
-	/*
-	 * boot the remote processor up again
-	 */
-	rproc_boot(rproc);
+	/* load firmware */
+	ret = request_firmware(&firmware_p, rproc->firmware, dev);
+	if (ret < 0) {
+		dev_err(dev, "request_firmware failed: %d\n", ret);
+		goto unlock_mutex;
+	}
 
-	return 0;
+	/* boot the remote processor up again */
+	ret = rproc_start(rproc, firmware_p);
+
+	release_firmware(firmware_p);
+
+unlock_mutex:
+	mutex_unlock(&rproc->lock);
+	return ret;
 }
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
