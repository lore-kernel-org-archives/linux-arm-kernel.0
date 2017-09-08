From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  8 Sep 2017 15:50:14 +0800
Subject: [PATCH 6/8] drm/sun4i: tcon: Support backend input mux
In-Reply-To: <20170908075016.18657-1-wens@csie.org>
References: <20170908075016.18657-1-wens@csie.org>
Message-ID: <20170908075016.18657-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TCON has a mux to select the source of the data to display.
This mux includes selecting the display backends. On the A31,
which has two display pipelines, this mux can let the TCON
select either backend as its data source. Although the muxing
can be changed on the fly, DRM needs to be able to group a
bunch of layers such that they get switched to another crtc
together. This is because the display backend does the layer
compositing, while the TCON generates the display timings.
This constraint is not supported by DRM.

Here we simply pair up backends and TCONs with the same ID.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 25 +++++++++++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  3 +++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index e9ab03f0bf6e..0951e3f0a35e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -701,6 +701,25 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	if (ret < 0)
 		goto err_free_clocks;
 
+	if (tcon->quirks->needs_de_be_mux) {
+		/*
+		 * We assume there is no dynamic muxing of backends
+		 * and TCONs, so we select the backend with same ID.
+		 *
+		 * While dynamic selection might be interesting, since
+		 * the CRTC is tied to the TCON, while the layers are
+		 * tied to the backends, this means, we will need to
+		 * switch between groups of layers. There might not be
+		 * a way to represent this constraint in DRM.
+		 */
+		regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
+				   SUN4I_TCON0_CTL_SRC_SEL_MASK,
+				   tcon->id);
+		regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
+				   SUN4I_TCON1_CTL_SRC_SEL_MASK,
+				   tcon->id);
+	}
+
 	list_add_tail(&tcon->list, &drv->tcon_list);
 
 	return 0;
@@ -756,11 +775,13 @@ static const struct sun4i_tcon_quirks sun5i_a13_quirks = {
 };
 
 static const struct sun4i_tcon_quirks sun6i_a31_quirks = {
-	.has_channel_1	= true,
+	.has_channel_1		= true,
+	.needs_de_be_mux	= true,
 };
 
 static const struct sun4i_tcon_quirks sun6i_a31s_quirks = {
-	.has_channel_1	= true,
+	.has_channel_1		= true,
+	.needs_de_be_mux	= true,
 };
 
 static const struct sun4i_tcon_quirks sun8i_a33_quirks = {
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 552c88ec16be..5a219d1ccc26 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -37,6 +37,7 @@
 #define SUN4I_TCON0_CTL_TCON_ENABLE			BIT(31)
 #define SUN4I_TCON0_CTL_CLK_DELAY_MASK			GENMASK(8, 4)
 #define SUN4I_TCON0_CTL_CLK_DELAY(delay)		((delay << 4) & SUN4I_TCON0_CTL_CLK_DELAY_MASK)
+#define SUN4I_TCON0_CTL_SRC_SEL_MASK			GENMASK(2, 0)
 
 #define SUN4I_TCON0_DCLK_REG			0x44
 #define SUN4I_TCON0_DCLK_GATE_BIT			(31)
@@ -85,6 +86,7 @@
 #define SUN4I_TCON1_CTL_INTERLACE_ENABLE		BIT(20)
 #define SUN4I_TCON1_CTL_CLK_DELAY_MASK			GENMASK(8, 4)
 #define SUN4I_TCON1_CTL_CLK_DELAY(delay)		((delay << 4) & SUN4I_TCON1_CTL_CLK_DELAY_MASK)
+#define SUN4I_TCON1_CTL_SRC_SEL_MASK			GENMASK(1, 0)
 
 #define SUN4I_TCON1_BASIC0_REG			0x94
 #define SUN4I_TCON1_BASIC0_X(width)			((((width) - 1) & 0xfff) << 16)
@@ -146,6 +148,7 @@
 struct sun4i_tcon_quirks {
 	bool	has_unknown_mux; /* sun5i has undocumented mux */
 	bool	has_channel_1;	/* a33 does not have channel 1 */
+	bool	needs_de_be_mux; /* sun6i needs mux to select backend */
 };
 
 struct sun4i_tcon {
-- 
2.14.1
