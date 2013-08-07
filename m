From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:28:31 +0900
Subject: [GIT PULL 10/19] ARM: shmobile: marzen: Switch to DT_MACHINE_START
In-Reply-To: <cover.1375838900.git.horms+renesas@verge.net.au>
References: <cover.1375838900.git.horms+renesas@verge.net.au>
Message-ID: <7ebbb4ae6f2d6242178d332c67ad49772f9fe88d.1375838900.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert the marzen board to use DT_MACHINE_START. With this in
place all mach-shmobile boards use DT_MACHINE_START. Also, this
makes it possible for the r8a7779 SMP code to use DT for CPUs.

Signed-off-by: Magnus Damm <damm@opensource.se>
[horms+renesas at verge.net.au: Select USE_OF in Kconfig]
[horms+renesas at verge.net.au: Provide dt_compat in DT_MACHINE_START]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig        | 1 +
 arch/arm/mach-shmobile/board-marzen.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 9e07985..16c3072 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -156,6 +156,7 @@ config MACH_MARZEN
 	depends on ARCH_R8A7779
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select USE_OF
 
 config MACH_MARZEN_REFERENCE
 	bool "MARZEN board - Reference Device Tree Implementation"
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index a7d1010..bcd07c0 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -238,7 +238,12 @@ static void __init marzen_init(void)
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
 }
 
-MACHINE_START(MARZEN, "marzen")
+static const char *marzen_boards_compat_dt[] __initdata = {
+        "renesas,marzen",
+        NULL,
+};
+
+DT_MACHINE_START(MARZEN, "marzen")
 	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_add_early_devices,
@@ -246,5 +251,6 @@ MACHINE_START(MARZEN, "marzen")
 	.init_irq	= r8a7779_init_irq,
 	.init_machine	= marzen_init,
 	.init_late	= r8a7779_init_late,
+	.dt_compat	= marzen_boards_compat_dt,
 	.init_time	= r8a7779_earlytimer_init,
 MACHINE_END
-- 
1.8.3.2
