From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 May 2017 18:09:32 +0200
Subject: [PATCH v4 07/11] drm/sun4i: Ignore the generic connectors for
 components
In-Reply-To: <cover.c61cbe60123a4aeb24f255bca7927218dda6283e.1495900658.git-series.maxime.ripard@free-electrons.com>
References: <cover.c61cbe60123a4aeb24f255bca7927218dda6283e.1495900658.git-series.maxime.ripard@free-electrons.com>
Message-ID: <5b34efbc6a9453e845d60170507958df30f76f33.1495900658.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic connectors such as hdmi-connector doesn't have any driver in,
so if they are added to the component list, we will be waiting forever for
a non-existing driver to probe.

Add a list of the connectors we want to ignore when building our component
list.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 1dd1948025d2..cfc0b2fcb0a6 100644
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
@@ -207,6 +212,13 @@ static int sun4i_drv_add_endpoints(struct device *dev,
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
