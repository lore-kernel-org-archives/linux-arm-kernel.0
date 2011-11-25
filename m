From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Thu, 24 Nov 2011 22:12:49 -0600
Subject: [PATCH 1/2] ARM: OMAP: dmtimer: fix sleeping function called from
 invalid context
In-Reply-To: <1322194370-8073-1-git-send-email-omar.ramirez@ti.com>
References: <1322194370-8073-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <1322194370-8073-2-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap_dm_timer_request* holds a spin_lock_irqsave while inner routines call
clk_get_sys which holds a mutex_lock, given that mutex can be put to sleep
a BUG message is triggered. This occurs in 2 ocassions.

1. When the fck is gotten at the beginning of omap_dm_timer_prepare by using
   clk_get (which will call clk_get_sys), this was fixed by getting the clock
   handles on probe.

2. When omap_dm_timer_set_source tries to get the clock handles (with clk_get)
   for the fck and source clock, this was moved to be made after
   spin_unlock_irqsave when the context is not atomic anymore.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   69 +++++++++++++++++++++++++----------------
 1 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index af3b92b..2acd4de 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -134,22 +134,13 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
 	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
-	int ret;
-
-	timer->fclk = clk_get(&timer->pdev->dev, "fck");
-	if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
-		timer->fclk = NULL;
-		dev_err(&timer->pdev->dev, ": No fclk handle.\n");
-		return -EINVAL;
-	}
 
 	if (pdata->needs_manual_reset)
 		omap_dm_timer_reset(timer);
 
-	ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
-
 	timer->posted = 1;
-	return ret;
+
+	return 0;
 }
 
 struct omap_dm_timer *omap_dm_timer_request(void)
@@ -168,19 +159,26 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 		break;
 	}
 
-	if (timer) {
-		ret = omap_dm_timer_prepare(timer);
-		if (ret) {
-			timer->reserved = 0;
-			timer = NULL;
-		}
+	if (!timer) {
+		spin_unlock_irqrestore(&dm_timer_lock, flags);
+		goto err_no_timer;
 	}
+
+	omap_dm_timer_prepare(timer);
+
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
-	if (!timer)
-		pr_debug("%s: timer request failed!\n", __func__);
+	ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+	if (ret) {
+		timer->reserved = 0;
+		goto err_no_timer;
+	}
 
 	return timer;
+
+err_no_timer:
+	pr_debug("%s: timer request failed!\n", __func__);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_request);
 
@@ -199,19 +197,26 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 		}
 	}
 
-	if (timer) {
-		ret = omap_dm_timer_prepare(timer);
-		if (ret) {
-			timer->reserved = 0;
-			timer = NULL;
-		}
+	if (!timer) {
+		spin_unlock_irqrestore(&dm_timer_lock, flags);
+		goto err_no_timer;
 	}
+
+	omap_dm_timer_prepare(timer);
+
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
-	if (!timer)
-		pr_debug("%s: timer%d request failed!\n", __func__, id);
+	ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+	if (ret) {
+		timer->reserved = 0;
+		goto err_no_timer;
+	}
 
 	return timer;
+
+err_no_timer:
+	pr_debug("%s: timer%d request failed!\n", __func__, id);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
 
@@ -658,6 +663,14 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 		goto err_free_mem;
 	}
 
+	timer->fclk = clk_get(&pdev->dev, "fck");
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
+		timer->fclk = NULL;
+		dev_err(&pdev->dev, ": No fclk handle for id %d.\n", pdev->id);
+		ret = -EINVAL;
+		goto err_clk_handle;
+	}
+
 	timer->id = pdev->id;
 	timer->irq = irq->start;
 	timer->reserved = pdata->reserved;
@@ -686,6 +699,8 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_clk_handle:
+	iounmap(timer->io_base);
 err_free_mem:
 	kfree(timer);
 
-- 
1.7.5.4
