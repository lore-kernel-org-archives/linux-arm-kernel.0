From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  2 Feb 2017 19:51:54 +0100
Subject: [PATCH 04/23] TCB backup
In-Reply-To: <20170202185213.21698-1-alexandre.belloni@free-electrons.com>
References: <20170202185213.21698-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170202185213.21698-4-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/tcb_clksrc.c | 55 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index d4ca9962a759..e49f6cf2daf3 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -3,7 +3,7 @@
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-
+#include <linux/syscore_ops.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/ioport.h>
@@ -39,7 +39,15 @@
  * For deeper system sleep states, this will be mandatory...
  */
 
-static void __iomem *tcaddr;
+void __iomem *tcaddr;
+static struct
+{
+	u32 cmr;
+	u32 imr;
+	u32 rc;
+	bool clken;
+} tcb_cache[3];
+u32 bmr_cache;
 
 static u64 tc_get_cycles(struct clocksource *cs)
 {
@@ -61,12 +69,55 @@ static u64 tc_get_cycles32(struct clocksource *cs)
 	return __raw_readl(tcaddr + ATMEL_TC_REG(0, CV));
 }
 
+void tc_clksrc_suspend(struct clocksource *cs)
+{
+	int i;
+
+	for (i = 0; i < 3; i++) {
+		tcb_cache[i].cmr = readl(tcaddr + ATMEL_TC_REG(i, CMR));
+		tcb_cache[i].imr = readl(tcaddr + ATMEL_TC_REG(i, IMR));
+		tcb_cache[i].rc = readl(tcaddr + ATMEL_TC_REG(i, RC));
+		tcb_cache[i].clken = !!(readl(tcaddr + ATMEL_TC_REG(i, SR)) &
+					ATMEL_TC_CLKSTA);
+	}
+
+	bmr_cache = readl(tcaddr + ATMEL_TC_BMR);
+}
+
+void tc_clksrc_resume(struct clocksource *cs)
+{
+	int i;
+
+	for (i = 0; i < 3; i++) {
+		__raw_writel(tcb_cache[i].cmr, tcaddr + ATMEL_TC_REG(i, CMR));
+		__raw_writel(0, tcaddr + ATMEL_TC_REG(i, RA));
+		__raw_writel(0, tcaddr + ATMEL_TC_REG(i, RB));
+		__raw_writel(tcb_cache[i].rc, tcaddr + ATMEL_TC_REG(i, RC));
+		__raw_writel(0xff, tcaddr + ATMEL_TC_REG(i, IDR));
+		__raw_writel(tcb_cache[i].imr, tcaddr + ATMEL_TC_REG(i, IER));
+		if (tcb_cache[i].clken)
+			__raw_writel(ATMEL_TC_CLKEN, tcaddr +
+				     ATMEL_TC_REG(i, CCR));
+	}
+
+	writel(bmr_cache, tcaddr + ATMEL_TC_BMR);
+	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
+
+	for (i = 0; i < 3; i++) {
+		tcb_cache[i].cmr = readl(tcaddr + ATMEL_TC_REG(i, CMR));
+		tcb_cache[i].imr = readl(tcaddr + ATMEL_TC_REG(i, IMR));
+		tcb_cache[i].rc = readl(tcaddr + ATMEL_TC_REG(i, RC));
+	}
+}
+
 static struct clocksource clksrc = {
 	.name           = "tcb_clksrc",
 	.rating         = 200,
 	.read           = tc_get_cycles,
 	.mask           = CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend	= tc_clksrc_suspend,
+	.resume		= tc_clksrc_resume,
 };
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
-- 
2.11.0
