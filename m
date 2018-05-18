From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri, 18 May 2018 15:34:58 -0600
Subject: [PATCH 14/16] drm/msm: Support per-instance address spaces
In-Reply-To: <20180518213500.31595-1-jcrouse@codeaurora.org>
References: <20180518213500.31595-1-jcrouse@codeaurora.org>
Message-ID: <20180518213500.31595-15-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a per-instance address spaces when a new DRM file instance is
opened assuming the target supports it and the underlying
infrastructure exists. If the operation is unsupported fall back
quietly to use the global pagetable.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 2b663435a3f7..31d1e7589892 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -22,6 +22,7 @@
 #include "msm_fence.h"
 #include "msm_gpu.h"
 #include "msm_kms.h"
+#include "msm_gem.h"
 
 
 /*
@@ -511,7 +512,27 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
 
 	msm_submitqueue_init(dev, ctx);
 
-	ctx->aspace = priv->gpu->aspace;
+	/* FIXME: Do we want a dynamic name of some sort? */
+	/* FIXME: We need a smarter way to set the range based on target */
+
+	ctx->aspace = msm_gem_address_space_create_instance(
+		priv->gpu->aspace->mmu, "gpu", 0x100000000, 0x1ffffffff);
+
+	if (IS_ERR(ctx->aspace)) {
+		int ret = PTR_ERR(ctx->aspace);
+
+		/*
+		 * if per-instance pagetables are not supported, fall back to
+		 * using the generic address space
+		 */
+		if (ret == -EOPNOTSUPP)
+			ctx->aspace = priv->gpu->aspace;
+		else {
+			kfree(ctx);
+			return ret;
+		}
+	}
+
 	file->driver_priv = ctx;
 
 	return 0;
@@ -527,8 +548,12 @@ static int msm_open(struct drm_device *dev, struct drm_file *file)
 	return context_init(dev, file);
 }
 
-static void context_close(struct msm_file_private *ctx)
+static void context_close(struct msm_drm_private *priv,
+		struct msm_file_private *ctx)
 {
+	if (ctx && ctx->aspace != priv->gpu->aspace)
+		msm_gem_address_space_put(ctx->aspace);
+
 	msm_submitqueue_close(ctx);
 	kfree(ctx);
 }
@@ -543,7 +568,7 @@ static void msm_postclose(struct drm_device *dev, struct drm_file *file)
 		priv->lastctx = NULL;
 	mutex_unlock(&dev->struct_mutex);
 
-	context_close(ctx);
+	context_close(priv, ctx);
 }
 
 static irqreturn_t msm_irq(int irq, void *arg)
-- 
2.17.0
