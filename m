From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun,  6 Aug 2017 10:25:12 +0200
Subject: [PATCH 03/12] [media] s5p-g2d: constify v4l2_m2m_ops structures
In-Reply-To: <1502007921-22968-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1502007921-22968-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1502007921-22968-4-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/media/platform/s5p-g2d/g2d.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-g2d/g2d.c b/drivers/media/platform/s5p-g2d/g2d.c
index 81ed5cd..bd655b5 100644
--- a/drivers/media/platform/s5p-g2d/g2d.c
+++ b/drivers/media/platform/s5p-g2d/g2d.c
@@ -611,7 +611,7 @@ static irqreturn_t g2d_isr(int irq, void *prv)
 	.vfl_dir	= VFL_DIR_M2M,
 };
 
-static struct v4l2_m2m_ops g2d_m2m_ops = {
+static const struct v4l2_m2m_ops g2d_m2m_ops = {
 	.device_run	= device_run,
 	.job_abort	= job_abort,
 };
