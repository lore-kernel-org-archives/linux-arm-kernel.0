From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Tue, 10 Jul 2018 22:34:58 +0200
Subject: [PATCH v2 05/18] drm/sun4i: tcon: Release node when traversing of
 graph
In-Reply-To: <20180710203511.18454-1-jernej.skrabec@siol.net>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
Message-ID: <20180710203511.18454-6-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function sun4i_tcon_find_engine_traverse() doesn't release node if it
needs to traverse of graph deeper than 1 level.

Fix this by calling of_node_put().

Fixes: 49836b11fe71 ("drm/sun4i: tcon: Generalize engine search algorithm")

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index aacc841d3dc6..3fb084f802e2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -811,6 +811,7 @@ sun4i_tcon_find_engine_traverse(struct sun4i_drv *drv,
 	 * remote output id. If this for some reason can't be done, 0
 	 * is used as input port id.
 	 */
+	of_node_put(port);
 	port = of_graph_get_remote_port(ep);
 	if (!of_property_read_u32(port, "reg", &reg) && reg > 0)
 		reg -= 1;
-- 
2.18.0
