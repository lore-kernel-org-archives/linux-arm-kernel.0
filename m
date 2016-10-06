From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  7 Oct 2016 00:06:24 +0800
Subject: [PATCH 4/9] drm/sun4i: Add compatible string for A31/A31s TCON
 (timing controller)
In-Reply-To: <20161006160629.11198-1-wens@csie.org>
References: <20161006160629.11198-1-wens@csie.org>
Message-ID: <20161006160629.11198-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 TCON has mux controls for how TCON outputs are routed to the
HDMI and MIPI DSI blocks.

Since the A31s does not have MIPI DSI, it only has a mux for the HDMI
controller input.

This patch only adds support for the compatible strings. Actual support
for the mux controls should be added with HDMI and MIPI DSI support.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/display/sunxi/sun4i-drm.txt     |  4 +++-
 drivers/gpu/drm/sun4i/sun4i_drv.c                       |  2 ++
 drivers/gpu/drm/sun4i/sun4i_tcon.c                      | 17 +++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h                      |  2 ++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 5368961cd727..15fdca8909f2 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -28,6 +28,8 @@ The TCON acts as a timing controller for RGB, LVDS and TV interfaces.
 Required properties:
  - compatible: value must be either:
    * allwinner,sun5i-a13-tcon
+   * allwinner,sun6i-a31-tcon
+   * allwinner,sun6i-a31s-tcon
    * allwinner,sun8i-a33-tcon
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
@@ -50,7 +52,7 @@ Required properties:
   second the block connected to the TCON channel 1 (usually the TV
   encoder)
 
-On the A13, there is one more clock required:
+On SoCs other than the A33, there is one more clock required:
    - 'tcon-ch1': The clock driving the TCON channel 1
 
 DRC
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index c4d03c1b6db8..35af3728c4ee 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -206,6 +206,8 @@ static bool sun4i_drv_node_is_frontend(struct device_node *node)
 static bool sun4i_drv_node_is_tcon(struct device_node *node)
 {
 	return of_device_is_compatible(node, "allwinner,sun5i-a13-tcon") ||
+		of_device_is_compatible(node, "allwinner,sun6i-a31-tcon") ||
+		of_device_is_compatible(node, "allwinner,sun6i-a31s-tcon") ||
 		of_device_is_compatible(node, "allwinner,sun8i-a33-tcon");
 }
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 5a5407193753..745708f85ab6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -590,6 +590,21 @@ const struct sun4i_tcon_quirks sun5i_a13_quirks = {
 	.has_dma_src	= true,
 };
 
+const struct sun4i_tcon_quirks sun6i_a31_quirks = {
+	.max_clock	= 200000,
+	.has_channel_1	= true,
+	.has_dma_src	= true,
+	.has_hdmi_mux	= true,
+	.has_dsi_mux	= true,
+};
+
+const struct sun4i_tcon_quirks sun6i_a31s_quirks = {
+	.max_clock	= 200000,
+	.has_channel_1	= true,
+	.has_dma_src	= true,
+	.has_hdmi_mux	= true,
+};
+
 const struct sun4i_tcon_quirks sun8i_a33_quirks = {
 	.max_clock	= 200000,
 	/* nothing is supported */
@@ -597,6 +612,8 @@ const struct sun4i_tcon_quirks sun8i_a33_quirks = {
 
 static const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun5i-a13-tcon", .data = &sun5i_a13_quirks },
+	{ .compatible = "allwinner,sun6i-a31-tcon", .data = &sun6i_a31_quirks },
+	{ .compatible = "allwinner,sun6i-a31s-tcon", .data = &sun6i_a31s_quirks },
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
 	{ }
 };
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 972ca2b7c8c2..deebb97e9c3f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -148,6 +148,8 @@ struct sun4i_tcon_quirks {
 	bool	has_channel_1;	/* a33 does not have channel 1 */
 	bool	has_bypass_src;	/* has separate input bypassing CEU */
 	bool	has_dma_src;	/* has DMA input */
+	bool	has_hdmi_mux;	/* HDMI source selector */
+	bool	has_dsi_mux;	/* MIPI DSI source selector */
 };
 
 struct sun4i_tcon {
-- 
2.9.3
