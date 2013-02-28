From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Thu, 28 Feb 2013 11:01:06 +0100
Subject: [PATCH RESEND 1/2] clocksource: dbx500-prcmu: use relaxed readl
 variant
Message-ID: <1362045667-23891-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

Modify clksrc_dbx500_prcmu_read to replace readl() with readl_relaxed().
This speeds up calls to the function by about 40%.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/clocksource/clksrc-dbx500-prcmu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index c26c369..159f54a 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -33,15 +33,14 @@
 
 static void __iomem *clksrc_dbx500_timer_base;
 
-static cycle_t clksrc_dbx500_prcmu_read(struct clocksource *cs)
+static cycle_t notrace clksrc_dbx500_prcmu_read(struct clocksource *cs)
 {
+	void __iomem *base = clksrc_dbx500_timer_base;
 	u32 count, count2;
 
 	do {
-		count = readl(clksrc_dbx500_timer_base +
-			      PRCMU_TIMER_DOWNCOUNT);
-		count2 = readl(clksrc_dbx500_timer_base +
-			       PRCMU_TIMER_DOWNCOUNT);
+		count = readl_relaxed(base + PRCMU_TIMER_DOWNCOUNT);
+		count2 = readl_relaxed(base + PRCMU_TIMER_DOWNCOUNT);
 	} while (count2 != count);
 
 	/* Negate because the timer is a decrementing counter */
-- 
1.7.12.1
