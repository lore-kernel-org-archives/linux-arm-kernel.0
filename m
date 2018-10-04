From: jolly.shah@xilinx.com (Jolly Shah)
Date: Thu, 4 Oct 2018 14:23:39 -0700
Subject: [PATCH v3 2/4] firmware: xilinx: Add APIs to control node status/power
In-Reply-To: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
References: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
Message-ID: <1538688221-9823-3-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add Xilinx ZynqMP firmware APIs to control node status
and power. These APIs allows turning on/off power domain
and setting capabilities of devices present in power domain.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 58 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 26 ++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 9a1c72a..faf6a52 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -469,6 +469,61 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
 				   arg1, arg2, out);
 }
 
+/**
+ * zynqmp_pm_request_node() - Request a node with specific capabilities
+ * @node:		Node ID of the slave
+ * @capabilities:	Requested capabilities of the slave
+ * @qos:		Quality of service (not supported)
+ * @ack:		Flag to specify whether acknowledge is requested
+ *
+ * This function is used by master to request particular node from firmware.
+ * Every master must request node before using it.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
+				  const u32 qos,
+				  const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_REQUEST_NODE, node, capabilities,
+				   qos, ack, NULL);
+}
+
+/**
+ * zynqmp_pm_release_node() - Release a node
+ * @node:	Node ID of the slave
+ *
+ * This function is used by master to inform firmware that master
+ * has released node. Once released, master must not use that node
+ * without re-request.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_release_node(const u32 node)
+{
+	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, node, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
+ * @node:		Node ID of the slave
+ * @capabilities:	Requested capabilities of the slave
+ * @qos:		Quality of service (not supported)
+ * @ack:		Flag to specify whether acknowledge is requested
+ *
+ * This API function is to be used for slaves a PU already has requested
+ * to change its capabilities.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
+				     const u32 qos,
+				     const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_SET_REQUIREMENT, node, capabilities,
+				   qos, ack, NULL);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -482,6 +537,9 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
 	.ioctl = zynqmp_pm_ioctl,
+	.request_node = zynqmp_pm_request_node,
+	.release_node = zynqmp_pm_release_node,
+	.set_requirement = zynqmp_pm_set_requirement,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 3c3c28e..6998f7d 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -32,8 +32,19 @@
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+#define ZYNQMP_PM_MAX_QOS	100U
+
+/* Node capabilities */
+#define	ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
+#define	ZYNQMP_PM_CAPABILITY_CONTEXT	0x2U
+#define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
+#define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_REQUEST_NODE = 13,
+	PM_RELEASE_NODE,
+	PM_SET_REQUIREMENT,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -75,6 +86,12 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_NUM_CLOCKS = 12,
 };
 
+enum zynqmp_pm_request_ack {
+	ZYNQMP_PM_REQUEST_ACK_NO = 1,
+	ZYNQMP_PM_REQUEST_ACK_BLOCKING,
+	ZYNQMP_PM_REQUEST_ACK_NON_BLOCKING,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -102,6 +119,15 @@ struct zynqmp_eemi_ops {
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
+	int (*request_node)(const u32 node,
+			    const u32 capabilities,
+			    const u32 qos,
+			    const enum zynqmp_pm_request_ack ack);
+	int (*release_node)(const u32 node);
+	int (*set_requirement)(const u32 node,
+			       const u32 capabilities,
+			       const u32 qos,
+			       const enum zynqmp_pm_request_ack ack);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4
