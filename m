From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Nov 2013 16:32:16 +0900
Subject: [PATCH RFC v2 14/17] ARM: shmobile: marzen-reference: Instantiate
 clkdevs for SCIF and CMT
In-Reply-To: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
References: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1385451139-29686-15-git-send-email-horms+renesas@verge.net.au>
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
 arch/arm/mach-shmobile/board-marzen-reference.c | 28 ++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index e261431..1a2fac1 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -19,7 +19,9 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clk.h>
 #include <linux/clk/shmobile.h>
+#include <linux/clkdev.h>
 #include <linux/clocksource.h>
 #include <linux/of_platform.h>
 #include <mach/r8a7779.h>
@@ -38,7 +40,31 @@ static void __init marzen_init_timer(void)
 
 static void __init marzen_init(void)
 {
-#ifndef CONFIG_COMMON_CLK
+#ifdef CONFIG_COMMON_CLK
+	/*
+	 * This is a really crude hack to provide clkdev support to the SCIF
+	 * and CMT devices until they get moved to DT.
+	 */
+	static const char * const scif_names[] = {
+		"scif0", "scif1", "scif2", "scif3", "scif4", "scif5",
+	};
+	struct clk *clk;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(scif_names); i++) {
+		clk = clk_get(NULL, scif_names[i]);
+		if (clk) {
+			clk_register_clkdev(clk, NULL, "sh-sci.%u", i);
+			clk_put(clk);
+		}
+	}
+
+	clk = clk_get(NULL, "cmt0");
+	if (clk) {
+		clk_register_clkdev(clk, NULL, "sh_cmt.0");
+		clk_put(clk);
+	}
+#else
 	r8a7779_clock_init();
 #endif
 	r8a7779_add_standard_devices_dt();
-- 
1.8.4
