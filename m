From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 18 Aug 2016 12:10:59 +0200
Subject: [PATCH 06/13] scpi: add priv_scpi_ops and fill legacy structure
In-Reply-To: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471515066-3626-7-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to use the legacy functions variants, add a new priv_scpi_ops
structure that will contain the internal alterne functions and then use these
alternate call in the probe function.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 68 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index b0d911b..3fe39fe 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -213,6 +213,7 @@ struct scpi_drvinfo {
 	struct scpi_ops *scpi_ops;
 	struct scpi_chan *channels;
 	struct scpi_dvfs_info *dvfs[MAX_DVFS_DOMAINS];
+	const struct priv_scpi_ops *ops;
 };
 
 /*
@@ -299,6 +300,17 @@ struct dev_pstate_set {
 	u8 pstate;
 } __packed;
 
+struct priv_scpi_ops {
+	/* Internal Specific Ops */
+	void (*handle_remote_msg)(struct mbox_client *c, void *msg);
+	void (*tx_prepare)(struct mbox_client *c, void *msg);
+	/* Message Specific Ops */
+	int (*init_versions)(struct scpi_drvinfo *info);
+	int (*dvfs_get_info)(u8 domain, struct dvfs_info *buf);
+	/* System wide Ops */
+	struct scpi_ops *scpi_ops;
+};
+
 static struct scpi_drvinfo *scpi_info;
 
 static int scpi_linux_errmap[SCPI_ERR_MAX] = {
@@ -695,9 +707,12 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
 	if (scpi_info->dvfs[domain])	/* data already populated */
 		return scpi_info->dvfs[domain];
 
-	ret = scpi_send_message(SCPI_CMD_GET_DVFS_INFO, &domain, sizeof(domain),
+	if (scpi_info->ops && scpi_info->ops->dvfs_get_info)
+		ret = scpi_info->ops->dvfs_get_info(domain, &buf);
+	else
+		ret = scpi_send_message(SCPI_CMD_GET_DVFS_INFO,
+					&domain, sizeof(domain),
 				&buf, sizeof(buf));
-
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -855,6 +870,22 @@ static struct scpi_ops scpi_ops = {
 	.vendor_send_message = scpi_ext_send_message,
 };
 
+static struct scpi_ops legacy_scpi_ops = {
+	.get_version = scpi_get_version,
+	.clk_get_range = NULL,
+	.clk_get_val = legacy_scpi_clk_get_val,
+	.clk_set_val = legacy_scpi_clk_set_val,
+	.dvfs_get_idx = legacy_scpi_dvfs_get_idx,
+	.dvfs_set_idx = legacy_scpi_dvfs_set_idx,
+	.dvfs_get_info = scpi_dvfs_get_info,
+	.sensor_get_capability = legacy_scpi_sensor_get_capability,
+	.sensor_get_info = legacy_scpi_sensor_get_info,
+	.sensor_get_value = legacy_scpi_sensor_get_value,
+	.device_get_power_state = NULL,
+	.device_set_power_state = NULL,
+	.vendor_send_message = legacy_scpi_send_message,
+};
+
 struct scpi_ops *get_scpi_ops(void)
 {
 	return scpi_info ? scpi_info->scpi_ops : NULL;
@@ -972,8 +1003,17 @@ static int scpi_alloc_xfer_list(struct device *dev, struct scpi_chan *ch)
 	return 0;
 }
 
+static const struct priv_scpi_ops scpi_legacy_ops = {
+	.handle_remote_msg = legacy_scpi_handle_remote_msg,
+	.tx_prepare = legacy_scpi_tx_prepare,
+	.init_versions = legacy_scpi_init_versions,
+	.dvfs_get_info = legacy_scpi_dvfs_get_info,
+	.scpi_ops = &legacy_scpi_ops,
+};
+
 static const struct of_device_id scpi_of_match[] = {
 	{.compatible = "arm,scpi"},
+	{.compatible = "amlogic,meson-gxbb-scpi", .data = &scpi_legacy_ops},
 	{},
 };
 
@@ -986,11 +1026,18 @@ static int scpi_probe(struct platform_device *pdev)
 	struct scpi_chan *scpi_chan;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	const struct of_device_id *match;
+
+	match = of_match_device(scpi_of_match, &pdev->dev);
+	if (!match)
+		return -EINVAL;
 
 	scpi_info = devm_kzalloc(dev, sizeof(*scpi_info), GFP_KERNEL);
 	if (!scpi_info)
 		return -ENOMEM;
 
+	scpi_info->ops = match->data;
+
 	count = of_count_phandle_with_args(np, "mboxes", "#mbox-cells");
 	if (count < 0) {
 		dev_err(dev, "no mboxes property in '%s'\n", np->full_name);
@@ -1023,7 +1070,13 @@ static int scpi_probe(struct platform_device *pdev)
 		pchan->tx_payload = pchan->rx_payload + (size >> 1);
 
 		cl->dev = dev;
-		cl->rx_callback = scpi_handle_remote_msg;
+		if (scpi_info->ops && scpi_info->ops->handle_remote_msg)
+			cl->rx_callback = scpi_info->ops->handle_remote_msg;
+		else
+			cl->rx_callback = scpi_handle_remote_msg;
+		if (scpi_info->ops && scpi_info->ops->tx_prepare)
+			cl->tx_prepare = scpi_info->ops->tx_prepare;
+		else
 		cl->tx_prepare = scpi_tx_prepare;
 		cl->tx_block = true;
 		cl->tx_tout = 20;
@@ -1054,6 +1107,9 @@ err:
 	scpi_info->num_chans = count;
 	platform_set_drvdata(pdev, scpi_info);
 
+	if (scpi_info->ops && scpi_info->ops->init_versions)
+		ret = scpi_info->ops->init_versions(scpi_info);
+	else
 	ret = scpi_init_versions(scpi_info);
 	if (ret) {
 		dev_err(dev, "incorrect or no SCP firmware found\n");
@@ -1067,7 +1123,11 @@ err:
 		  FW_REV_MAJOR(scpi_info->firmware_version),
 		  FW_REV_MINOR(scpi_info->firmware_version),
 		  FW_REV_PATCH(scpi_info->firmware_version));
-	scpi_info->scpi_ops = &scpi_ops;
+
+	if (scpi_info->ops && scpi_info->ops->scpi_ops)
+		scpi_info->scpi_ops = scpi_info->ops->scpi_ops;
+	else
+		scpi_info->scpi_ops = &scpi_ops;
 
 	ret = sysfs_create_groups(&dev->kobj, versions_groups);
 	if (ret)
-- 
1.9.1
