From: 21cnbao@gmail.com (Barry Song)
Date: Mon,  5 May 2014 19:30:04 +0800
Subject: [PATCH] clocksource:sirf: remove the hardcode for the clk of timers
Message-ID: <1399289404-10247-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhiwu Song <Zhiwu.Song@csr.com>

Nobody want to know the connection between io clk and timer clk,
so exposing this information to timer module is not reasonable.
this patch moves to define the timers' clk in dt.

Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi      |    1 +
 arch/arm/boot/dts/prima2.dtsi      |    1 +
 drivers/clocksource/timer-marco.c  |    8 +++-----
 drivers/clocksource/timer-prima2.c |    5 +----
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 9d72674..317bc59 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -195,6 +195,7 @@
 				compatible = "sirf,prima2-tick";
 				reg = <0xb0020000 0x1000>;
 				interrupts = <0>;
+				clocks = <&clks 11>;
 			};
 
 			nand at b0030000 {
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 1e82571..7e7d884 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -201,6 +201,7 @@
 				compatible = "sirf,prima2-tick";
 				reg = <0xb0020000 0x1000>;
 				interrupts = <0>;
+				clocks = <&clks 11>;
 			};
 
 			nand at b0030000 {
diff --git a/drivers/clocksource/timer-marco.c b/drivers/clocksource/timer-marco.c
index b52e1c0..571d109 100644
--- a/drivers/clocksource/timer-marco.c
+++ b/drivers/clocksource/timer-marco.c
@@ -252,15 +252,13 @@ static void __init sirfsoc_clockevent_init(void)
 }
 
 /* initialize the kernel jiffy timer source */
-static void __init sirfsoc_marco_timer_init(void)
+static void __init sirfsoc_marco_timer_init(struct device_node *np)
 {
 	unsigned long rate;
 	u32 timer_div;
 	struct clk *clk;
 
-	/* timer's input clock is io clock */
-	clk = clk_get_sys("io", NULL);
-
+	clk = of_clk_get(np, 0);
 	BUG_ON(IS_ERR(clk));
 	rate = clk_get_rate(clk);
 
@@ -303,6 +301,6 @@ static void __init sirfsoc_of_timer_init(struct device_node *np)
 	if (!sirfsoc_timer1_irq.irq)
 		panic("No irq passed for timer1 via DT\n");
 
-	sirfsoc_marco_timer_init();
+	sirfsoc_marco_timer_init(np);
 }
 CLOCKSOURCE_OF_DECLARE(sirfsoc_marco_timer, "sirf,marco-tick", sirfsoc_of_timer_init );
diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index 1a6b2d6..19bc0a9 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -185,11 +185,8 @@ static void __init sirfsoc_prima2_timer_init(struct device_node *np)
 	unsigned long rate;
 	struct clk *clk;
 
-	/* timer's input clock is io clock */
-	clk = clk_get_sys("io", NULL);
-
+	clk = of_clk_get(np, 0);
 	BUG_ON(IS_ERR(clk));
-
 	rate = clk_get_rate(clk);
 
 	BUG_ON(rate < PRIMA2_CLOCK_FREQ);
-- 
1.7.5.4
