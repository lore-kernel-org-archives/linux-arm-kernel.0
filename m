From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed,  8 Nov 2017 13:47:50 +0100
Subject: [PATCH 1/3] tee: add tee_param_is_memref() for driver use
In-Reply-To: <1510145272-14842-1-git-send-email-jens.wiklander@linaro.org>
References: <1510145272-14842-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <1510145272-14842-2-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Etienne Carriere <etienne.carriere@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_core.c  | 16 ++--------------
 include/linux/tee_drv.h | 12 ++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 58a5009eacc3..c78104589e42 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -221,18 +221,6 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
 	return 0;
 }
 
-static bool param_is_memref(struct tee_param *param)
-{
-	switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
-	case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
-	case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
-	case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static int tee_ioctl_open_session(struct tee_context *ctx,
 				  struct tee_ioctl_buf_data __user *ubuf)
 {
@@ -296,7 +284,7 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
 	if (params) {
 		/* Decrease ref count for all valid shared memory pointers */
 		for (n = 0; n < arg.num_params; n++)
-			if (param_is_memref(params + n) &&
+			if (tee_param_is_memref(params + n) &&
 			    params[n].u.memref.shm)
 				tee_shm_put(params[n].u.memref.shm);
 		kfree(params);
@@ -358,7 +346,7 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
 	if (params) {
 		/* Decrease ref count for all valid shared memory pointers */
 		for (n = 0; n < arg.num_params; n++)
-			if (param_is_memref(params + n) &&
+			if (tee_param_is_memref(params + n) &&
 			    params[n].u.memref.shm)
 				tee_shm_put(params[n].u.memref.shm);
 		kfree(params);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index cb889afe576b..f4a0ac05ebb4 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -275,4 +275,16 @@ int tee_shm_get_id(struct tee_shm *shm);
  */
 struct tee_shm *tee_shm_get_from_id(struct tee_context *ctx, int id);
 
+static inline bool tee_param_is_memref(struct tee_param *param)
+{
+	switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
+	case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
+	case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
+	case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 #endif /*__TEE_DRV_H*/
-- 
2.7.4
