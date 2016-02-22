From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Feb 2016 22:08:41 +0100
Subject: [PATCH 7/8] drm: msm: move HDMI into separate module
In-Reply-To: <1456175331-714117-1-git-send-email-arnd@arndb.de>
References: <1456175331-714117-1-git-send-email-arnd@arndb.de>
Message-ID: <1456175331-714117-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving around the Makefile for HDMI caused a link error with
the main driver referring to a builtin module that has no
exported symbols:

drivers/gpu/built-in.o: In function `msm_drm_register':
:(.init.text+0x654): undefined reference to `msm_hdmi_register'

This changes the EDP symbol to a 'tristate' so we can build it
as a module, and exports the symbols as necessary.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 883656affe4d ("drm/msm/hdmi: Create separate Makefile/Kconfig")
---
 drivers/gpu/drm/msm/Makefile      | 2 +-
 drivers/gpu/drm/msm/hdmi/Kconfig  | 7 ++++++-
 drivers/gpu/drm/msm/hdmi/Makefile | 6 ++++--
 drivers/gpu/drm/msm/hdmi/hdmi.c   | 3 +++
 drivers/gpu/drm/msm/msm_drv.h     | 2 +-
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index e67bdaa14635..06fd13989476 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -40,7 +40,7 @@ drm-msm-$(CONFIG_DRM_FBDEV_EMULATION) += msm_fbdev.o
 drm-msm-$(CONFIG_COMMON_CLK) += mdp/mdp4/mdp4_lvds_pll.o
 
 obj-$(CONFIG_DRM_MSM_DSI_MODULE) += dsi/
-obj-$(CONFIG_DRM_MSM_HDMI) += hdmi/
+obj-$(CONFIG_DRM_MSM_HDMI_MODULE) += hdmi/
 obj-$(CONFIG_DRM_MSM_EDP_MODULE) += edp/
 
 obj-$(CONFIG_DRM_MSM)	+= drm-msm.o drm_msm_helper.o
diff --git a/drivers/gpu/drm/msm/hdmi/Kconfig b/drivers/gpu/drm/msm/hdmi/Kconfig
index 4b24e1e4bac4..8e9abaeae758 100644
--- a/drivers/gpu/drm/msm/hdmi/Kconfig
+++ b/drivers/gpu/drm/msm/hdmi/Kconfig
@@ -1,7 +1,12 @@
 config DRM_MSM_HDMI
-	bool "Enable HDMI support in MSM DRM driver"
+	tristate "Enable HDMI support in MSM DRM driver"
 	depends on DRM_MSM
 	default y
 	help
 	  Choose this option if you have a need for HDMI connector
 	  support.
+
+config DRM_MSM_HDMI_MODULE
+	tristate
+	default y if DRM_MSM=y && DRM_MSM_HDMI=m
+	default DRM_MSM_HDMI
diff --git a/drivers/gpu/drm/msm/hdmi/Makefile b/drivers/gpu/drm/msm/hdmi/Makefile
index 799dbca89bd4..6cb4598f48d7 100644
--- a/drivers/gpu/drm/msm/hdmi/Makefile
+++ b/drivers/gpu/drm/msm/hdmi/Makefile
@@ -1,6 +1,8 @@
 ccflags-y := -Iinclude/drm -Idrivers/gpu/drm/msm
 
-obj-y := hdmi.o hdmi_phy.o hdmi_audio.o hdmi_bridge.o hdmi_connector.o \
+obj-$(CONFIG_DRM_MSM_HDMI_MODULE) += drm-msm-hdmi.o
+
+drm-msm-hdmi-y := hdmi.o hdmi_phy.o hdmi_audio.o hdmi_bridge.o hdmi_connector.o \
 	 hdmi_hdcp.o hdmi_i2c.o hdmi_phy_8960.o hdmi_phy_8x60.o hdmi_phy_8x74.o
 
-obj-$(CONFIG_COMMON_CLK) += hdmi_pll_8960.o hdmi_phy_8996.o
+drm-msm-hdmi-$(CONFIG_COMMON_CLK) += hdmi_pll_8960.o hdmi_phy_8996.o
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 3bcfb1ded8b3..8e01d942d1c9 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -343,6 +343,7 @@ fail:
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(msm_hdmi_modeset_init);
 
 /*
  * The hdmi device:
@@ -522,9 +523,11 @@ void __init msm_hdmi_register(void)
 	msm_hdmi_phy_driver_register();
 	platform_driver_register(&msm_hdmi_driver);
 }
+EXPORT_SYMBOL_GPL(msm_hdmi_register);
 
 void __exit msm_hdmi_unregister(void)
 {
 	platform_driver_unregister(&msm_hdmi_driver);
 	msm_hdmi_phy_driver_unregister();
 }
+EXPORT_SYMBOL_GPL(msm_hdmi_unregister);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 8786738a6832..905c17e373e7 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -244,7 +244,7 @@ struct drm_fb_helper *msm_fbdev_init(struct drm_device *dev);
 void msm_fbdev_free(struct drm_device *dev);
 
 struct hdmi;
-#ifdef CONFIG_DRM_MSM_HDMI
+#if IS_ENABLED(CONFIG_DRM_MSM_HDMI)
 int msm_hdmi_modeset_init(struct hdmi *hdmi, struct drm_device *dev,
 		struct drm_encoder *encoder);
 void __init msm_hdmi_register(void);
-- 
2.7.0
