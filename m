From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Jun 2016 14:39:41 +0200
Subject: [PATCH] ARM: tegra: remove board_init_funcs array
Message-ID: <20160622124052.1263574-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a configuration that enables CONFIG_UBSAN_SANITIZE_ALL, I am getting
a section mismatch warning for tegra20:

WARNING: arch/arm/mach-tegra/built-in.o(.data+0x6e0): Section mismatch in reference from the variable board_init_funcs to the function .init.text:paz00_init()

The array is no longer useful here since there is only one entry,
so we can simply call the function directly after checking
of_machine_is_compatible(). This fixes the section mismatch
and is easier to read.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-tegra/tegra.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 2378fa560a21..42d7ee9658fa 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -118,32 +118,14 @@ out:
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
 }
 
-static void __init paz00_init(void)
-{
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
-		tegra_paz00_wifikill_init();
-}
-
-static struct {
-	char *machine;
-	void (*init)(void);
-} board_init_funcs[] = {
-	{ "compal,paz00", paz00_init },
-};
-
 static void __init tegra_dt_init_late(void)
 {
-	int i;
-
 	tegra_init_suspend();
 	tegra_cpuidle_init();
 
-	for (i = 0; i < ARRAY_SIZE(board_init_funcs); i++) {
-		if (of_machine_is_compatible(board_init_funcs[i].machine)) {
-			board_init_funcs[i].init();
-			break;
-		}
-	}
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
+	    of_machine_is_compatible("compal,paz00"))
+		tegra_paz00_wifikill_init();
 }
 
 static const char * const tegra_dt_board_compat[] = {
-- 
2.9.0
