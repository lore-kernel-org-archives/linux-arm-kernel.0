From: stefan@agner.ch (Stefan Agner)
Date: Tue,  4 Sep 2018 22:21:08 -0700
Subject: [PATCH 1/6] drm/bridge: use bus flags in bridge timings
Message-ID: <20180905052113.21262-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DRM bus flags convey additional information on pixel data on
the bus. All current available bus flags might be of interest for
a bridge. Remove the sampling_edge field and use bus_flags.

In the case at hand a dumb VGA bridge needs a specific data enable
polarity (DRM_BUS_FLAG_DE_LOW).

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c |  6 +++---
 include/drm/drm_bridge.h              | 11 +++++------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index 9b706789a341..7a5c24967115 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -234,7 +234,7 @@ static int dumb_vga_remove(struct platform_device *pdev)
  */
 static const struct drm_bridge_timings default_dac_timings = {
 	/* Timing specifications, datasheet page 7 */
-	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_POSEDGE,
 	.setup_time_ps = 500,
 	.hold_time_ps = 1500,
 };
@@ -245,7 +245,7 @@ static const struct drm_bridge_timings default_dac_timings = {
  */
 static const struct drm_bridge_timings ti_ths8134_dac_timings = {
 	/* From timing diagram, datasheet page 9 */
-	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_POSEDGE,
 	/* From datasheet, page 12 */
 	.setup_time_ps = 3000,
 	/* I guess this means latched input */
@@ -258,7 +258,7 @@ static const struct drm_bridge_timings ti_ths8134_dac_timings = {
  */
 static const struct drm_bridge_timings ti_ths8135_dac_timings = {
 	/* From timing diagram, datasheet page 14 */
-	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_POSEDGE,
 	/* From datasheet, page 16 */
 	.setup_time_ps = 2000,
 	.hold_time_ps = 500,
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index bd850747ce54..85d4b51eae19 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -244,14 +244,13 @@ struct drm_bridge_funcs {
  */
 struct drm_bridge_timings {
 	/**
-	 * @sampling_edge:
+	 * @bus_flags:
 	 *
-	 * Tells whether the bridge samples the digital input signal
-	 * from the display engine on the positive or negative edge of the
-	 * clock, this should reuse the DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE
-	 * bitwise flags from the DRM connector (bit 2 and 3 valid).
+	 * Tells what additional settings for the pixel data on the bus
+	 * this bridge requires (like pixel signal polarity). See also
+	 * &drm_display_info->bus_flags.
 	 */
-	u32 sampling_edge;
+	u32 bus_flags;
 	/**
 	 * @setup_time_ps:
 	 *
-- 
2.18.0
