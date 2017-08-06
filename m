From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun,  6 Aug 2017 10:25:14 +0200
Subject: [PATCH 05/12] [media] vcodec: mediatek: constify v4l2_m2m_ops
 structures
In-Reply-To: <1502007921-22968-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1502007921-22968-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1502007921-22968-6-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The v4l2_m2m_ops structures are only passed as the only
argument to v4l2_m2m_init, which is declared as const.
Thus the v4l2_m2m_ops structures themselves can be const.

Done with the help of Coccinelle.

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct v4l2_m2m_ops i at p = { ... };

@ok1@
identifier r.i;
position p;
@@
v4l2_m2m_init(&i at p)

@bad@
position p != {r.p,ok1.p};
identifier r.i;
struct v4l2_m2m_ops e;
@@
e at i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct v4l2_m2m_ops i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index f17a86b..226f908 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -865,7 +865,7 @@ static void mtk_jpeg_job_abort(void *priv)
 {
 }
 
-static struct v4l2_m2m_ops mtk_jpeg_m2m_ops = {
+static const struct v4l2_m2m_ops mtk_jpeg_m2m_ops = {
 	.device_run = mtk_jpeg_device_run,
 	.job_ready  = mtk_jpeg_job_ready,
 	.job_abort  = mtk_jpeg_job_abort,
