From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 29 Aug 2013 10:53:09 -0700
Subject: [PATCH RFC 2/3] clocksource/cadence_ttc: Make clocksource optional
In-Reply-To: <1377798790-28927-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1377798790-28927-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1377798790-28927-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms, like Zynq, the input clock for the TTC is directly
derived from the CPU clock, which means it scales when cpufreq adjusts
the CPU frequency.
At the same time the clocksource core expects a clocksource to be
stable and doesn't allow frequency adjustments.

Therefore a new flag - 'input-clock-unstable' - is added to the DT
bindings for this driver. In case the flag is present the driver does
not register the timer as clocksource.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt | 4 ++++
 drivers/clocksource/cadence_ttc_timer.c                       | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt b/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt
index 993695c..a936c0a 100644
--- a/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt
+++ b/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt
@@ -6,6 +6,10 @@ Required properties:
 - interrupts : A list of 3 interrupts; one per timer channel.
 - clocks: phandle to the source clock
 
+Optional properties:
+- input-clock-unstable : Mark the timer's input clock as unstable. E.g. it
+			 scales with cpufreq.
+
 Example:
 
 ttc0: ttc0 at f8001000 {
diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index 99ec898..66aaf6a 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -407,7 +407,8 @@ static void __init ttc_timer_init(struct device_node *timer)
 		BUG();
 	}
 
-	ttc_setup_clocksource(clk_cs, timer_baseaddr);
+	if (!of_property_read_bool(timer, "input-clock-unstable"))
+		ttc_setup_clocksource(clk_cs, timer_baseaddr);
 	ttc_setup_clockevent(clk_ce, timer_baseaddr + 4, irq);
 
 	pr_info("%s #0 at %p, irq=%d\n", timer->name, timer_baseaddr, irq);
-- 
1.8.4
