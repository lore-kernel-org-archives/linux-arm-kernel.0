From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:23 +0900
Subject: [PATCH 10/24] ARM: shmobile: marzen-reference: Instantiate clkdevs
 for SCIF and TMU
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
Message-ID: <2b2084e8d4ae9265a3240722cb8adce06c0f393f.1403487423.git.horms+renesas@verge.net.au>
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
 arch/arm/mach-shmobile/board-marzen-reference.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index f642819..3017040 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -25,6 +25,7 @@
 #include <mach/r8a7779.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
+#include "clock.h"
 #include "common.h"
 #include "irqs.h"
 
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
2.0.0.rc2
