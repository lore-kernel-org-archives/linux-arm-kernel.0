From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Apr 2017 19:00:19 +0200
Subject: [PATCH] [media] exynos_hdmi: improve MEDIA_CEC_NOTIFIER dependency
Message-ID: <20170419170030.2869578-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the media subsystem is built as a loadable module, a built-in
DRM driver cannot use the cec notifiers:

drivers/gpu/drm/exynos/exynos_hdmi.o: In function `hdmi_get_modes':
exynos_hdmi.c:(.text.hdmi_get_modes+0x80): undefined reference to `cec_notifier_set_phys_addr_from_edid'
drivers/gpu/drm/exynos/exynos_hdmi.o: In function `hdmi_remove':
exynos_hdmi.c:(.text.hdmi_remove+0x24): undefined reference to `cec_notifier_set_phys_addr'
exynos_hdmi.c:(.text.hdmi_remove+0x38): undefined reference to `cec_notifier_put'

This adds a Kconfig dependency to enforce the HDMI driver to also
be a loadable module in this case.

Fixes: 278c811c5d05 ("[media] exynos_hdmi: add CEC notifier support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
index 1d185347c64c..65ba292f8e40 100644
--- a/drivers/gpu/drm/exynos/Kconfig
+++ b/drivers/gpu/drm/exynos/Kconfig
@@ -1,6 +1,7 @@
 config DRM_EXYNOS
 	tristate "DRM Support for Samsung SoC EXYNOS Series"
 	depends on OF && DRM && (ARCH_S3C64XX || ARCH_EXYNOS || ARCH_MULTIPLATFORM)
+	depends on (MEDIA_SUPPORT && MEDIA_CEC_NOTIFIER) || !MEDIA_CEC_NOTIFIER
 	select DRM_KMS_HELPER
 	select VIDEOMODE_HELPERS
 	help
-- 
2.9.0
