From: agross@codeaurora.org (Andy Gross)
Date: Tue, 25 Aug 2015 15:36:35 -0500
Subject: [PATCH] soc: qcom: smd: Use correct remote processor ID
Message-ID: <1440534995-12899-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes SMEM addressing issues when remote processors need to use
secure SMEM partitions.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 .../devicetree/bindings/soc/qcom/qcom,smd.txt      |    7 +++++++
 drivers/soc/qcom/smd.c                             |   18 ++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
index f65c76d..3b60702 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
@@ -37,6 +37,12 @@ The edge is described by the following properties:
 	Definition: the identifier of the remote processor in the smd channel
 		    allocation table
 
+- qcom,remote-pid:
+	Usage: required
+	Value type: <u32>
+	Definition: the identifier for the remote processor as known by the rest
+		    of the system.
+
 = SMD DEVICES
 
 In turn, subnodes of the "edges" represent devices tied to SMD channels on that
@@ -68,6 +74,7 @@ The following example represents a smd node, with one edge representing the
 			interrupts = <0 168 1>;
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
+			qcom,remote-pid = <0xffffffff>;
 
 			rpm_requests {
 				compatible = "qcom,rpm-msm8974";
diff --git a/drivers/soc/qcom/smd.c b/drivers/soc/qcom/smd.c
index 327adcf..bca8aba 100644
--- a/drivers/soc/qcom/smd.c
+++ b/drivers/soc/qcom/smd.c
@@ -111,6 +111,7 @@ struct qcom_smd_edge {
 	struct qcom_smd *smd;
 	struct device_node *of_node;
 	unsigned edge_id;
+	unsigned remote_pid;
 
 	int irq;
 
@@ -572,7 +573,7 @@ static irqreturn_t qcom_smd_edge_intr(int irq, void *data)
 	 * have to scan if the amount of available space in smem have changed
 	 * since last scan.
 	 */
-	available = qcom_smem_get_free_space(edge->edge_id);
+	available = qcom_smem_get_free_space(edge->remote_pid);
 	if (available != edge->smem_available) {
 		edge->smem_available = available;
 		edge->need_rescan = true;
@@ -976,7 +977,8 @@ static struct qcom_smd_channel *qcom_smd_create_channel(struct qcom_smd_edge *ed
 	spin_lock_init(&channel->recv_lock);
 	init_waitqueue_head(&channel->fblockread_event);
 
-	ret = qcom_smem_get(edge->edge_id, smem_info_item, (void **)&info, &info_size);
+	ret = qcom_smem_get(edge->remote_pid, smem_info_item, (void **)&info,
+			    &info_size);
 	if (ret)
 		goto free_name_and_channel;
 
@@ -997,7 +999,8 @@ static struct qcom_smd_channel *qcom_smd_create_channel(struct qcom_smd_edge *ed
 		goto free_name_and_channel;
 	}
 
-	ret = qcom_smem_get(edge->edge_id, smem_fifo_item, &fifo_base, &fifo_size);
+	ret = qcom_smem_get(edge->remote_pid, smem_fifo_item, &fifo_base,
+			    &fifo_size);
 	if (ret)
 		goto free_name_and_channel;
 
@@ -1041,7 +1044,7 @@ static void qcom_discover_channels(struct qcom_smd_edge *edge)
 	int i;
 
 	for (tbl = 0; tbl < SMD_ALLOC_TBL_COUNT; tbl++) {
-		ret = qcom_smem_get(edge->edge_id,
+		ret = qcom_smem_get(edge->remote_pid,
 				    smem_items[tbl].alloc_tbl_id,
 				    (void **)&alloc_tbl,
 				    NULL);
@@ -1184,6 +1187,13 @@ static int qcom_smd_parse_edge(struct device *dev,
 		return -EINVAL;
 	}
 
+	key = "qcom,remote-pid";
+	ret = of_property_read_u32(node, key, &edge->remote_pid);
+	if (ret) {
+		dev_err(dev, "edge missing %s property\n", key);
+		return -EINVAL;
+	}
+
 	syscon_np = of_parse_phandle(node, "qcom,ipc", 0);
 	if (!syscon_np) {
 		dev_err(dev, "no qcom,ipc node\n");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
