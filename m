From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 6 Jul 2017 15:51:27 -0500
Subject: [PATCH] mediatek: constify vb2_ops structure
Message-ID: <20170706205127.GA20926@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for vb2_ops structures that are only stored in the ops field of a
vb2_queue structure. That field is declared const, so vb2_ops structures
that have this property can be declared as const also.

This issue was detected using Coccinelle and the following semantic patch:

@r disable optional_qualifier@
identifier i;
position p;
@@
static struct vb2_ops i at p = { ... };

@ok@
identifier r.i;
struct vb2_queue e;
position p;
@@
e.ops = &i at p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct vb2_ops e;
@@
e at i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
struct vb2_ops i = { ... };

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index 451a540..f17a86b 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -756,7 +756,7 @@ static void mtk_jpeg_stop_streaming(struct vb2_queue *q)
 	pm_runtime_put_sync(ctx->jpeg->dev);
 }
 
-static struct vb2_ops mtk_jpeg_qops = {
+static const struct vb2_ops mtk_jpeg_qops = {
 	.queue_setup        = mtk_jpeg_queue_setup,
 	.buf_prepare        = mtk_jpeg_buf_prepare,
 	.buf_queue          = mtk_jpeg_buf_queue,
-- 
2.5.0
