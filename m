From: philippe.cornu@st.com (Philippe Cornu)
Date: Thu, 25 Jan 2018 11:38:00 +0100
Subject: [PATCH v2 2/2] drm/bridge/synopsys: dsi: Fix dsi_host_transfer()
 return value
In-Reply-To: <20180125103800.1999-1-philippe.cornu@st.com>
References: <20180125103800.1999-1-philippe.cornu@st.com>
Message-ID: <20180125103800.1999-3-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dw_mipi_dsi_host_transfer() must return the number of
bytes transmitted/received on success instead of 0.
Note: As the read feature is not implemented, only the
transmitted number of bytes is returned for the moment.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 72ecaeb40822..090bf62d1ea8 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -419,7 +419,16 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
 
 	dw_mipi_message_config(dsi, msg);
 
-	return dw_mipi_dsi_write(dsi, &packet);
+	ret = dw_mipi_dsi_write(dsi, &packet);
+	if (ret)
+		return ret;
+
+	/*
+	 * TODO Only transmitted size is returned as actual driver does
+	 * not support dcs/generic reads. Please update return value when
+	 * delivering the read feature.
+	 */
+	return packet.size;
 }
 
 static const struct mipi_dsi_host_ops dw_mipi_dsi_host_ops = {
-- 
2.15.1
