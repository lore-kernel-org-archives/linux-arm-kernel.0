From: yannick.fertre@st.com (Yannick Fertre)
Date: Tue, 28 Mar 2017 11:44:45 +0200
Subject: [PATCH v5 02/10] drm/fb-cma-helper: Add drm_fb_cma_get_gem_addr()
In-Reply-To: <1490694293-18358-1-git-send-email-yannick.fertre@st.com>
References: <1490694293-18358-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1490694293-18358-3-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add function drm_fb_cma_get_gem_addr() which return the physical address
of framebuffer (1st pixel). This function will usually be called by plane
callback (atomic_update).

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/gpu/drm/drm_fb_cma_helper.c | 27 +++++++++++++++++++++++++++
 include/drm/drm_fb_cma_helper.h     |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
index 74cd393..126f52a 100644
--- a/drivers/gpu/drm/drm_fb_cma_helper.c
+++ b/drivers/gpu/drm/drm_fb_cma_helper.c
@@ -260,6 +260,33 @@ struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct drm_framebuffer *fb,
 EXPORT_SYMBOL_GPL(drm_fb_cma_get_gem_obj);
 
 /**
+ * drm_fb_cma_get_gem_addr() - Get physical address for framebuffer
+ * @fb: The framebuffer
+ * @state: Which state of drm plane
+ * @plane: Which plane
+ * Return the CMA GEM address for given framebuffer.
+ *
+ * This function will usually be called from the PLANE callback functions.
+ */
+dma_addr_t drm_fb_cma_get_gem_addr(struct drm_framebuffer *fb,
+				   struct drm_plane_state *state,
+				   unsigned int plane)
+{
+	struct drm_fb_cma *fb_cma = to_fb_cma(fb);
+	dma_addr_t paddr;
+
+	if (plane >= 4)
+		return 0;
+
+	paddr = fb_cma->obj[plane]->paddr + fb->offsets[plane];
+	paddr += fb->format->cpp[plane] * (state->src_x >> 16);
+	paddr += fb->pitches[plane] * (state->src_y >> 16);
+
+	return paddr;
+}
+EXPORT_SYMBOL_GPL(drm_fb_cma_get_gem_addr);
+
+/**
  * drm_fb_cma_prepare_fb() - Prepare CMA framebuffer
  * @plane: Which plane
  * @state: Plane state attach fence to
diff --git a/include/drm/drm_fb_cma_helper.h b/include/drm/drm_fb_cma_helper.h
index a5ecc0a..199a63f 100644
--- a/include/drm/drm_fb_cma_helper.h
+++ b/include/drm/drm_fb_cma_helper.h
@@ -41,6 +41,10 @@ struct drm_framebuffer *drm_fb_cma_create(struct drm_device *dev,
 struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct drm_framebuffer *fb,
 	unsigned int plane);
 
+dma_addr_t drm_fb_cma_get_gem_addr(struct drm_framebuffer *fb,
+				   struct drm_plane_state *state,
+				   unsigned int plane);
+
 int drm_fb_cma_prepare_fb(struct drm_plane *plane,
 			  struct drm_plane_state *state);
 
-- 
1.9.1
