From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 16 Mar 2016 14:57:43 +0100
Subject: [PATCH v2 9/9] drm: atmel-hlcdc: route DMA accesses through AHB
 interfaces
In-Reply-To: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1458136663-21396-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In relation with the actuall bandwidth consumed on a DMA Source interface,
choose the less used one for a created plane.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c  |  6 +++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 43 +++++++++++++++++++++++--
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index cbba029..14e74e5 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -319,7 +319,11 @@ static int atmel_hlcdc_crtc_atomic_check(struct drm_crtc *c,
 	if (ret)
 		return ret;
 
-	return atmel_hlcdc_plane_prepare_disc_area(s);
+	ret = atmel_hlcdc_plane_prepare_disc_area(s);
+	if (ret)
+		return ret;
+
+	return atmel_hlcdc_plane_prepare_ahb_routing(s);
 }
 
 static void atmel_hlcdc_crtc_atomic_begin(struct drm_crtc *c,
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 302c958..c71a300 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -165,6 +165,7 @@ struct atmel_hlcdc_planes *
 atmel_hlcdc_create_planes(struct drm_device *dev);
 
 int atmel_hlcdc_plane_prepare_disc_area(struct drm_crtc_state *c_state);
+int atmel_hlcdc_plane_prepare_ahb_routing(struct drm_crtc_state *c_state);
 
 void atmel_hlcdc_crtc_irq(struct drm_crtc *c);
 
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 35027d0..0995eef 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -58,6 +58,8 @@ struct atmel_hlcdc_plane_state {
 	int disc_w;
 	int disc_h;
 
+	int ahb_id;
+
 	/* These fields are private and should not be touched */
 	int bpp[ATMEL_HLCDC_MAX_PLANES];
 	unsigned int offsets[ATMEL_HLCDC_MAX_PLANES];
@@ -359,8 +361,10 @@ atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
 
 	atmel_hlcdc_layer_update_cfg(&plane->layer,
 				     ATMEL_HLCDC_LAYER_DMA_CFG_ID,
-				     ATMEL_HLCDC_LAYER_DMA_BLEN_MASK,
-				     ATMEL_HLCDC_LAYER_DMA_BLEN_INCR16);
+				     ATMEL_HLCDC_LAYER_DMA_BLEN_MASK |
+				     ATMEL_HLCDC_LAYER_DMA_SIF,
+				     ATMEL_HLCDC_LAYER_DMA_BLEN_INCR16 |
+				     state->ahb_id);
 
 	atmel_hlcdc_layer_update_cfg(&plane->layer, layout->general_config,
 				     ATMEL_HLCDC_LAYER_ITER2BL |
@@ -435,6 +439,41 @@ static void atmel_hlcdc_plane_update_buffers(struct atmel_hlcdc_plane *plane,
 	}
 }
 
+int atmel_hlcdc_plane_prepare_ahb_routing(struct drm_crtc_state *c_state)
+{
+	unsigned int ahb_load[2] = { };
+	struct drm_plane *plane;
+
+	drm_atomic_crtc_state_for_each_plane(plane, c_state) {
+		struct atmel_hlcdc_plane_state *plane_state;
+		struct drm_plane_state *plane_s;
+		unsigned int pixels, load = 0;
+		int i;
+
+		plane_s = drm_atomic_get_plane_state(c_state->state, plane);
+		if (IS_ERR(plane_s))
+			return PTR_ERR(plane_s);
+
+		plane_state =
+			drm_plane_state_to_atmel_hlcdc_plane_state(plane_s);
+
+		pixels = (plane_state->src_w * plane_state->src_h) -
+			 (plane_state->disc_w * plane_state->disc_h);
+
+		for (i = 0; i < plane_state->nplanes; i++)
+			load += pixels * plane_state->bpp[i];
+
+		if (ahb_load[0] <= ahb_load[1])
+			plane_state->ahb_id = 0;
+		else
+			plane_state->ahb_id = 1;
+
+		ahb_load[plane_state->ahb_id] += load;
+	}
+
+	return 0;
+}
+
 int
 atmel_hlcdc_plane_prepare_disc_area(struct drm_crtc_state *c_state)
 {
-- 
2.5.0
