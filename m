From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Mon, 16 Jun 2014 17:07:29 +0200
Subject: [PATCH v4 17/19] ARM: shmobile: koelsch-reference: Enable CMT0 in
 device tree
In-Reply-To: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1402931251-22581-18-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No more device needs to be added from platform code when booting the
reference platform, remove the now empty r8a7791_add_dt_devices()
function completely.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts            | 4 ++++
 arch/arm/mach-shmobile/board-koelsch-reference.c | 2 --
 arch/arm/mach-shmobile/include/mach/r8a7791.h    | 1 -
 arch/arm/mach-shmobile/setup-r8a7791.c           | 7 +------
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 5dac673..7817ca8 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -297,6 +297,10 @@
 	};
 };
 
+&cmt0 {
+	status = "ok";
+};
+
 &sata0 {
 	status = "okay";
 };
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 26189e2..1a73200 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -86,7 +86,6 @@ static void __init koelsch_add_du_device(void)
  * devices until they get moved to DT.
  */
 static const struct clk_name clk_names[] __initconst = {
-	{ "cmt0", "fck", "sh-cmt-48-gen2.0" },
 	{ "du0", "du.0", "rcar-du-r8a7791" },
 	{ "du1", "du.1", "rcar-du-r8a7791" },
 	{ "lvds0", "lvds.0", "rcar-du-r8a7791" },
@@ -95,7 +94,6 @@ static const struct clk_name clk_names[] __initconst = {
 static void __init koelsch_add_standard_devices(void)
 {
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
-	r8a7791_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	koelsch_add_du_device();
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7791.h b/arch/arm/mach-shmobile/include/mach/r8a7791.h
index 86eae7b..c1bf7ab 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7791.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7791.h
@@ -2,7 +2,6 @@
 #define __ASM_R8A7791_H__
 
 void r8a7791_add_standard_devices(void);
-void r8a7791_add_dt_devices(void);
 void r8a7791_clock_init(void);
 void r8a7791_pinmux_init(void);
 void r8a7791_pm_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index ddd2fca..a66727e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -180,11 +180,6 @@ static const struct resource thermal_resources[] __initconst = {
 					thermal_resources,		\
 					ARRAY_SIZE(thermal_resources))
 
-void __init r8a7791_add_dt_devices(void)
-{
-	r8a7791_register_cmt(0);
-}
-
 void __init r8a7791_add_standard_devices(void)
 {
 	r8a7791_register_scif(0);
@@ -202,7 +197,7 @@ void __init r8a7791_add_standard_devices(void)
 	r8a7791_register_scif(12);
 	r8a7791_register_scif(13);
 	r8a7791_register_scif(14);
-	r8a7791_add_dt_devices();
+	r8a7791_register_cmt(0);
 	r8a7791_register_irqc(0);
 	r8a7791_register_thermal();
 }
-- 
1.8.5.5
