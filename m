From: philippe.cornu@st.com (Philippe Cornu)
Date: Tue, 23 Jan 2018 15:26:17 +0100
Subject: [PATCH v1 1/2] drm/bridge/synopsys: dsi: Fix dsi_host_transfer()
 return value
In-Reply-To: <20180123142618.28384-1-philippe.cornu@st.com>
References: <20180123142618.28384-1-philippe.cornu@st.com>
Message-ID: <20180123142618.28384-2-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dw_mipi_dsi_host_transfer() must return the number of
bytes transmitted/received on success instead of 0.
Note: nb_bytes is introduced in this patch as it will be
re-used with the future dcs/generic dsi read feature.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index f458798af788..096cf5e5bb30 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -403,7 +403,7 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
 {
 	struct dw_mipi_dsi *dsi = host_to_dsi(host);
 	struct mipi_dsi_packet packet;
-	int ret;
+	int ret, nb_bytes;
 
 	ret = mipi_dsi_create_packet(&packet, msg);
 	if (ret) {
@@ -413,7 +413,13 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
 
 	dw_mipi_message_config(dsi, msg);
 
-	return dw_mipi_dsi_write(dsi, &packet);
+	ret = dw_mipi_dsi_write(dsi, &packet);
+	if (ret)
+		return ret;
+
+	nb_bytes = packet.size;
+
+	return nb_bytes;
 }
 
 static const struct mipi_dsi_host_ops dw_mipi_dsi_host_ops = {
-- 
2.15.1
