From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 13 Dec 2017 19:53:13 +0100
Subject: [PATCH 3/3] clocksource/drivers: integrator-ap: parse the chosen node
In-Reply-To: <20171213185313.20017-1-alexandre.belloni@free-electrons.com>
References: <20171213185313.20017-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171213185313.20017-4-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver currently uses aliases to know whether the timer is the
clocksource or the clockevent. Add the /chosen/linux,clocksource and
/chosen/linux,clockevent parsing while keeping backward compatibility.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/Kconfig               |  1 +
 drivers/clocksource/timer-integrator-ap.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 9a22d1048fcf..053aca99caf7 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -212,6 +212,7 @@ config KEYSTONE_TIMER
 config INTEGRATOR_AP_TIMER
 	bool "Integrator-ap timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
+	select TIMER_OF
 	help
 	  Enables support for the Integrator-ap timer.
 
diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index 62d24690ba02..8f38be724aff 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -197,6 +197,17 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 	rate = clk_get_rate(clk);
 	writel(0, base + TIMER_CTRL);
 
+	if (timer_of_is_clocksource(node))
+		/* The primary timer lacks IRQ, use as clocksource */
+		return integrator_clocksource_init(rate, base);
+
+	if (timer_of_is_clockevent(node)) {
+		/* The secondary timer will drive the clock event */
+		irq = irq_of_parse_and_map(node, 0);
+		return integrator_clockevent_init(rate, base, irq);
+	}
+
+	/* DT ABI compatibility below */
 	err = of_property_read_string(of_aliases,
 				"arm,timer-primary", &path);
 	if (err) {
-- 
2.15.1
