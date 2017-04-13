From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Thu, 13 Apr 2017 12:18:50 +0800
Subject: [PATCH] [media] mtk-mdp: Fix g_/s_selection capture/compose logic
Message-ID: <1492057130-1194-1-git-send-email-minghsiu.tsai@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Kurtz <djkurtz@chromium.org>

Experiments show that the:
 (1) mtk-mdp uses the _MPLANE form of CAPTURE/OUTPUT
 (2) CAPTURE types use CROP targets, and OUTPUT types use COMPOSE targets

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>

---
 drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
index 13afe48..8ab7ca0 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
@@ -837,12 +837,12 @@ static int mtk_mdp_m2m_g_selection(struct file *file, void *fh,
 	struct mtk_mdp_ctx *ctx = fh_to_ctx(fh);
 	bool valid = false;
 
-	if (s->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
-		if (mtk_mdp_is_target_compose(s->target))
-			valid = true;
-	} else if (s->type == V4L2_BUF_TYPE_VIDEO_OUTPUT) {
+	if (s->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		if (mtk_mdp_is_target_crop(s->target))
 			valid = true;
+	} else if (s->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		if (mtk_mdp_is_target_compose(s->target))
+			valid = true;
 	}
 	if (!valid) {
 		mtk_mdp_dbg(1, "[%d] invalid type:%d,%u", ctx->id, s->type,
@@ -907,12 +907,12 @@ static int mtk_mdp_m2m_s_selection(struct file *file, void *fh,
 	int ret;
 	bool valid = false;
 
-	if (s->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
-		if (s->target == V4L2_SEL_TGT_COMPOSE)
-			valid = true;
-	} else if (s->type == V4L2_BUF_TYPE_VIDEO_OUTPUT) {
+	if (s->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		if (s->target == V4L2_SEL_TGT_CROP)
 			valid = true;
+	} else if (s->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		if (s->target == V4L2_SEL_TGT_COMPOSE)
+			valid = true;
 	}
 	if (!valid) {
 		mtk_mdp_dbg(1, "[%d] invalid type:%d,%u", ctx->id, s->type,
@@ -925,7 +925,7 @@ static int mtk_mdp_m2m_s_selection(struct file *file, void *fh,
 	if (ret)
 		return ret;
 
-	if (mtk_mdp_is_target_crop(s->target))
+	if (mtk_mdp_is_target_compose(s->target))
 		frame = &ctx->s_frame;
 	else
 		frame = &ctx->d_frame;
-- 
1.9.1
