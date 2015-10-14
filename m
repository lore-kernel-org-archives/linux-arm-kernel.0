From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 14 Oct 2015 10:17:14 -0400
Subject: [PATCH v4 2/3] soc: ti: add firmware file name as part of the driver
In-Reply-To: <1444832235-15263-1-git-send-email-m-karicheri2@ti.com>
References: <1444832235-15263-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1444832235-15263-3-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently firmware file name is included in the DTS. This is not scalable
as user has to change the DTS if they need upgrade to a new firmware.
Instead, add the firmware file name in the driver itself. As long as there
is no API change, new firmware upgrade is easy and require no driver
change. User is expected to copy the firmware image to the file system
and add a sym link to the new firmware for doing an upgrade. Driver add
a array of firmware file names to search for the available firmware blobs.
This scheme also prepare the driver for future changes to API if ever
happens. In such case it is assumed that driver needs to change to
accommodate the new firmware and new firmware file name will get added to
the array.

Also update the DT document to remove the firmware attribute and add
description about firmware in the driver documentation.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 v4: no change from v3
 Documentation/arm/keystone/knav-qmss.txt           | 26 ++++++++++++
 .../bindings/soc/ti/keystone-navigator-qmss.txt    |  1 -
 drivers/soc/ti/knav_qmss.h                         |  1 -
 drivers/soc/ti/knav_qmss_queue.c                   | 47 +++++++++++++---------
 4 files changed, 54 insertions(+), 21 deletions(-)

diff --git a/Documentation/arm/keystone/knav-qmss.txt b/Documentation/arm/keystone/knav-qmss.txt
index 79946d1..da34a5b 100644
--- a/Documentation/arm/keystone/knav-qmss.txt
+++ b/Documentation/arm/keystone/knav-qmss.txt
@@ -22,3 +22,29 @@ pool management.
 knav qmss driver provides a set of APIs to drivers to open/close qmss queues,
 allocate descriptor pools, map the descriptors, push/pop to queues etc. For
 details of the available APIs, please refers to include/linux/soc/ti/knav_qmss.h
+
+DT documentation is available at
+Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
+
+Accumulator QMSS queues using PDSP firmware
+============================================
+The QMSS PDSP firmware support accumulator channel that can monitor a single
+queue or multiple contiguous queues. drivers/soc/ti/knav_qmss_acc.c is the
+driver that interface with the accumulator PDSP. This configures
+accumulator channels defined in DTS (example in DT documentation) to monitor
+1 or 32 queues per channel. More description on the firmware is available in
+CPPI/QMSS Low Level Driver document (docs/CPPI_QMSS_LLD_SDS.pdf) at
+	git://git.ti.com/keystone-rtos/qmss-lld.git
+
+k2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin firmware supports upto 48 accumulator
+channels. This firmware is available under ti-keystone folder of
+firmware.git at
+   git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
+
+To use copy the firmware image to lib/firmware folder of the initramfs or
+ubifs file system and provide a sym link to k2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin
+in the file system and boot up the kernel. User would see
+
+ "firmware file ks2_qmss_pdsp_acc48.bin downloaded for PDSP"
+
+in the boot up log if loading of firmware to PDSP is successful.
diff --git a/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt b/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
index d8e8cdb..d1ce21a 100644
--- a/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
+++ b/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
@@ -221,7 +221,6 @@ qmss: qmss at 2a40000 {
 		#size-cells = <1>;
 		ranges;
 		pdsp0 at 0x2a10000 {
-			firmware = "keystone/qmss_pdsp_acc48_k2_le_1_0_0_8.fw";
 			reg = <0x2a10000 0x1000>,
 			      <0x2a0f000 0x100>,
 			      <0x2a0c000 0x3c8>,
diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
index 51da234..c31b8d8 100644
--- a/drivers/soc/ti/knav_qmss.h
+++ b/drivers/soc/ti/knav_qmss.h
@@ -135,7 +135,6 @@ struct knav_pdsp_info {
 	};
 	void __iomem					*intd;
 	u32 __iomem					*iram;
-	const char					*firmware;
 	u32						id;
 	struct list_head				list;
 };
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 6d8646d..06d9de8 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -68,6 +68,12 @@ static DEFINE_MUTEX(knav_dev_lock);
 	     idx < (kdev)->num_queues_in_use;			\
 	     idx++, inst = knav_queue_idx_to_inst(kdev, idx))
 
+/* All firmware file names end up here. List the firmware file names below.
+ * Newest followed by older ones. Search is done from start of the array
+ * until a firmware file is found.
+ */
+const char *knav_acc_firmwares[] = {"ks2_qmss_pdsp_acc48.bin"};
+
 /**
  * knav_queue_notify: qmss queue notfier call
  *
@@ -1439,7 +1445,6 @@ static int knav_queue_init_pdsps(struct knav_device *kdev,
 	struct device *dev = kdev->dev;
 	struct knav_pdsp_info *pdsp;
 	struct device_node *child;
-	int ret;
 
 	for_each_child_of_node(pdsps, child) {
 		pdsp = devm_kzalloc(dev, sizeof(*pdsp), GFP_KERNEL);
@@ -1448,17 +1453,6 @@ static int knav_queue_init_pdsps(struct knav_device *kdev,
 			return -ENOMEM;
 		}
 		pdsp->name = knav_queue_find_name(child);
-		ret = of_property_read_string(child, "firmware",
-					      &pdsp->firmware);
-		if (ret < 0 || !pdsp->firmware) {
-			dev_err(dev, "unknown firmware for pdsp %s\n",
-				pdsp->name);
-			devm_kfree(dev, pdsp);
-			continue;
-		}
-		dev_dbg(dev, "pdsp name %s fw name :%s\n", pdsp->name,
-			pdsp->firmware);
-
 		pdsp->iram =
 			knav_queue_map_reg(kdev, child,
 					   KNAV_QUEUE_PDSP_IRAM_REG_INDEX);
@@ -1489,9 +1483,9 @@ static int knav_queue_init_pdsps(struct knav_device *kdev,
 		}
 		of_property_read_u32(child, "id", &pdsp->id);
 		list_add_tail(&pdsp->list, &kdev->pdsps);
-		dev_dbg(dev, "added pdsp %s: command %p, iram %p, regs %p, intd %p, firmware %s\n",
+		dev_dbg(dev, "added pdsp %s: command %p, iram %p, regs %p, intd %p\n",
 			pdsp->name, pdsp->command, pdsp->iram, pdsp->regs,
-			pdsp->intd, pdsp->firmware);
+			pdsp->intd);
 	}
 	return 0;
 }
@@ -1518,14 +1512,29 @@ static int knav_queue_load_pdsp(struct knav_device *kdev,
 {
 	int i, ret, fwlen;
 	const struct firmware *fw;
+	bool found = false;
 	u32 *fwdata;
 
-	ret = request_firmware(&fw, pdsp->firmware, kdev->dev);
-	if (ret) {
-		dev_err(kdev->dev, "failed to get firmware %s for pdsp %s\n",
-			pdsp->firmware, pdsp->name);
-		return ret;
+	for (i = 0; i < ARRAY_SIZE(knav_acc_firmwares); i++) {
+		if (knav_acc_firmwares[i]) {
+			ret = request_firmware(&fw,
+					       knav_acc_firmwares[i],
+					       kdev->dev);
+			if (!ret) {
+				found = true;
+				break;
+			}
+		}
+	}
+
+	if (!found) {
+		dev_err(kdev->dev, "failed to get firmware for pdsp\n");
+		return -ENODEV;
 	}
+
+	dev_info(kdev->dev, "firmware file %s downloaded for PDSP\n",
+		 knav_acc_firmwares[i]);
+
 	writel_relaxed(pdsp->id + 1, pdsp->command + 0x18);
 	/* download the firmware */
 	fwdata = (u32 *)fw->data;
-- 
1.9.1
