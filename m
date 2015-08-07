From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  7 Aug 2015 18:27:33 +0200
Subject: [PATCH 2/4] drm/bridge: Add vendor prefixes
In-Reply-To: <1438964855-16989-1-git-send-email-thierry.reding@gmail.com>
References: <1438964855-16989-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1438964855-16989-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Use vendor prefixes for Kconfig symbols and filenames. This should make
it easier to identify the various bridge drivers and to organize the
directory.

While at it, rename dw_hdmi.[ch] to dw-hdmi.[ch] for consistency.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/configs/exynos_defconfig                    |  4 ++--
 arch/arm/configs/multi_v7_defconfig                  |  4 ++--
 drivers/gpu/drm/bridge/Kconfig                       | 10 +++++-----
 drivers/gpu/drm/bridge/Makefile                      |  6 +++---
 drivers/gpu/drm/bridge/{dw_hdmi.c => dw-hdmi.c}      |  2 +-
 drivers/gpu/drm/bridge/{dw_hdmi.h => dw-hdmi.h}      |  0
 drivers/gpu/drm/bridge/{ptn3460.c => nxp-ptn3460.c}  |  0
 drivers/gpu/drm/bridge/{ps8622.c => parade-ps8622.c} |  0
 8 files changed, 13 insertions(+), 13 deletions(-)
 rename drivers/gpu/drm/bridge/{dw_hdmi.c => dw-hdmi.c} (99%)
 rename drivers/gpu/drm/bridge/{dw_hdmi.h => dw-hdmi.h} (100%)
 rename drivers/gpu/drm/bridge/{ptn3460.c => nxp-ptn3460.c} (100%)
 rename drivers/gpu/drm/bridge/{ps8622.c => parade-ps8622.c} (100%)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 67965cedeb69..099438e19f05 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -125,8 +125,8 @@ CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_REGULATOR_TPS65090=y
 CONFIG_DRM=y
-CONFIG_DRM_PTN3460=y
-CONFIG_DRM_PS8622=y
+CONFIG_DRM_NXP_PTN3460=y
+CONFIG_DRM_PARADE_PS8622=y
 CONFIG_DRM_EXYNOS=y
 CONFIG_DRM_EXYNOS_FIMD=y
 CONFIG_DRM_EXYNOS_DSI=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fb587b2330ad..29be77726ec8 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -438,8 +438,8 @@ CONFIG_VIDEO_RENESAS_VSP1=m
 CONFIG_VIDEO_ADV7180=m
 CONFIG_VIDEO_ML86V7667=m
 CONFIG_DRM=y
-CONFIG_DRM_PTN3460=m
-CONFIG_DRM_PS8622=m
+CONFIG_DRM_NXP_PTN3460=m
+CONFIG_DRM_PARADE_PS8622=m
 CONFIG_DRM_EXYNOS=m
 CONFIG_DRM_EXYNOS_DSI=y
 CONFIG_DRM_EXYNOS_FIMD=y
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index acef3223772c..adac3250684b 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -3,16 +3,16 @@ config DRM_DW_HDMI
 	depends on DRM
 	select DRM_KMS_HELPER
 
-config DRM_PTN3460
-	tristate "PTN3460 DP/LVDS bridge"
+config DRM_NXP_PTN3460
+	tristate "NXP PTN3460 DP/LVDS bridge"
 	depends on DRM
 	depends on OF
 	select DRM_KMS_HELPER
 	select DRM_PANEL
 	---help---
-	  ptn3460 eDP-LVDS bridge chip driver.
+	  NXP PTN3460 eDP-LVDS bridge chip driver.
 
-config DRM_PS8622
+config DRM_PARADE_PS8622
 	tristate "Parade eDP/LVDS bridge"
 	depends on DRM
 	depends on OF
@@ -21,4 +21,4 @@ config DRM_PS8622
 	select BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
 	---help---
-	  parade eDP-LVDS bridge chip driver.
+	  Parade eDP-LVDS bridge chip driver.
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 8dfebd984370..fe490e2a7f25 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -1,5 +1,5 @@
 ccflags-y := -Iinclude/drm
 
-obj-$(CONFIG_DRM_PS8622) += ps8622.o
-obj-$(CONFIG_DRM_PTN3460) += ptn3460.o
-obj-$(CONFIG_DRM_DW_HDMI) += dw_hdmi.o
+obj-$(CONFIG_DRM_DW_HDMI) += dw-hdmi.o
+obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
+obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw-hdmi.c
similarity index 99%
rename from drivers/gpu/drm/bridge/dw_hdmi.c
rename to drivers/gpu/drm/bridge/dw-hdmi.c
index 816d104ca4da..8bb00b70702a 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw-hdmi.c
@@ -26,7 +26,7 @@
 #include <drm/drm_encoder_slave.h>
 #include <drm/bridge/dw_hdmi.h>
 
-#include "dw_hdmi.h"
+#include "dw-hdmi.h"
 
 #define HDMI_EDID_LEN		512
 
diff --git a/drivers/gpu/drm/bridge/dw_hdmi.h b/drivers/gpu/drm/bridge/dw-hdmi.h
similarity index 100%
rename from drivers/gpu/drm/bridge/dw_hdmi.h
rename to drivers/gpu/drm/bridge/dw-hdmi.h
diff --git a/drivers/gpu/drm/bridge/ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
similarity index 100%
rename from drivers/gpu/drm/bridge/ptn3460.c
rename to drivers/gpu/drm/bridge/nxp-ptn3460.c
diff --git a/drivers/gpu/drm/bridge/ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
similarity index 100%
rename from drivers/gpu/drm/bridge/ps8622.c
rename to drivers/gpu/drm/bridge/parade-ps8622.c
-- 
2.4.5
