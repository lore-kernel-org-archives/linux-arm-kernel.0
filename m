From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat,  9 Mar 2013 21:23:21 +0100
Subject: [PATCH v3 12/12] clocksource: samsung-time: Add Device Tree support
In-Reply-To: <1362860601-18464-1-git-send-email-tomasz.figa@gmail.com>
References: <1362860601-18464-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1362860601-18464-13-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for parsing all platform-specific data from
Device Tree and instantiation using clocksource_of_init to samsung-time
clocksource driver.

Cc: devicetree-discuss at lists.ozlabs.org
Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 .../devicetree/bindings/timer/samsung-pwm.txt      |  33 ++++++
 drivers/clocksource/samsung-time.c                 | 116 ++++++++++++++++++++-
 2 files changed, 146 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/samsung-pwm.txt

diff --git a/Documentation/devicetree/bindings/timer/samsung-pwm.txt b/Documentation/devicetree/bindings/timer/samsung-pwm.txt
new file mode 100644
index 0000000..3aabe81
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/samsung-pwm.txt
@@ -0,0 +1,33 @@
+* Samsung PWM timers
+
+Samsung SoCs contain PWM timer blocks which can be used for system clock source
+and clock event timers.
+
+Be aware that this configuration is supported only on uniprocessor platforms.
+For SMP SoCs, SMP-aware timers should be used, like MCT.
+
+Required properties:
+- compatible : should be one of following:
+    samsung,s3c24xx-pwm - for 16-bit timers present on S3C24xx
+    samsung,s3c64xx-pwm - for 32-bit timers present on S3C64xx and newer
+- reg: base address and size of register area
+- interrupts: list of timer interrupts (one interrupt per timer, starting at
+  timer 0)
+
+Optional properties:
+- samsung,prescale-divisor: PWM prescaler divisor (from 1 to 256)
+- samsung,divisor: PWM main divider divisor (1, 2, 4, 8 or 16)
+- samsung,pwm-outputs: list of PWM channels reserved for use as PWM outputs
+    - an array of up to 5 elements being indices of PWM channels (from 0 to 4),
+    the order does not matter.
+
+Example:
+	timer at 7f006000 {
+		compatible = "samsung,s3c64xx-pwm";
+		reg = <0x7f006000 0x1000>;
+		interrupt-parent = <&vic0>;
+		interrupts = <23>, <24>, <25>, <27>, <28>;
+		samsung,prescale-divisor = <2>;
+		samsung,divisor = <1>;
+		samsung,pwm-outputs = <0>, <1>;
+	};
diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index 5c6cfca..dbfc5f2 100644
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
 
 #include <clocksource/samsung-time.h>
@@ -412,9 +415,12 @@ static void __init samsung_timer_resources(void)
 	unsigned long source_id = timer_source.source_id;
 	char devname[15];
 
-	timer_base = ioremap_nocache(timer_variant.reg_base, SZ_4K);
-	if (!timer_base)
-		panic("failed to map timer registers");
+	if (!timer_base) {
+		/* Compatibility fallback for non-DT platforms */
+		timer_base = ioremap_nocache(timer_variant.reg_base, SZ_4K);
+		if (!timer_base)
+			panic("failed to map timer registers");
+	}
 
 	timerclk = clk_get(NULL, "timers");
 	if (IS_ERR(timerclk))
@@ -447,6 +453,11 @@ static void __init samsung_timer_resources(void)
 	clk_enable(tin_source);
 }
 
+enum {
+	TYPE_S3C24XX,
+	TYPE_S3C64XX,
+};
+
 void __init samsung_timer_init(void)
 {
 	if (!timer_source.source_id && !timer_source.event_id)
@@ -459,3 +470,102 @@ void __init samsung_timer_init(void)
 	samsung_clockevent_init();
 	samsung_clocksource_init();
 }
+
+#ifdef CONFIG_OF
+static const struct of_device_id samsung_timer_ids[] = {
+	{ .compatible = "samsung,s3c24xx-pwm", .data = (void *)TYPE_S3C24XX, },
+	{ .compatible = "samsung,s3c64xx-pwm", .data = (void *)TYPE_S3C64XX, },
+	{},
+};
+
+static void __init samsung_of_timer_init(void)
+{
+	const struct of_device_id *match;
+	u8 channel_mask = (1 << 5) - 1;
+	struct device_node *np;
+	struct property *prop;
+	const __be32 *cur;
+	u32 val;
+	int i;
+
+	np = of_find_matching_node_and_match(NULL,
+					samsung_timer_ids, &match);
+	if (!np)
+		panic("timer node not found");
+
+	timer_base = of_iomap(np, 0);
+	if (!timer_base)
+		panic("failed to map timer registers");
+
+	for (i = 0; i < SAMSUNG_PWM_NUM; ++i)
+		timer_variant.irqs[i] = irq_of_parse_and_map(np, i);
+
+	if (!timer_variant.irqs[timer_source.event_id])
+		panic("no clock event irq provided");
+
+	switch ((unsigned int)match->data) {
+	case TYPE_S3C24XX:
+		timer_variant.bits = 16;
+		timer_variant.prescale = 25;
+		timer_variant.divisor = 2;
+		timer_variant.has_tint_cstat = false;
+		break;
+	case TYPE_S3C64XX:
+		timer_variant.bits = 32;
+		timer_variant.prescale = 2;
+		timer_variant.divisor = 1;
+		timer_variant.has_tint_cstat = true;
+		break;
+	}
+
+	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
+		if (val >= SAMSUNG_PWM_NUM) {
+			pr_warning("%s: invalid channel index in samsung,pwm-outputs property\n",
+								__func__);
+			continue;
+		}
+		channel_mask &= ~(1 << val);
+	}
+
+	val = fls(channel_mask);
+	if (!val)
+		panic("failed to find PWM channel for clock source");
+	timer_source.source_id = val - 1;
+	channel_mask &= ~(1 << timer_source.source_id);
+
+	val = fls(channel_mask);
+	if (!val)
+		panic("failed to find PWM channel for clock events");
+	timer_source.event_id = val - 1;
+
+	if (!of_property_read_u32(np, "samsung,prescale-divisor", &val)) {
+		if (val < 1 || val > 256)
+			panic("samsung,prescale-divisor property out of range");
+		timer_variant.prescale = val;
+	}
+
+	if (!of_property_read_u32(np, "samsung,divisor", &val)) {
+		switch (val) {
+		case 1:
+		case 2:
+		case 4:
+		case 8:
+		case 16:
+			timer_variant.divisor = val;
+			break;
+		default:
+			panic("invalid value of samsung,divisor property");
+		}
+	}
+
+	pr_info("samsung-time: using PWM channels %d (source) and %d (event)\n",
+				timer_source.source_id, timer_source.event_id);
+
+	samsung_timer_init();
+}
+#endif /* CONFIG_OF */
+
+CLOCKSOURCE_OF_DECLARE(s3c24xx_timer,
+				"samsung,s3c24xx-pwm", samsung_of_timer_init)
+CLOCKSOURCE_OF_DECLARE(s3c64xx_timer,
+				"samsung,s3c64xx-pwm", samsung_of_timer_init)
-- 
1.8.1.5
