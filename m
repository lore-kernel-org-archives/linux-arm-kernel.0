From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 21:22:36 +0100
Subject: [PATCH, RESEND] drm/exynos: clean up dma_addr_t use
Message-ID: <4162061.CKR3sICqgU@wuerfel>
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
I send this one ages ago but never got a reaction. I rebased it several
times when the driver changed, and it still seems to be needed.

diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 3119ababaa13..5279878bbc7f 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -399,7 +399,7 @@ static void decon_update_plane(struct exynos_drm_crtc *crtc,
 	 */
 
 	/* buffer start address */
-	val = (unsigned long)plane->dma_addr[0];
+	val = (u32)plane->dma_addr[0] & 0xffffffff;
 	writel(val, ctx->regs + VIDW_BUF_START(win));
 
 	padding = (pitch / bpp) - state->fb->width;
@@ -412,8 +412,7 @@ static void decon_update_plane(struct exynos_drm_crtc *crtc,
 	writel(plane->src_x, ctx->regs + VIDW_OFFSET_X(win));
 	writel(plane->src_y, ctx->regs + VIDW_OFFSET_Y(win));
 
-	DRM_DEBUG_KMS("start addr = 0x%lx\n",
-			(unsigned long)val);
+	DRM_DEBUG_KMS("start addr = %pad\n", &plane->dma_addr[0]);
 	DRM_DEBUG_KMS("ovl_width = %d, ovl_height = %d\n",
 			plane->crtc_w, plane->crtc_h);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
index fcea28bdbc42..0c47dce643d7 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
@@ -201,7 +201,7 @@ struct exynos_drm_gem *exynos_drm_fb_gem(struct drm_framebuffer *fb, int index)
 	if (!exynos_gem)
 		return NULL;
 
-	DRM_DEBUG_KMS("dma_addr: 0x%lx\n", (unsigned long)exynos_gem->dma_addr);
+	DRM_DEBUG_KMS("dma_addr: %pad\n", &exynos_gem->dma_addr);
 
 	return exynos_gem;
 }
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index ae9727174168..56cf506d1336 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -633,16 +633,16 @@ static void fimd_update_plane(struct exynos_drm_crtc *crtc,
 
 	/* buffer start address */
 	dma_addr = plane->dma_addr[0] + offset;
-	val = (unsigned long)dma_addr;
+	val = (u32)dma_addr & 0xffffffff;
 	writel(val, ctx->regs + VIDWx_BUF_START(win, 0));
 
 	/* buffer end address */
 	size = pitch * plane->crtc_h;
-	val = (unsigned long)(dma_addr + size);
+	val = (u32)((dma_addr + size) & 0xffffffff);
 	writel(val, ctx->regs + VIDWx_BUF_END(win, 0));
 
-	DRM_DEBUG_KMS("start addr = 0x%lx, end addr = 0x%lx, size = 0x%lx\n",
-			(unsigned long)dma_addr, val, size);
+	DRM_DEBUG_KMS("start addr = %pad, end addr = %pad, size = 0x%lx\n",
+			&dma_addr, &val, size);
 	DRM_DEBUG_KMS("ovl_width = %d, ovl_height = %d\n",
 			plane->crtc_w, plane->crtc_h);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index c17efdb238a6..b0a9b362c5b0 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -350,7 +350,7 @@ static void g2d_add_cmdlist_to_inuse(struct exynos_drm_g2d_private *g2d_priv,
 	/* this links to base address of new cmdlist */
 	lnode = list_entry(g2d_priv->inuse_cmdlist.prev,
 				struct g2d_cmdlist_node, list);
-	lnode->cmdlist->data[lnode->cmdlist->last] = node->dma_addr;
+	lnode->cmdlist->data[lnode->cmdlist->last] = node->dma_addr & 0xffffffff;
 
 add_to_list:
 	list_add_tail(&node->list, &g2d_priv->inuse_cmdlist);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index 252eb301470c..666f041ca343 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -89,8 +89,8 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem)
 
 	sg_free_table(&sgt);
 
-	DRM_DEBUG_KMS("dma_addr(0x%lx), size(0x%lx)\n",
-			(unsigned long)exynos_gem->dma_addr, exynos_gem->size);
+	DRM_DEBUG_KMS("dma_addr(%pad), size(0x%lx)\n",
+			&exynos_gem->dma_addr, exynos_gem->size);
 
 	return 0;
 
@@ -114,8 +114,8 @@ static void exynos_drm_free_buf(struct exynos_drm_gem *exynos_gem)
 		return;
 	}
 
-	DRM_DEBUG_KMS("dma_addr(0x%lx), size(0x%lx)\n",
-			(unsigned long)exynos_gem->dma_addr, exynos_gem->size);
+	DRM_DEBUG_KMS("dma_addr(%pad), size(0x%lx)\n",
+			&exynos_gem->dma_addr, exynos_gem->size);
 
 	dma_free_attrs(dev->dev, exynos_gem->size, exynos_gem->cookie,
 			(dma_addr_t)exynos_gem->dma_addr,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
index 67d24236e745..ec2056f91b36 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
@@ -582,8 +582,8 @@ static struct drm_exynos_ipp_mem_node
 
 			buf_info->handles[i] = qbuf->handle[i];
 			buf_info->base[i] = *addr;
-			DRM_DEBUG_KMS("i[%d]base[0x%x]hd[0x%lx]\n", i,
-				      buf_info->base[i], buf_info->handles[i]);
+			DRM_DEBUG_KMS("i[%d]base[%pad]hd[0x%lx]\n", i,
+				      &buf_info->base[i], buf_info->handles[i]);
 		}
 	}
 
