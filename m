From: fkan@apm.com (Feng Kan)
Date: Fri, 23 Feb 2018 16:46:49 -0800
Subject: [PATCH] PCIe bridge deferred probe breaks suspend resume
Message-ID: <1519433209-14581-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not a patch, but rather a question regarding the deferred
probe's effect on PCIe PM ordering. This happens on our system
which defer the probing of root bridge due to  the IOMMU not being
ready. Because of the deferred action, the bridge is moved to the
end of the dpm_list which results in incorrect suspend and resume
sequence.

In the cases I have seen, the bridge is always reordered because of
startup sequence. They are always place after the endpoint. If that
is the case the following code should be able to prevent such cases.
However, is there some cases here that would violate such situation?
---
 drivers/base/dd.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index de6fd09..5b96d5c 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -116,15 +116,17 @@ static void deferred_probe_work_func(struct work_struct *work)
 		 */
 		mutex_unlock(&deferred_probe_mutex);
 
-		/*
-		 * Force the device to the end of the dpm_list since
-		 * the PM code assumes that the order we add things to
-		 * the list is a good order for suspend but deferred
-		 * probe makes that very unsafe.
-		 */
-		device_pm_lock();
-		device_pm_move_last(dev);
-		device_pm_unlock();
+		 if (!dev_is_pci(dev)) {
+			 /*
+			  * Force the device to the end of the dpm_list since
+			  * the PM code assumes that the order we add things to
+			  * the list is a good order for suspend but deferred
+			  * probe makes that very unsafe.
+			  */
+			 device_pm_lock();
+			 device_pm_move_last(dev);
+			 device_pm_unlock();
+		 }
 
 		dev_dbg(dev, "Retrying from deferred list\n");
 		if (initcall_debug && !initcalls_done)
-- 
2.7.4
