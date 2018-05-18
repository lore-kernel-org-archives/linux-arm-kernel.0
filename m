From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri, 18 May 2018 15:34:52 -0600
Subject: [PATCH 08/16] drm/msm: Pass the MMU domain index in struct
 msm_file_private
In-Reply-To: <20180518213500.31595-1-jcrouse@codeaurora.org>
References: <20180518213500.31595-1-jcrouse@codeaurora.org>
Message-ID: <20180518213500.31595-9-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass the index of the MMU domain in struct msm_file_private instead
of assuming gpu->id throughout the submit path. This clears the way
to change ctx->aspace to a per-instance pagetable.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/msm_drv.c        | 16 ++++------------
 drivers/gpu/drm/msm/msm_drv.h        |  1 +
 drivers/gpu/drm/msm/msm_gem.h        |  1 +
 drivers/gpu/drm/msm/msm_gem_submit.c | 11 ++++++-----
 drivers/gpu/drm/msm/msm_gpu.c        |  5 ++---
 5 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 30cd514d8f7c..2b663435a3f7 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -502,6 +502,7 @@ static void load_gpu(struct drm_device *dev)
 
 static int context_init(struct drm_device *dev, struct drm_file *file)
 {
+	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_file_private *ctx;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
@@ -510,6 +511,7 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
 
 	msm_submitqueue_init(dev, ctx);
 
+	ctx->aspace = priv->gpu->aspace;
 	file->driver_priv = ctx;
 
 	return 0;
@@ -683,17 +685,6 @@ static int msm_ioctl_gem_cpu_fini(struct drm_device *dev, void *data,
 	return ret;
 }
 
-static int msm_ioctl_gem_info_iova(struct drm_device *dev,
-		struct drm_gem_object *obj, uint64_t *iova)
-{
-	struct msm_drm_private *priv = dev->dev_private;
-
-	if (!priv->gpu)
-		return -EINVAL;
-
-	return msm_gem_get_iova(obj, priv->gpu->aspace, iova);
-}
-
 static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 		struct drm_file *file)
 {
@@ -709,9 +700,10 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 		return -ENOENT;
 
 	if (args->flags & MSM_INFO_IOVA) {
+		struct msm_file_private *ctx = file->driver_priv;
 		uint64_t iova;
 
-		ret = msm_ioctl_gem_info_iova(dev, obj, &iova);
+		ret = msm_gem_get_iova(obj, ctx->aspace, &iova);
 		if (!ret)
 			args->offset = iova;
 	} else {
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 48ed5b9a8580..897b08135927 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -58,6 +58,7 @@ struct msm_file_private {
 	rwlock_t queuelock;
 	struct list_head submitqueues;
 	int queueid;
+	struct msm_gem_address_space *aspace;
 };
 
 enum msm_mdp_plane_property {
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index c5d9bd3e47a8..fe8b3aa7d76f 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -138,6 +138,7 @@ void msm_gem_vunmap(struct drm_gem_object *obj, enum msm_gem_lock subclass);
 struct msm_gem_submit {
 	struct drm_device *dev;
 	struct msm_gpu *gpu;
+	struct msm_gem_address_space *aspace;
 	struct list_head node;   /* node in ring submit list */
 	struct list_head bo_list;
 	struct ww_acquire_ctx ticket;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 7bd83e0afa97..d5dffcba9919 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -31,8 +31,8 @@
 #define BO_PINNED   0x2000
 
 static struct msm_gem_submit *submit_create(struct drm_device *dev,
-		struct msm_gpu *gpu, struct msm_gpu_submitqueue *queue,
-		uint32_t nr_bos, uint32_t nr_cmds)
+		struct msm_gpu *gpu, struct msm_gem_address_space *aspace,
+		struct msm_gpu_submitqueue *queue, uint32_t nr_bos, uint32_t nr_cmds)
 {
 	struct msm_gem_submit *submit;
 	uint64_t sz = sizeof(*submit) + ((u64)nr_bos * sizeof(submit->bos[0])) +
@@ -46,6 +46,7 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 		return NULL;
 
 	submit->dev = dev;
+	submit->aspace = aspace;
 	submit->gpu = gpu;
 	submit->fence = NULL;
 	submit->pid = get_pid(task_pid(current));
@@ -167,7 +168,7 @@ static void submit_unlock_unpin_bo(struct msm_gem_submit *submit,
 	struct msm_gem_object *msm_obj = submit->bos[i].obj;
 
 	if (submit->bos[i].flags & BO_PINNED)
-		msm_gem_put_iova(&msm_obj->base, submit->gpu->aspace);
+		msm_gem_put_iova(&msm_obj->base, submit->aspace);
 
 	if (submit->bos[i].flags & BO_LOCKED)
 		ww_mutex_unlock(&msm_obj->resv->lock);
@@ -270,7 +271,7 @@ static int submit_pin_objects(struct msm_gem_submit *submit)
 
 		/* if locking succeeded, pin bo: */
 		ret = msm_gem_get_iova(&msm_obj->base,
-				submit->gpu->aspace, &iova);
+				submit->aspace, &iova);
 
 		if (ret)
 			break;
@@ -471,7 +472,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		}
 	}
 
-	submit = submit_create(dev, gpu, queue, args->nr_bos, args->nr_cmds);
+	submit = submit_create(dev, gpu, ctx->aspace, queue, args->nr_bos, args->nr_cmds);
 	if (!submit) {
 		ret = -ENOMEM;
 		goto out_unlock;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 1c09acfb4028..2f45bea04221 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -551,7 +551,7 @@ static void retire_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 		struct msm_gem_object *msm_obj = submit->bos[i].obj;
 		/* move to inactive: */
 		msm_gem_move_to_inactive(&msm_obj->base);
-		msm_gem_put_iova(&msm_obj->base, gpu->aspace);
+		msm_gem_put_iova(&msm_obj->base, submit->aspace);
 		drm_gem_object_put(&msm_obj->base);
 	}
 
@@ -635,8 +635,7 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 
 		/* submit takes a reference to the bo and iova until retired: */
 		drm_gem_object_get(&msm_obj->base);
-		msm_gem_get_iova(&msm_obj->base,
-				submit->gpu->aspace, &iova);
+		msm_gem_get_iova(&msm_obj->base, submit->aspace, &iova);
 
 		if (submit->bos[i].flags & MSM_SUBMIT_BO_WRITE)
 			msm_gem_move_to_active(&msm_obj->base, gpu, true, submit->fence);
-- 
2.17.0
