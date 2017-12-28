From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Thu, 28 Dec 2017 16:38:56 +0100
Subject: [PATCH 1/2] tee: add start argument to shm_register callback
In-Reply-To: <20171228153857.30086-1-jens.wiklander@linaro.org>
References: <20171228153857.30086-1-jens.wiklander@linaro.org>
Message-ID: <20171228153857.30086-2-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a start argument to the shm_register callback to allow the callback
to check memory type of the passed pages.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c          | 6 ++++--
 drivers/tee/optee/optee_private.h | 6 ++++--
 drivers/tee/tee_shm.c             | 2 +-
 include/linux/tee_drv.h           | 3 ++-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index e675e82ff095..d61c14b788f2 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -536,7 +536,8 @@ void optee_free_pages_list(void *list, size_t num_entries)
 }
 
 int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
-		       struct page **pages, size_t num_pages)
+		       struct page **pages, size_t num_pages,
+		       unsigned long start)
 {
 	struct tee_shm *shm_arg = NULL;
 	struct optee_msg_arg *msg_arg;
@@ -606,7 +607,8 @@ int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
 }
 
 int optee_shm_register_supp(struct tee_context *ctx, struct tee_shm *shm,
-			    struct page **pages, size_t num_pages)
+			    struct page **pages, size_t num_pages,
+			    unsigned long start)
 {
 	/*
 	 * We don't want to register supplicant memory in OP-TEE.
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index de7962ebc1b6..f04930879762 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -173,11 +173,13 @@ void optee_enable_shm_cache(struct optee *optee);
 void optee_disable_shm_cache(struct optee *optee);
 
 int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
-		       struct page **pages, size_t num_pages);
+		       struct page **pages, size_t num_pages,
+		       unsigned long start);
 int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm);
 
 int optee_shm_register_supp(struct tee_context *ctx, struct tee_shm *shm,
-			    struct page **pages, size_t num_pages);
+			    struct page **pages, size_t num_pages,
+			    unsigned long start);
 int optee_shm_unregister_supp(struct tee_context *ctx, struct tee_shm *shm);
 
 int optee_from_msg_param(struct tee_param *params, size_t num_params,
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 04e1b8b37046..6a17b02ada5e 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -299,7 +299,7 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 	}
 
 	rc = teedev->desc->ops->shm_register(ctx, shm, shm->pages,
-					     shm->num_pages);
+					     shm->num_pages, start);
 	if (rc) {
 		ret = ERR_PTR(rc);
 		goto err;
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index a1d7f467657c..230a1ebbf3bc 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -108,7 +108,8 @@ struct tee_driver_ops {
 	int (*supp_send)(struct tee_context *ctx, u32 ret, u32 num_params,
 			 struct tee_param *param);
 	int (*shm_register)(struct tee_context *ctx, struct tee_shm *shm,
-			    struct page **pages, size_t num_pages);
+			    struct page **pages, size_t num_pages,
+			    unsigned long start);
 	int (*shm_unregister)(struct tee_context *ctx, struct tee_shm *shm);
 };
 
-- 
2.14.1
