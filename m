From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Feb 2015 09:55:48 +0100
Subject: [PATCH v2] drm: exynos: clean up dma_addr_t use
Message-ID: <2659839.sUGysve8VL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_addr_t may be 32 or 64 bits long on 32-bit CPUs, so we cannot
cast it to a pointer without getting a compiler warning:

drivers/gpu/drm/exynos/exynos_drm_buf.c: In function 'lowlevel_buffer_allocate':
drivers/gpu/drm/exynos/exynos_drm_buf.c:109:18: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  buf->dma_addr = (dma_addr_t)NULL;
                  ^

The use of pointers is wrong here anyway, and so is the cast
to the same type, and printing the value as a 32-bit instance.

This patch tries for address all these issues in the exynos
drm driver, by printing the values as %pad and removing the
bogus type casts.

I've added '& 0xffffffff' masks in a few places I found where
a dma_addr_t is assigned to a 32-bit value, as a reminder that
this code will not work with 64-bit dma addresses. There should
not be any change in the generated code here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix incorrect conversion in fimd_win_commit()

diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 63f02e2380ae..0512157b065f 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -335,7 +335,7 @@ static void decon_win_mode_set(struct exynos_drm_crtc *crtc,
 			win_data->offset_x, win_data->offset_y);
 	DRM_DEBUG_KMS("ovl_width = %d, ovl_height = %d\n",
 			win_data->ovl_width, win_data->ovl_height);
-	DRM_DEBUG_KMS("paddr = 0x%lx\n", (unsigned long)win_data->dma_addr);
+	DRM_DEBUG_KMS("paddr = %pad\n", &win_data->dma_addr);
 	DRM_DEBUG_KMS("fb_width = %d, crtc_width = %d\n",
 			plane->fb_width, plane->crtc_width);
 }
@@ -490,7 +490,7 @@ static void decon_win_commit(struct exynos_drm_crtc *crtc, int zpos)
 	decon_shadow_protect_win(ctx, win, true);
 
 	/* buffer start address */
-	val = (unsigned long)win_data->dma_addr;
+	val = win_data->dma_addr & 0xffffffff;
 	writel(val, ctx->regs + VIDW_BUF_START(win));
 
 	/* buffer size */
@@ -501,8 +501,7 @@ static void decon_win_commit(struct exynos_drm_crtc *crtc, int zpos)
 	writel(win_data->offset_x, ctx->regs + VIDW_OFFSET_X(win));
 	writel(win_data->offset_y, ctx->regs + VIDW_OFFSET_Y(win));
 
-	DRM_DEBUG_KMS("start addr = 0x%lx\n",
-			(unsigned long)win_data->dma_addr);
+	DRM_DEBUG_KMS("start addr = %pad\n", &win_data->dma_addr);
 	DRM_DEBUG_KMS("ovl_width = %d, ovl_height = %d\n",
 			win_data->ovl_width, win_data->ovl_height);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_buf.c b/drivers/gpu/drm/exynos/exynos_drm_buf.c
index 24994ba10e28..935157e65236 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_buf.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_buf.c
@@ -97,16 +97,15 @@ static int lowlevel_buffer_allocate(struct drm_device *dev,
 		goto err_free_attrs;
 	}
 
-	DRM_DEBUG_KMS("dma_addr(0x%lx), size(0x%lx)\n",
-			(unsigned long)buf->dma_addr,
-			buf->size);
+	DRM_DEBUG_KMS("dma_addr(%pad), size(0x%lx)\n",
+			&buf->dma_addr, buf->size);
 
 	return ret;
 
 err_free_attrs:
 	dma_free_attrs(dev->dev, buf->size, buf->pages,
-			(dma_addr_t)buf->dma_addr, &buf->dma_attrs);
-	buf->dma_addr = (dma_addr_t)NULL;
+		       buf->dma_addr, &buf->dma_attrs);
+	buf->dma_addr = 0;
 err_free:
 	if (!is_drm_iommu_supported(dev))
 		drm_free_large(buf->pages);
@@ -122,9 +121,8 @@ static void lowlevel_buffer_deallocate(struct drm_device *dev,
 		return;
 	}
 
-	DRM_DEBUG_KMS("dma_addr(0x%lx), size(0x%lx)\n",
-			(unsigned long)buf->dma_addr,
-			buf->size);
+	DRM_DEBUG_KMS("dma_addr(%pad), size(0x%lx)\n",
+		      &buf->dma_addr, buf->size);
 
 	sg_free_table(buf->sgt);
 
@@ -133,13 +131,13 @@ static void lowlevel_buffer_deallocate(struct drm_device *dev,
 
 	if (!is_drm_iommu_supported(dev)) {
 		dma_free_attrs(dev->dev, buf->size, buf->cookie,
-				(dma_addr_t)buf->dma_addr, &buf->dma_attrs);
+			       buf->dma_addr, &buf->dma_attrs);
 		drm_free_large(buf->pages);
 	} else
 		dma_free_attrs(dev->dev, buf->size, buf->pages,
-				(dma_addr_t)buf->dma_addr, &buf->dma_attrs);
+			       buf->dma_addr, &buf->dma_attrs);
 
-	buf->dma_addr = (dma_addr_t)NULL;
+	buf->dma_addr = 0;
 }
 
 struct exynos_drm_gem_buf *exynos_drm_init_buf(struct drm_device *dev,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
index d346d1e6eda0..b259c1bf8752 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
@@ -290,7 +290,7 @@ struct exynos_drm_gem_buf *exynos_drm_fb_buffer(struct drm_framebuffer *fb,
 	if (!buffer)
 		return NULL;
 
-	DRM_DEBUG_KMS("dma_addr = 0x%lx\n", (unsigned long)buffer->dma_addr);
+	DRM_DEBUG_KMS("dma_addr = %pad\n", &buffer->dma_addr);
 
 	return buffer;
 }
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 925fc69af1a0..cb1c003c6479 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -550,7 +550,7 @@ static void fimd_win_mode_set(struct exynos_drm_crtc *crtc,
 			win_data->offset_x, win_data->offset_y);
 	DRM_DEBUG_KMS("ovl_width = %d, ovl_height = %d\n",
 			win_data->ovl_width, win_data->ovl_height);
-	DRM_DEBUG_KMS("paddr = 0x%lx\n", (unsigned long)win_data->dma_addr);
+	DRM_DEBUG_KMS("paddr = %pad\n", &win_data->dma_addr);
 	DRM_DEBUG_KMS("fb_width = %d, crtc_width = %d\n",
 			plane->fb_width, plane->crtc_width);
 }
@@ -671,6 +671,7 @@ static void fimd_win_commit(struct exynos_drm_crtc *crtc, int zpos)
 	struct fimd_win_data *win_data;
 	int win = zpos;
 	unsigned long val, alpha, size;
+	dma_addr_t end;
 	unsigned int last_x;
 	unsigned int last_y;
 
@@ -705,16 +706,16 @@ static void fimd_win_commit(struct exynos_drm_crtc *crtc, int zpos)
 	fimd_shadow_protect_win(ctx, win, true);
 
 	/* buffer start address */
-	val = (unsigned long)win_data->dma_addr;
+	val = (u32)win_data->dma_addr & 0xffffffff;
 	writel(val, ctx->regs + VIDWx_BUF_START(win, 0));
 
 	/* buffer end address */
 	size = win_data->fb_width * win_data->ovl_height * (win_data->bpp >> 3);
-	val = (unsigned long)(win_data->dma_addr + size);
+	end = win_data->dma_addr + size;
 	writel(val, ctx->regs + VIDWx_BUF_END(win, 0));
 
-	DRM_DEBUG_KMS("start addr = 0x%lx, end addr = 0x%lx, size = 0x%lx\n",
-			(unsigned long)win_data->dma_addr, val, size);
+	DRM_DEBUG_KMS("start addr = %pad, end addr = %pad, size = 0x%lx\n",
+			&win_data->dma_addr, &end, size);
 	DRM_DEBUG_KMS("ovl_width = %d, ovl_height = %d\n",
 			win_data->ovl_width, win_data->ovl_height);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 81a250830808..8f9b025bdf72 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -348,7 +348,7 @@ static void g2d_add_cmdlist_to_inuse(struct exynos_drm_g2d_private *g2d_priv,
 	/* this links to base address of new cmdlist */
 	lnode = list_entry(g2d_priv->inuse_cmdlist.prev,
 				struct g2d_cmdlist_node, list);
-	lnode->cmdlist->data[lnode->cmdlist->last] = node->dma_addr;
+	lnode->cmdlist->data[lnode->cmdlist->last] = node->dma_addr & 0xffffffff;
 
 add_to_list:
 	list_add_tail(&node->list, &g2d_priv->inuse_cmdlist);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
index d5ad17dfc24d..0b9cdd3b11d8 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
@@ -546,8 +546,8 @@ static struct drm_exynos_ipp_mem_node
 
 			buf_info->handles[i] = qbuf->handle[i];
 			buf_info->base[i] = *addr;
-			DRM_DEBUG_KMS("i[%d]base[0x%x]hd[0x%lx]\n", i,
-				      buf_info->base[i], buf_info->handles[i]);
+			DRM_DEBUG_KMS("i[%d]base[%pad]hd[0x%lx]\n", i,
+				      &buf_info->base[i], buf_info->handles[i]);
 		}
 	}
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index a5616872eee7..027ff93fd9ca 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -78,8 +78,8 @@ int exynos_check_plane(struct drm_plane *plane, struct drm_framebuffer *fb)
 
 		exynos_plane->dma_addr[i] = buffer->dma_addr;
 
-		DRM_DEBUG_KMS("buffer: %d, dma_addr = 0x%lx\n",
-				i, (unsigned long)exynos_plane->dma_addr[i]);
+		DRM_DEBUG_KMS("buffer: %d, dma_addr = %pad\n",
+				i, &exynos_plane->dma_addr[i]);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index b886972b5888..1617088fc451 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -191,7 +191,7 @@ static void vidi_win_mode_set(struct exynos_drm_crtc *crtc,
 			win_data->offset_x, win_data->offset_y);
 	DRM_DEBUG_KMS("ovl_width = %d, ovl_height = %d\n",
 			win_data->ovl_width, win_data->ovl_height);
-	DRM_DEBUG_KMS("paddr = 0x%lx\n", (unsigned long)win_data->dma_addr);
+	DRM_DEBUG_KMS("paddr = %pad\n", &win_data->dma_addr);
 	DRM_DEBUG_KMS("fb_width = %d, crtc_width = %d\n",
 			plane->fb_width, plane->crtc_width);
 }
