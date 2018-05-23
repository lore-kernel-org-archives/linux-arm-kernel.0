From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 23 May 2018 21:07:16 +0200
Subject: [PATCH 5/5] drm/rockchip: lvds: add missing of_node_put
In-Reply-To: <1527102436-13447-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1527102436-13447-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1527102436-13447-6-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device node iterators perform an of_node_get on each iteration, so a
jump out of the loop requires an of_node_put.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
iterator name for_each_child_of_node;
@@

 for_each_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
+  of_node_put(child);
?  break;
   ...
}
... when != child
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/gpu/drm/rockchip/rockchip_lvds.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index e67f4ea..051b8be 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -363,8 +363,10 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		of_property_read_u32(endpoint, "reg", &endpoint_id);
 		ret = drm_of_find_panel_or_bridge(dev->of_node, 1, endpoint_id,
 						  &lvds->panel, &lvds->bridge);
-		if (!ret)
+		if (!ret) {
+			of_node_put(endpoint);
 			break;
+		}
 	}
 	if (!child_count) {
 		DRM_DEV_ERROR(dev, "lvds port does not have any children\n");
