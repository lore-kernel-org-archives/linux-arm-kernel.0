From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Sat, 22 Sep 2018 19:11:47 +0530
Subject: [RFC PATCH v3 1/3] firmware: xilinx: Add zynqmp_pm_get_chipid() API
In-Reply-To: <20180922134149.5693-1-nava.manne@xilinx.com>
References: <20180922134149.5693-1-nava.manne@xilinx.com>
Message-ID: <20180922134149.5693-2-nava.manne@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new API to provide access to the
hardware related data like soc revision, IDCODE... etc.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-corrected typo error in commit msg.
Changes for v2:
                -New Patch.

 drivers/firmware/xilinx/zynqmp.c     | 24 ++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7ccedf083926..7a33f934dce7 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -447,8 +447,32 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
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
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
+	.get_chipid = zynqmp_pm_get_chipid,
 	.ioctl = zynqmp_pm_ioctl,
 	.query_data = zynqmp_pm_query_data,
 	.clock_enable = zynqmp_pm_clock_enable,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 58a74781b51d..5a49d6f937b5 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_GET_CHIPID = 22,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -90,6 +91,7 @@ struct zynqmp_pm_query_data {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*get_chipid)(u32 *idcode, u32 *version);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 	int (*clock_enable)(u32 clock_id);
-- 
2.18.0
