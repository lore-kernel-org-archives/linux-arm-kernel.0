From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Mon, 16 Jun 2014 17:07:28 +0200
Subject: [PATCH v4 16/19] ARM: shmobile: lager-reference: Enable CMT0 in
 device tree
In-Reply-To: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1402931251-22581-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No more device needs to be added from platform code when booting the
reference platform, remove the now empty r8a7790_add_dt_devices()
function completely.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts            | 4 ++++
 arch/arm/mach-shmobile/board-lager-reference.c | 2 --
 arch/arm/mach-shmobile/include/mach/r8a7790.h  | 1 -
 arch/arm/mach-shmobile/setup-r8a7790.c         | 7 +------
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 850dff8..32a636f 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -237,6 +237,10 @@
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
index 4393f12..ee6feb9 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -90,7 +90,6 @@ static void __init lager_add_du_device(void)
  * devices until they get moved to DT.
  */
 static const struct clk_name clk_names[] __initconst = {
-	{ "cmt0", "fck", "sh-cmt-48-gen2.0" },
 	{ "du0", "du.0", "rcar-du-r8a7790" },
 	{ "du1", "du.1", "rcar-du-r8a7790" },
 	{ "du2", "du.2", "rcar-du-r8a7790" },
@@ -101,7 +100,6 @@ static const struct clk_name clk_names[] __initconst = {
 static void __init lager_add_standard_devices(void)
 {
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
-	r8a7790_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	lager_add_du_device();
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index 3ebc1f4..9684441 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
@@ -29,7 +29,6 @@ enum {
 };
 
 void r8a7790_add_standard_devices(void);
-void r8a7790_add_dt_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
 void r8a7790_pm_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 80af1d2..37d6eca 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -279,11 +279,6 @@ static struct resource cmt0_resources[] = {
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
@@ -296,7 +291,7 @@ void __init r8a7790_add_standard_devices(void)
 	r8a7790_register_scif(7);
 	r8a7790_register_scif(8);
 	r8a7790_register_scif(9);
-	r8a7790_add_dt_devices();
+	r8a7790_register_cmt(0);
 	r8a7790_register_irqc(0);
 	r8a7790_register_thermal();
 	r8a7790_register_i2c(0);
-- 
1.8.5.5
