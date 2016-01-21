From: john@metanate.com (John Keeping)
Date: Thu, 21 Jan 2016 18:19:34 +0000
Subject: [PATCH v2] drm/rockchip: respect CONFIG_DRM_FBDEV_EMULATION
In-Reply-To: <20160121165251.GO19130@phenom.ffwll.local>
References: <1453384426-32617-1-git-send-email-john@metanate.com>
 <20160121165251.GO19130@phenom.ffwll.local>
Message-ID: <20160121181934.76cb2c03.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If DRM_FBDEV_EMULATION is not selected in the config then we can save a
bit of space by not including the framebuffer code.

Signed-off-by: John Keeping <john@metanate.com>
---
On Thu, 21 Jan 2016 17:52:51 +0100, Daniel Vetter wrote:

> On Thu, Jan 21, 2016 at 01:53:46PM +0000, John Keeping wrote:
> > If DRM_FBDEV_EMULATION is not selected in the config then we should not
> > setup a framebuffer console.  
> 
> It should just magically work, and this patch here just removes a bit more
> dead code in the rockchip driver itself that's not needed in case fbdev
> emulation is disabled.
> 
> Can you please double-check this is the case and then resend with a
> clarified commit message?

You're right, it does work without this change, so this is just to save
a bit of space when we don't need this feature.

v2:
- change commit message to clarify that this is only to remove some dead
  code

 drivers/gpu/drm/rockchip/Makefile             |  3 ++-
 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.h | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index a4e03bc..f6a809a 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -2,8 +2,9 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o rockchip_drm_fbdev.o \
+rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o \
 		rockchip_drm_gem.o rockchip_drm_vop.o
+rockchipdrm-$(CONFIG_DRM_FBDEV_EMULATION) += rockchip_drm_fbdev.o
 
 obj-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
 obj-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.h b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.h
index 50432e9..73718c5 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.h
@@ -15,7 +15,18 @@
 #ifndef _ROCKCHIP_DRM_FBDEV_H
 #define _ROCKCHIP_DRM_FBDEV_H
 
+#ifdef CONFIG_DRM_FBDEV_EMULATION
 int rockchip_drm_fbdev_init(struct drm_device *dev);
 void rockchip_drm_fbdev_fini(struct drm_device *dev);
+#else
+static inline int rockchip_drm_fbdev_init(struct drm_device *dev)
+{
+	return 0;
+}
+
+static inline void rockchip_drm_fbdev_fini(struct drm_device *dev)
+{
+}
+#endif
 
 #endif /* _ROCKCHIP_DRM_FBDEV_H */
-- 
2.7.0.226.gfe986fe
