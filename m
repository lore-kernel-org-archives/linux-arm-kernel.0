From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 22 May 2012 14:51:12 +0300
Subject: [PATCH] remoteproc: block premature rproc booting
Message-ID: <1337687472-23009-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When an rproc instance is registered, remoteproc asynchronously
loads its firmware in order to tell which vdevs it supports.

Later on those vdevs are registered, and when probed, their drivers
usually trigger powering on of the remote processor.

OTOH, non-standard scenarios might involve early invocation of
rproc_boot even before the asynchronous fw loading has completed.

We're not sure we really want to support those scenarios, but right
now we do (e.g. via rproc_get_by_name), so let's simply fix this race
by blocking those premature rproc_boot() flows until the async fw
loading is completed.

Reported-and-tested-by: Sjur Brandeland <sjur.brandeland@stericsson.com>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/remoteproc/remoteproc_core.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 40e2b2d..464ea4f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1141,6 +1141,18 @@ int rproc_boot(struct rproc *rproc)
 
 	dev = rproc->dev;
 
+	/*
+	 * if asynchronoush fw loading is underway, wait up to 65 secs
+	 * (just a bit more than the firmware request's timeout)
+	 */
+	ret = wait_for_completion_interruptible_timeout(
+					&rproc->firmware_loading_complete,
+					msecs_to_jiffies(65000));
+	if (ret <= 0) {
+		dev_err(dev, "async fw loading isn't complete: %d\n", ret);
+		return ret ? ret : -ETIMEDOUT;
+	}
+
 	ret = mutex_lock_interruptible(&rproc->lock);
 	if (ret) {
 		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
-- 
1.7.5.4
