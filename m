From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  9 Mar 2017 18:05:31 +0800
Subject: [PATCH 08/11] drm/sun4i: Fetch TCON ID from device tree
In-Reply-To: <20170309100534.14023-1-wens@csie.org>
References: <20170309100534.14023-1-wens@csie.org>
Message-ID: <20170309100534.14023-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Allwinner SoCs have 2 display pipelines, as in 2 of each
components, including the frontend, backend, TCON, and any other
extras.

As the backend and TCON are always paired together and form the CRTC,
we need to know which backend or TCON we are currently probing, so we
can pair them when initializing the CRTC.

This patch figures out the TCON's ID from the device tree and stores
it in the TCON's data structure. It does this by looking at the "reg"
property of any remote endpoints connected to the TCON's output port,
except LCD panels or external bridges on the RGB interface.

If none are found, it assumes the system only has 1 TCON.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 60 ++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 3ced0b1cef6e..b774c9a50c55 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -471,6 +471,55 @@ struct drm_bridge *sun4i_tcon_find_bridge(struct device_node *node)
 	return of_drm_find_bridge(remote) ?: ERR_PTR(-EPROBE_DEFER);
 }
 
+/*
+ * The tcon can output video to an tv or hdmi encoder. When there are 2
+ * tcons, on older SoCs with DE 1.0, either tcon can be muxed to the
+ * encoder.
+ *
+ * This relationship within the display pipeline is encoded in the device
+ * tree with of_graph. Here we use it to figure out which tcon, if there
+ * are 2 or more, we are currently probing. The number would be in the
+ * "reg" property of the downstream input port endpoint.
+ */
+static int sun4i_tcon_of_get_id(struct device_node *node)
+{
+	struct device_node *port, *ep;
+	int ret = -EINVAL;
+
+	/* output is port 1 */
+	port = of_graph_get_port_by_id(node, 1);
+	if (!port)
+		return -EINVAL;
+
+	/* try finding a downstream endpoint */
+	for_each_available_child_of_node(port, ep) {
+		struct device_node *remote;
+		u32 reg;
+
+		ret = of_property_read_u32(ep, "reg", &reg);
+		if (ret)
+			continue;
+
+		/* Skip endpoint 0, the LCD panel interface */
+		if (!reg)
+			continue;
+
+		remote = of_parse_phandle(ep, "remote-endpoint", 0);
+		if (!remote)
+			continue;
+
+		ret = of_property_read_u32(remote, "reg", &reg);
+		if (ret)
+			continue;
+
+		ret = reg;
+	}
+
+	of_node_put(port);
+
+	return ret;
+}
+
 static int sun4i_tcon_bind(struct device *dev, struct device *master,
 			   void *data)
 {
@@ -488,6 +537,17 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	tcon->dev = dev;
 	tcon->quirks = of_device_get_match_data(dev);
 
+	/* This can fail if the DT does not have any downstream encoders. */
+	tcon->id = sun4i_tcon_of_get_id(dev->of_node);
+	if (tcon->id < 0) {
+		/*
+		 * TODO We currently support only 1 TCON, so we can
+		 * safely set this to 0. This should be revisited
+		 * when we add support for multiple pipelines.
+		 */
+		tcon->id = 0;
+	}
+
 	tcon->lcd_rst = devm_reset_control_get(dev, "lcd");
 	if (IS_ERR(tcon->lcd_rst)) {
 		dev_err(dev, "Couldn't get our reset line\n");
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index f636343a935d..28b8da1e6c18 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -172,6 +172,8 @@ struct sun4i_tcon {
 
 	/* Associated crtc */
 	struct sun4i_crtc		*crtc;
+
+	int				id;
 };
 
 struct drm_bridge *sun4i_tcon_find_bridge(struct device_node *node);
-- 
2.11.0
