From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Apr 2015 13:42:51 +0900
Subject: [PATCH 1/3] clocksource: exynos_mct: Change exynos4_mct_tick_clear
 return type to void
Message-ID: <1430368973-23786-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return value of exynos4_mct_tick_clear() was never checked so it can
be safely changed to void.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 83564c9cfdbe..87c2e558c465 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -413,7 +413,7 @@ static inline void exynos4_tick_set_mode(enum clock_event_mode mode,
 	}
 }
 
-static int exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
+static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
 {
 	struct clock_event_device *evt = &mevt->evt;
 
@@ -426,12 +426,8 @@ static int exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
 		exynos4_mct_tick_stop(mevt);
 
 	/* Clear the MCT tick interrupt */
-	if (readl_relaxed(reg_base + mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1) {
+	if (readl_relaxed(reg_base + mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1)
 		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
-		return 1;
-	} else {
-		return 0;
-	}
 }
 
 static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
-- 
1.9.1
