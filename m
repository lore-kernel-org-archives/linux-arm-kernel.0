From: john@metanate.com (John Keeping)
Date: Thu, 21 Jan 2016 13:53:46 +0000
Subject: [PATCH] drm/rockchip: respect CONFIG_DRM_FBDEV_EMULATION
Message-ID: <1453384426-32617-1-git-send-email-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If DRM_FBDEV_EMULATION is not selected in the config then we should not
setup a framebuffer console.

Signed-off-by: John Keeping <john@metanate.com>
---
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
