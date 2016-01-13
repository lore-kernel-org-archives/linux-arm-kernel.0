From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 14:48:13 +0100
Subject: [PATCH] drm: nouveau: fix nouveau_debugfs_init prototype
Message-ID: <3968390.Pvmnq3v7oC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new debugfs initialization code fails to build when CONFIG_DEBUG_FS
is disabled:

In file included from /git/arm-soc/drivers/gpu/drm/nouveau/nouveau_drm.c:57:0:
drivers/gpu/drm/nouveau/nouveau_debugfs.h: In function 'nouveau_debugfs_init':
drivers/gpu/drm/nouveau/nouveau_debugfs.h:37:29: error: parameter name omitted
 nouveau_debugfs_init(struct nouveau_drm *)

This fixes the prototypes so we can build it again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b126a200e9db ("drm/nouveau/debugfs: we need a ctrl object for debugfs")
---
This broke when the nouveau patches got merged into drm-next on Monday.
Found on ARM randconfig builds.

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.h b/drivers/gpu/drm/nouveau/nouveau_debugfs.h
index 52c7161297d7..b8c03ff5bf05 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.h
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.h
@@ -34,13 +34,13 @@ nouveau_drm_debugfs_cleanup(struct drm_minor *minor)
 }
 
 static inline int
-nouveau_debugfs_init(struct nouveau_drm *)
+nouveau_debugfs_init(struct nouveau_drm *drm)
 {
 	return 0;
 }
 
 static inline void
-nouveau_debugfs_fini(struct nouveau_drm *)
+nouveau_debugfs_fini(struct nouveau_drm *drm)
 {
 }
 
