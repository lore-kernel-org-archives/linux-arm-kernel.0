From: joelf@ti.com (Joel Fernandes)
Date: Wed, 16 Apr 2014 19:03:18 -0500
Subject: [PATCH 8/9] ARM: OMAP: dmtimer: Add function to check for timer
 availability
In-Reply-To: <1397692999-7800-1-git-send-email-joelf@ti.com>
References: <1397692999-7800-1-git-send-email-joelf@ti.com>
Message-ID: <1397692999-7800-8-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify the check for a timer availability in atleast 4 places by providing a
function to do the same.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 8a4a97c..7e806f9 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -704,14 +704,22 @@ int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_disable);
 
+static int is_timer_available(struct omap_dm_timer *timer)
+{
+	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+		pr_err("Timer not available or enabled.\n");
+		WARN_ON(1);
+		return 0;
+	}
+	return 1;
+}
+
 unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 {
 	unsigned int l;
 
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
-		pr_err("%s: timer not available or enabled.\n", __func__);
+	if (!is_timer_available(timer))
 		return 0;
-	}
 
 	l = __raw_readl(timer->irq_stat);
 
@@ -721,7 +729,7 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
 
 int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev)))
+	if (!is_timer_available(timer))
 		return -EINVAL;
 
 	__omap_dm_timer_write_status(timer, value);
@@ -732,10 +740,8 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
 
 unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
-		pr_err("%s: timer not iavailable or enabled.\n", __func__);
+	if (!is_timer_available(timer))
 		return 0;
-	}
 
 	return __omap_dm_timer_read_counter(timer, timer->posted);
 }
@@ -743,10 +749,8 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
 
 int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
-		pr_err("%s: timer not available or enabled.\n", __func__);
+	if (!is_timer_available(timer))
 		return -EINVAL;
-	}
 
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, value);
 
-- 
1.7.9.5
