From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Tue, 20 Sep 2011 17:00:25 +0530
Subject: [PATCH v16 10/12] OMAP: dmtimer: extend spinlock in request functions
In-Reply-To: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1316518227-28116-11-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The request functions now verify the success of omap_dm_timer_prepare() call
after a timer is acquired. If *_prepare() fails then we have to release the
timer. In order to avoid race condition during this time, include *_prepare()
within lock.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index f549c63..631b6af 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -166,7 +166,6 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 		timer->reserved = 1;
 		break;
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (timer) {
 		ret = omap_dm_timer_prepare(timer);
@@ -175,6 +174,7 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 			timer = NULL;
 		}
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (!timer)
 		pr_debug("%s: timer request failed!\n", __func__);
@@ -197,7 +197,6 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (timer) {
 		ret = omap_dm_timer_prepare(timer);
@@ -206,6 +205,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 			timer = NULL;
 		}
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (!timer)
 		pr_debug("%s: timer%d request failed!\n", __func__, id);
-- 
1.7.0.4
