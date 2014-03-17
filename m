From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 17 Mar 2014 11:28:06 +0800
Subject: [PATCH] drm/exynos: Fix (more) freeing issues in exynos_drm_drv.c
Message-ID: <1395026886-14325-1-git-send-email-djkurtz@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following commit [0] fixed a use-after-free, but left the subdrv open
in the error path.

[0] commit 6ca605f7c70895a35737435f17ae9cc5e36f1466
drm/exynos: Fix freeing issues in exynos_drm_drv.c

Change-Id: I452e944bf090fb11434d9e34213c890c41c15d73
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/gpu/drm/exynos/exynos_drm_drv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index 215131a..c204b4e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -172,20 +172,24 @@ static int exynos_drm_open(struct drm_device *dev, struct drm_file *file)
 
 	ret = exynos_drm_subdrv_open(dev, file);
 	if (ret)
-		goto out;
+		goto err_file_priv_free;
 
 	anon_filp = anon_inode_getfile("exynos_gem", &exynos_drm_gem_fops,
 					NULL, 0);
 	if (IS_ERR(anon_filp)) {
 		ret = PTR_ERR(anon_filp);
-		goto out;
+		goto err_subdrv_close;
 	}
 
 	anon_filp->f_mode = FMODE_READ | FMODE_WRITE;
 	file_priv->anon_filp = anon_filp;
 
 	return ret;
-out:
+
+err_subdrv_close:
+	exynos_drm_subdrv_close(dev, file);
+
+err_file_priv_free:
 	kfree(file_priv);
 	file->driver_priv = NULL;
 	return ret;
-- 
1.9.0.279.gdc9e3eb
