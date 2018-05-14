From: baolin.wang@linaro.org (Baolin Wang)
Date: Mon, 14 May 2018 16:55:30 +0800
Subject: [RFC PATCH 04/10] clocksource: tegra20_timer: Remove
 register_persistent_clock() API
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
Message-ID: <ee93d3f510b1840199f6c9afe8cb08c82d3afcf2.1526285602.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will convert all drivers to use persistent clock framework to compensate
the suspend time for OS time, instead of using the register_persistent_clock()
API in ARM architecture.

So this patch removes the register_persistent_clock() and implement its
function to read persistent clock.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/tegra20_timer.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index c337a81..97a34cb 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -124,7 +124,7 @@ static u64 tegra_rtc_read_ms(void)
 }
 
 /*
- * tegra_read_persistent_clock64 -  Return time from a persistent clock.
+ * read_persistent_clock64 -  Return time from a persistent clock.
  *
  * Reads the time from a source which isn't disabled during PM, the
  * 32k sync timer.  Convert the cycles elapsed since last read into
@@ -133,10 +133,16 @@ static u64 tegra_rtc_read_ms(void)
  * tegra_rtc driver could be executing to avoid race conditions
  * on the RTC shadow register
  */
-static void tegra_read_persistent_clock64(struct timespec64 *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	u64 delta;
 
+	if (!rtc_base) {
+		ts->tv_sec = 0;
+		ts->tv_nsec = 0;
+		return;
+	}
+
 	last_persistent_ms = persistent_ms;
 	persistent_ms = tegra_rtc_read_ms();
 	delta = persistent_ms - last_persistent_ms;
@@ -259,6 +265,6 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	else
 		clk_prepare_enable(clk);
 
-	return register_persistent_clock(NULL, tegra_read_persistent_clock64);
+	return 0;
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
-- 
1.7.9.5
