From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 21:26:55 +0100
Subject: [PATCH] drm: avoid uninitialized timestamp use in wait_vblank
Message-ID: <4063054.9IPA0UdbYa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc warns about the timestamp in drm_wait_vblank being possibly
used without an initialization:

drivers/gpu/drm/drm_irq.c: In function 'drm_wait_vblank':
drivers/gpu/drm/drm_irq.c:1755:28: warning: 'now.tv_usec' may be used uninitialized in this function [-Wmaybe-uninitialized]
   vblwait->reply.tval_usec = now.tv_usec;
drivers/gpu/drm/drm_irq.c:1754:27: warning: 'now.tv_sec' may be used uninitialized in this function [-Wmaybe-uninitialized]
   vblwait->reply.tval_sec = now.tv_sec;

This can happen if drm_vblank_count_and_time() returns 0 in its
error path. To sanitize the error case, I'm changing that function
to return a zero timestamp when it fails.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e6ae8687a87b ("drm: idiot-proof vblank")
---
I'm going through the maybe-unused warnings in randconfig builds, this one is
apparently not a false positive, although it only happens if something
else has already gone wrong.

diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
index d12a4efa651b..d32ff169fdb8 100644
--- a/drivers/gpu/drm/drm_irq.c
+++ b/drivers/gpu/drm/drm_irq.c
@@ -939,8 +939,10 @@ u32 drm_vblank_count_and_time(struct drm_device *dev, unsigned int pipe,
 	int count = DRM_TIMESTAMP_MAXRETRIES;
 	u32 cur_vblank;
 
-	if (WARN_ON(pipe >= dev->num_crtcs))
+	if (WARN_ON(pipe >= dev->num_crtcs)) {
+		*vblanktime = (struct timeval) { 0 };
 		return 0;
+	}
 
 	/*
 	 * Vblank timestamps are read lockless. To ensure consistency the vblank
