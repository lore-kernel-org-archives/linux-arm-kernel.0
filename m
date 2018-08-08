From: mchehab+samsung@kernel.org (Mauro Carvalho Chehab)
Date: Wed,  8 Aug 2018 10:52:51 -0400
Subject: [PATCH 1/6] media: exynos-gsc: fix return code if mutex was
 interrupted
Message-ID: <577a6299b1881c011bb82adb8a321ce72599a33c.1533739965.git.mchehab+samsung@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All poll routines expect a poll flag, and not error codes. So,
instead of returning -ERESTARTSYS if the mutex got interrupted,
return EPOLERR, just like the V4L2 VB2 code.

Solves this sparce warning:
	drivers/media/platform/exynos-gsc/gsc-m2m.c:716:24: warning: incorrect type in return expression (different base types)
	drivers/media/platform/exynos-gsc/gsc-m2m.c:716:24:    expected restricted __poll_t
	drivers/media/platform/exynos-gsc/gsc-m2m.c:716:24:    got int

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/platform/exynos-gsc/gsc-m2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-m2m.c b/drivers/media/platform/exynos-gsc/gsc-m2m.c
index e9ff27949a91..c9d2f6c5311a 100644
--- a/drivers/media/platform/exynos-gsc/gsc-m2m.c
+++ b/drivers/media/platform/exynos-gsc/gsc-m2m.c
@@ -713,7 +713,7 @@ static __poll_t gsc_m2m_poll(struct file *file,
 	__poll_t ret;
 
 	if (mutex_lock_interruptible(&gsc->lock))
-		return -ERESTARTSYS;
+		return EPOLLERR;
 
 	ret = v4l2_m2m_poll(file, ctx->m2m_ctx, wait);
 	mutex_unlock(&gsc->lock);
-- 
2.17.1
