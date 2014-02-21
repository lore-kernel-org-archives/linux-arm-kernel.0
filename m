From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:17 +0900
Subject: [PATCH 05/16] ARM: shmobile: lager-reference: Refactor clock lookup
 hack
In-Reply-To: <cover.1392960310.git.horms+renesas@verge.net.au>
References: <cover.1392960310.git.horms+renesas@verge.net.au>
Message-ID: <9a8c3ab9c0286a6c81012eaf9e95ec2d3e58d21f.1392960310.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Make the clock lookup hack more generic to ease the addition of more
devices.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 37 +++++++++++++++-----------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index dc8d76b..634ef15 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -31,30 +31,37 @@ static void __init lager_add_standard_devices(void)
 {
 #ifdef CONFIG_COMMON_CLK
 	/*
-	 * This is a really crude hack to provide clkdev support to the SCIF
-	 * and CMT devices until they get moved to DT.
+	 * This is a really crude hack to provide clkdev support to platform
+	 * devices until they get moved to DT.
 	 */
-	static const char * const scif_names[] = {
-		"scifa0", "scifa1", "scifb0", "scifb1",
-		"scifb2", "scifa2", "scif0", "scif1",
-		"hscif0", "hscif1",
+	static const struct clk_name {
+		const char *clk;
+		const char *con_id;
+		const char *dev_id;
+	} clk_names[] = {
+		{ "cmt0", NULL, "sh_cmt.0" },
+		{ "scifa0", NULL, "sh-sci.0" },
+		{ "scifa1", NULL, "sh-sci.1" },
+		{ "scifb0", NULL, "sh-sci.2" },
+		{ "scifb1", NULL, "sh-sci.3" },
+		{ "scifb2", NULL, "sh-sci.4" },
+		{ "scifa2", NULL, "sh-sci.5" },
+		{ "scif0", NULL, "sh-sci.6" },
+		{ "scif1", NULL, "sh-sci.7" },
+		{ "hscif0", NULL, "sh-sci.8" },
+		{ "hscif1", NULL, "sh-sci.9" },
 	};
 	struct clk *clk;
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(scif_names); ++i) {
-		clk = clk_get(NULL, scif_names[i]);
+	for (i = 0; i < ARRAY_SIZE(clk_names); ++i) {
+		clk = clk_get(NULL, clk_names[i].clk);
 		if (!IS_ERR(clk)) {
-			clk_register_clkdev(clk, NULL, "sh-sci.%u", i);
+			clk_register_clkdev(clk, clk_names[i].con_id,
+					    clk_names[i].dev_id);
 			clk_put(clk);
 		}
 	}
-
-	clk = clk_get(NULL, "cmt0");
-	if (!IS_ERR(clk)) {
-		clk_register_clkdev(clk, NULL, "sh_cmt.0");
-		clk_put(clk);
-	}
 #else
 	r8a7790_clock_init();
 #endif
-- 
1.8.5.2
