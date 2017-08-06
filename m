From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun,  6 Aug 2017 10:25:15 +0200
Subject: [PATCH 06/12] [media] exynos-gsc: constify v4l2_m2m_ops structures
In-Reply-To: <1502007921-22968-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1502007921-22968-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1502007921-22968-7-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/media/platform/exynos-gsc/gsc-m2m.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-m2m.c b/drivers/media/platform/exynos-gsc/gsc-m2m.c
index 33611a4..2a2994e 100644
--- a/drivers/media/platform/exynos-gsc/gsc-m2m.c
+++ b/drivers/media/platform/exynos-gsc/gsc-m2m.c
@@ -747,7 +747,7 @@ static int gsc_m2m_mmap(struct file *file, struct vm_area_struct *vma)
 	.mmap		= gsc_m2m_mmap,
 };
 
-static struct v4l2_m2m_ops gsc_m2m_ops = {
+static const struct v4l2_m2m_ops gsc_m2m_ops = {
 	.device_run	= gsc_m2m_device_run,
 	.job_abort	= gsc_m2m_job_abort,
 };
