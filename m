From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Sat, 20 Oct 2018 14:06:01 +0530
Subject: [PATCH 1/3] firmware: xilinx: Add zynqmp_pm_get_chipid() API
In-Reply-To: <20181020083603.27602-1-nava.manne@xilinx.com>
References: <20181020083603.27602-1-nava.manne@xilinx.com>
Message-ID: <20181020083603.27602-2-nava.manne@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new API to provide access to the
hardware related data like soc revision, IDCODE... etc.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v1:
		-None.

Changes for RFC-V3:
                -corrected typo error in commit msg.

Changes for RFC-v2:
                -New Patch.

 drivers/firmware/xilinx/zynqmp.c     | 24 ++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 84b3fd2..e76c889 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -187,6 +187,29 @@ static int zynqmp_pm_get_api_version(u32 *version)
 }
 
 /**
+ * zynqmp_pm_get_chipid - Get silicon ID registers
+ * @idcode:     IDCODE register
+ * @version:    version register
+ *
+ * Return:      Returns the status of the operation and the idcode and version
+ *              registers in @idcode and @version.
+ */
+static int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!idcode || !version)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	*idcode = ret_payload[1];
+	*version = ret_payload[2];
+
+	return ret;
+}
+
+/**
  * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
  * @version:	Returned version value
  *
@@ -430,6 +453,7 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
+	.get_chipid = zynqmp_pm_get_chipid,
 	.query_data = zynqmp_pm_query_data,
 	.clock_enable = zynqmp_pm_clock_enable,
 	.clock_disable = zynqmp_pm_clock_disable,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 015e130..1d3126d 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_GET_CHIPID = 22,
 	PM_QUERY_DATA = 35,
 	PM_CLOCK_ENABLE,
 	PM_CLOCK_DISABLE,
@@ -89,6 +90,7 @@ struct zynqmp_pm_query_data {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*get_chipid)(u32 *idcode, u32 *version);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 	int (*clock_enable)(u32 clock_id);
 	int (*clock_disable)(u32 clock_id);
-- 
2.7.4
