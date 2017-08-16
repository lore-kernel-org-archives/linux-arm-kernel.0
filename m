From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 16 Aug 2017 22:48:56 +0530
Subject: [PATCH 03/18] rpmsg: glink: Split rpm_probe to reuse the common code
In-Reply-To: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1502903951-5403-4-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

There is quite some code common in glink_rpm_probe that
can reused for glink-smem based transport as well. So
split the function and move the code to glink_native_probe
that can be used later when we add the support for
glink-smem based transport. Also reuse driver's remove as well.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_rpm.c | 85 ++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_rpm.c b/drivers/rpmsg/qcom_glink_rpm.c
index 870ce32..5f0fa0d 100644
--- a/drivers/rpmsg/qcom_glink_rpm.c
+++ b/drivers/rpmsg/qcom_glink_rpm.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/rpmsg.h>
@@ -1155,29 +1156,21 @@ static int glink_rpm_parse_toc(struct device *dev,
 	return -EINVAL;
 }
 
-static int glink_rpm_probe(struct platform_device *pdev)
+struct qcom_glink *qcom_glink_native_probe(struct device *dev,
+					   struct qcom_glink_pipe *rx,
+					   struct qcom_glink_pipe *tx)
 {
-	struct qcom_glink *glink;
-	struct glink_rpm_pipe *rx_pipe;
-	struct glink_rpm_pipe *tx_pipe;
-	struct device_node *np;
-	void __iomem *msg_ram;
-	size_t msg_ram_size;
-	struct device *dev = &pdev->dev;
-	struct resource r;
 	int irq;
 	int ret;
+	struct qcom_glink *glink;
 
 	glink = devm_kzalloc(dev, sizeof(*glink), GFP_KERNEL);
 	if (!glink)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	glink->dev = dev;
-
-	rx_pipe = devm_kzalloc(&pdev->dev, sizeof(*rx_pipe), GFP_KERNEL);
-	tx_pipe = devm_kzalloc(&pdev->dev, sizeof(*tx_pipe), GFP_KERNEL);
-	if (!rx_pipe || !tx_pipe)
-		return -ENOMEM;
+	glink->tx_pipe = tx;
+	glink->rx_pipe = rx;
 
 	mutex_init(&glink->tx_lock);
 	spin_lock_init(&glink->rx_lock);
@@ -1188,14 +1181,48 @@ static int glink_rpm_probe(struct platform_device *pdev)
 	idr_init(&glink->lcids);
 	idr_init(&glink->rcids);
 
-	glink->mbox_client.dev = &pdev->dev;
+	glink->mbox_client.dev = dev;
 	glink->mbox_chan = mbox_request_channel(&glink->mbox_client, 0);
 	if (IS_ERR(glink->mbox_chan)) {
 		if (PTR_ERR(glink->mbox_chan) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to acquire IPC channel\n");
-		return PTR_ERR(glink->mbox_chan);
+			dev_err(dev, "failed to acquire IPC channel\n");
+		return ERR_CAST(glink->mbox_chan);
+	}
+
+	irq = of_irq_get(dev->of_node, 0);
+	ret = devm_request_irq(dev, irq,
+			       qcom_glink_intr,
+			       IRQF_NO_SUSPEND | IRQF_SHARED,
+			       "glink-native", glink);
+	if (ret) {
+		dev_err(dev, "failed to request IRQ\n");
+		return ERR_PTR(ret);
 	}
 
+	ret = qcom_glink_send_version(glink);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return glink;
+}
+
+static int glink_rpm_probe(struct platform_device *pdev)
+{
+	struct qcom_glink *glink;
+	struct glink_rpm_pipe *rx_pipe;
+	struct glink_rpm_pipe *tx_pipe;
+	struct device_node *np;
+	void __iomem *msg_ram;
+	size_t msg_ram_size;
+	struct device *dev = &pdev->dev;
+	struct resource r;
+	int ret;
+
+	rx_pipe = devm_kzalloc(&pdev->dev, sizeof(*rx_pipe), GFP_KERNEL);
+	tx_pipe = devm_kzalloc(&pdev->dev, sizeof(*tx_pipe), GFP_KERNEL);
+	if (!rx_pipe || !tx_pipe)
+		return -ENOMEM;
+
 	np = of_parse_phandle(dev->of_node, "qcom,rpm-msg-ram", 0);
 	ret = of_address_to_resource(np, 0, &r);
 	of_node_put(np);
@@ -1219,27 +1246,13 @@ static int glink_rpm_probe(struct platform_device *pdev)
 	tx_pipe->native.avail = glink_rpm_tx_avail;
 	tx_pipe->native.write = glink_rpm_tx_write;
 
-	glink->tx_pipe = &tx_pipe->native;
-	glink->rx_pipe = &rx_pipe->native;
-
 	writel(0, tx_pipe->head);
 	writel(0, rx_pipe->tail);
 
-	irq = platform_get_irq(pdev, 0);
-	ret = devm_request_irq(dev, irq,
-			       qcom_glink_intr,
-			       IRQF_NO_SUSPEND | IRQF_SHARED,
-			       "glink-rpm", glink);
-	if (ret) {
-		dev_err(dev, "Failed to request IRQ\n");
-		return ret;
-	}
-
-	glink->irq = irq;
-
-	ret = qcom_glink_send_version(glink);
-	if (ret)
-		return ret;
+	glink = qcom_glink_native_probe(&pdev->dev, &rx_pipe->native,
+					&tx_pipe->native);
+	if (IS_ERR(glink))
+		return PTR_ERR(glink);
 
 	platform_set_drvdata(pdev, glink);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
