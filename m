From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 13 Mar 2014 08:36:35 +0900
Subject: [PATCH 03/03] ARM: shmobile: Use shmobile_clk_workaround() on Koelsch
In-Reply-To: <20140312233608.17009.65690.sendpatchset@w520>
References: <20140312233608.17009.65690.sendpatchset@w520>
Message-ID: <20140312233635.17009.37946.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert the Koelsch DT reference code to use the newly introduced
function shmobile_clk_workaround().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-koelsch-reference.c |   71 ++++++++--------------
 1 file changed, 28 insertions(+), 43 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2014-02-24 15:50:57.000000000 +0900
@@ -19,12 +19,11 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/clk.h>
-#include <linux/clkdev.h>
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
+#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/rcar-gen2.h>
@@ -82,49 +81,35 @@ static void __init koelsch_add_du_device
 	platform_device_register_full(&info);
 }
 
+/*
+ * This is a really crude hack to provide clkdev support to platform
+ * devices until they get moved to DT.
+ */
+static const struct clk_name clk_names[] = {
+	{ "cmt0", NULL, "sh_cmt.0" },
+	{ "scifa0", NULL, "sh-sci.0" },
+	{ "scifa1", NULL, "sh-sci.1" },
+	{ "scifb0", NULL, "sh-sci.2" },
+	{ "scifb1", NULL, "sh-sci.3" },
+	{ "scifb2", NULL, "sh-sci.4" },
+	{ "scifa2", NULL, "sh-sci.5" },
+	{ "scif0", NULL, "sh-sci.6" },
+	{ "scif1", NULL, "sh-sci.7" },
+	{ "scif2", NULL, "sh-sci.8" },
+	{ "scif3", NULL, "sh-sci.9" },
+	{ "scif4", NULL, "sh-sci.10" },
+	{ "scif5", NULL, "sh-sci.11" },
+	{ "scifa3", NULL, "sh-sci.12" },
+	{ "scifa4", NULL, "sh-sci.13" },
+	{ "scifa5", NULL, "sh-sci.14" },
+	{ "du0", "du.0", "rcar-du-r8a7791" },
+	{ "du1", "du.1", "rcar-du-r8a7791" },
+	{ "lvds0", "lvds.0", "rcar-du-r8a7791" },
+};
+
 static void __init koelsch_add_standard_devices(void)
 {
-	/*
-	 * This is a really crude hack to provide clkdev support to the CMT and
-	 * DU devices until they get moved to DT.
-	 */
-	static const struct clk_name {
-		const char *clk;
-		const char *con_id;
-		const char *dev_id;
-	} clk_names[] = {
-		{ "cmt0", NULL, "sh_cmt.0" },
-		{ "scifa0", NULL, "sh-sci.0" },
-		{ "scifa1", NULL, "sh-sci.1" },
-		{ "scifb0", NULL, "sh-sci.2" },
-		{ "scifb1", NULL, "sh-sci.3" },
-		{ "scifb2", NULL, "sh-sci.4" },
-		{ "scifa2", NULL, "sh-sci.5" },
-		{ "scif0", NULL, "sh-sci.6" },
-		{ "scif1", NULL, "sh-sci.7" },
-		{ "scif2", NULL, "sh-sci.8" },
-		{ "scif3", NULL, "sh-sci.9" },
-		{ "scif4", NULL, "sh-sci.10" },
-		{ "scif5", NULL, "sh-sci.11" },
-		{ "scifa3", NULL, "sh-sci.12" },
-		{ "scifa4", NULL, "sh-sci.13" },
-		{ "scifa5", NULL, "sh-sci.14" },
-		{ "du0", "du.0", "rcar-du-r8a7791" },
-		{ "du1", "du.1", "rcar-du-r8a7791" },
-		{ "lvds0", "lvds.0", "rcar-du-r8a7791" },
-	};
-	struct clk *clk;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(clk_names); ++i) {
-		clk = clk_get(NULL, clk_names[i].clk);
-		if (!IS_ERR(clk)) {
-			clk_register_clkdev(clk, clk_names[i].con_id,
-					    clk_names[i].dev_id);
-			clk_put(clk);
-		}
-	}
-
+	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
 	r8a7791_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
