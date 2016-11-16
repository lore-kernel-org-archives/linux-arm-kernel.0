From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 16 Nov 2016 17:37:31 +0800
Subject: [PATCH] drm/sun4i: Only count TCON endpoints as valid outputs
Message-ID: <20161116093732.12828-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun4i DRM driver counts the number of endpoints it found and
registers the whole DRM pipeline if any endpoints are found.

However, if the TCON and its child endpoints (LCD panels, TV encoder,
HDMI encoder, MIPI DSI encoder, etc.) aren't found, that means we
don't have any usable CRTCs, and the display pipeline is incomplete
and useless. The whole DRM display pipeline should only be registered
and enabled if there are proper outputs available.

The debug message "Queued %d outputs on pipeline %d\n" is also telling.

This patch makes the driver only count enabled TCON endpoints. If
none are found, the DRM pipeline is not used. This avoids screwing
up the simple framebuffer provided by the bootloader in cases where
we aren't able to support the display with the DRM subsystem, due
to lack of panel or bridge drivers, or just lack of progress.

Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi Maxime,

This avoids DRM screwing up simplefb on my SinA31s, which does not
have the display pipeline enabled in its dts file. But the display
engine and backend are already enabled in the dtsi.

I think this is a better and proper (for the driver) fix. The
alternative would be to disable the display-engine node in the dts
by default. Last time I asked you wanted to have them enabled by
default?

It may also be possible to push the check further down, and check
against panel and encoder endpoints, but I think that complicates
things. The TCON is a necessary part of the output.

ChenYu

---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index c3b21865443e..3603f34901b6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -243,9 +243,12 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 		DRM_DEBUG_DRIVER("Adding component %s\n",
 				 of_node_full_name(node));
 		component_match_add(dev, match, compare_of, node);
-		count++;
 	}
 
+	/* Only count the tcon as an output */
+	if (sun4i_drv_node_is_tcon(node))
+		count++;
+
 	/* Inputs are listed first, then outputs */
 	port = of_graph_get_port_by_id(node, 1);
 	if (!port) {
-- 
2.10.2
