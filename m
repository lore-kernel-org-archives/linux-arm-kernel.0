From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 14 Oct 2015 10:17:15 -0400
Subject: [PATCH v4 3/3] soc: ti: qmss: make acc queue support optional in the
 driver
In-Reply-To: <1444832235-15263-1-git-send-email-m-karicheri2@ti.com>
References: <1444832235-15263-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1444832235-15263-4-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

acc channels are available only if accumulator PDSP is loaded and
running in the SoC. As this requires firmware and user may not have
firmware in the file system, make the accumulator queue support
available in qmss driver optional. To use accumulator queus user needs
to add firmware to the file system and boot up kernel.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 v4: no change from v3
 Documentation/arm/keystone/knav-qmss.txt |  6 ++++++
 drivers/soc/ti/knav_qmss.h               |  2 ++
 drivers/soc/ti/knav_qmss_acc.c           | 10 ++++++++--
 drivers/soc/ti/knav_qmss_queue.c         | 20 +++++++++++++++-----
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/arm/keystone/knav-qmss.txt b/Documentation/arm/keystone/knav-qmss.txt
index da34a5b..fcdb9fd 100644
--- a/Documentation/arm/keystone/knav-qmss.txt
+++ b/Documentation/arm/keystone/knav-qmss.txt
@@ -48,3 +48,9 @@ in the file system and boot up the kernel. User would see
  "firmware file ks2_qmss_pdsp_acc48.bin downloaded for PDSP"
 
 in the boot up log if loading of firmware to PDSP is successful.
+
+Use of accumulated queues requires the firmware image to be present in the
+file system. The driver doesn't acc queues to the supported queue range if
+PDSP is not running in the SoC. The API call fails if there is a queue open
+request to an acc queue and PDSP is not running. So make sure to copy firmware
+to file system before using these queue types.
diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
index c31b8d8..6ff936c 100644
--- a/drivers/soc/ti/knav_qmss.h
+++ b/drivers/soc/ti/knav_qmss.h
@@ -137,6 +137,8 @@ struct knav_pdsp_info {
 	u32 __iomem					*iram;
 	u32						id;
 	struct list_head				list;
+	bool						loaded;
+	bool						started;
 };
 
 struct knav_qmgr_info {
diff --git a/drivers/soc/ti/knav_qmss_acc.c b/drivers/soc/ti/knav_qmss_acc.c
index b98fe56..d2d48f2 100644
--- a/drivers/soc/ti/knav_qmss_acc.c
+++ b/drivers/soc/ti/knav_qmss_acc.c
@@ -486,8 +486,8 @@ struct knav_range_ops knav_acc_range_ops = {
  * Return 0 on success or error
  */
 int knav_init_acc_range(struct knav_device *kdev,
-				struct device_node *node,
-				struct knav_range_info *range)
+			struct device_node *node,
+			struct knav_range_info *range)
 {
 	struct knav_acc_channel *acc;
 	struct knav_pdsp_info *pdsp;
@@ -530,6 +530,12 @@ int knav_init_acc_range(struct knav_device *kdev,
 		return -EINVAL;
 	}
 
+	if (!pdsp->started) {
+		dev_err(kdev->dev, "pdsp id %d not started for range %s\n",
+			info->pdsp_id, range->name);
+		return -ENODEV;
+	}
+
 	info->pdsp = pdsp;
 	channels = range->num_queues;
 	if (of_get_property(node, "multi-queue", NULL)) {
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 06d9de8..f3a0b6a 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1504,6 +1504,8 @@ static int knav_queue_stop_pdsp(struct knav_device *kdev,
 		dev_err(kdev->dev, "timed out on pdsp %s stop\n", pdsp->name);
 		return ret;
 	}
+	pdsp->loaded = false;
+	pdsp->started = false;
 	return 0;
 }
 
@@ -1592,16 +1594,24 @@ static int knav_queue_start_pdsps(struct knav_device *kdev)
 	int ret;
 
 	knav_queue_stop_pdsps(kdev);
-	/* now load them all */
+	/* now load them all. We return success even if pdsp
+	 * is not loaded as acc channels are optional on having
+	 * firmware availability in the system. We set the loaded
+	 * and stated flag and when initialize the acc range, check
+	 * it and init the range only if pdsp is started.
+	 */
 	for_each_pdsp(kdev, pdsp) {
 		ret = knav_queue_load_pdsp(kdev, pdsp);
-		if (ret < 0)
-			return ret;
+		if (!ret)
+			pdsp->loaded = true;
 	}
 
 	for_each_pdsp(kdev, pdsp) {
-		ret = knav_queue_start_pdsp(kdev, pdsp);
-		WARN_ON(ret);
+		if (pdsp->loaded) {
+			ret = knav_queue_start_pdsp(kdev, pdsp);
+			if (!ret)
+				pdsp->started = true;
+		}
 	}
 	return 0;
 }
-- 
1.9.1
