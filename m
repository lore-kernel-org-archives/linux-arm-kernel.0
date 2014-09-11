From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 11 Sep 2014 21:01:36 +0200
Subject: [PATCH 1/3] ARM: OMAP2+: make of_device_ids const
In-Reply-To: <20140911173943.GB18849@atomide.com>
References: <1410337579-23466-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1410337579-23466-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140911173943.GB18849@atomide.com>
Message-ID: <20140911190136.GM3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 10:39:43AM -0700, Tony Lindgren wrote:
> * Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [140910 01:27]:
> > of_device_ids (i.e. compatible strings and the respective data) are not
> > supposed to change at runtime. All functions working with of_device_ids
> > provided by <linux/of.h> work with const of_device_ids. So mark the
> > non-const function parameters and structs for OMAP2+ as const, too.
> 
> Hmm this does not seem to compile with omap2plus_defconfig because
> of section type conflicts. Looks like there's some issue now with the
> use of __initconst:
> 
> arch/arm/mach-omap2/board-generic.c:262:20: error: dra72x_boards_compat causes a section type conflict with omap_dt_match_table
> arch/arm/mach-omap2/board-generic.c:30:34: note: ?omap_dt_match_table? was declared here
> scripts/Makefile.build:257: recipe for target 'arch/arm/mach-omap2/board-generic.o' failed
The problem is dra74x_boards_compat though:

	static const char *dra74x_boards_compat[] __initconst = {
		...

*dra74x_boards_compat is const, but dra74x_boards_compat isn't, so
either the variable must go into __initdata or it must be declared as:

	static const char * const dra74x_boards_compat[] __initconst = {
		...

(but then I guess you get another warning because struct machine_desc's
dt_compat is declared as

	const char **dt_compat;

.)

With the patch below, arch/arm/mach-omap2/board-generic.c compiles just
fine. Don't know yet if the additional const in <asm/mach_desc.h> is
problematic ...

diff --git a/arch/arc/include/asm/mach_desc.h b/arch/arc/include/asm/mach_desc.h
index e8993a2be6c2..f4a7bc8d8967 100644
--- a/arch/arc/include/asm/mach_desc.h
+++ b/arch/arc/include/asm/mach_desc.h
@@ -35,7 +35,7 @@
  */
 struct machine_desc {
 	const char		*name;
-	const char		**dt_compat;
+	const char *const	*dt_compat;
 
 	void			(*init_early)(void);
 	void			(*init_irq)(void);
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

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
