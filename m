From: stefan@agner.ch (Stefan Agner)
Date: Wed, 12 Sep 2018 11:32:15 -0700
Subject: [PATCH v2 1/8] drm/bridge: use bus flags in bridge timings
In-Reply-To: <20180912183222.25414-1-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
Message-ID: <20180912183222.25414-2-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DRM bus flags conveys additional information on pixel data on
the bus. All currently available bus flags might be of interest for
a bridge. In the case at hand a dumb VGA bridge needs a specific
data enable polarity (DRM_BUS_FLAG_DE_LOW).

Replace the sampling_edge field with input_bus_flags and allow all
currently documented bus flags.

This changes the perspective from sampling side to the driving
side for the currently supported flags. We assume that the sampling
edge is always the opposite of the driving edge (hence we need to
invert the DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE flags). This is an
assumption we already make for displays. For all we know it is a
safe assumption for bridges too.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c |  6 +++---
 include/drm/drm_bridge.h              | 11 +++++------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index 9b706789a341..d5aa0f931ef2 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -234,7 +234,7 @@ static int dumb_vga_remove(struct platform_device *pdev)
  */
 static const struct drm_bridge_timings default_dac_timings = {
 	/* Timing specifications, datasheet page 7 */
-	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
 	.setup_time_ps = 500,
 	.hold_time_ps = 1500,
 };
@@ -245,7 +245,7 @@ static const struct drm_bridge_timings default_dac_timings = {
  */
 static const struct drm_bridge_timings ti_ths8134_dac_timings = {
 	/* From timing diagram, datasheet page 9 */
-	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
 	/* From datasheet, page 12 */
 	.setup_time_ps = 3000,
 	/* I guess this means latched input */
@@ -258,7 +258,7 @@ static const struct drm_bridge_timings ti_ths8134_dac_timings = {
  */
 static const struct drm_bridge_timings ti_ths8135_dac_timings = {
 	/* From timing diagram, datasheet page 14 */
-	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
 	/* From datasheet, page 16 */
 	.setup_time_ps = 2000,
 	.hold_time_ps = 500,
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index bd850747ce54..45e90f4b46c3 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -244,14 +244,13 @@ struct drm_bridge_funcs {
  */
 struct drm_bridge_timings {
 	/**
-	 * @sampling_edge:
+	 * @input_bus_flags:
 	 *
-	 * Tells whether the bridge samples the digital input signal
-	 * from the display engine on the positive or negative edge of the
-	 * clock, this should reuse the DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE
-	 * bitwise flags from the DRM connector (bit 2 and 3 valid).
+	 * Additional settings this bridge requires for the pixel data on
+	 * the input bus (e.g. pixel signal polarity). See also
+	 * &drm_display_info->bus_flags.
 	 */
-	u32 sampling_edge;
+	u32 input_bus_flags;
 	/**
 	 * @setup_time_ps:
 	 *
-- 
2.18.0
