From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 23:47:47 +0100
Subject: [PATCH 5/9] drm: export drm_vm_open_locked
In-Reply-To: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
Message-ID: <1360882071-4072668-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the exynos DRM driver can now be built as a module on
all multiplatform configurations, an existing bug has
become visible: The exynos driver uses the drm_vm_open_locked
function that is not exported. The obvious solution is to
export that symbol.

Without this patch, building ARM allmodconfig results in:

ERROR: "drm_vm_open_locked" [drivers/gpu/drm/exynos/exynosdrm.ko] undefined!

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Shirish S <s.shirish@samsung.com>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Rob Clark <rob@ti.com>
---
 drivers/gpu/drm/drm_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
index db7bd29..1d4f7c9 100644
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -422,6 +422,7 @@ void drm_vm_open_locked(struct drm_device *dev,
 		list_add(&vma_entry->head, &dev->vmalist);
 	}
 }
+EXPORT_SYMBOL_GPL(drm_vm_open_locked);
 
 static void drm_vm_open(struct vm_area_struct *vma)
 {
-- 
1.8.1.2
