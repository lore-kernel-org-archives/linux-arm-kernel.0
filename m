From: alexandru-cosmin.gheorghe@arm.com (Alexandru Gheorghe)
Date: Thu, 26 Jul 2018 17:17:51 +0100
Subject: [PATCH v2 05/10] drm/exynos: Use __drm_atomic_helper_plane_reset
 instead of copying the logic
In-Reply-To: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
References: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180726161756.1794-6-alexandru-cosmin.gheorghe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new helper function(__drm_atomic_helper_plane_reset) has been added
for linking a plane with its state and resetting the core
properties(alpha, rotation, etc.) to their default values.
Use that instead of duplicating the logic.

Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
---
 drivers/gpu/drm/exynos/exynos_drm_plane.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index eb9915da7dec..681328fbe7de 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -139,8 +139,7 @@ static void exynos_drm_plane_reset(struct drm_plane *plane)
 
 	exynos_state = kzalloc(sizeof(*exynos_state), GFP_KERNEL);
 	if (exynos_state) {
-		plane->state = &exynos_state->base;
-		plane->state->plane = plane;
+		__drm_atomic_helper_plane_reset(plane, &exynos_state->base);
 		plane->state->zpos = exynos_plane->config->zpos;
 	}
 }
-- 
2.18.0
