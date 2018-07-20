From: alexandru-cosmin.gheorghe@arm.com (Alexandru Gheorghe)
Date: Fri, 20 Jul 2018 22:15:02 +0100
Subject: [PATCH 03/10] drm: mali-dp: Use __drm_atomic_helper_plane_reset
 instead of copying the logic
In-Reply-To: <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
References: <20180713161407.GQ20303@art_vandelay>
 <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180720211509.23605-4-alexandru-cosmin.gheorghe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
