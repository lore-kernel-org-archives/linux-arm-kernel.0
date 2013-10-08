From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Tue,  8 Oct 2013 16:06:04 +0530
Subject: [PATCH] DRM: TTM: Fix memory leak issue in ttm_agp_tt_create().
Message-ID: <1381228565-20846-1-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds kfree() in ttm_agp_tt_create() to avoide the
memory leak, without this there is a chance of memory leak in
ttm_tt_init() fail case.

Signed-off-by: Jeyaraman R <jeyaraman.rangasamy@lge.com>
Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Jones <davej@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: dri-devel at lists.freedesktop.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/gpu/drm/ttm/ttm_agp_backend.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/ttm/ttm_agp_backend.c b/drivers/gpu/drm/ttm/ttm_agp_backend.c
index 3302f99..764be36 100644
--- a/drivers/gpu/drm/ttm/ttm_agp_backend.c
+++ b/drivers/gpu/drm/ttm/ttm_agp_backend.c
@@ -126,6 +126,7 @@ struct ttm_tt *ttm_agp_tt_create(struct ttm_bo_device *bdev,
 	agp_be->ttm.func = &ttm_agp_func;
 
 	if (ttm_tt_init(&agp_be->ttm, bdev, size, page_flags, dummy_read_page)) {
+		kfree(agp_be);
 		return NULL;
 	}
 
-- 
1.7.9.5
