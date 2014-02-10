From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 10 Feb 2014 16:07:53 -0300
Subject: [PATCH 1/2] clocksource: armada-370-xp: Add support for Armada 375
In-Reply-To: <1392059274-26965-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392059274-26965-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1392059274-26965-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

The Armada 375 has a 25 Mhz fixed clock, but it is non-functional.
Therefore, let's use the A370 initialization for now, using the provided
parent clock.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../bindings/timer/marvell,armada-370-xp-timer.txt          | 13 +++++++++----
 drivers/clocksource/time-armada-370-xp.c                    | 13 ++++++++++++-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
index f455182..59894fb 100644
--- a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
+++ b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
@@ -1,9 +1,11 @@
-Marvell Armada 370 and Armada XP Timers
----------------------------------------
+Marvell Armada 370, 375 and XP Timers
+-------------------------------------
 
 Required properties:
-- compatible: Should be either "marvell,armada-370-timer" or
-  "marvell,armada-xp-timer" as appropriate.
+- compatible: Should be either:
+    - "marvell,armada-370-timer"
+    - "marvell,armada-375-timer"
+    - "marvell,armada-xp-timer"
 - interrupts: Should contain the list of Global Timer interrupts and
   then local timer interrupts
 - reg: Should contain location and length for timers register. First
@@ -13,6 +15,9 @@ Required properties:
 Clocks required for compatible = "marvell,armada-370-timer":
 - clocks : Must contain a single entry describing the clock input
 
+Clocks required for compatible = "marvell,armada-375-timer":
+- clocks : Must contain a single entry describing the clock input
+
 Clocks required for compatible = "marvell,armada-xp-timer":
 - clocks : Must contain an entry for each entry in clock-names.
 - clock-names : Must include the following entries:
diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index ee8691b..87eda6d 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -15,12 +15,15 @@
  * used as clock_event_device.
  *
  * ---
- * Clocksource driver for Armada 370 and Armada XP SoC.
+ * Clocksource driver for Armada 370, Armada 375 and Armada XP SoC.
  * This driver implements one compatible string for each SoC, given
  * each has its own characteristics:
  *
  *   * Armada 370 has no 25 MHz fixed timer.
  *
+ *   * Armada 375 has a non-usable 25 Mhz fixed timer, due to hardware
+ *     issues.
+ *
  *   * Armada XP cannot work properly without such 25 MHz fixed timer as
  *     doing otherwise leads to using a clocksource whose frequency varies
  *     when doing cpufreq frequency changes.
@@ -316,3 +319,11 @@ static void __init armada_370_timer_init(struct device_node *np)
 }
 CLOCKSOURCE_OF_DECLARE(armada_370, "marvell,armada-370-timer",
 		       armada_370_timer_init);
+
+/*
+ * Currently support the Armada 375 timer as identical to the Armada 370.
+ * However, let's keep a SoC-specific compatible string to allow to change
+ * this in the future.
+ */
+CLOCKSOURCE_OF_DECLARE(armada_375, "marvell,armada-375-timer",
+		       armada_370_timer_init);
-- 
1.8.1.5
