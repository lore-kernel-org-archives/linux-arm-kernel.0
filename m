From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 6 Jul 2017 15:46:00 -0500
Subject: [PATCH] mtk-mdp: constify vb2_ops structure
Message-ID: <20170706204600.GA18061@embeddedgus>
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
 drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
index 13afe48..3038d62 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
@@ -621,7 +621,7 @@ static void mtk_mdp_m2m_buf_queue(struct vb2_buffer *vb)
 	v4l2_m2m_buf_queue(ctx->m2m_ctx, to_vb2_v4l2_buffer(vb));
 }
 
-static struct vb2_ops mtk_mdp_m2m_qops = {
+static const struct vb2_ops mtk_mdp_m2m_qops = {
 	.queue_setup	 = mtk_mdp_m2m_queue_setup,
 	.buf_prepare	 = mtk_mdp_m2m_buf_prepare,
 	.buf_queue	 = mtk_mdp_m2m_buf_queue,
-- 
2.5.0
