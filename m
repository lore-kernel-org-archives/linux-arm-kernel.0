From: jolly.shah@xilinx.com (Jolly Shah)
Date: Fri, 14 Sep 2018 12:39:49 -0700
Subject: [PATCH v4 2/3] firmware: xilinx: Implement ZynqMP power management
 APIs
In-Reply-To: <1536953990-12755-1-git-send-email-jollys@xilinx.com>
References: <1536953990-12755-1-git-send-email-jollys@xilinx.com>
Message-ID: <1536953990-12755-3-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add Xilinx ZynqMP firmware APIs to set suspend mode
and inform firmware that master has initialized its
own power management.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 29 +++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 84b3fd2..c7a3b6c 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -428,6 +428,33 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
+ *			       master has initialized its own power management
+ *
+ * This API function is to be used for notify the power management controller
+ * about the completed power management initialization.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_init_finalize(void)
+{
+	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_set_suspend_mode()	- Set system suspend mode
+ * @mode:	Mode to set for system suspend
+ *
+ * This API function is used to set mode of system suspend.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_set_suspend_mode(u32 mode)
+{
+	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, NULL);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -440,6 +467,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.init_finalize = zynqmp_pm_init_finalize,
+	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 015e130..1424170 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -28,12 +28,21 @@
 /* SMC SIP service Call Function Identifier Prefix */
 #define PM_SIP_SVC			0xC2000000
 #define PM_GET_TRUSTZONE_VERSION	0xa03
+#define PM_SET_SUSPEND_MODE		0xa02
+#define GET_CALLBACK_DATA		0xa01
 
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+/* Number of arguments for a callback */
+#define CB_ARG_CNT	4
+
+/* Payload size (consists of callback API ID + arguments) */
+#define CB_PAYLOAD_SIZE (CB_ARG_CNT + 1)
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_PM_INIT_FINALIZE = 21,
 	PM_QUERY_DATA = 35,
 	PM_CLOCK_ENABLE,
 	PM_CLOCK_DISABLE,
@@ -73,6 +82,12 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_ATTRIBUTES,
 };
 
+enum zynqmp_pm_suspend_reason {
+	SUSPEND_POWER_REQUEST = 201,
+	SUSPEND_ALERT,
+	SUSPEND_SYSTEM_SHUTDOWN,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -99,8 +114,13 @@ struct zynqmp_eemi_ops {
 	int (*clock_getrate)(u32 clock_id, u64 *rate);
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
+	int (*init_finalize)(void);
+	int (*set_suspend_mode)(u32 mode);
 };
 
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
+			u32 arg2, u32 arg3, u32 *ret_payload);
+
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
 const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
 #else
-- 
2.7.4
