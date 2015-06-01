From: ruchandani.tina@gmail.com (Tina Ruchandani)
Date: Mon, 1 Jun 2015 08:43:08 +0530
Subject: [PATCH] drm/exynos/ipp: Replace struct timeval usage
Message-ID: <20150601031308.GA2785@tinar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'struct timeval' uses a 32-bit seconds representation which
will overflow in the year 2038 and beyond. This patch
replaces the use of struct timeval with struct timespec64
which uses a 64-bit seconds representation and is y2038 safe.

The patch is part of a larger effort to remove all 32-bit
timekeeping variables (timeval, time_t and timespec) from the
kernel.
---
 drivers/gpu/drm/exynos/exynos_drm_ipp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
index b7f1cbc..7cd4a97 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
+#include <linux/time64.h>
 
 #include <drm/drmP.h>
 #include <drm/exynos_drm.h>
@@ -1414,7 +1415,7 @@ static int ipp_send_event(struct exynos_drm_ippdrv *ippdrv,
 	struct drm_exynos_ipp_queue_buf qbuf;
 	struct drm_exynos_ipp_send_event *e;
 	struct list_head *head;
-	struct timeval now;
+	struct timespec64 now;
 	unsigned long flags;
 	u32 tbuf_id[EXYNOS_DRM_OPS_MAX] = {0, };
 	int ret, i;
@@ -1518,10 +1519,11 @@ static int ipp_send_event(struct exynos_drm_ippdrv *ippdrv,
 	e = list_first_entry(&c_node->event_list,
 		struct drm_exynos_ipp_send_event, base.link);
 
-	do_gettimeofday(&now);
-	DRM_DEBUG_KMS("tv_sec[%ld]tv_usec[%ld]\n", now.tv_sec, now.tv_usec);
+	getnstimeofday64(&now);
+	DRM_DEBUG_KMS("tv_sec[%lld]tv_usec[%lld]\n", now.tv_sec, (now.tv_nsec /
+								NSEC_PER_SEC));
 	e->event.tv_sec = now.tv_sec;
-	e->event.tv_usec = now.tv_usec;
+	e->event.tv_usec = now.tv_nsec / NSEC_PER_SEC;
 	e->event.prop_id = property->prop_id;
 
 	/* set buffer id about source destination */
-- 
2.2.0.rc0.207.ga3a616c
