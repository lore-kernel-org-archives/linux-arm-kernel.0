From: thibault.saunier@osg.samsung.com (Thibault Saunier)
Date: Fri, 10 Feb 2017 11:10:20 -0300
Subject: [PATCH v3 2/4] [media] exynos-gsc: Respect userspace colorspace
 setting in try_fmt
In-Reply-To: <20170210141022.25412-1-thibault.saunier@osg.samsung.com>
References: <20170210141022.25412-1-thibault.saunier@osg.samsung.com>
Message-ID: <20170210141022.25412-3-thibault.saunier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the colorspace is specified by userspace we should respect
it and not reset it ourself if we can support it.

Signed-off-by: Thibault Saunier <thibault.saunier@osg.samsung.com>

---

Changes in v3:
- Do not check values in the g_fmt functions as Andrzej explained in previous review
- Set colorspace if user passed V4L2_COLORSPACE_DEFAULT in

Changes in v2: None

 drivers/media/platform/exynos-gsc/gsc-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
index db7d9883861b..021598817938 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/exynos-gsc/gsc-core.c
@@ -472,10 +472,13 @@ int gsc_try_fmt_mplane(struct gsc_ctx *ctx, struct v4l2_format *f)
 
 	pix_mp->num_planes = fmt->num_planes;
 
-	if (pix_mp->width > 720 && pix_mp->height > 576) /* HD */
-		pix_mp->colorspace = V4L2_COLORSPACE_REC709;
-	else /* SD */
-		pix_mp->colorspace = V4L2_COLORSPACE_SMPTE170M;
+	if (pix_mp->colorspace != V4L2_COLORSPACE_REC709 &&
+		pix_mp->colorspace != V4L2_COLORSPACE_SMPTE170M) {
+		if (pix_mp->width > 720 && pix_mp->height > 576) /* HD */
+			pix_mp->colorspace = V4L2_COLORSPACE_REC709;
+		else /* SD */
+			pix_mp->colorspace = V4L2_COLORSPACE_SMPTE170M;
+	}
 
 	for (i = 0; i < pix_mp->num_planes; ++i) {
 		struct v4l2_plane_pix_format *plane_fmt = &pix_mp->plane_fmt[i];
-- 
2.11.1
