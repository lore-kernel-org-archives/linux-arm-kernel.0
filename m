From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 14 Jun 2017 14:39:41 +0200
Subject: [PATCH 20/23] clocksource/drivers/tcb_clksrc: Save timer context on
 suspend/resume
In-Reply-To: <1497443984-12371-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170614123800.GH2261@mai>
 <1497443984-12371-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1497443984-12371-20-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

On sama5d2, power to the core may be cut while entering suspend mode. It is
necessary to save and restore the TCB registers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/tcb_clksrc.c | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index d4ca996..828729c 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -9,6 +9,7 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/syscore_ops.h>
 #include <linux/atmel_tc.h>
 
 
@@ -40,6 +41,14 @@
  */
 
 static void __iomem *tcaddr;
+static struct
+{
+	u32 cmr;
+	u32 imr;
+	u32 rc;
+	bool clken;
+} tcb_cache[3];
+static u32 bmr_cache;
 
 static u64 tc_get_cycles(struct clocksource *cs)
 {
@@ -61,12 +70,54 @@ static u64 tc_get_cycles32(struct clocksource *cs)
 	return __raw_readl(tcaddr + ATMEL_TC_REG(0, CV));
 }
 
+void tc_clksrc_suspend(struct clocksource *cs)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tcb_cache); i++) {
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
+	for (i = 0; i < ARRAY_SIZE(tcb_cache); i++) {
+		/* Restore registers for the channel, RA and RB are not used  */
+		writel(tcb_cache[i].cmr, tcaddr + ATMEL_TC_REG(i, CMR));
+		writel(tcb_cache[i].rc, tcaddr + ATMEL_TC_REG(i, RC));
+		writel(0, tcaddr + ATMEL_TC_REG(i, RA));
+		writel(0, tcaddr + ATMEL_TC_REG(i, RB));
+		/* Disable all the interrupts */
+		writel(0xff, tcaddr + ATMEL_TC_REG(i, IDR));
+		/* Reenable interrupts that were enabled before suspending */
+		writel(tcb_cache[i].imr, tcaddr + ATMEL_TC_REG(i, IER));
+		/* Start the clock if it was used */
+		if (tcb_cache[i].clken)
+			writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(i, CCR));
+	}
+
+	/* Dual channel, chain channels */
+	writel(bmr_cache, tcaddr + ATMEL_TC_BMR);
+	/* Finally, trigger all the channels*/
+	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
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
2.7.4
