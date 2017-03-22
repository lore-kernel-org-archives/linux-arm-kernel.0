From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Wed, 22 Mar 2017 18:48:28 +0300
Subject: [PATCH v7 1/7] clocksource/drivers/clksrc-evt-probe: Describe with
 the DT both the clocksource and the clockevent
In-Reply-To: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
References: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1490197714-25415-2-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The CLOCKSOURCE_OF_DECLARE() was introduced before the
CLOCKEVENT_OF_DECLARE() and that resulted in some abuse where the
clockevent and the clocksource are both initialized in the same init
routine.

With the introduction of the CLOCKEVENT_OF_DECLARE(), the driver can
now split the clocksource and the clockevent init code. However, the
device tree may specify a single node, so the same node will be passed
to the clockevent/clocksource's init function, with the same base
address.

with this patch it is possible to specify an attribute to the timer's node to
specify if it is a clocksource or a clockevent and define two timers node.

For example:

        timer: timer at 98400000 {
                compatible = "moxa,moxart-timer";
                reg = <0x98400000 0x42>;
                interrupts = <19 1>;
                clocks = <&coreclk>;
                clockevent;
        };

        timer: timer at 98400010 {
                compatible = "moxa,moxart-timer";
                reg = <0x98400010 0x42>;
                clocks = <&coreclk>;
                clocksource;
        };

With this approach, we allow a mechanism to clearly define a clocksource or a
clockevent without aerobatics we can find around in some drivers:
	timer-sp804.c, arc-timer.c, dw_apb_timer_of.c, mps2-timer.c,
	renesas-ostm.c, time-efm32.c, time-lpc32xx.c.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 Documentation/devicetree/bindings/timer/timer.txt |   38 +++++++++++++++++++++
 drivers/clocksource/clkevt-probe.c                |    7 ++++
 drivers/clocksource/clksrc-probe.c                |    7 ++++
 3 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/timer.txt

diff --git a/Documentation/devicetree/bindings/timer/timer.txt b/Documentation/devicetree/bindings/timer/timer.txt
new file mode 100644
index 0000000..f1ee0cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/timer.txt
@@ -0,0 +1,38 @@
+
+Specifying timer information for devices
+========================================
+
+The timer can be declared via the macro:
+
+CLOCKSOURCE_OF_DECLARE(name, init) if it is a clocksource
+CLOCKEVENT_OF_DECLARE(name, init) if it is a clockevent
+
+The CLOCKSOURCE_OF_DECLARE() was introduced before the
+CLOCKEVENT_OF_DECLARE() and that resulted in some abuse where the
+clockevent and the clocksource are both initialized in the same init
+routine.
+
+With the introduction of the CLOCKEVENT_OF_DECLARE(), the driver can
+now split the clocksource and the clockevent init code. However, the
+device tree may specify a single node, so the same node will be passed
+to the clockevent/clocksource's init function, with the same base
+address. It is possible to specify an attribute to the timer's node to
+specify if it is a clocksource or a clockevent and define two timers
+node.
+
+Example:
+
+	timer: timer at 98400000 {
+		compatible = "moxa,moxart-timer";
+		reg = <0x98400000 0x42>;
+		interrupts = <19 1>;
+		clocks = <&coreclk>;
+		clockevent;
+	};
+
+	timer: timer at 98400010 {
+		compatible = "moxa,moxart-timer";
+		reg = <0x98400010 0x42>;
+		clocks = <&coreclk>;
+		clocksource;
+	};
diff --git a/drivers/clocksource/clkevt-probe.c b/drivers/clocksource/clkevt-probe.c
index eb89b50..fa02ac1 100644
--- a/drivers/clocksource/clkevt-probe.c
+++ b/drivers/clocksource/clkevt-probe.c
@@ -37,6 +37,13 @@ int __init clockevent_probe(void)
 
 		init_func = match->data;
 
+		/*
+		 * The device node describes a clocksource, ignore it
+		 * as we are in the clockevent init routine.
+		 */
+		if (of_property_read_bool(np, "clocksource"))
+			continue;
+
 		ret = init_func(np);
 		if (ret) {
 			pr_warn("Failed to initialize '%s' (%d)\n",
diff --git a/drivers/clocksource/clksrc-probe.c b/drivers/clocksource/clksrc-probe.c
index bc62be9..ce50f33 100644
--- a/drivers/clocksource/clksrc-probe.c
+++ b/drivers/clocksource/clksrc-probe.c
@@ -38,6 +38,13 @@ void __init clocksource_probe(void)
 
 		init_func_ret = match->data;
 
+		/*
+		 * The device node describes a clockevent, ignore it
+		 * as we are in the clocksource init routine.
+		 */
+		if (of_property_read_bool(np, "clockevent"))
+			continue;
+
 		ret = init_func_ret(np);
 		if (ret) {
 			pr_err("Failed to initialize '%s': %d",
-- 
1.7.9.5
