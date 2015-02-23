From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 23 Feb 2015 16:59:28 +0100
Subject: [PATCH 2/3] ARM: shmobile: r8a7740: Remove restart callback
In-Reply-To: <1424707169-23007-1-git-send-email-geert+renesas@glider.be>
References: <1424707169-23007-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1424707169-23007-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the restart handling hack from the r8a7740 generic multiplatform
case.

Restart on DT-based r8a7740 platforms is now handled through the
R-Mobile reset driver.

This reverts commit 1174c712afa2779f ("ARM: shmobile: r8a7740: Add
restart callback").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To avoid losing functionality, this depends on:
  - commit fa0f8d6700857457 ("power: reset: Add reset driver for
    R-Mobile platforms"), which is in v4.0-rc1,
  - commit aba07789d811b6cf ("ARM: shmobile: r8a7740 dtsi: Add PM domain
    support"), which is in v4.0-rc1,
  - "ARM: shmobile: Enable R-Mobile reset driver in multiplatform
    defconfig", which is the first patch of this series.
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index dd64caf792160198..9832e48396a40a92 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -842,13 +842,6 @@ static void __init r8a7740_generic_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-#define RESCNT2 IOMEM(0xe6188020)
-static void r8a7740_restart(enum reboot_mode mode, const char *cmd)
-{
-	/* Do soft power on reset */
-	writel(1 << 31, RESCNT2);
-}
-
 static const char *r8a7740_boards_compat_dt[] __initdata = {
 	"renesas,r8a7740",
 	NULL,
@@ -861,7 +854,6 @@ DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.init_machine	= r8a7740_generic_init,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7740_boards_compat_dt,
-	.restart	= r8a7740_restart,
 MACHINE_END
 
 #endif /* CONFIG_USE_OF */
-- 
1.9.1
