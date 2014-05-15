From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 May 2014 20:32:07 +0900
Subject: [PATCH v6 12/17] ARM: shmobile: marzen-reference: Instantiate clkdevs
 for SCIF and TMU
In-Reply-To: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
References: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1400153532-23675-13-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the common clock framework is supported, the clock lookup
entries in clock-r8a7779.c are not registered anymore. Devices must
instead reference their clocks in the device tree. However, SCIF and CMT
devices are still instantiated through platform code, and thus need a
clock lookup entry.

Retrieve the SCIF and CMT clock entries by name and register clkdevs for
the corresponding devices. This will be removed when the SCIF and CMT
devices will be instantiated from the device tree.

Based on work for the Koelsch board by Laurent Pinchart.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v6
* Update for "ARM: shmobile: r8a7778: Switch to new style TMU device"

v5
* No change

v4
* As suggested by Geert Uytterhoeven and Magnus Damm
  - Make use of shmobile_clk_workaround()
  - This patch now depends on
    "ARM: shmobile: Introduce shmobile_clk_workaround()"

v3
* Initialise TMU clocks instead of CMT clocks
  - It is TMU that Marzen uses as a clocksource
* Refactor clock initialisation hack as per more recent mainline
  code for Koelsch
* Use IS_ERR to check the return value of clk_get()
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index e261431..d09e850 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -23,6 +23,7 @@
 #include <linux/clocksource.h>
 #include <linux/of_platform.h>
 #include <mach/r8a7779.h>
+#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <asm/irq.h>
@@ -36,9 +37,27 @@ static void __init marzen_init_timer(void)
 	clocksource_of_init();
 }
 
+#ifdef CONFIG_COMMON_CLK
+/*
+ * This is a really crude hack to provide clkdev support to platform
+ * devices until they get moved to DT.
+ */
+static const struct clk_name clk_names[] __initconst = {
+	{ "scif0", NULL, "sh-sci.0" },
+	{ "scif1", NULL, "sh-sci.1" },
+	{ "scif2", NULL, "sh-sci.2" },
+	{ "scif3", NULL, "sh-sci.3" },
+	{ "scif4", NULL, "sh-sci.4" },
+	{ "scif5", NULL, "sh-sci.5" },
+	{ "tmu0", "fck", "sh-tmu.0" },
+};
+#endif
+
 static void __init marzen_init(void)
 {
-#ifndef CONFIG_COMMON_CLK
+#ifdef CONFIG_COMMON_CLK
+	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
+#else
 	r8a7779_clock_init();
 #endif
 	r8a7779_add_standard_devices_dt();
-- 
1.8.5.2
