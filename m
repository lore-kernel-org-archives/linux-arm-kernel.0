From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  3 May 2017 13:59:52 +0200
Subject: [PATCH v2 15/20] drm/sun4i: Ignore the generic connectors for
 components
In-Reply-To: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <88de0f79b508e51b5fbf38fac058921a3c748807.1493812478.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic connectors such as hdmi-connector doesn't have any driver in,
so if they are added to the component list, we will be waiting forever for
a non-existing driver to probe.

Add a list of the connectors we want to ignore when building our component
list.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 8ddd72cd5873..8c9d2e36be55 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -164,6 +164,11 @@ static const struct component_master_ops sun4i_drv_master_ops = {
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
@@ -204,7 +209,8 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 	    !of_device_is_available(node))
 		return 0;
 
-	if (!sun4i_drv_node_is_frontend(node)) {
+	if (!sun4i_drv_node_is_connector(node) &&
+	    !sun4i_drv_node_is_frontend(node)) {
 		/* Add current component */
 		DRM_DEBUG_DRIVER("Adding component %s\n",
 				 of_node_full_name(node));
-- 
git-series 0.8.11
