From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 10 Feb 2013 14:20:23 +0100
Subject: [PATCH 12/12] clocksource: samsung-time: Add Device Tree support
In-Reply-To: <1360502423-2246-1-git-send-email-tomasz.figa@gmail.com>
References: <1360502423-2246-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1360502423-2246-13-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for parsing all platform-specific data from
Device Tree and instantiation using clocksource_of_init to samsung-time
clocksource driver.

Cc: devicetree-discuss at lists.ozlabs.org
Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 .../devicetree/bindings/arm/samsung-timer.txt      |  32 +++++++
 drivers/clocksource/samsung-time.c                 | 102 ++++++++++++++++++++-
 2 files changed, 131 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung-timer.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung-timer.txt b/Documentation/devicetree/bindings/arm/samsung-timer.txt
new file mode 100644
index 0000000..8eb7030
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung-timer.txt
@@ -0,0 +1,32 @@
+* Samsung PWM timer
+
+Samsung SoCs contain PWM timer blocks which can be used for system clock source
+and clock event timers.
+
+Be aware that this configuration is supported only on uniprocessor platforms.
+For SMP SoCs, SMP-aware timers should be used, like MCT.
+
+Required properties:
+- compatible : should be one of following:
+    samsung,s3c24xx-pwm-timer - for 16-bit timers present on S3C24xx
+    samsung,s3c64xx-pwm-timer - for 32-bit timers present on S3C64xx and newer
+- reg: base address and size of register area
+- interrupts: interrupt list for all five PWM timers.
+- samsung,source-timer: index of timer to be used as clocksource
+- samsung,event-timer: index of timer to be used as clock event
+
+Optional properties:
+- samsung,prescale: PWM prescaler divisor (from 1 to 256)
+- samsung,divisor: PWM main divider divisor (1, 2, 4, 8 or 16)
+
+Example:
+	timer at 7f006000 {
+		compatible = "samsung,s3c64xx-pwm-timer";
+		reg = <0x7f006000 0x1000>;
+		interrupt-parent = <&vic0>;
+		interrupts = <23>, <24>, <25>, <27>, <28>;
+		samsung,source-timer = <4>;
+		samsung,event-timer = <3>;
+		samsung,prescale = <2>;
+		samsung,divisor = <1>;
+	};
diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index 19a1c8a..63d2992 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -14,6 +14,9 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clockchips.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/samsung-time.h>
 
@@ -479,9 +482,11 @@ static void __init samsung_timer_resources(void)
 	unsigned long source_id = timer_source.source_id;
 	char devname[15];
 
-	timer_base = ioremap_nocache(timer_variant.reg_base, SZ_4K);
-	if (!timer_base)
-		panic("failed to map timer registers");
+	if (!timer_base) {
+		timer_base = ioremap_nocache(timer_variant.reg_base, SZ_4K);
+		if (!timer_base)
+			panic("failed to map timer registers");
+	}
 
 	timerclk = clk_get(NULL, "timers");
 	if (IS_ERR(timerclk))
@@ -514,8 +519,92 @@ static void __init samsung_timer_resources(void)
 	clk_enable(tin_source);
 }
 
+enum {
+	TYPE_S3C24XX,
+	TYPE_S3C64XX,
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id samsung_timer_ids[] = {
+	{ .compatible = "samsung,s3c24xx-pwm-timer",
+					.data = (void *)TYPE_S3C24XX, },
+	{ .compatible = "samsung,s3c64xx-pwm-timer",
+					.data = (void *)TYPE_S3C64XX, },
+	{},
+};
+
+static void samsung_timer_parse_dt(struct device_node *np,
+					const struct of_device_id *match)
+{
+	int i;
+	u32 val;
+
+	if (of_property_read_u32(np, "samsung,source-timer", &val))
+		panic("no samsung,source-timer property provided");
+	if (val > ARRAY_SIZE(timer_variant.irqs))
+		panic("samsung,source-timer property out of range");
+	timer_source.source_id = val;
+
+	if (of_property_read_u32(np, "samsung,event-timer", &val))
+		panic("no samsung,event-timer property provided");
+	if (val > ARRAY_SIZE(timer_variant.irqs))
+		panic("samsung,event-timer property out of range");
+	timer_source.event_id = val;
+
+	timer_base = of_iomap(np, 0);
+	if (!timer_base)
+		panic("failed to map timer registers");
+
+	for (i = 0; i < ARRAY_SIZE(timer_variant.irqs); ++i)
+		timer_variant.irqs[i] = irq_of_parse_and_map(np, i);
+
+	if (!timer_variant.irqs[timer_source.event_id])
+		panic("no clock event irq provided");
+
+	switch ((unsigned int)match->data) {
+	case TYPE_S3C24XX:
+		timer_variant.bits = 16;
+		timer_variant.prescale = 25;
+		timer_variant.prescale = 50;
+		timer_variant.has_tint_cstat = false;
+		break;
+	case TYPE_S3C64XX:
+		timer_variant.bits = 32;
+		timer_variant.prescale = 2;
+		timer_variant.divisor = 2;
+		timer_variant.has_tint_cstat = true;
+		break;
+	}
+
+	if (!of_property_read_u32(np, "samsung,prescale", &val)) {
+		if (val < 1 || val > 256)
+			panic("prescale must be from 1 to 256 range");
+		timer_variant.prescale = val;
+	}
+
+	if (!of_property_read_u32(np, "samsung,divisor", &val)) {
+		if (val > 16 || (1 << (fls(val) - 1)) != val)
+			panic("divsor must be 1, 2, 4, 8 or 16");
+		timer_variant.divisor = timer_variant.prescale * val;
+	}
+}
+#endif
+
 void __init samsung_timer_init(void)
 {
+#ifdef CONFIG_OF
+	struct device_node *np;
+	const struct of_device_id *match;
+
+	if (of_have_populated_dt()) {
+		np = of_find_matching_node_and_match(NULL,
+						samsung_timer_ids, &match);
+		if (!np)
+			panic("timer node not found");
+
+		samsung_timer_parse_dt(np, match);
+	}
+#endif
 	if (!timer_source.source_id && !timer_source.event_id)
 		panic("timer sources not set (see samsung_set_timer_source)!\n");
 
@@ -526,3 +615,10 @@ void __init samsung_timer_init(void)
 	samsung_clockevent_init();
 	samsung_clocksource_init();
 }
+
+#ifdef CONFIG_OF
+CLOCKSOURCE_OF_DECLARE(s3c24xx_timer,
+			"samsung,s3c24xx-pwm-timer", samsung_timer_init)
+CLOCKSOURCE_OF_DECLARE(s3c64xx_timer,
+			"samsung,s3c64xx-pwm-timer", samsung_timer_init)
+#endif
-- 
1.8.1.2
