From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  7 Mar 2018 14:58:18 +0100
Subject: [PATCH 1/3] ARM: ux500: Drop U8540/9540 support
Message-ID: <20180307135820.16221-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The U8540 was an evolved version of the U8500, but it was never
mass produced or put into products, only reference designs exist.
The upstream support was never completed and it is unlikely that
this will happen so drop the support for now to simplify
maintenance of the U8500.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Kconfig       |  3 ---
 arch/arm/mach-ux500/cpu-db8500.c  | 16 ++--------------
 arch/arm/mach-ux500/db8500-regs.h |  4 ----
 3 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index f98332ea2ef2..7289ec8404c9 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -26,11 +26,8 @@ config UX500_SOC_DB8500
 	bool
 	select MFD_DB8500_PRCMU
 	select PINCTRL_DB8500
-	select PINCTRL_DB8540
 	select PINCTRL_AB8500
 	select PINCTRL_AB8505
-	select PINCTRL_AB9540
-	select PINCTRL_AB8540
 	select REGULATOR
 	select REGULATOR_DB8500_PRCMU
 	select CLKSRC_DBX500_PRCMU
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 36cd23c8be9b..389ecf6faa00 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -111,11 +111,6 @@ static void ux500_restart(enum reboot_mode mode, const char *cmd)
 	prcmu_system_reset(0);
 }
 
-static struct of_dev_auxdata u8540_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("stericsson,db8500-prcmu", 0x80157000, "db8500-prcmu", NULL),
-	{},
-};
-
 static const struct of_device_id u8500_local_bus_nodes[] = {
 	/* only create devices below soc node */
 	{ .compatible = "stericsson,db8500", },
@@ -129,20 +124,13 @@ static void __init u8500_init_machine(void)
 	/* Initialize ux500 power domains */
 	ux500_pm_domains_init();
 
-	/* automatically probe child nodes of dbx5x0 devices */
-	if (of_machine_is_compatible("st-ericsson,u8540"))
-		of_platform_populate(NULL, u8500_local_bus_nodes,
-				     u8540_auxdata_lookup, NULL);
-	else
-		of_platform_populate(NULL, u8500_local_bus_nodes,
-				     NULL, NULL);
+	of_platform_populate(NULL, u8500_local_bus_nodes,
+			     NULL, NULL);
 }
 
 static const char * stericsson_dt_platform_compat[] = {
 	"st-ericsson,u8500",
-	"st-ericsson,u8540",
 	"st-ericsson,u9500",
-	"st-ericsson,u9540",
 	NULL,
 };
 
diff --git a/arch/arm/mach-ux500/db8500-regs.h b/arch/arm/mach-ux500/db8500-regs.h
index 27399553c841..3d6e1955119a 100644
--- a/arch/arm/mach-ux500/db8500-regs.h
+++ b/arch/arm/mach-ux500/db8500-regs.h
@@ -41,10 +41,6 @@
 /* ASIC ID is at 0xbf4 offset within this region */
 #define U8500_ASIC_ID_BASE	0x9001D000
 
-#define U9540_BOOT_ROM_BASE	0xFFFE0000
-/* ASIC ID is at 0xbf4 offset within this region */
-#define U9540_ASIC_ID_BASE	0xFFFFD000
-
 #define U8500_PER6_BASE		0xa03c0000
 #define U8500_PER7_BASE		0xa03d0000
 #define U8500_PER5_BASE		0xa03e0000
-- 
2.14.3
