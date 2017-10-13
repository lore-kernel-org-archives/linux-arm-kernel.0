From: volodymyr_babchuk@epam.com (Volodymyr Babchuk)
Date: Fri, 13 Oct 2017 22:32:44 +0300
Subject: [PATCH v1 14/14] tee: shm: inline tee_shm_get_id()
In-Reply-To: <1507923164-12796-1-git-send-email-volodymyr_babchuk@epam.com>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
 <1507923164-12796-1-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <1507923164-12796-15-git-send-email-volodymyr_babchuk@epam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Volodymyr Babchuk <vlad.babchuk@gmail.com>

Now, when struct tee_shm is defined in public header,
we can inline small getter functions like this one.

Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
---

 * Previously this patch moved tee_shm_is_registered() also,
   but now it is declared as inline in the same patch that
   adds it. So now this change moves only tee_shm_get_id().
   Commit message was changed accordingly.

---
 drivers/tee/tee_shm.c   | 11 -----------
 include/linux/tee_drv.h |  5 ++++-
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index b48f83d..5f5f771 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -496,17 +496,6 @@ struct tee_shm *tee_shm_get_from_id(struct tee_context *ctx, int id)
 EXPORT_SYMBOL_GPL(tee_shm_get_from_id);
 
 /**
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
-/**
  * tee_shm_put() - Decrease reference count on a shared memory handle
  * @shm:	Shared memory handle
  */
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 9cd4e5f..c36ecea 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -428,7 +428,10 @@ static inline size_t tee_shm_get_page_offset(struct tee_shm *shm)
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
-- 
2.7.4
