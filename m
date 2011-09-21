From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 21 Sep 2011 23:17:45 +0800
Subject: [PATCH v2 1/3] ARM: CSR: PM: save/restore timer status in suspend
	cycle
In-Reply-To: <1316618267-4348-1-git-send-email-21cnbao@gmail.com>
References: <1316618267-4348-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1316618267-4348-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <baohua.song@csr.com>

SiRFprimaII will lose power in deepsleep mode except rtc, pmu and sdram
self-refresh.
This patch saves timer-related registers while suspending and restore
them while resuming.

Signed-off-by: Barry Song <baohua.song@csr.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-prima2/timer.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-prima2/timer.c b/arch/arm/mach-prima2/timer.c
index ed7ec48..3b15961 100644
--- a/arch/arm/mach-prima2/timer.c
+++ b/arch/arm/mach-prima2/timer.c
@@ -40,6 +40,17 @@
 
 #define SIRFSOC_TIMER_LATCH_BIT	 BIT(0)
 
+#define SIRFSOC_TIMER_REG_CNT 11
+
+static const u32 sirfsoc_timer_reg_list[SIRFSOC_TIMER_REG_CNT] = {
+	SIRFSOC_TIMER_MATCH_0, SIRFSOC_TIMER_MATCH_1, SIRFSOC_TIMER_MATCH_2,
+	SIRFSOC_TIMER_MATCH_3, SIRFSOC_TIMER_MATCH_4, SIRFSOC_TIMER_MATCH_5,
+	SIRFSOC_TIMER_INT_EN, SIRFSOC_TIMER_WATCHDOG_EN, SIRFSOC_TIMER_DIV,
+	SIRFSOC_TIMER_LATCHED_LO, SIRFSOC_TIMER_LATCHED_HI,
+};
+
+static u32 sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT];
+
 static void __iomem *sirfsoc_timer_base;
 static void __init sirfsoc_of_timer_map(void);
 
@@ -106,6 +117,27 @@ static void sirfsoc_timer_set_mode(enum clock_event_mode mode,
 	}
 }
 
+static void sirfsoc_clocksource_suspend(struct clocksource *cs)
+{
+	int i;
+
+	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
+
+	for (i = 0; i < SIRFSOC_TIMER_REG_CNT; i++)
+		sirfsoc_timer_reg_val[i] = readl_relaxed(sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);
+}
+
+static void sirfsoc_clocksource_resume(struct clocksource *cs)
+{
+	int i;
+
+	for (i = 0; i < SIRFSOC_TIMER_REG_CNT; i++)
+		writel_relaxed(sirfsoc_timer_reg_val[i], sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);
+
+	writel_relaxed(sirfsoc_timer_reg_val[i - 2], sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);
+	writel_relaxed(sirfsoc_timer_reg_val[i - 1], sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);
+}
+
 static struct clock_event_device sirfsoc_clockevent = {
 	.name = "sirfsoc_clockevent",
 	.rating = 200,
@@ -120,6 +152,8 @@ static struct clocksource sirfsoc_clocksource = {
 	.mask = CLOCKSOURCE_MASK(64),
 	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
 	.read = sirfsoc_timer_read,
+	.suspend = sirfsoc_clocksource_suspend,
+	.resume = sirfsoc_clocksource_resume,
 };
 
 static struct irqaction sirfsoc_timer_irq = {
-- 
1.7.0.4
