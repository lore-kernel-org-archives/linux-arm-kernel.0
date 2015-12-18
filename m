From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:10 +0100
Subject: [PATCH 57/69] clocksource/drivers/tango-xtal: Replace code by
 clocksource_mmio_init
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-57-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code to initialize, register and read the clocksource is
already factored out in mmio.c via the clocksource_mmio_init function.

Factor out the code with the clocksource_mmio_init function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig      |  1 +
 drivers/clocksource/tango_xtal.c | 18 +++---------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index db240cb..b251013 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -351,6 +351,7 @@ config CLKSRC_TANGO_XTAL
 	bool "Clocksource for Tango SoC" if COMPILE_TEST
 	depends on ARM
 	select CLKSRC_OF
+	select CLKSRC_MMIO
 	help
 	  This enables the clocksource for Tango SoC
 
diff --git a/drivers/clocksource/tango_xtal.c b/drivers/clocksource/tango_xtal.c
index d297b30..2bcecaf 100644
--- a/drivers/clocksource/tango_xtal.c
+++ b/drivers/clocksource/tango_xtal.c
@@ -19,19 +19,6 @@ static u64 notrace read_sched_clock(void)
 	return read_xtal_counter();
 }
 
-static cycle_t read_clocksource(struct clocksource *cs)
-{
-	return read_xtal_counter();
-}
-
-static struct clocksource tango_xtal = {
-	.name	= "tango-xtal",
-	.rating	= 350,
-	.read	= read_clocksource,
-	.mask	= CLOCKSOURCE_MASK(32),
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 static void __init tango_clocksource_init(struct device_node *np)
 {
 	struct clk *clk;
@@ -53,8 +40,9 @@ static void __init tango_clocksource_init(struct device_node *np)
 	delay_timer.freq = xtal_freq;
 	delay_timer.read_current_timer = read_xtal_counter;
 
-	ret = clocksource_register_hz(&tango_xtal, xtal_freq);
-	if (ret != 0) {
+	ret = clocksource_mmio_init(xtal_in_cnt, "tango-xtal", xtal_freq, 350,
+				    32, clocksource_mmio_readl_up);
+	if (!ret) {
 		pr_err("%s: registration failed\n", np->full_name);
 		return;
 	}
-- 
1.9.1
