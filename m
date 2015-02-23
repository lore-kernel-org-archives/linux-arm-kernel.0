From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 23 Feb 2015 16:59:29 +0100
Subject: [PATCH 3/3] ARM: shmobile: sh73a0: Remove restart callback
In-Reply-To: <1424707169-23007-1-git-send-email-geert+renesas@glider.be>
References: <1424707169-23007-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1424707169-23007-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the restart handling hack from the sh73a0 generic multiplatform
case.

Restart on DT-based sh73a0 platforms is now handled through the
R-Mobile reset driver.

This basically reverts commit cad900819fba0176 ("ARM: shmobile: sh73a0:
Add restart callback").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To avoid losing functionality, this depends on:
  - commit fa0f8d6700857457 ("power: reset: Add reset driver for
    R-Mobile platforms"), which is in v4.0-rc1,
  - commit 126693a80f451ecd ("ARM: shmobile: sh73a0 dtsi: Add PM domain
    support"), which is in sh73a0-multiplatform-for-v3.21,
  - "ARM: shmobile: Enable R-Mobile reset driver in multiplatform
    defconfig", which is the first patch of this series.
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index d17d2682dfa8bd0c..e63c2c2558171498 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -814,13 +814,6 @@ void __init sh73a0_add_early_devices(void)
 	shmobile_setup_console();
 }
 
-#define RESCNT2 IOMEM(0xe6188020)
-static void sh73a0_restart(enum reboot_mode mode, const char *cmd)
-{
-	/* Do soft power on reset */
-	writel((1 << 31), RESCNT2);
-}
-
 #ifdef CONFIG_USE_OF
 
 static void __init sh73a0_generic_init(void)
@@ -843,7 +836,6 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
 	.init_early	= shmobile_init_delay,
 	.init_machine	= sh73a0_generic_init,
 	.init_late	= shmobile_init_late,
-	.restart	= sh73a0_restart,
 	.dt_compat	= sh73a0_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
1.9.1
