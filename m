From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 13 Nov 2015 15:46:47 +0800
Subject: [PATCH] clocksource/drivers/dw_apb_timer: use {readl|writel}_relaxed
Message-ID: <1447400807-4706-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

readl/writel is too expensive on Cortex A9 w/ outer L2 cache,
especially the writel will try to hold l2x0_lock, which could increase
chance of L2 cache maintance spinning at the l2x0_lock.

The driver does not perform DMA, so it's safe to use the relaxed
version. From another side, the relaxed io accessor macros are
available on all architectures now, so we can use the relaxed versions
to get a trivial overall system performance improvement on some
architectures.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clocksource/dw_apb_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
index c76c750..04282ee 100644
--- a/drivers/clocksource/dw_apb_timer.c
+++ b/drivers/clocksource/dw_apb_timer.c
@@ -51,13 +51,13 @@ clocksource_to_dw_apb_clocksource(struct clocksource *cs)
 
 static unsigned long apbt_readl(struct dw_apb_timer *timer, unsigned long offs)
 {
-	return readl(timer->base + offs);
+	return readl_relaxed(timer->base + offs);
 }
 
 static void apbt_writel(struct dw_apb_timer *timer, unsigned long val,
 		 unsigned long offs)
 {
-	writel(val, timer->base + offs);
+	writel_relaxed(val, timer->base + offs);
 }
 
 static void apbt_disable_int(struct dw_apb_timer *timer)
-- 
2.6.2
