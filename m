From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Thu, 24 Nov 2011 22:12:50 -0600
Subject: [PATCH 2/2] ARM: OMAP: dmtimer: reorganize omap_dm_timer_request_*
In-Reply-To: <1322194370-8073-1-git-send-email-omar.ramirez@ti.com>
References: <1322194370-8073-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <1322194370-8073-3-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap_dm_timer_request and omap_dm_timer_request_specific have almost
the same code except for a conditional check and the parameters they
receive.

omap_dm_timer_request_specific can be sent a -1 parameter to contain
the behavior of omap_dm_timer_request and thus get rid of some lines
of code.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |   83 ++++++++---------------------
 arch/arm/plat-omap/include/plat/dmtimer.h |    6 ++-
 2 files changed, 26 insertions(+), 63 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 2acd4de..aa7e6da 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -131,88 +131,49 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 	timer->posted = 1;
 }
 
-int omap_dm_timer_prepare(struct omap_dm_timer *timer)
-{
-	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
-
-	if (pdata->needs_manual_reset)
-		omap_dm_timer_reset(timer);
-
-	timer->posted = 1;
-
-	return 0;
-}
-
-struct omap_dm_timer *omap_dm_timer_request(void)
+struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 {
-	struct omap_dm_timer *timer = NULL, *t;
+	struct omap_dm_timer *t = NULL;
+	struct dmtimer_platform_data *pdata;
 	unsigned long flags;
 	int ret = 0;
 
 	spin_lock_irqsave(&dm_timer_lock, flags);
-	list_for_each_entry(t, &omap_timer_list, node) {
-		if (t->reserved)
-			continue;
-
-		timer = t;
-		timer->reserved = 1;
-		break;
-	}
 
-	if (!timer) {
-		spin_unlock_irqrestore(&dm_timer_lock, flags);
-		goto err_no_timer;
-	}
-
-	omap_dm_timer_prepare(timer);
-
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
-
-	ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
-	if (ret) {
-		timer->reserved = 0;
-		goto err_no_timer;
-	}
-
-	return timer;
-
-err_no_timer:
-	pr_debug("%s: timer request failed!\n", __func__);
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_request);
-
-struct omap_dm_timer *omap_dm_timer_request_specific(int id)
-{
-	struct omap_dm_timer *timer = NULL, *t;
-	unsigned long flags;
-	int ret = 0;
+	if (id == -1) {
+		list_for_each_entry(t, &omap_timer_list, node) {
+			if (!t->reserved)
+				break;
+		}
 
-	spin_lock_irqsave(&dm_timer_lock, flags);
-	list_for_each_entry(t, &omap_timer_list, node) {
-		if (t->pdev->id == id && !t->reserved) {
-			timer = t;
-			timer->reserved = 1;
-			break;
+	} else {
+		list_for_each_entry(t, &omap_timer_list, node) {
+			if (t->pdev->id == id && !t->reserved)
+				break;
 		}
 	}
 
-	if (!timer) {
+	if (!t) {
 		spin_unlock_irqrestore(&dm_timer_lock, flags);
 		goto err_no_timer;
 	}
 
-	omap_dm_timer_prepare(timer);
+	t->reserved = 1;
+	t->posted = 1;
+
+	pdata = t->pdev->dev.platform_data;
+	if (pdata->needs_manual_reset)
+		omap_dm_timer_reset(t);
 
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
-	ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+	ret = omap_dm_timer_set_source(t, OMAP_TIMER_SRC_32_KHZ);
 	if (ret) {
-		timer->reserved = 0;
+		t->reserved = 0;
 		goto err_no_timer;
 	}
 
-	return timer;
+	return t;
 
 err_no_timer:
 	pr_debug("%s: timer%d request failed!\n", __func__, id);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 9418f00..b8b563d 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -107,7 +107,6 @@ struct dmtimer_platform_data {
 	int (*get_context_loss_count)(struct device *dev);
 };
 
-struct omap_dm_timer *omap_dm_timer_request(void);
 struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
 int omap_dm_timer_free(struct omap_dm_timer *timer);
 void omap_dm_timer_enable(struct omap_dm_timer *timer);
@@ -282,7 +281,10 @@ struct omap_dm_timer {
 	int (*get_context_loss_count)(struct device *dev);
 };
 
-int omap_dm_timer_prepare(struct omap_dm_timer *timer);
+static inline struct omap_dm_timer *omap_dm_timer_request(void)
+{
+	return omap_dm_timer_request_specific(-1);
+}
 
 static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
 						int posted)
-- 
1.7.5.4
