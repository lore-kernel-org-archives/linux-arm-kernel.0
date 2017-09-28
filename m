From: volodymyr_babchuk@epam.com (Volodymyr Babchuk)
Date: Thu, 28 Sep 2017 21:04:11 +0300
Subject: [PATCH v1 14/14] tee: shm: inline tee_shm getter functions
In-Reply-To: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <1506621851-6929-15-git-send-email-volodymyr_babchuk@epam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Volodymyr Babchuk <vlad.babchuk@gmail.com>

Now, when struct tee_shm is defined in public header,
we can inline small getter functions.

Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
---
 drivers/tee/tee_shm.c   | 17 -----------------
 include/linux/tee_drv.h | 10 ++++++++--
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 5176c83..453700a 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -494,23 +494,6 @@ struct tee_shm *tee_shm_get_from_id(struct tee_context *ctx, int id)
 }
 EXPORT_SYMBOL_GPL(tee_shm_get_from_id);
 
-bool tee_shm_is_registered(struct tee_shm *shm)
-{
-	return shm && (shm->flags & TEE_SHM_REGISTER);
-}
-EXPORT_SYMBOL_GPL(tee_shm_is_registered);
-
-/**
- * tee_shm_get_id() - Get id of a shared memory object
- * @shm:	Shared memory handle
- * @returns id
- */
-int tee_shm_get_id(struct tee_shm *shm)
-{
-	return shm->id;
-}
-EXPORT_SYMBOL_GPL(tee_shm_get_id);
-
 /**
  * tee_shm_put() - Decrease reference count on a shared memory handle
  * @shm:	Shared memory handle
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 6aaef65..2ae0286 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -429,7 +429,10 @@ static inline size_t tee_shm_get_page_offset(struct tee_shm *shm)
  * @shm:	Shared memory handle
  * @returns id
  */
-int tee_shm_get_id(struct tee_shm *shm);
+static inline int tee_shm_get_id(struct tee_shm *shm)
+{
+	return shm->id;
+}
 
 /**
  * tee_shm_get_from_id() - Find shared memory object and increase reference
@@ -445,6 +448,9 @@ struct tee_shm *tee_shm_get_from_id(struct tee_context *ctx, int id);
  * @shm:	Shared memory handle
  * @returns true if object is registered in TEE
  */
-bool tee_shm_is_registered(struct tee_shm *shm);
+static inline bool tee_shm_is_registered(struct tee_shm *shm)
+{
+	return shm && (shm->flags & TEE_SHM_REGISTER);
+}
 
 #endif /*__TEE_DRV_H*/
-- 
2.7.4
