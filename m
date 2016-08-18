From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 18 Aug 2016 12:11:02 +0200
Subject: [PATCH 09/13] scpi: implement rockchip support via the vendor_msg
 mechanism
In-Reply-To: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471515066-3626-10-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support the Rockchip legacy procotol, implement the vendor
mailbox specific functions and add ops to the of_match table.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 275feef..d73db7c 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -455,6 +455,37 @@ static int legacy_scpi_get_chan(u8 cmd)
 	return 0;
 }
 
+/* Rockchip SoCs needs a special structure as a message */
+
+struct rockchip_scpi_xfer {
+	u32 cmd;
+	int rx_size;
+};
+
+static int rockchip_init(struct device *dev, struct scpi_chan *chan)
+{
+	chan->vendor_data = devm_kmalloc(dev,
+					 sizeof(struct rockchip_scpi_xfer),
+					 GFP_KERNEL);
+	if (!chan->vendor_data)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int rockchip_prepare(struct scpi_chan *chan)
+{
+	struct scpi_xfer *msg = chan->t;
+	struct rockchip_scpi_xfer *xfer = chan->vendor_data;
+
+	xfer->cmd = msg->cmd;
+	xfer->rx_size = msg->rx_len;
+
+	msg->vendor_msg = xfer;
+
+	return 0;
+}
+
 static struct scpi_xfer *get_scpi_xfer(struct scpi_chan *ch)
 {
 	struct scpi_xfer *t;
@@ -1026,9 +1057,21 @@ static const struct priv_scpi_ops scpi_legacy_ops = {
 	.scpi_ops = &legacy_scpi_ops,
 };
 
+static const struct priv_scpi_ops scpi_rockchip_ops = {
+	.init = rockchip_init,
+	.prepare = rockchip_prepare,
+	.handle_remote_msg = legacy_scpi_handle_remote_msg,
+	.tx_prepare = legacy_scpi_tx_prepare,
+	.init_versions = legacy_scpi_init_versions,
+	.dvfs_get_info = legacy_scpi_dvfs_get_info,
+	.scpi_ops = &legacy_scpi_ops,
+};
+
 static const struct of_device_id scpi_of_match[] = {
 	{.compatible = "arm,scpi"},
 	{.compatible = "amlogic,meson-gxbb-scpi", .data = &scpi_legacy_ops},
+	{.compatible = "rockchip,rk3368-scpi", .data = &scpi_rockchip_ops},
+	{.compatible = "rockchip,rk3399-scpi", .data = &scpi_rockchip_ops},
 	{},
 };
 
-- 
1.9.1
