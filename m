From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Feb 2016 22:08:39 +0100
Subject: [PATCH 5/8] drm: msm: move DSI into separate module
In-Reply-To: <1456175331-714117-1-git-send-email-arnd@arndb.de>
References: <1456175331-714117-1-git-send-email-arnd@arndb.de>
Message-ID: <1456175331-714117-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving around the Makefile for DSI caused a link error with
the main driver referring to a builtin module that has no
exported symbols:

drivers/gpu/built-in.o: In function `msm_drm_register':
:(.init.text+0x654): undefined reference to `msm_dsi_register'

This changes the DSI symbol to a 'tristate' so we can build it
as a module, and exports the symbols as necessary.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/Makefile            |  4 ++--
 drivers/gpu/drm/msm/dsi/Kconfig         |  7 ++++++-
 drivers/gpu/drm/msm/dsi/Makefile        | 16 +++++++++-------
 drivers/gpu/drm/msm/dsi/dsi.c           |  6 ++++--
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.h |  2 +-
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.h |  2 +-
 drivers/gpu/drm/msm/msm_drv.h           |  2 +-
 7 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 6817e9390153..4b18a2c670b9 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -33,13 +33,13 @@ drm-msm-y := \
 	msm_rd.o \
 	msm_ringbuffer.o
 
-drm-msm-$(CONFIG_DRM_MSM_DSI) += mdp/mdp4/mdp4_dsi_encoder.o \
+drm-msm-$(CONFIG_DRM_MSM_DSI_MODULE) += mdp/mdp4/mdp4_dsi_encoder.o \
 				 mdp/mdp5/mdp5_cmd_encoder.o
 
 drm-msm-$(CONFIG_DRM_FBDEV_EMULATION) += msm_fbdev.o
 drm-msm-$(CONFIG_COMMON_CLK) += mdp/mdp4/mdp4_lvds_pll.o
 
-obj-$(CONFIG_DRM_MSM_DSI) += dsi/
+obj-$(CONFIG_DRM_MSM_DSI_MODULE) += dsi/
 obj-$(CONFIG_DRM_MSM_HDMI) += hdmi/
 obj-$(CONFIG_DRM_MSM_EDP) += edp/
 
diff --git a/drivers/gpu/drm/msm/dsi/Kconfig b/drivers/gpu/drm/msm/dsi/Kconfig
index 91dcf21bfc03..9cddaf0229f7 100644
--- a/drivers/gpu/drm/msm/dsi/Kconfig
+++ b/drivers/gpu/drm/msm/dsi/Kconfig
@@ -1,5 +1,5 @@
 config DRM_MSM_DSI
-	bool "Enable DSI support in MSM DRM driver"
+	tristate "Enable DSI support in MSM DRM driver"
 	depends on DRM_MSM
 	select DRM_PANEL
 	select DRM_MIPI_DSI
@@ -8,6 +8,11 @@ config DRM_MSM_DSI
 	  Choose this option if you have a need for MIPI DSI connector
 	  support.
 
+config DRM_MSM_DSI_MODULE
+	tristate
+	default y if DRM_MSM=y && DRM_MSM_DSI=m
+	default DRM_MSM_DSI
+
 if DRM_MSM_DSI
 
 config DRM_MSM_DSI_PLL
diff --git a/drivers/gpu/drm/msm/dsi/Makefile b/drivers/gpu/drm/msm/dsi/Makefile
index 26c8fb689229..53d1cdc16748 100644
--- a/drivers/gpu/drm/msm/dsi/Makefile
+++ b/drivers/gpu/drm/msm/dsi/Makefile
@@ -1,13 +1,15 @@
 ccflags-y := -Iinclude/drm -Idrivers/gpu/drm/msm -Idrivers/gpu/drm/msm/dsi
 
-obj-y := dsi.o dsi_cfg.o dsi_host.o dsi_manager.o phy/dsi_phy.o
+obj-$(CONFIG_DRM_MSM_DSI_MODULE) += drm-msm-dsi.o
 
-obj-$(CONFIG_DRM_MSM_DSI_28NM_PHY) += phy/dsi_phy_28nm.o
-obj-$(CONFIG_DRM_MSM_DSI_20NM_PHY) += phy/dsi_phy_20nm.o
-obj-$(CONFIG_DRM_MSM_DSI_28NM_8960_PHY) += phy/dsi_phy_28nm_8960.o
+drm-msm-dsi-y := dsi.o dsi_cfg.o dsi_host.o dsi_manager.o phy/dsi_phy.o
+
+drm-msm-dsi-$(CONFIG_DRM_MSM_DSI_28NM_PHY) += phy/dsi_phy_28nm.o
+drm-msm-dsi-$(CONFIG_DRM_MSM_DSI_20NM_PHY) += phy/dsi_phy_20nm.o
+drm-msm-dsi-$(CONFIG_DRM_MSM_DSI_28NM_8960_PHY) += phy/dsi_phy_28nm_8960.o
 
 ifeq ($(CONFIG_DRM_MSM_DSI_PLL),y)
-obj-y += pll/dsi_pll.o
-obj-$(CONFIG_DRM_MSM_DSI_28NM_PHY) += pll/dsi_pll_28nm.o
-obj-$(CONFIG_DRM_MSM_DSI_28NM_8960_PHY) += pll/dsi_pll_28nm_8960.o
+drm-msm-dsi-y += pll/dsi_pll.o
+drm-msm-dsi-$(CONFIG_DRM_MSM_DSI_28NM_PHY) += pll/dsi_pll_28nm.o
+drm-msm-dsi-$(CONFIG_DRM_MSM_DSI_28NM_8960_PHY) += pll/dsi_pll_28nm_8960.o
 endif
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 6edcd6f57e70..8523a7cdc419 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -10,7 +10,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-
+#include <linux/module.h>
 #include "dsi.h"
 
 struct drm_encoder *msm_dsi_get_encoder(struct msm_dsi *msm_dsi)
@@ -178,6 +178,7 @@ void __init msm_dsi_register(void)
 	msm_dsi_phy_driver_register();
 	platform_driver_register(&dsi_driver);
 }
+EXPORT_SYMBOL_GPL(msm_dsi_register);
 
 void __exit msm_dsi_unregister(void)
 {
@@ -185,6 +186,7 @@ void __exit msm_dsi_unregister(void)
 	msm_dsi_phy_driver_unregister();
 	platform_driver_unregister(&dsi_driver);
 }
+EXPORT_SYMBOL_GPL(msm_dsi_unregister);
 
 int msm_dsi_modeset_init(struct msm_dsi *msm_dsi, struct drm_device *dev,
 		struct drm_encoder *encoders[MSM_DSI_ENCODER_NUM])
@@ -262,4 +264,4 @@ fail:
 
 	return ret;
 }
-
+EXPORT_SYMBOL_GPL(msm_dsi_modeset_init);
diff --git a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.h b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.h
index b2828717be2a..3a9e7879d535 100644
--- a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.h
+++ b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.h
@@ -217,7 +217,7 @@ struct drm_encoder *mdp4_lcdc_encoder_init(struct drm_device *dev,
 struct drm_connector *mdp4_lvds_connector_init(struct drm_device *dev,
 		struct device_node *panel_node, struct drm_encoder *encoder);
 
-#ifdef CONFIG_DRM_MSM_DSI
+#if IS_ENABLED(CONFIG_DRM_MSM_DSI)
 struct drm_encoder *mdp4_dsi_encoder_init(struct drm_device *dev);
 #else
 static inline struct drm_encoder *mdp4_dsi_encoder_init(struct drm_device *dev)
diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.h b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.h
index 9a25898239d3..6a1325fd71aa 100644
--- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.h
+++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.h
@@ -224,7 +224,7 @@ int mdp5_encoder_set_split_display(struct drm_encoder *encoder,
 int mdp5_encoder_get_linecount(struct drm_encoder *encoder);
 u32 mdp5_encoder_get_framecount(struct drm_encoder *encoder);
 
-#ifdef CONFIG_DRM_MSM_DSI
+#if IS_ENABLED(CONFIG_DRM_MSM_DSI)
 struct drm_encoder *mdp5_cmd_encoder_init(struct drm_device *dev,
 		struct mdp5_interface *intf, struct mdp5_ctl *ctl);
 int mdp5_cmd_encoder_set_split_display(struct drm_encoder *encoder,
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index b8bd88b66c9c..86df81b46eb0 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -294,7 +294,7 @@ enum msm_dsi_encoder_id {
 	MSM_DSI_CMD_ENCODER_ID = 1,
 	MSM_DSI_ENCODER_NUM = 2
 };
-#ifdef CONFIG_DRM_MSM_DSI
+#if IS_ENABLED(CONFIG_DRM_MSM_DSI)
 void __init msm_dsi_register(void);
 void __exit msm_dsi_unregister(void);
 int msm_dsi_modeset_init(struct msm_dsi *msm_dsi, struct drm_device *dev,
-- 
2.7.0
