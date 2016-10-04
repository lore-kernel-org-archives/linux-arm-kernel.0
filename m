From: briannorris@chromium.org (Brian Norris)
Date: Tue,  4 Oct 2016 11:12:09 -0700
Subject: [PATCH v2 1/2] clocksource: arm_arch_timer: Don't assume clock runs
 in suspend
Message-ID: <1475604730-140264-1-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM ARM specifies that the system counter "must be implemented in an
always-on power domain," and so we try to use the counter as a source of
timekeeping across suspend/resume. Unfortunately, some SoCs (e.g.,
Rockchip's RK3399) do not keep the counter ticking properly when
switched from their high-power clock to the lower-power clock used in
system suspend. Support this quirk by adding a new device tree property.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v2:
 * add new device tree property, instead of re-using the "always-on"
   property (which has different meaning)

 Documentation/devicetree/bindings/arm/arch_timer.txt | 5 +++++
 drivers/clocksource/arm_arch_timer.c                 | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
index ef5fbe9a77c7..ad440a2b8051 100644
--- a/Documentation/devicetree/bindings/arm/arch_timer.txt
+++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
@@ -38,6 +38,11 @@ to deliver its interrupts via SPIs.
   architecturally-defined reset values. Only supported for 32-bit
   systems which follow the ARMv7 architected reset values.
 
+- arm,no-tick-in-suspend : The main counter does not tick when the system is in
+  low-power system suspend on some SoCs. This behavior does not match the
+  Architecture Reference Manual's specification that the system counter "must
+  be implemented in an always-on power domain."
+
 
 Example:
 
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 73c487da6d2a..a2503db7e533 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -81,6 +81,7 @@ static struct clock_event_device __percpu *arch_timer_evt;
 static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;
 static bool arch_timer_c3stop;
 static bool arch_timer_mem_use_virtual;
+static bool arch_counter_suspend_stop;
 
 static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
 
@@ -576,7 +577,7 @@ static struct clocksource clocksource_counter = {
 	.rating	= 400,
 	.read	= arch_counter_read,
 	.mask	= CLOCKSOURCE_MASK(56),
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
 static struct cyclecounter cyclecounter = {
@@ -616,6 +617,8 @@ static void __init arch_counter_register(unsigned type)
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
 	}
 
+	if (!arch_counter_suspend_stop)
+		clocksource_counter.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
 	start_count = arch_timer_read_counter();
 	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
 	cyclecounter.mult = clocksource_counter.mult;
@@ -907,6 +910,10 @@ static int __init arch_timer_of_init(struct device_node *np)
 	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
 		arch_timer_uses_ppi = PHYS_SECURE_PPI;
 
+	/* On some systems, the counter stops ticking when in suspend. */
+	arch_counter_suspend_stop = of_property_read_bool(np,
+							 "arm,no-tick-in-suspend");
+
 	return arch_timer_init();
 }
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
-- 
2.8.0.rc3.226.g39d4020
