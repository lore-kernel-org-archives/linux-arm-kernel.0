From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 3 Jun 2013 00:56:02 +0200
Subject: [PATCH 01/10] clocksource: dw_apb_timer_of: use the clocksource as
 sched clock if necessary
In-Reply-To: <201306030055.15413.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de>
Message-ID: <201306030056.03522.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the dw_apb_timer always expects a separate special timer to be
availbable for the sched_clock. Some devices using dw_apb_timers do not
have the sptimer but can use the clocksource as sched_clock.
Therefore this patch adds using the clocksource timer as
a fallback if no usable sched timer is found.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clocksource/dw_apb_timer_of.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index ab09ed3..d6c0fda 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -57,6 +57,9 @@ static void add_clockevent(struct device_node *event_timer)
 	dw_apb_clockevent_register(ced);
 }
 
+static void __iomem *sched_io_base;
+static u32 sched_rate;
+
 static void add_clocksource(struct device_node *source_timer)
 {
 	void __iomem *iobase;
@@ -71,9 +74,15 @@ static void add_clocksource(struct device_node *source_timer)
 
 	dw_apb_clocksource_start(cs);
 	dw_apb_clocksource_register(cs);
-}
 
-static void __iomem *sched_io_base;
+	/*
+	 * Fallback to use the clocksource as sched_clock if no separate
+	 * timer is found. sched_io_base then points to the current_value
+	 * register of the clocksource timer.
+	 */
+	sched_io_base = iobase + 0x04;
+	sched_rate = rate;
+}
 
 static u32 read_sched_clock(void)
 {
@@ -89,16 +98,15 @@ static const struct of_device_id sptimer_ids[] __initconst = {
 static void init_sched_clock(void)
 {
 	struct device_node *sched_timer;
-	u32 rate;
 
 	sched_timer = of_find_matching_node(NULL, sptimer_ids);
-	if (!sched_timer)
-		panic("No RTC for sched clock to use");
-
-	timer_get_base_and_rate(sched_timer, &sched_io_base, &rate);
-	of_node_put(sched_timer);
+	if (sched_timer) {
+		timer_get_base_and_rate(sched_timer, &sched_io_base,
+					&sched_rate);
+		of_node_put(sched_timer);
+	}
 
-	setup_sched_clock(read_sched_clock, 32, rate);
+	setup_sched_clock(read_sched_clock, 32, sched_rate);
 }
 
 static const struct of_device_id osctimer_ids[] __initconst = {
-- 
1.7.2.3
