From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Mon, 15 May 2017 15:01:10 +0200
Subject: [PATCH] tee: optee: fix uninitialized symbol 'parg'
Message-ID: <1494853270-22019-1-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the static checker warning in optee_release().
error: uninitialized symbol 'parg'.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 58169e519422..857141e29e80 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -224,13 +224,14 @@ static void optee_release(struct tee_context *ctx)
 	if (!IS_ERR(shm)) {
 		arg = tee_shm_get_va(shm, 0);
 		/*
-		 * If va2pa fails for some reason, we can't call
-		 * optee_close_session(), only free the memory. Secure OS
-		 * will leak sessions and finally refuse more sessions, but
-		 * we will at least let normal world reclaim its memory.
+		 * If va2pa fails for some reason, we can't call into
+		 * secure world, only free the memory. Secure OS will leak
+		 * sessions and finally refuse more sessions, but we will
+		 * at least let normal world reclaim its memory.
 		 */
 		if (!IS_ERR(arg))
-			tee_shm_va2pa(shm, arg, &parg);
+			if (tee_shm_va2pa(shm, arg, &parg))
+				arg = NULL; /* prevent usage of parg below */
 	}
 
 	list_for_each_entry_safe(sess, sess_tmp, &ctxdata->sess_list,
-- 
2.7.4
