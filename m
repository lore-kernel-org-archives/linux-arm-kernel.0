From: philippe.cornu@st.com (Philippe Cornu)
Date: Tue, 23 Jan 2018 15:26:18 +0100
Subject: [PATCH v1 2/2] drm/bridge/synopsys: dsi: Add a warning msg on dsi
 read operations
In-Reply-To: <20180123142618.28384-1-philippe.cornu@st.com>
References: <20180123142618.28384-1-philippe.cornu@st.com>
Message-ID: <20180123142618.28384-3-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DCS/GENERIC DSI read feature is not yet implemented so it
is important to warn the host_transfer() caller in case of
read operation requests.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 096cf5e5bb30..e46ddff8601c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -417,7 +417,14 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
 	if (ret)
 		return ret;
 
-	nb_bytes = packet.size;
+	if (msg->rx_buf && msg->rx_len > 0) {
+		/* TODO dw drv improvements: implement read feature */
+		dev_warn(dsi->dev, "read operations not yet implemented\n");
+		return -EPERM;
+
+	} else {
+		nb_bytes = packet.size;
+	}
 
 	return nb_bytes;
 }
-- 
2.15.1
