From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  7 Aug 2015 18:27:35 +0200
Subject: [PATCH 4/4] drm/bridge: Put Kconfig entries in a separate menu
In-Reply-To: <1438964855-16989-1-git-send-email-thierry.reding@gmail.com>
References: <1438964855-16989-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1438964855-16989-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Put the Kconfig entries for bridge drivers into a separate menu so that
they are automatically grouped and don't clutter up the top-level menu.

While at it, move the bridge menu towards the end of the top-level menu
where the panel menu is already located.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/Kconfig        |  4 ++--
 drivers/gpu/drm/bridge/Kconfig | 14 +++++++++++---
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 06ae5008c5ed..86191586340f 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -99,8 +99,6 @@ config DRM_KMS_CMA_HELPER
 
 source "drivers/gpu/drm/i2c/Kconfig"
 
-source "drivers/gpu/drm/bridge/Kconfig"
-
 config DRM_TDFX
 	tristate "3dfx Banshee/Voodoo3+"
 	depends on DRM && PCI
@@ -255,6 +253,8 @@ source "drivers/gpu/drm/tegra/Kconfig"
 
 source "drivers/gpu/drm/panel/Kconfig"
 
+source "drivers/gpu/drm/bridge/Kconfig"
+
 source "drivers/gpu/drm/sti/Kconfig"
 
 source "drivers/gpu/drm/amd/amdkfd/Kconfig"
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index adac3250684b..2de52a53a803 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -1,11 +1,18 @@
+config DRM_BRIDGE
+	def_bool y
+	depends on DRM
+	help
+	  Bridge registration and lookup framework.
+
+menu "Display Interface Bridges"
+	depends on DRM && DRM_BRIDGE
+
 config DRM_DW_HDMI
 	tristate
-	depends on DRM
 	select DRM_KMS_HELPER
 
 config DRM_NXP_PTN3460
 	tristate "NXP PTN3460 DP/LVDS bridge"
-	depends on DRM
 	depends on OF
 	select DRM_KMS_HELPER
 	select DRM_PANEL
@@ -14,7 +21,6 @@ config DRM_NXP_PTN3460
 
 config DRM_PARADE_PS8622
 	tristate "Parade eDP/LVDS bridge"
-	depends on DRM
 	depends on OF
 	select DRM_PANEL
 	select DRM_KMS_HELPER
@@ -22,3 +28,5 @@ config DRM_PARADE_PS8622
 	select BACKLIGHT_CLASS_DEVICE
 	---help---
 	  Parade eDP-LVDS bridge chip driver.
+
+endmenu
-- 
2.4.5
