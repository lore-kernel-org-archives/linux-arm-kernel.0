From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 28 Mar 2016 21:28:56 -0400
Subject: [PATCH 2/3] drm/exynos: Use VIDEO_SAMSUNG_EXYNOS_GSC=n as GSC Kconfig
 dependency
In-Reply-To: <1459214937-18686-1-git-send-email-javier@osg.samsung.com>
References: <1459214937-18686-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1459214937-18686-3-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit aeefb36832e5 ("drm/exynos: gsc: add device tree support and remove
usage of static mappings") made the DRM_EXYNOS_GSC Kconfig symbol to only
be selectable if the exynos-gsc V4L2 driver isn't enabled, since both use
the same HW IP block.

But added the dependency as depends on !VIDEO_SAMSUNG_EXYNOS_GSC which is
not correct since Kconfig expressions are not boolean but tristate. So it
will only evaluate to 'n' if VIDEO_SAMSUNG_EXYNOS_GSC=y but will evaluate
to 'm' if VIDEO_SAMSUNG_S5P_G2D=m.

This means that both the V4L2 and DRM drivers can be enabled if the former
is enabled as a module, which is not what we want.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/gpu/drm/exynos/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
index baddf33fb475..8c27037787fc 100644
--- a/drivers/gpu/drm/exynos/Kconfig
+++ b/drivers/gpu/drm/exynos/Kconfig
@@ -118,7 +118,7 @@ config DRM_EXYNOS_ROTATOR
 
 config DRM_EXYNOS_GSC
 	bool "GScaler"
-	depends on DRM_EXYNOS_IPP && ARCH_EXYNOS5 && !VIDEO_SAMSUNG_EXYNOS_GSC
+	depends on DRM_EXYNOS_IPP && ARCH_EXYNOS5 && VIDEO_SAMSUNG_EXYNOS_GSC=n
 	help
 	  Choose this option if you want to use Exynos GSC for DRM.
 
-- 
2.5.0
