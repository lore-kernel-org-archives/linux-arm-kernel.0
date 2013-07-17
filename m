From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 18 Jul 2013 08:31:51 +0900
Subject: [PATCH 12/22] ARM: shmobile: Remove unused r8a7740 auxdata table
In-Reply-To: <cover.1374103272.git.horms+renesas@verge.net.au>
References: <cover.1374103272.git.horms+renesas@verge.net.au>
Message-ID: <88378837780166d67a11142cd6f76596c0a2d8c3.1374103272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Pass NULL to of_platform_populate instead of passing
an empty list. This cleans up the code and reduces the
number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 00c5a70..ac29c2e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -986,16 +986,22 @@ void __init r8a7740_add_early_devices(void)
 
 #ifdef CONFIG_USE_OF
 
-static const struct of_dev_auxdata r8a7740_auxdata_lookup[] __initconst = {
-	{ }
-};
+void __init r8a7740_add_early_devices_dt(void)
+{
+	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
+
+	early_platform_add_devices(r8a7740_early_devices,
+				   ARRAY_SIZE(r8a7740_early_devices));
+
+	/* setup early console here as well */
+	shmobile_setup_console();
+}
 
 void __init r8a7740_add_standard_devices_dt(void)
 {
 	platform_add_devices(r8a7740_devices_dt,
 			    ARRAY_SIZE(r8a7740_devices_dt));
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     r8a7740_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 void __init r8a7740_init_delay(void)
-- 
1.7.10.4
