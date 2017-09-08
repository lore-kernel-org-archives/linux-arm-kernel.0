From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  8 Sep 2017 15:50:11 +0800
Subject: [PATCH 3/8] drm/sun4i: tcon: Check for multiple paths between TCONs
 and backends
In-Reply-To: <20170908075016.18657-1-wens@csie.org>
References: <20170908075016.18657-1-wens@csie.org>
Message-ID: <20170908075016.18657-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch b317fa3ba11a ("drm/sun4i: tcon: Find matching display backend
by device node matching") assumed a one-to-one mapping between TCONs
and backends. This turned out wrong, as we found muxing controls in the
TCON of the A31, and undocumented usage of the backend output selector
of the A20.

Make sun4i_tcon_find_engine() bail out if the current node has multiple
input connections.

Fixes: b317fa3ba11a ("drm/sun4i: tcon: Find matching display backend
		      by device node matching")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index eb32676d5b01..065654dbfb2c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -473,6 +473,20 @@ static struct sunxi_engine *sun4i_tcon_find_engine(struct sun4i_drv *drv,
 	if (!port)
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * This only works if there is only one path from the TCON
+	 * to any display engine. Otherwise the probe order of the
+	 * TCONs and display engines is not guaranteed. They may
+	 * either bind to the wrong one, or worse, bind to the same
+	 * one if additional checks are not done.
+	 *
+	 * Bail out if there are multiple input connections.
+	 */
+	if (of_get_available_child_count(port) != 1) {
+		of_node_put(port);
+		return ERR_PTR(-EINVAL);
+	}
+
 	for_each_available_child_of_node(port, ep) {
 		remote = of_graph_get_remote_port_parent(ep);
 		if (!remote)
-- 
2.14.1
