From: philippe.cornu@st.com (Philippe Cornu)
Date: Thu, 25 Jan 2018 11:37:59 +0100
Subject: [PATCH v2 1/2] drm/bridge/synopsys: dsi: Add a warning msg on dsi
 read requests
In-Reply-To: <20180125103800.1999-1-philippe.cornu@st.com>
References: <20180125103800.1999-1-philippe.cornu@st.com>
Message-ID: <20180125103800.1999-2-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dcs/generic dsi read feature is not yet implemented so it
is important to warn the host_transfer() caller in case of
read operation requests.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index daec7881be6d..72ecaeb40822 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -405,6 +405,12 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
 	struct mipi_dsi_packet packet;
 	int ret;
 
+	if (msg->rx_buf || msg->rx_len) {
+		/* TODO dw drv improvements: implement read feature */
+		dev_warn(dsi->dev, "read operations not yet implemented\n");
+		return -EINVAL;
+	}
+
 	ret = mipi_dsi_create_packet(&packet, msg);
 	if (ret) {
 		dev_err(dsi->dev, "failed to create packet: %d\n", ret);
-- 
2.15.1
