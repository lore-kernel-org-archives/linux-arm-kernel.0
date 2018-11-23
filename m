From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:25:06 +0100
Subject: [PATCH v2 34/43] drm/sun4i: Add buffer stride and offset
 configuration for tiling mode
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-35-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces stride and offset configuration for the VPU tiling mode.
Stride is calculated differently than it is for linear formats and an
offset is calculated, for which new register definitions are introduced.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 54 ++++++++++++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  7 ++++
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index efa1ff0802bd..3f76a5572449 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -125,21 +125,69 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
+	unsigned int strides[3] = {};
+
 	dma_addr_t paddr;
 	bool swap;
 
+	if (fb->modifier == DRM_FORMAT_MOD_ALLWINNER_TILED) {
+		unsigned int width = state->src_w >> 16;
+		unsigned int offset;
+
+		/*
+		 * In MB32 tiled mode, the stride is defined as the distance
+		 * between the start of the end line of the current tile and
+		 * the start of the first line in the next vertical tile.
+		 *
+		 * Tiles are represented in row-major order, thus the end line
+		 * of current tile starts at: 31 * 32 (31 lines of 32 cols),
+		 * the next vertical tile starts at: 32-bit-aligned-width * 32
+		 * and the distance is: 32 * (32-bit-aligned-width - 31).
+		 */
+
+		strides[0] = (fb->pitches[0] - 31) * 32;
+
+		/* Offset of the bottom-right point in the end tile. */
+		offset = (width + (32 - 1)) & (32 - 1);
+
+		regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF0_REG,
+			     SUN4I_FRONTEND_TB_OFF_X1(offset));
+
+		if (fb->format->num_planes > 1) {
+			strides[1] = (fb->pitches[1] - 31) * 32;
+
+			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF1_REG,
+				     SUN4I_FRONTEND_TB_OFF_X1(offset));
+		}
+
+		if (fb->format->num_planes > 2) {
+			strides[2] = (fb->pitches[2] - 31) * 32;
+
+			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF2_REG,
+				     SUN4I_FRONTEND_TB_OFF_X1(offset));
+		}
+	} else {
+		strides[0] = fb->pitches[0];
+
+		if (fb->format->num_planes > 1)
+			strides[1] = fb->pitches[1];
+
+		if (fb->format->num_planes > 2)
+			strides[2] = fb->pitches[2];
+	}
+
 	/* Set the line width */
 	DRM_DEBUG_DRIVER("Frontend stride: %d bytes\n", fb->pitches[0]);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD0_REG,
-		     fb->pitches[0]);
+		     strides[0]);
 
 	if (fb->format->num_planes > 1)
 		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD1_REG,
-			     fb->pitches[1]);
+			     strides[1]);
 
 	if (fb->format->num_planes > 2)
 		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD2_REG,
-			     fb->pitches[2]);
+			     strides[2]);
 
 	/* Some planar formats require chroma channel swapping by hand. */
 	swap = sun4i_frontend_format_chroma_requires_swap(fb->format->format);
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index ae53ee644694..822d39ca4b8e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -25,6 +25,13 @@
 #define SUN4I_FRONTEND_BUF_ADDR1_REG		0x024
 #define SUN4I_FRONTEND_BUF_ADDR2_REG		0x028
 
+#define SUN4I_FRONTEND_TB_OFF0_REG		0x030
+#define SUN4I_FRONTEND_TB_OFF1_REG		0x034
+#define SUN4I_FRONTEND_TB_OFF2_REG		0x038
+#define SUN4I_FRONTEND_TB_OFF_X1(x1)			((x1) << 16)
+#define SUN4I_FRONTEND_TB_OFF_Y0(y0)			((y0) << 8)
+#define SUN4I_FRONTEND_TB_OFF_X0(x0)			(x0)
+
 #define SUN4I_FRONTEND_LINESTRD0_REG		0x040
 #define SUN4I_FRONTEND_LINESTRD1_REG		0x044
 #define SUN4I_FRONTEND_LINESTRD2_REG		0x048
-- 
2.19.1
