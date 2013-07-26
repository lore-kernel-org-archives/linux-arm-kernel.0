From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Jul 2013 09:51:51 +0900
Subject: [PATCH v3 2/4] ARM: shmobile: marzen: Switch to DT_MACHINE_START
In-Reply-To: <1374799913-27461-1-git-send-email-horms+renesas@verge.net.au>
References: <1374799913-27461-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1374799913-27461-3-git-send-email-horms+renesas@verge.net.au>
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

v3 [Simon Horman]
* Move r8a7779-marzen dts into a separate patch

v2 [Simon Horman]
* Select USE_OF in Kconfig
* Provide dt_compat in DT_MACHINE_START
* Provide r8a7779-marzen dts

v1 [Magnus Damm]
---
 arch/arm/mach-shmobile/Kconfig        | 1 +
 arch/arm/mach-shmobile/board-marzen.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 0130805..1f94c31 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -182,6 +182,7 @@ config MACH_MARZEN
 	depends on ARCH_R8A7779
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select USE_OF
 
 config MACH_MARZEN_REFERENCE
 	bool "MARZEN board - Reference Device Tree Implementation"
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 1f57865..91f8751 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -237,7 +237,12 @@ static void __init marzen_init(void)
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
@@ -245,5 +250,6 @@ MACHINE_START(MARZEN, "marzen")
 	.init_irq	= r8a7779_init_irq,
 	.init_machine	= marzen_init,
 	.init_late	= r8a7779_init_late,
+	.dt_compat	= marzen_boards_compat_dt,
 	.init_time	= r8a7779_earlytimer_init,
 MACHINE_END
-- 
1.8.2.1
