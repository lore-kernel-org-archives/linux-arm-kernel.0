From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon,  1 Oct 2012 23:12:06 +0200
Subject: [PATCH V2 3/3] clocksource: time-armada-370-xp converted to clk
 framework
In-Reply-To: <1349125926-16144-1-git-send-email-gregory.clement@free-electrons.com>
References: <1349125926-16144-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1349125926-16144-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts      |    4 ----
 arch/arm/boot/dts/armada-370-xp.dtsi     |    1 +
 drivers/clocksource/time-armada-370-xp.c |   11 ++++++-----
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index fffd5c2..4a31b03 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -34,9 +34,5 @@
 			clock-frequency = <200000000>;
 			status = "okay";
 		};
-		timer at d0020300 {
-			clock-frequency = <600000000>;
-			status = "okay";
-		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 6b6b932..e62f478 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -62,6 +62,7 @@
 			       compatible = "marvell,armada-370-xp-timer";
 			       reg = <0xd0020300 0x30>;
 			       interrupts = <37>, <38>, <39>, <40>;
+			       clocks = <&coreclk 2>;
 		};
 	};
 };
diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index 4674f94..a4605fd 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/kernel.h>
+#include <linux/clk.h>
 #include <linux/timer.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
@@ -167,7 +168,6 @@ void __init armada_370_xp_timer_init(void)
 	u32 u;
 	struct device_node *np;
 	unsigned int timer_clk;
-	int ret;
 	np = of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-timer");
 	timer_base = of_iomap(np, 0);
 	WARN_ON(!timer_base);
@@ -179,13 +179,14 @@ void __init armada_370_xp_timer_init(void)
 		       timer_base + TIMER_CTRL_OFF);
 		timer_clk = 25000000;
 	} else {
-		u32 clk = 0;
-		ret = of_property_read_u32(np, "clock-frequency", &clk);
-		WARN_ON(!clk || ret < 0);
+		unsigned long rate = 0;
+		struct clk *clk = of_clk_get(np, 0);
+		WARN_ON(IS_ERR(clk));
+		rate =  clk_get_rate(clk);
 		u = readl(timer_base + TIMER_CTRL_OFF);
 		writel(u & ~(TIMER0_25MHZ | TIMER1_25MHZ),
 		       timer_base + TIMER_CTRL_OFF);
-		timer_clk = clk / TIMER_DIVIDER;
+		timer_clk = rate / TIMER_DIVIDER;
 	}
 
 	/* We use timer 0 as clocksource, and timer 1 for
-- 
1.7.9.5
