From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 13:05:36 +0800
Subject: [PATCH v3 05/11] ARM: highbank: use clocksource_of_init for sp804
In-Reply-To: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1363151142-32162-6-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since sp804 hardware information could be stored in DTS file, remove
those ioremap operations. Use clocksource_of_init() instead.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/boot/dts/ecx-common.dtsi |    4 +++-
 arch/arm/mach-highbank/highbank.c |   19 +------------------
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/ecx-common.dtsi b/arch/arm/boot/dts/ecx-common.dtsi
index d61b535..7ae5b2d 100644
--- a/arch/arm/boot/dts/ecx-common.dtsi
+++ b/arch/arm/boot/dts/ecx-common.dtsi
@@ -105,8 +105,10 @@
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0xfff34000 0x1000>;
 			interrupts = <0 18 4>;
-			clocks = <&pclk>;
+			clocks = <&pclk &pclk>;
 			clock-names = "apb_pclk";
+			arm,sp804-clocksource = <0x20>;
+			arm,sp804-clockevent = <0>;
 		};
 
 		rtc at fff35000 {
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index cfd843b..7829c2d 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -91,33 +91,16 @@ static void __init highbank_init_irq(void)
 #endif
 }
 
-static struct clk_lookup lookup = {
-	.dev_id = "sp804",
-	.con_id = NULL,
-};
-
 static void __init highbank_timer_init(void)
 {
-	int irq;
 	struct device_node *np;
-	void __iomem *timer_base;
 
 	/* Map system registers */
 	np = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
 	sregs_base = of_iomap(np, 0);
 	WARN_ON(!sregs_base);
 
-	np = of_find_compatible_node(NULL, NULL, "arm,sp804");
-	timer_base = of_iomap(np, 0);
-	WARN_ON(!timer_base);
-	irq = irq_of_parse_and_map(np, 0);
-
-	of_clk_init(NULL);
-	lookup.clk = of_clk_get(np, 0);
-	clkdev_add(&lookup);
-
-	sp804_clocksource_and_sched_clock_init(timer_base + 0x20, "timer1");
-	sp804_clockevents_init(timer_base, irq, "timer0");
+	clocksource_of_init();
 
 	twd_local_timer_of_register();
 
-- 
1.7.10.4
