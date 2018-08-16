From: wendy.liang@xilinx.com (Wendy Liang)
Date: Thu, 16 Aug 2018 00:06:28 -0700
Subject: [PATCH 5/7] firmware: xlnx-zynqmp: Add shutdown/wakeup request
In-Reply-To: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
Message-ID: <1534403190-28523-6-git-send-email-jliang@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add shutdown/wakeup a resource eemi operations to shutdown
or bringup a resource.

Signed-off-by: Wendy Liang <jliang@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 35 +++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  8 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 2e97f60..aa83262 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -475,6 +475,39 @@ static int zynqmp_pm_release_node(const u32 node)
 	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, node, 0, 0, 0, NULL);
 }
 
+/**
+ * zynqmp_pm_force_powerdown - PM call to request for another PU or subsystem to
+ *				be powered down forcefully
+ * @target:	Node ID of the targeted PU or subsystem
+ * @ack:	Flag to specify whether acknowledge is requested
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_force_powerdown(const u32 target,
+				     const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, target, ack, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_request_wakeup - PM call to wake up selected master or subsystem
+ * @node:	Node ID of the master or subsystem
+ * @set_addr:	Specifies whether the address argument is relevant
+ * @address:	Address from which to resume when woken up
+ * @ack:	Flag to specify whether acknowledge requested
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_request_wakeup(const u32 node,
+				    const bool set_addr,
+				    const u64 address,
+				    const enum zynqmp_pm_request_ack ack)
+{
+	/* set_addr flag is encoded into 1st bit of address */
+	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
+				   address >> 32, ack, NULL);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
@@ -490,6 +523,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getparent = zynqmp_pm_clock_getparent,
 	.request_node = zynqmp_pm_request_node,
 	.release_node = zynqmp_pm_release_node,
+	.force_powerdown = zynqmp_pm_force_powerdown,
+	.request_wakeup = zynqmp_pm_request_wakeup,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 02067a3..efc73bc 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -54,6 +54,8 @@ enum pm_api_id {
 	PM_CLOCK_GETRATE,
 	PM_CLOCK_SETPARENT,
 	PM_CLOCK_GETPARENT,
+	PM_FORCE_POWERDOWN = 8,
+	PM_REQUEST_WAKEUP = 10,
 	PM_REQUEST_NODE = 13,
 	PM_RELEASE_NODE = 14,
 };
@@ -137,6 +139,12 @@ struct zynqmp_eemi_ops {
 			    const u32 qos,
 			    const enum zynqmp_pm_request_ack ack);
 	int (*release_node)(const u32 node);
+	int (*force_powerdown)(const u32 target,
+			       const enum zynqmp_pm_request_ack ack);
+	int (*request_wakeup)(const u32 node,
+			      const bool set_addr,
+			      const u64 address,
+			      const enum zynqmp_pm_request_ack ack);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4
