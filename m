From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 4 Sep 2015 17:46:38 -0400
Subject: [PATCH v1 1/2] soc: ti: display firmware file name as part of boot log
Message-ID: <1441403199-10936-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To help the user, print the PDSP file name as part of
knav_queue_load_pdsp(). This will be useful for users to know what
version of the firmware is loaded to PDSP. Also update the
document for the location of the QMSS accumulator PDSP firmware.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 v1 : fixed firmware file names in documentation
 .../bindings/soc/ti/keystone-navigator-qmss.txt      | 20 +++++++++++++++++++-
 drivers/soc/ti/knav_qmss_queue.c                     |  3 +++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt b/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
index d8e8cdb..ca0a1a7 100644
--- a/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
+++ b/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
@@ -221,7 +221,7 @@ qmss: qmss at 2a40000 {
 		#size-cells = <1>;
 		ranges;
 		pdsp0 at 0x2a10000 {
-			firmware = "keystone/qmss_pdsp_acc48_k2_le_1_0_0_8.fw";
+			firmware = "k2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin";
 			reg = <0x2a10000 0x1000>,
 			      <0x2a0f000 0x100>,
 			      <0x2a0c000 0x3c8>,
@@ -230,3 +230,21 @@ qmss: qmss at 2a40000 {
 		};
 	};
 }; /* qmss */
+
+Accumulator QMSS Channel using PDSP firmware
+============================================
+The QMSS PDSP firmware support accumulator channel that can monitor a single
+queue or multiple contiguous queues. drivers/soc/ti/knav_qmss_acc.c is the
+driver that interface with the accumulator PDSP. This configures
+accumulator channels defined in DTS (example above) to monitor 1 or 32 queues
+per channel. More description on the firmware is available in CPPI/QMSS Low
+Level Driver document (docs/CPPI_QMSS_LLD_SDS.pdf) at
+	git://git.ti.com/keystone-rtos/qmss-lld.git
+
+k2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin firmware supports upto 48 accumulator
+channels. This firmware is available under firmware folder of the above repo
+under the name acc48_le.bin. To use copy the firmware image to lib/firmware
+folder of the initramfs or ubifs file system as
+k2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin and boot up the kernel. User would see
+"firmware file ks2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin downloaded for PDSP" in
+the boot up log if loading of firmware to PDSP is successful.
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 6d8646d..f26ce99 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1526,6 +1526,9 @@ static int knav_queue_load_pdsp(struct knav_device *kdev,
 			pdsp->firmware, pdsp->name);
 		return ret;
 	}
+	dev_info(kdev->dev, "firmware file %s downloaded for PDSP\n",
+		 pdsp->firmware);
+
 	writel_relaxed(pdsp->id + 1, pdsp->command + 0x18);
 	/* download the firmware */
 	fwdata = (u32 *)fw->data;
-- 
1.9.1
