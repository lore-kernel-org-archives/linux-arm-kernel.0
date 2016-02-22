From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Feb 2016 22:08:40 +0100
Subject: [PATCH 6/8] drm: msm: move EDP into separate module
In-Reply-To: <1456175331-714117-1-git-send-email-arnd@arndb.de>
References: <1456175331-714117-1-git-send-email-arnd@arndb.de>
Message-ID: <1456175331-714117-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving around the Makefile for EDP caused a link error with
the main driver referring to a builtin module that has no
exported symbols:

drivers/gpu/built-in.o: In function `msm_drm_register':
:(.init.text+0x654): undefined reference to `msm_edp_register'

This changes the EDP symbol to a 'tristate' so we can build it
as a module, and exports the symbols as necessary.

Fixes: 75a5cfa5739f ("drm/msm/edp: Create separate Makefile/Kconfig")
---
 drivers/gpu/drm/msm/Makefile     | 2 +-
 drivers/gpu/drm/msm/edp/Kconfig  | 7 ++++++-
 drivers/gpu/drm/msm/edp/Makefile | 4 +++-
 drivers/gpu/drm/msm/edp/edp.c    | 4 ++++
 drivers/gpu/drm/msm/msm_drv.h    | 2 +-
 5 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 4b18a2c670b9..e67bdaa14635 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -41,7 +41,7 @@ drm-msm-$(CONFIG_COMMON_CLK) += mdp/mdp4/mdp4_lvds_pll.o
 
 obj-$(CONFIG_DRM_MSM_DSI_MODULE) += dsi/
 obj-$(CONFIG_DRM_MSM_HDMI) += hdmi/
-obj-$(CONFIG_DRM_MSM_EDP) += edp/
+obj-$(CONFIG_DRM_MSM_EDP_MODULE) += edp/
 
 obj-$(CONFIG_DRM_MSM)	+= drm-msm.o drm_msm_helper.o
 
diff --git a/drivers/gpu/drm/msm/edp/Kconfig b/drivers/gpu/drm/msm/edp/Kconfig
index 576d8c2fd713..b4cecabebc1d 100644
--- a/drivers/gpu/drm/msm/edp/Kconfig
+++ b/drivers/gpu/drm/msm/edp/Kconfig
@@ -1,7 +1,12 @@
 config DRM_MSM_EDP
-	bool "Enable EDP support in MSM DRM driver"
+	tristate "Enable EDP support in MSM DRM driver"
 	depends on DRM_MSM
 	default y
 	help
 	  Choose this option if you have a need for Embedded Display
 	  Port encoder support.
+
+config DRM_MSM_EDP_MODULE
+	tristate
+	default y if DRM_MSM=y && DRM_MSM_EDP=m
+	default DRM_MSM_EDP
diff --git a/drivers/gpu/drm/msm/edp/Makefile b/drivers/gpu/drm/msm/edp/Makefile
index e623d59d1706..37c45037f76f 100644
--- a/drivers/gpu/drm/msm/edp/Makefile
+++ b/drivers/gpu/drm/msm/edp/Makefile
@@ -1,3 +1,5 @@
 ccflags-y := -Iinclude/drm -Idrivers/gpu/drm/msm
 
-obj-y := edp.o edp_aux.o edp_bridge.o edp_connector.o edp_ctrl.o edp_phy.o
+obj-$(CONFIG_DRM_MSM_EDP_MODULE) := drm-msm-edp.o
+
+drm-msm-edp-y := edp.o edp_aux.o edp_bridge.o edp_connector.o edp_ctrl.o edp_phy.o
diff --git a/drivers/gpu/drm/msm/edp/edp.c b/drivers/gpu/drm/msm/edp/edp.c
index 0940e84b2821..48645d0d649a 100644
--- a/drivers/gpu/drm/msm/edp/edp.c
+++ b/drivers/gpu/drm/msm/edp/edp.c
@@ -11,6 +11,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/module.h>
 #include <linux/of_irq.h>
 #include "edp.h"
 
@@ -136,12 +137,14 @@ void __init msm_edp_register(void)
 	DBG("");
 	platform_driver_register(&edp_driver);
 }
+EXPORT_SYMBOL_GPL(msm_edp_register);
 
 void __exit msm_edp_unregister(void)
 {
 	DBG("");
 	platform_driver_unregister(&edp_driver);
 }
+EXPORT_SYMBOL_GPL(msm_edp_unregister);
 
 /* Second part of initialization, the drm/kms level modeset_init */
 int msm_edp_modeset_init(struct msm_edp *edp, struct drm_device *dev,
@@ -206,3 +209,4 @@ fail:
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(msm_edp_modeset_init);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 86df81b46eb0..8786738a6832 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -266,7 +266,7 @@ static inline void __exit msm_hdmi_unregister(void)
 #endif
 
 struct msm_edp;
-#ifdef CONFIG_DRM_MSM_EDP
+#if IS_ENABLED(CONFIG_DRM_MSM_EDP)
 void __init msm_edp_register(void);
 void __exit msm_edp_unregister(void);
 int msm_edp_modeset_init(struct msm_edp *edp, struct drm_device *dev,
-- 
2.7.0
