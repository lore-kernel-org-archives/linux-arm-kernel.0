From: alexandru-cosmin.gheorghe@arm.com (Alexandru Gheorghe)
Date: Thu, 26 Jul 2018 17:17:49 +0100
Subject: [PATCH v2 03/10] drm: mali-dp: Use __drm_atomic_helper_plane_reset
 instead of copying the logic
In-Reply-To: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
References: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180726161756.1794-4-alexandru-cosmin.gheorghe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new helper function(__drm_atomic_helper_plane_reset) has been added
for linking a plane with its state and resetting the core
properties(alpha, rotation, etc.) to their default values.
Use that instead of duplicating the logic.

Reviewed-by: Ayan Kumar halder <ayan.halder@arm.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
---
 drivers/gpu/drm/arm/malidp_planes.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 29409a65d864..49c37f6dd63e 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -78,11 +78,8 @@ static void malidp_plane_reset(struct drm_plane *plane)
 	kfree(state);
 	plane->state = NULL;
 	state = kzalloc(sizeof(*state), GFP_KERNEL);
-	if (state) {
-		state->base.plane = plane;
-		state->base.rotation = DRM_MODE_ROTATE_0;
-		plane->state = &state->base;
-	}
+	if (state)
+		__drm_atomic_helper_plane_reset(plane, &state->base);
 }
 
 static struct
-- 
2.18.0
