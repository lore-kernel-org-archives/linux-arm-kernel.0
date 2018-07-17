From: jolly.shah@xilinx.com (Jolly Shah)
Date: Tue, 17 Jul 2018 12:59:01 -0700
Subject: [PATCH v10 04/10] firmware: xilinx: Add query data API
In-Reply-To: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
Message-ID: <1531857547-16652-5-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajan Vaja <rajanv@xilinx.com>

Add ZynqMP firmware query data API to query platform
specific information(clocks, pins) from firmware.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 14 ++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 24cfd9e..8ec5682 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -260,9 +260,23 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
 				   arg1, arg2, out);
 }
 
+/**
+ * zynqmp_pm_query_data() - Get query data from firmware
+ * @qdata:	Variable to the zynqmp_pm_query_data structure
+ * @out:	Returned output value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
+				   qdata.arg2, qdata.arg3, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
+	.query_data = zynqmp_pm_query_data,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 2eec6e7..55ed2ba 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -35,6 +35,7 @@
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_IOCTL = 34,
+	PM_QUERY_DATA,
 };
 
 /* PMU-FW return status codes */
@@ -48,9 +49,28 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_query_id {
+	PM_QID_INVALID,
+};
+
+/**
+ * struct zynqmp_pm_query_data - PM query data
+ * @qid:	query ID
+ * @arg1:	Argument 1 of query data
+ * @arg2:	Argument 2 of query data
+ * @arg3:	Argument 3 of query data
+ */
+struct zynqmp_pm_query_data {
+	u32 qid;
+	u32 arg1;
+	u32 arg2;
+	u32 arg3;
+};
+
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
+	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4
