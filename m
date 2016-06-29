From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Wed, 29 Jun 2016 17:33:56 -0600
Subject: [PATCH] media: s5p-mfc fix vidioc_g_crop() to return crop info.
Message-ID: <1467243236-13395-1-git-send-email-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix vidioc_g_crop() to report crop information irrepective of ctx state.
g_crop is expected to return crop information as long as the passed in
v4l2_crop type field is vV4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index a01a373..4ace9e1 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -774,12 +774,9 @@ static int vidioc_g_crop(struct file *file, void *priv,
 	struct s5p_mfc_dev *dev = ctx->dev;
 	u32 left, right, top, bottom;
 
-	if (ctx->state != MFCINST_HEAD_PARSED &&
-	ctx->state != MFCINST_RUNNING && ctx->state != MFCINST_FINISHING
-					&& ctx->state != MFCINST_FINISHED) {
-			mfc_err("Cannont set crop\n");
-			return -EINVAL;
-		}
+	if (cr->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		return -EINVAL;
+
 	if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_H264) {
 		left = s5p_mfc_hw_call(dev->mfc_ops, get_crop_info_h, ctx);
 		right = left >> S5P_FIMV_SHARED_CROP_RIGHT_SHIFT;
-- 
2.7.4
