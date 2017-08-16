From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 16 Aug 2017 22:49:01 +0530
Subject: [PATCH 08/18] rpmsg: glink: Add support for transport version
 negotiation
In-Reply-To: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1502903951-5403-9-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

G-link supports a version number and feature flags for each transport.
A combination of the version number and feature flags enable/disable:

 (*) G-Link software updates for each edge
 (*) Individual features for each edge

Endpoints negotiate both the version and the supported flags when
the transport is opened and they cannot be changed after negotiation has
been completed.

Each full implementation of G-Link must support a minimum of the current
version, the previous version, and the base negotiation version called v0.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_glink_native.c | 75 ++++++++++++++++++++++++++++++++++++---
 drivers/rpmsg/qcom_glink_native.h |  5 +++
 drivers/rpmsg/qcom_glink_rpm.c    |  4 ++-
 drivers/rpmsg/qcom_glink_smem.c   |  1 +
 4 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index dd22a23..4d24561 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -31,6 +31,7 @@
 #include "qcom_glink_native.h"
 
 #define GLINK_NAME_SIZE		32
+#define GLINK_VERSION_1		1
 
 #define RPM_GLINK_CID_MIN	1
 #define RPM_GLINK_CID_MAX	65536
@@ -93,6 +94,9 @@ struct qcom_glink {
 	struct mutex idr_lock;
 	struct idr lcids;
 	struct idr rcids;
+	unsigned long features;
+
+	bool intentless;
 };
 
 enum {
@@ -255,8 +259,8 @@ static int qcom_glink_send_version(struct qcom_glink *glink)
 	struct glink_msg msg;
 
 	msg.cmd = cpu_to_le16(RPM_CMD_VERSION);
-	msg.param1 = cpu_to_le16(1);
-	msg.param2 = cpu_to_le32(GLINK_FEATURE_INTENTLESS);
+	msg.param1 = cpu_to_le16(GLINK_VERSION_1);
+	msg.param2 = cpu_to_le32(glink->features);
 
 	return qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
 }
@@ -266,8 +270,8 @@ static void qcom_glink_send_version_ack(struct qcom_glink *glink)
 	struct glink_msg msg;
 
 	msg.cmd = cpu_to_le16(RPM_CMD_VERSION_ACK);
-	msg.param1 = cpu_to_le16(1);
-	msg.param2 = cpu_to_le32(0);
+	msg.param1 = cpu_to_le16(GLINK_VERSION_1);
+	msg.param2 = cpu_to_le32(glink->features);
 
 	qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
 }
@@ -361,6 +365,63 @@ static void qcom_glink_send_close_ack(struct qcom_glink *glink,
 	qcom_glink_tx(glink, &req, sizeof(req), NULL, 0, true);
 }
 
+/**
+ * qcom_glink_receive_version() - receive version/features from remote system
+ *
+ * @glink:	pointer to transport interface
+ * @r_version:	remote version
+ * @r_features:	remote features
+ *
+ * This function is called in response to a remote-initiated version/feature
+ * negotiation sequence.
+ */
+static void qcom_glink_receive_version(struct qcom_glink *glink,
+				       u32 version,
+				       u32 features)
+{
+	switch (version) {
+	case 0:
+		break;
+	case GLINK_VERSION_1:
+		glink->features &= features;
+		/* FALLTHROUGH */
+	default:
+		qcom_glink_send_version_ack(glink);
+		break;
+	}
+}
+
+/**
+ * qcom_glink_receive_version_ack() - receive negotiation ack from remote system
+ *
+ * @glink:	pointer to transport interface
+ * @r_version:	remote version response
+ * @r_features:	remote features response
+ *
+ * This function is called in response to a local-initiated version/feature
+ * negotiation sequence and is the counter-offer from the remote side based
+ * upon the initial version and feature set requested.
+ */
+static void qcom_glink_receive_version_ack(struct qcom_glink *glink,
+					   u32 version,
+					   u32 features)
+{
+	switch (version) {
+	case 0:
+		/* Version negotiation failed */
+		break;
+	case GLINK_VERSION_1:
+		if (features == glink->features)
+			break;
+
+		glink->features &= features;
+		/* FALLTHROUGH */
+	default:
+		qcom_glink_send_version(glink);
+		break;
+	}
+}
+
 static int qcom_glink_rx_defer(struct qcom_glink *glink, size_t extra)
 {
 	struct glink_defer_cmd *dcmd;
@@ -908,9 +969,10 @@ static void qcom_glink_work(struct work_struct *work)
 
 		switch (cmd) {
 		case RPM_CMD_VERSION:
-			qcom_glink_send_version_ack(glink);
+			qcom_glink_receive_version(glink, param1, param2);
 			break;
 		case RPM_CMD_VERSION_ACK:
+			qcom_glink_receive_version_ack(glink, param1, param2);
 			break;
 		case RPM_CMD_OPEN:
 			qcom_glink_rx_open(glink, param1, msg->data);
@@ -931,6 +993,7 @@ static void qcom_glink_work(struct work_struct *work)
 }
 
 struct qcom_glink *qcom_glink_native_probe(struct device *dev,
+					   unsigned long features,
 					   struct qcom_glink_pipe *rx,
 					   struct qcom_glink_pipe *tx)
 {
@@ -946,6 +1009,8 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
 	glink->tx_pipe = tx;
 	glink->rx_pipe = rx;
 
+	glink->features = features;
+
 	mutex_init(&glink->tx_lock);
 	spin_lock_init(&glink->rx_lock);
 	INIT_LIST_HEAD(&glink->rx_queue);
diff --git a/drivers/rpmsg/qcom_glink_native.h b/drivers/rpmsg/qcom_glink_native.h
index d5627a4..f418787 100644
--- a/drivers/rpmsg/qcom_glink_native.h
+++ b/drivers/rpmsg/qcom_glink_native.h
@@ -14,6 +14,10 @@
 #ifndef __QCOM_GLINK_NATIVE_H__
 #define __QCOM_GLINK_NATIVE_H__
 
+#define GLINK_FEATURE_INTENT_REUSE	BIT(0)
+#define GLINK_FEATURE_MIGRATION		BIT(1)
+#define GLINK_FEATURE_TRACER_PKT	BIT(2)
+
 struct qcom_glink_pipe {
 	size_t length;
 
@@ -31,6 +35,7 @@ struct qcom_glink_pipe {
 struct qcom_glink;
 
 struct qcom_glink *qcom_glink_native_probe(struct device *dev,
+					   unsigned long features,
 					   struct qcom_glink_pipe *rx,
 					   struct qcom_glink_pipe *tx);
 void qcom_glink_native_remove(struct qcom_glink *glink);
diff --git a/drivers/rpmsg/qcom_glink_rpm.c b/drivers/rpmsg/qcom_glink_rpm.c
index cc73af0..7d039cd 100644
--- a/drivers/rpmsg/qcom_glink_rpm.c
+++ b/drivers/rpmsg/qcom_glink_rpm.c
@@ -302,7 +302,9 @@ static int glink_rpm_probe(struct platform_device *pdev)
 	writel(0, tx_pipe->head);
 	writel(0, rx_pipe->tail);
 
-	glink = qcom_glink_native_probe(&pdev->dev, &rx_pipe->native,
+	glink = qcom_glink_native_probe(&pdev->dev,
+					0,
+					&rx_pipe->native,
 					&tx_pipe->native);
 	if (IS_ERR(glink))
 		return PTR_ERR(glink);
diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
index defa10b..496a5e3 100644
--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -278,6 +278,7 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
 	*tx_pipe->head = 0;
 
 	glink = qcom_glink_native_probe(dev,
+					GLINK_FEATURE_TRACER_PKT,
 					&rx_pipe->native, &tx_pipe->native);
 	if (IS_ERR(glink)) {
 		ret = PTR_ERR(glink);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
