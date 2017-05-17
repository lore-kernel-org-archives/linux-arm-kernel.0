From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 May 2017 09:40:44 +0200
Subject: [PATCH v3 15/21] drm/sun4i: Ignore the generic connectors for
 components
In-Reply-To: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
References: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
Message-ID: <a766ed0410e4c78e49f1e462775fdba1a70a88bf.1495006350.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic connectors such as hdmi-connector doesn't have any driver in,
so if they are added to the component list, we will be waiting forever for
a non-existing driver to probe.

Add a list of the connectors we want to ignore when building our component
list.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index c52f7a9eb045..9b3e8c8d7c75 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -166,6 +166,11 @@ static const struct component_master_ops sun4i_drv_master_ops = {
 	.unbind	= sun4i_drv_unbind,
 };
 
+static bool sun4i_drv_node_is_connector(struct device_node *node)
+{
+	return of_device_is_compatible(node, "hdmi-connector");
+}
+
 static bool sun4i_drv_node_is_frontend(struct device_node *node)
 {
 	return of_device_is_compatible(node, "allwinner,sun5i-a13-display-frontend") ||
@@ -206,6 +211,13 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 	    !of_device_is_available(node))
 		return 0;
 
+	/*
+	 * The connectors will be the last nodes in our pipeline, we
+	 * can just bail out.
+	 */
+	if (sun4i_drv_node_is_connector(node))
+		return 0;
+
 	if (!sun4i_drv_node_is_frontend(node)) {
 		/* Add current component */
 		DRM_DEBUG_DRIVER("Adding component %s\n",
-- 
git-series 0.9.1
