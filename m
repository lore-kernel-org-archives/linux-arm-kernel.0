From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 20 Aug 2014 09:24:13 +0900
Subject: [PATCH 4/8] ARM: shmobile: lager-reference: Enable CMT0 in device tree
In-Reply-To: <cover.1408492048.git.horms+renesas@verge.net.au>
References: <cover.1408492048.git.horms+renesas@verge.net.au>
Message-ID: <247fd5ec6e9a41f9299df27be82104efc56e622b.1408492048.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

No more device needs to be added from platform code when booting the
reference platform, remove the now empty r8a7790_add_dt_devices()
function completely.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts            | 4 ++++
 arch/arm/mach-shmobile/board-lager-reference.c | 2 --
 arch/arm/mach-shmobile/r8a7790.h               | 1 -
 arch/arm/mach-shmobile/setup-r8a7790.c         | 7 +------
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 856b423..7853c2c 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -252,6 +252,10 @@
 	};
 };
 
+&cmt0 {
+	status = "ok";
+};
+
 &mmcif1 {
 	pinctrl-0 = <&mmc1_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 41c808e..2a05c02 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -92,7 +92,6 @@ static void __init lager_add_du_device(void)
  * devices until they get moved to DT.
  */
 static const struct clk_name clk_names[] __initconst = {
-	{ "cmt0", "fck", "sh-cmt-48-gen2.0" },
 	{ "du0", "du.0", "rcar-du-r8a7790" },
 	{ "du1", "du.1", "rcar-du-r8a7790" },
 	{ "du2", "du.2", "rcar-du-r8a7790" },
@@ -103,7 +102,6 @@ static const struct clk_name clk_names[] __initconst = {
 static void __init lager_add_standard_devices(void)
 {
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
-	r8a7790_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	lager_add_du_device();
diff --git a/arch/arm/mach-shmobile/r8a7790.h b/arch/arm/mach-shmobile/r8a7790.h
index 459827f..388f051 100644
--- a/arch/arm/mach-shmobile/r8a7790.h
+++ b/arch/arm/mach-shmobile/r8a7790.h
@@ -27,7 +27,6 @@ enum {
 };
 
 void r8a7790_add_standard_devices(void);
-void r8a7790_add_dt_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
 void r8a7790_pm_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 0c12b01..877fdeb 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -282,11 +282,6 @@ static struct resource cmt0_resources[] = {
 					  &cmt##idx##_platform_data,	\
 					  sizeof(struct sh_timer_config))
 
-void __init r8a7790_add_dt_devices(void)
-{
-	r8a7790_register_cmt(0);
-}
-
 void __init r8a7790_add_standard_devices(void)
 {
 	r8a7790_register_scif(0);
@@ -299,7 +294,7 @@ void __init r8a7790_add_standard_devices(void)
 	r8a7790_register_scif(7);
 	r8a7790_register_scif(8);
 	r8a7790_register_scif(9);
-	r8a7790_add_dt_devices();
+	r8a7790_register_cmt(0);
 	r8a7790_register_irqc(0);
 	r8a7790_register_thermal();
 	r8a7790_register_i2c(0);
-- 
2.0.1
