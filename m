From: volodymyr_babchuk@epam.com (Volodymyr Babchuk)
Date: Thu, 28 Sep 2017 21:04:10 +0300
Subject: [PATCH v1 13/14] tee: use reference counting for tee_context
In-Reply-To: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <1506621851-6929-14-git-send-email-volodymyr_babchuk@epam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Volodymyr Babchuk <vlad.babchuk@gmail.com>

We need to ensure that tee_context is present until last
shared buffer will be freed.

Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
---
 drivers/tee/tee_core.c    | 40 +++++++++++++++++++++++++++++++---------
 drivers/tee/tee_private.h |  3 +++
 drivers/tee/tee_shm.c     |  7 +++++++
 include/linux/tee_drv.h   |  7 +++++++
 4 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 295910f..3d49ac2 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -54,6 +54,7 @@ static int tee_open(struct inode *inode, struct file *filp)
 		goto err;
 	}
 
+	kref_init(&ctx->refcount);
 	ctx->teedev = teedev;
 	INIT_LIST_HEAD(&ctx->list_shm);
 	filp->private_data = ctx;
@@ -68,19 +69,40 @@ static int tee_open(struct inode *inode, struct file *filp)
 	return rc;
 }
 
-static int tee_release(struct inode *inode, struct file *filp)
+void teedev_ctx_get(struct tee_context *ctx)
 {
-	struct tee_context *ctx = filp->private_data;
-	struct tee_device *teedev = ctx->teedev;
-	struct tee_shm *shm;
+	if (ctx->releasing)
+		return;
+
+	kref_get(&ctx->refcount);
+}
 
+static void teedev_ctx_release(struct kref *ref)
+{
+	struct tee_context *ctx = container_of(ref, struct tee_context,
+					       refcount);
+	ctx->releasing = true;
 	ctx->teedev->desc->ops->release(ctx);
-	mutex_lock(&ctx->teedev->mutex);
-	list_for_each_entry(shm, &ctx->list_shm, link)
-		shm->ctx = NULL;
-	mutex_unlock(&ctx->teedev->mutex);
 	kfree(ctx);
-	tee_device_put(teedev);
+}
+
+void teedev_ctx_put(struct tee_context *ctx)
+{
+	if (ctx->releasing)
+		return;
+
+	kref_put(&ctx->refcount, teedev_ctx_release);
+}
+
+static void teedev_close_context(struct tee_context *ctx)
+{
+	tee_device_put(ctx->teedev);
+	teedev_ctx_put(ctx);
+}
+
+static int tee_release(struct inode *inode, struct file *filp)
+{
+	teedev_close_context(filp->private_data);
 	return 0;
 }
 
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index 2bc2b5a..85d99d6 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -73,4 +73,7 @@ int tee_shm_get_fd(struct tee_shm *shm);
 bool tee_device_get(struct tee_device *teedev);
 void tee_device_put(struct tee_device *teedev);
 
+void teedev_ctx_get(struct tee_context *ctx);
+void teedev_ctx_put(struct tee_context *ctx);
+
 #endif /*TEE_PRIVATE_H*/
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 1ed708c..5176c83 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -53,6 +53,9 @@ static void tee_shm_release(struct tee_shm *shm)
 		kfree(shm->pages);
 	}
 
+	if (shm->ctx)
+		teedev_ctx_put(shm->ctx);
+
 	kfree(shm);
 
 	tee_device_put(teedev);
@@ -187,6 +190,7 @@ struct tee_shm *__tee_shm_alloc(struct tee_context *ctx,
 	}
 
 	if (ctx) {
+		teedev_ctx_get(ctx);
 		mutex_lock(&teedev->mutex);
 		list_add_tail(&shm->link, &ctx->list_shm);
 		mutex_unlock(&teedev->mutex);
@@ -256,6 +260,8 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 		return ERR_PTR(-EINVAL);
 	}
 
+	teedev_ctx_get(ctx);
+
 	shm = kzalloc(sizeof(*shm), GFP_KERNEL);
 	if (!shm) {
 		ret = ERR_PTR(-ENOMEM);
@@ -332,6 +338,7 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 		kfree(shm->pages);
 	}
 	kfree(shm);
+	teedev_ctx_put(ctx);
 	tee_device_put(teedev);
 	return ret;
 }
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index d773827..6aaef65 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -17,6 +17,7 @@
 
 #include <linux/types.h>
 #include <linux/idr.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/tee.h>
 
@@ -42,11 +43,17 @@ struct tee_shm_pool;
  * @teedev:	pointer to this drivers struct tee_device
  * @list_shm:	List of shared memory object owned by this context
  * @data:	driver specific context data, managed by the driver
+ * @refcount:	reference counter for this structure
+ * @releasing:  flag that indicates if context is being released right now.
+ *		It is needed to break circular dependency on context during
+ *              shared memory release.
  */
 struct tee_context {
 	struct tee_device *teedev;
 	struct list_head list_shm;
 	void *data;
+	struct kref refcount;
+	bool releasing;
 };
 
 struct tee_param_memref {
-- 
2.7.4
