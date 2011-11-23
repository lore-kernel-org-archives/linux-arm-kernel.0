From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Nov 2011 09:50:09 +0000
Subject: [PATCH] arm/tegra: Fix build error with tegra_assert_system_reset
In-Reply-To: <1322009631-711-1-git-send-email-swarren@nvidia.com>
References: <1322009631-711-1-git-send-email-swarren@nvidia.com>
Message-ID: <20111123095009.GG9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 05:53:51PM -0700, Stephen Warren wrote:
> Build error:
> 
> error: static declaration of 'tegra_assert_system_reset' follows non-static
> declaration
> 
> Fix:
> 
> Remove the non-static declaration; the function should be local now.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks Stephen.  I'd prefer to fix this a different way, moving tegra to
use the .restart method instead.  So, I'm about to merge this into the
commit which created your error.

diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
index f6f03ce..e417a83 100644
--- a/arch/arm/mach-tegra/board-dt.c
+++ b/arch/arm/mach-tegra/board-dt.c
@@ -134,5 +134,6 @@ DT_MACHINE_START(TEGRA_DT, "nVidia Tegra (Flattened Device Tree)")
 	.handle_irq	= gic_handle_irq,
 	.timer		= &tegra_timer,
 	.init_machine	= tegra_dt_init,
+	.restart	= tegra_assert_system_reset,
 	.dt_compat	= tegra_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index fd190a8..70ee674 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -191,4 +191,5 @@ MACHINE_START(HARMONY, "harmony")
 	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_harmony_init,
+	.restart	= tegra_assert_system_reset,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 0b7e1cf..33d6205 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -194,4 +194,5 @@ MACHINE_START(PAZ00, "Toshiba AC100 / Dynabook AZ")
 	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_paz00_init,
+	.restart	= tegra_assert_system_reset,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index 7328379..c1599eb 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -288,6 +288,7 @@ MACHINE_START(SEABOARD, "seaboard")
 	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_seaboard_init,
+	.restart	= tegra_assert_system_reset,
 MACHINE_END
 
 MACHINE_START(KAEN, "kaen")
@@ -298,6 +299,7 @@ MACHINE_START(KAEN, "kaen")
 	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_kaen_init,
+	.restart	= tegra_assert_system_reset,
 MACHINE_END
 
 MACHINE_START(WARIO, "wario")
@@ -308,4 +310,5 @@ MACHINE_START(WARIO, "wario")
 	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_wario_init,
+	.restart	= tegra_assert_system_reset,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index 60a36a2..c242314 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -180,4 +180,5 @@ MACHINE_START(TRIMSLICE, "trimslice")
 	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_trimslice_init,
+	.restart	= tegra_assert_system_reset,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
index f159577..1d14df7 100644
--- a/arch/arm/mach-tegra/board.h
+++ b/arch/arm/mach-tegra/board.h
@@ -23,6 +23,8 @@
 
 #include <linux/types.h>
 
+void tegra_assert_system_reset(char mode, const char *cmd);
+
 void __init tegra_init_early(void);
 void __init tegra_map_common_io(void);
 void __init tegra_init_irq(void);
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 1374d10..20f396d 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -31,7 +31,7 @@
 #include "clock.h"
 #include "fuse.h"
 
-static void tegra_assert_system_reset(char mode, const char *cmd)
+void tegra_assert_system_reset(char mode, const char *cmd)
 {
 	void __iomem *reset = IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x04);
 	u32 reg;
@@ -74,7 +74,6 @@ static void __init tegra_init_cache(void)
 
 void __init tegra_init_early(void)
 {
-	arm_pm_restart = tegra_assert_system_reset;
 	tegra_init_fuse();
 	tegra_init_clock();
 	tegra_clk_init_from_table(common_clk_init_table);
