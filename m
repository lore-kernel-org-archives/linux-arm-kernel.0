From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 25 Nov 2015 23:48:33 +0800
Subject: [PATCH v3 1/2] clocksource/drivers/dw_apb_timer: Inline apbt_readl
 and apbt_writel
In-Reply-To: <1448466514-5298-1-git-send-email-jszhang@marvell.com>
References: <1448466514-5298-1-git-send-email-jszhang@marvell.com>
Message-ID: <1448466514-5298-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems gcc can automatically inline apbt_writel() for us, but
apbt_real isn't inlined. This patch makes them inline to get a trivial
performance improvement: the time __apbt_read_clocksource() spends on
Marvell BG4CT platform:

 before the patch 1275240ns on average
 after the patch 1263240ns on average

so we get 1% performance improvement.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clocksource/dw_apb_timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
index 3a6d9db..114696b 100644
--- a/drivers/clocksource/dw_apb_timer.c
+++ b/drivers/clocksource/dw_apb_timer.c
@@ -49,13 +49,13 @@ clocksource_to_dw_apb_clocksource(struct clocksource *cs)
 	return container_of(cs, struct dw_apb_clocksource, cs);
 }
 
-static u32 apbt_readl(struct dw_apb_timer *timer, unsigned long offs)
+static inline u32 apbt_readl(struct dw_apb_timer *timer, unsigned long offs)
 {
 	return readl(timer->base + offs);
 }
 
-static void apbt_writel(struct dw_apb_timer *timer, u32 val,
-		 unsigned long offs)
+static inline void apbt_writel(struct dw_apb_timer *timer, u32 val,
+			unsigned long offs)
 {
 	writel(val, timer->base + offs);
 }
-- 
2.6.2
