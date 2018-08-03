From: jolly.shah@xilinx.com (Jolly Shah)
Date: Fri, 3 Aug 2018 10:53:22 -0700
Subject: [PATCH v11 05/11] firmware: xilinx: Add clock APIs
In-Reply-To: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
Message-ID: <1533318808-10781-6-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajan Vaja <rajanv@xilinx.com>

Add clock APIs to control clocks through firmware
interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 186 ++++++++++++++++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h |  30 ++++++
 2 files changed, 214 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 8ec5682..41ed800 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -269,14 +269,196 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
  */
 static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
 {
-	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
-				   qdata.arg2, qdata.arg3, out);
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
+				  qdata.arg2, qdata.arg3, out);
+
+	/*
+	 * For clock name query, all bytes in SMC response are clock name
+	 * characters and return code is always success. For invalid clocks,
+	 * clock name bytes would be zeros.
+	 */
+	return qdata.qid == PM_QID_CLOCK_GET_NAME ? 0 : ret;
+}
+
+/**
+ * zynqmp_pm_clock_enable() - Enable the clock for given id
+ * @clock_id:	ID of the clock to be enabled
+ *
+ * This function is used by master to enable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_enable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_disable() - Disable the clock for given id
+ * @clock_id:	ID of the clock to be disable
+ *
+ * This function is used by master to disable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_disable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getstate() - Get the clock state for given id
+ * @clock_id:	ID of the clock to be queried
+ * @state:	1/0 (Enabled/Disabled)
+ *
+ * This function is used by master to get the state of clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETSTATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*state = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setdivider() - Set the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value
+ *
+ * This function is used by master to set divider for any clock
+ * to achieve desired rate.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETDIVIDER, clock_id, divider,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getdivider() - Get the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value
+ *
+ * This function is used by master to get divider values
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETDIVIDER, clock_id, 0,
+				  0, 0, ret_payload);
+	*divider = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setrate() - Set the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to set rate for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, clock_id,
+				   lower_32_bits(rate),
+				   upper_32_bits(rate),
+				   0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getrate() - Get the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to get rate
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*rate = ((u64)ret_payload[2] << 32) | ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setparent() - Set the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to set parent for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, clock_id,
+				   parent_id, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getparent() - Get the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to get parent index
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETPARENT, clock_id, 0,
+				  0, 0, ret_payload);
+	*parent_id = ret_payload[1];
+
+	return ret;
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
 	.query_data = zynqmp_pm_query_data,
+	.clock_enable = zynqmp_pm_clock_enable,
+	.clock_disable = zynqmp_pm_clock_disable,
+	.clock_getstate = zynqmp_pm_clock_getstate,
+	.clock_setdivider = zynqmp_pm_clock_setdivider,
+	.clock_getdivider = zynqmp_pm_clock_getdivider,
+	.clock_setrate = zynqmp_pm_clock_setrate,
+	.clock_getrate = zynqmp_pm_clock_getrate,
+	.clock_setparent = zynqmp_pm_clock_setparent,
+	.clock_getparent = zynqmp_pm_clock_getparent,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 55ed2ba..58a7478 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -36,6 +36,15 @@ enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
+	PM_CLOCK_ENABLE,
+	PM_CLOCK_DISABLE,
+	PM_CLOCK_GETSTATE,
+	PM_CLOCK_SETDIVIDER,
+	PM_CLOCK_GETDIVIDER,
+	PM_CLOCK_SETRATE,
+	PM_CLOCK_GETRATE,
+	PM_CLOCK_SETPARENT,
+	PM_CLOCK_GETPARENT,
 };
 
 /* PMU-FW return status codes */
@@ -49,8 +58,20 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_ioctl_id {
+	IOCTL_SET_PLL_FRAC_MODE = 8,
+	IOCTL_GET_PLL_FRAC_MODE,
+	IOCTL_SET_PLL_FRAC_DATA,
+	IOCTL_GET_PLL_FRAC_DATA,
+};
+
 enum pm_query_id {
 	PM_QID_INVALID,
+	PM_QID_CLOCK_GET_NAME,
+	PM_QID_CLOCK_GET_TOPOLOGY,
+	PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS,
+	PM_QID_CLOCK_GET_PARENTS,
+	PM_QID_CLOCK_GET_ATTRIBUTES,
 };
 
 /**
@@ -71,6 +92,15 @@ struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
+	int (*clock_enable)(u32 clock_id);
+	int (*clock_disable)(u32 clock_id);
+	int (*clock_getstate)(u32 clock_id, u32 *state);
+	int (*clock_setdivider)(u32 clock_id, u32 divider);
+	int (*clock_getdivider)(u32 clock_id, u32 *divider);
+	int (*clock_setrate)(u32 clock_id, u64 rate);
+	int (*clock_getrate)(u32 clock_id, u64 *rate);
+	int (*clock_setparent)(u32 clock_id, u32 parent_id);
+	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4
