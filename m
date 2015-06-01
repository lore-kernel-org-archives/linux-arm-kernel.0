From: ruchandani.tina@gmail.com (Tina Ruchandani)
Date: Mon, 1 Jun 2015 08:36:18 +0530
Subject: [PATCH] drm/exynos: g2d: Replace struct timeval usage
Message-ID: <20150601030618.GA2754@tinar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'struct timeval' uses a 32-bit seconds representation which
will overflow in the year 2038 and beyond. This patch
replaces the use of struct timeval with struct timespec64
which uses a 64-bit seconds representation and is y2038 safe.

The patch is part of a larger effort to remove all 32-bit
timekeeping variables (timeval, time_t and timespec) from the
kernel.

Signed-off-by: Tina Ruchandani <ruchandani.tina@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 81a2508..69e236f 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/time64.h>
 #include <linux/workqueue.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-attrs.h>
@@ -889,7 +890,7 @@ static void g2d_finish_event(struct g2d_data *g2d, u32 cmdlist_no)
 	struct drm_device *drm_dev = g2d->subdrv.drm_dev;
 	struct g2d_runqueue_node *runqueue_node = g2d->runqueue_node;
 	struct drm_exynos_pending_g2d_event *e;
-	struct timeval now;
+	struct timespec64 now;
 	unsigned long flags;
 
 	if (list_empty(&runqueue_node->event_list))
@@ -898,9 +899,9 @@ static void g2d_finish_event(struct g2d_data *g2d, u32 cmdlist_no)
 	e = list_first_entry(&runqueue_node->event_list,
 			     struct drm_exynos_pending_g2d_event, base.link);
 
-	do_gettimeofday(&now);
+	getnstimeofday64(&now);
 	e->event.tv_sec = now.tv_sec;
-	e->event.tv_usec = now.tv_usec;
+	e->event.tv_usec = (now.tv_nsec / NSEC_PER_USEC);
 	e->event.cmdlist_no = cmdlist_no;
 
 	spin_lock_irqsave(&drm_dev->event_lock, flags);
-- 
2.2.0.rc0.207.ga3a616c
