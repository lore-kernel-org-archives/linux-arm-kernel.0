From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 11 Sep 2014 21:29:01 +0200
Subject: [PATCH] ARM: omap2: make arrays containing machine compatible strings
 const
Message-ID: <1410463741-29202-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definition

	static const char *omap3_boards_compat[] __initconst = {

defines a changable array of constant strings. That is you must not do:

	*omap3_boards_compat[0] = 'f';

but

	omap3_boards_compat[0] = "another string";

is fine. So the annotation __initconst is wrong and yields a compiler
error when other really const variables are added with __initconst.

As the struct machine_desc member dt_compat is declared as

	const char *const *dt_compat;

making the arrays const is the better alternative over changing all
annotations to __initdata.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-omap2/board-generic.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 5827abb080e4..0b311d51425f 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -43,7 +43,7 @@ static void __init omap_generic_init(void)
 }
 
 #ifdef CONFIG_SOC_OMAP2420
-static const char *omap242x_boards_compat[] __initconst = {
+static const char *const omap242x_boards_compat[] __initconst = {
 	"ti,omap2420",
 	NULL,
 };
@@ -62,7 +62,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_SOC_OMAP2430
-static const char *omap243x_boards_compat[] __initconst = {
+static const char *const omap243x_boards_compat[] __initconst = {
 	"ti,omap2430",
 	NULL,
 };
@@ -81,7 +81,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
-static const char *omap3_boards_compat[] __initconst = {
+static const char *const omap3_boards_compat[] __initconst = {
 	"ti,omap3430",
 	"ti,omap3",
 	NULL,
@@ -100,7 +100,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.restart	= omap3xxx_restart,
 MACHINE_END
 
-static const char *omap36xx_boards_compat[] __initconst = {
+static const char *const omap36xx_boards_compat[] __initconst = {
 	"ti,omap36xx",
 	NULL,
 };
@@ -118,7 +118,7 @@ DT_MACHINE_START(OMAP36XX_DT, "Generic OMAP36xx (Flattened Device Tree)")
 	.restart	= omap3xxx_restart,
 MACHINE_END
 
-static const char *omap3_gp_boards_compat[] __initconst = {
+static const char *const omap3_gp_boards_compat[] __initconst = {
 	"ti,omap3-beagle",
 	"timll,omap3-devkit8000",
 	NULL,
@@ -137,7 +137,7 @@ DT_MACHINE_START(OMAP3_GP_DT, "Generic OMAP3-GP (Flattened Device Tree)")
 	.restart	= omap3xxx_restart,
 MACHINE_END
 
-static const char *am3517_boards_compat[] __initconst = {
+static const char *const am3517_boards_compat[] __initconst = {
 	"ti,am3517",
 	NULL,
 };
@@ -157,7 +157,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_SOC_AM33XX
-static const char *am33xx_boards_compat[] __initconst = {
+static const char *const am33xx_boards_compat[] __initconst = {
 	"ti,am33xx",
 	NULL,
 };
@@ -177,7 +177,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
-static const char *omap4_boards_compat[] __initconst = {
+static const char *const omap4_boards_compat[] __initconst = {
 	"ti,omap4460",
 	"ti,omap4430",
 	"ti,omap4",
@@ -199,7 +199,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_SOC_OMAP5
-static const char *omap5_boards_compat[] __initconst = {
+static const char *const omap5_boards_compat[] __initconst = {
 	"ti,omap5432",
 	"ti,omap5430",
 	"ti,omap5",
@@ -221,7 +221,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_SOC_AM43XX
-static const char *am43_boards_compat[] __initconst = {
+static const char *const am43_boards_compat[] __initconst = {
 	"ti,am4372",
 	"ti,am43",
 	NULL,
@@ -240,7 +240,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_SOC_DRA7XX
-static const char *dra74x_boards_compat[] __initconst = {
+static const char *const dra74x_boards_compat[] __initconst = {
 	"ti,dra742",
 	"ti,dra7",
 	NULL,
@@ -259,7 +259,7 @@ DT_MACHINE_START(DRA74X_DT, "Generic DRA74X (Flattened Device Tree)")
 	.restart	= omap44xx_restart,
 MACHINE_END
 
-static const char *dra72x_boards_compat[] __initconst = {
+static const char *const dra72x_boards_compat[] __initconst = {
 	"ti,dra722",
 	NULL,
 };
-- 
2.1.0
