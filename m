From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 28 Mar 2016 21:28:55 -0400
Subject: [PATCH 1/3] drm/exynos: Use VIDEO_SAMSUNG_S5P_G2D=n as G2D Kconfig
 dependency
In-Reply-To: <1459214937-18686-1-git-send-email-javier@osg.samsung.com>
References: <1459214937-18686-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1459214937-18686-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 254d4d111ee1 ("drm/exynos: Add dependency for G2D in Kconfig") made
the DRM_EXYNOS_G2D symbol to only be selectable if the s5p-g2d V4L2 driver
is not enabled, since both use the same HW IP block.

But added the dependency as depends on !VIDEO_SAMSUNG_S5P_G2D which isn't
correct since Kconfig expressions are not boolean but tristate. So it will
only evaluate to 'n' if VIDEO_SAMSUNG_S5P_G2D=y but it will evaluate to m
if VIDEO_SAMSUNG_S5P_G2D=m.

This means that both the V4L2 and DRM drivers can be enabled if the former
is enabled as a module, which is not what we want.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/gpu/drm/exynos/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
index f17d39279596..baddf33fb475 100644
--- a/drivers/gpu/drm/exynos/Kconfig
+++ b/drivers/gpu/drm/exynos/Kconfig
@@ -94,7 +94,7 @@ comment "Sub-drivers"
 
 config DRM_EXYNOS_G2D
 	bool "G2D"
-	depends on !VIDEO_SAMSUNG_S5P_G2D
+	depends on VIDEO_SAMSUNG_S5P_G2D=n
 	select FRAME_VECTOR
 	help
 	  Choose this option if you want to use Exynos G2D for DRM.
-- 
2.5.0
