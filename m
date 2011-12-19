From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 19 Dec 2011 12:24:03 -0700
Subject: [PATCH 1/3] arm/tegra: Delete tegra_init_clock()
Message-ID: <1324322645-30653-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tegra_init_clock() is written to call tegra2_init_clocks(), which only
exists if Tegra20 support is enabled. This breaks the build of a
Tegra30-only kernel.

tegra_init_clock() isn't actually used any more; tegra20_init_early()
calls tegra2_init_clocks() directly. So, just delete this function.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
These 3 patches are all cleanup for Tegra's for-3.3/soc branch.

 arch/arm/mach-tegra/board.h |    1 -
 arch/arm/mach-tegra/clock.c |    5 -----
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
index 628f5a8..75d1543 100644
--- a/arch/arm/mach-tegra/board.h
+++ b/arch/arm/mach-tegra/board.h
@@ -30,7 +30,6 @@ void __init tegra30_init_early(void);
 void __init tegra_map_common_io(void);
 void __init tegra_init_irq(void);
 void __init tegra_dt_init_irq(void);
-void __init tegra_init_clock(void);
 int __init tegra_pcie_init(bool init_port0, bool init_port1);
 
 extern struct sys_timer tegra_timer;
diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
index a8f359d..8337068 100644
--- a/arch/arm/mach-tegra/clock.c
+++ b/arch/arm/mach-tegra/clock.c
@@ -399,11 +399,6 @@ void tegra_periph_reset_assert(struct clk *c)
 }
 EXPORT_SYMBOL(tegra_periph_reset_assert);
 
-void __init tegra_init_clock(void)
-{
-	tegra2_init_clocks();
-}
-
 #ifdef CONFIG_DEBUG_FS
 
 static int __clk_lock_all_spinlocks(void)
-- 
1.7.0.4
