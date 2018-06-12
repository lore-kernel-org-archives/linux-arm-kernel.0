From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Tue, 12 Jun 2018 22:00:22 +0200
Subject: [PATCH v2 13/27] drm/sun4i: Don't check for LVDS and RGB when TCON
 has only ch1
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Message-ID: <20180612200036.21483-14-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LVDS and RGB interfaces are always connected to TCONs which have channel
0. It doesn't make sense to try to init them on TV TCONs.

Add a check if TCON has channel 0 before trying to init LVDS or RGB
interface.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 32 ++++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 5dae623968f7..b1205a7bc20f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1117,23 +1117,25 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 		goto err_free_dotclock;
 	}
 
-	/*
-	 * If we have an LVDS panel connected to the TCON, we should
-	 * just probe the LVDS connector. Otherwise, just probe RGB as
-	 * we used to.
-	 */
-	remote = of_graph_get_remote_node(dev->of_node, 1, 0);
-	if (of_device_is_compatible(remote, "panel-lvds"))
-		if (can_lvds)
-			ret = sun4i_lvds_init(drm, tcon);
+	if (tcon->quirks->has_channel_0) {
+		/*
+		 * If we have an LVDS panel connected to the TCON, we should
+		 * just probe the LVDS connector. Otherwise, just probe RGB as
+		 * we used to.
+		 */
+		remote = of_graph_get_remote_node(dev->of_node, 1, 0);
+		if (of_device_is_compatible(remote, "panel-lvds"))
+			if (can_lvds)
+				ret = sun4i_lvds_init(drm, tcon);
+			else
+				ret = -EINVAL;
 		else
-			ret = -EINVAL;
-	else
-		ret = sun4i_rgb_init(drm, tcon);
-	of_node_put(remote);
+			ret = sun4i_rgb_init(drm, tcon);
+		of_node_put(remote);
 
-	if (ret < 0)
-		goto err_free_dotclock;
+		if (ret < 0)
+			goto err_free_dotclock;
+	}
 
 	if (tcon->quirks->needs_de_be_mux) {
 		/*
-- 
2.17.1
