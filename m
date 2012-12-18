From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 18 Dec 2012 09:46:12 +0900
Subject: [PATCH 8/9] ARM: shmobile: sh7372: Do not initialise TMU when using DT
In-Reply-To: <1355791573-20281-1-git-send-email-horms+renesas@verge.net.au>
References: <1355791573-20281-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1355791573-20281-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is in preparation for initialising INTC using DT.
The proposed INTC configuration is not complete and does
not allow the TMU to be initialised, to exclude it when using DT.

Cc: Magnus Damm <damm@opensource.se>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh7372.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index a07954f..90af2e9 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -968,7 +968,7 @@ static struct platform_device spu1_device = {
 	.num_resources	= ARRAY_SIZE(spu1_resources),
 };
 
-static struct platform_device *sh7372_early_devices[] __initdata = {
+static struct platform_device *sh7372_early_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
 	&scif2_device,
@@ -977,6 +977,9 @@ static struct platform_device *sh7372_early_devices[] __initdata = {
 	&scif5_device,
 	&scif6_device,
 	&cmt2_device,
+};
+
+static struct platform_device *sh7372_early_devices[] __initdata = {
 	&tmu00_device,
 	&tmu01_device,
 };
@@ -1030,6 +1033,8 @@ void __init sh7372_add_standard_devices(void)
 
 	sh7372_init_pm_domains();
 
+	platform_add_devices(sh7372_early_devices_dt,
+			    ARRAY_SIZE(sh7372_early_devices_dt));
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
 
@@ -1048,6 +1053,8 @@ static void __init sh7372_earlytimer_init(void)
 
 void __init sh7372_add_early_devices(void)
 {
+	early_platform_add_devices(sh7372_early_devices_dt,
+				   ARRAY_SIZE(sh7372_early_devices_dt));
 	early_platform_add_devices(sh7372_early_devices,
 				   ARRAY_SIZE(sh7372_early_devices));
 
@@ -1064,8 +1071,8 @@ void __init sh7372_add_early_devices_dt(void)
 {
 	shmobile_setup_delay(800, 1, 3); /* Cortex-A8 @ 800MHz */
 
-	early_platform_add_devices(sh7372_early_devices,
-				   ARRAY_SIZE(sh7372_early_devices));
+	early_platform_add_devices(sh7372_early_devices_dt,
+				   ARRAY_SIZE(sh7372_early_devices_dt));
 
 	/* setup early console here as well */
 	shmobile_setup_console();
@@ -1080,8 +1087,8 @@ void __init sh7372_add_standard_devices_dt(void)
 	/* clocks are setup late during boot in the case of DT */
 	sh7372_clock_init();
 
-	platform_add_devices(sh7372_early_devices,
-			    ARRAY_SIZE(sh7372_early_devices));
+	platform_add_devices(sh7372_early_devices_dt,
+			    ARRAY_SIZE(sh7372_early_devices_dt));
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     sh7372_auxdata_lookup, NULL);
-- 
1.7.10.4
