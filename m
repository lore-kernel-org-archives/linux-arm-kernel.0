From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:32:14 +0100
Subject: [PATCH 71/97] ARM: l2c: convert tegra to generic l2c initialisation
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerHi-0001YW-Oi@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-tegra/tegra.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 1bc49f9db015..15ac9fcc96b1 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -70,20 +70,12 @@ u32 tegra_uart_config[3] = {
 	0,
 };
 
-static void __init tegra_init_cache(void)
-{
-#ifdef CONFIG_CACHE_L2X0
-	l2x0_of_init(0x3c400001, 0xc20fc3fe);
-#endif
-}
-
 static void __init tegra_init_early(void)
 {
 	of_register_trusted_foundations();
 	tegra_apb_io_init();
 	tegra_init_fuse();
 	tegra_cpu_reset_handler_init();
-	tegra_init_cache();
 	tegra_powergate_init();
 	tegra_hotplug_init();
 }
@@ -171,8 +163,10 @@ static const char * const tegra_dt_board_compat[] = {
 };
 
 DT_MACHINE_START(TEGRA_DT, "NVIDIA Tegra SoC (Flattened Device Tree)")
-	.map_io		= tegra_map_common_io,
+	.l2c_aux_val	= 0x3c400001,
+	.l2c_aux_mask	= 0xc20fc3fe,
 	.smp		= smp_ops(tegra_smp_ops),
+	.map_io		= tegra_map_common_io,
 	.init_early	= tegra_init_early,
 	.init_irq	= tegra_dt_init_irq,
 	.init_machine	= tegra_dt_init,
-- 
1.8.3.1
