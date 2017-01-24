From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 24 Jan 2017 18:42:26 -0300
Subject: [PATCH] [media] exynos-gsc: Avoid spamming the log on VIDIOC_TRY_FMT
Message-ID: <1485294146-7467-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There isn't an ioctl to enum the supported field orders, so a user-space
application can call VIDIOC_TRY_FMT using different field orders to know
if one is supported. For example, GStreamer does this so during playback
dozens of the following messages appear in the kernel log buffer:

[ 442.143393] Not supported field order(4)

Instead of printing this as an error, just keep it as debug information.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/media/platform/exynos-gsc/gsc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
index 8524fe15fa80..678b600f0500 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/exynos-gsc/gsc-core.c
@@ -408,7 +408,7 @@ int gsc_try_fmt_mplane(struct gsc_ctx *ctx, struct v4l2_format *f)
 	if (pix_mp->field == V4L2_FIELD_ANY)
 		pix_mp->field = V4L2_FIELD_NONE;
 	else if (pix_mp->field != V4L2_FIELD_NONE) {
-		pr_err("Not supported field order(%d)\n", pix_mp->field);
+		pr_debug("Not supported field order(%d)\n", pix_mp->field);
 		return -EINVAL;
 	}
 
-- 
2.7.4
