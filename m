From: ccross@android.com (Colin Cross)
Date: Wed, 17 Nov 2010 16:20:15 -0800
Subject: [PATCH] ARM: tegra: timer: Separate clocksource and sched_clock
Message-ID: <1290039615-23407-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tegra_clocksource_read should not use cnt32_to_63, wrapping is
already handled in the clocksource code.  Move the cnt32_to_63
into the sched_clock function, and replace the use of clocksource
mult and shift with a multiplication by 1000 to convert us to ns.

Change-Id: Ica1158c3fbed0ba53391f7db61180129a957511d
Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/timer.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 9057d6f..b49f2f5 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -91,7 +91,7 @@ static void tegra_timer_set_mode(enum clock_event_mode mode,
 
 static cycle_t tegra_clocksource_read(struct clocksource *cs)
 {
-	return cnt32_to_63(timer_readl(TIMERUS_CNTR_1US));
+	return timer_readl(TIMERUS_CNTR_1US);
 }
 
 static struct clock_event_device tegra_clockevent = {
@@ -106,14 +106,13 @@ static struct clocksource tegra_clocksource = {
 	.name	= "timer_us",
 	.rating	= 300,
 	.read	= tegra_clocksource_read,
-	.mask	= 0x7FFFFFFFFFFFFFFFULL,
+	.mask	= CLOCKSOURCE_MASK(32),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
 unsigned long long sched_clock(void)
 {
-	return clocksource_cyc2ns(tegra_clocksource.read(&tegra_clocksource),
-		tegra_clocksource.mult, tegra_clocksource.shift);
+	return cnt32_to_63(timer_readl(TIMERUS_CNTR_1US)) * 1000;
 }
 
 static irqreturn_t tegra_timer_interrupt(int irq, void *dev_id)
-- 
1.7.3.1
