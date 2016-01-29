From: hramrach@gmail.com (Michal Suchanek)
Date: Fri, 29 Jan 2016 18:07:14 +0100
Subject: Exynos Snow board display regression
Message-ID: <CAOMqctT2dAQERos8bhrtVirF7ma4onq+UUS2ks-86LJ_mVDU6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

after  commit a9fa852886fd5a7ccec3b7e9eff75f85072f009c

display no longer works on the Snow board. The built-in panel is no
longer probed.

The commit *supposedly* provides for backwards compatibility and at
first glance only new options for probing the panel are added.

However, reverting the commit on top of 4.5-rc1 gives working display
again so there is probably some subtle non-obvious catch in the logic.

Any ideas what might go wrong here?

Thanks

Michal

Author: Inki Dae <inki.dae@samsung.com>
Date:   Thu Nov 26 21:34:18 2015 +0900

    drm/exynos: dp: add of_graph dt binding support for panel

    This patch adds of_graph dt binding support for panel device
    and also keeps the backward compatibility.

    i.e.,
    The dts file for Exynos5800 based peach pi board
    has a panel property so we need to keep the backward compatibility.

    Changelog v3:
    - bind only one of two nodes outbound - panel or bridge.

    Changelog v2:
    - return -EINVAL if getting a port node failed.

    Signed-off-by: Inki Dae <inki.dae@samsung.com>
    Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c
b/drivers/gpu/drm/exynos/exynos_dp_core.c
index 94f02a0..60260a0 100644
--- a/drivers/gpu/drm/exynos/exynos_dp_core.c
+++ b/drivers/gpu/drm/exynos/exynos_dp_core.c
@@ -1392,7 +1392,7 @@ static const struct component_ops exynos_dp_ops = {
 static int exynos_dp_probe(struct platform_device *pdev)
 {
        struct device *dev = &pdev->dev;
-       struct device_node *panel_node, *bridge_node, *endpoint;
+       struct device_node *panel_node = NULL, *bridge_node, *endpoint = NULL;
        struct exynos_dp_device *dp;
        int ret;

@@ -1403,14 +1403,32 @@ static int exynos_dp_probe(struct platform_device *pdev)

        platform_set_drvdata(pdev, dp);

+       /* This is for the backward compatibility. */
        panel_node = of_parse_phandle(dev->of_node, "panel", 0);
        if (panel_node) {
                dp->panel = of_drm_find_panel(panel_node);
                of_node_put(panel_node);
                if (!dp->panel)
                        return -EPROBE_DEFER;
+       } else {
+               endpoint = of_graph_get_next_endpoint(dev->of_node, NULL);
+               if (endpoint) {
+                       panel_node = of_graph_get_remote_port_parent(endpoint);
+                       if (panel_node) {
+                               dp->panel = of_drm_find_panel(panel_node);
+                               of_node_put(panel_node);
+                               if (!dp->panel)
+                                       return -EPROBE_DEFER;
+                       } else {
+                               DRM_ERROR("no port node for panel device.\n");
+                               return -EINVAL;
+                       }
+               }
        }

+       if (endpoint)
+               goto out;
+
        endpoint = of_graph_get_next_endpoint(dev->of_node, NULL);
        if (endpoint) {
                bridge_node = of_graph_get_remote_port_parent(endpoint);
@@ -1423,6 +1441,7 @@ static int exynos_dp_probe(struct platform_device *pdev)
                        return -EPROBE_DEFER;
        }

+out:
        pm_runtime_enable(dev);

        ret = component_add(&pdev->dev, &exynos_dp_ops);
