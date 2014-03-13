From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 17:59:57 +0900
Subject: [PATCH v4 14/19] ARM: shmobile: marzen-reference: Instantiate clkdevs
 for SCIF and TMU
In-Reply-To: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
References: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1394701202-25823-15-git-send-email-horms+renesas@verge.net.au>
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
 arch/arm/mach-shmobile/board-marzen-reference.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index e261431..5823c83 100644
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
@@ -36,9 +37,29 @@ static void __init marzen_init_timer(void)
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
+	{ "tmu0", NULL, "sh_tmu.0" },
+	{ "tmu1", NULL, "sh_tmu.1" },
+	{ "tmu2", NULL, "sh_tmu.2" },
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
