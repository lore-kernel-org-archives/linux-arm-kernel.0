From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue,  1 Aug 2017 21:13:00 +0800
Subject: [PATCH 09/13] [NOT FOR REVIEW NOW] drm: bridge: Add a pre_init
 function for the dw_hdmi driver
In-Reply-To: <20170801131304.7741-1-icenowy@aosc.io>
References: <20170801131304.7741-1-icenowy@aosc.io>
Message-ID: <20170801131304.7741-10-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

Some platform glues of DesignWare HDMI controller require some
initialization to be performed before probing the main HDMI controller.

Add a pre_init function for this kind of work.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 +++
 include/drm/bridge/dw_hdmi.h              | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 6c6466c6297c..1e69b7631cae 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2343,6 +2343,9 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		goto err_isfr;
 	}
 
+	if (plat_data->pre_init)
+		plat_data->pre_init(plat_data->pre_init_data);
+
 	/* Product and revision IDs */
 	hdmi->version = (hdmi_readb(hdmi, HDMI_DESIGN_ID) << 8)
 		      | (hdmi_readb(hdmi, HDMI_REVISION_ID) << 0);
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 182f83283e24..6e109c336ca1 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -128,6 +128,8 @@ struct dw_hdmi_plat_data {
 					   const struct drm_display_mode *mode);
 	unsigned long input_bus_format;
 	unsigned long input_bus_encoding;
+	void (*pre_init)(void *data);
+	void *pre_init_data;
 
 	/* Vendor PHY support */
 	const struct dw_hdmi_phy_ops *phy_ops;
-- 
2.13.0
