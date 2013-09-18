From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Sep 2013 19:53:57 +0200
Subject: [PATCH 24/26] ARM: tegra: remove custom .init_time hook
In-Reply-To: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1379526839-14798-25-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With arch/arm calling of_clk_init(NULL) from time_init(), we can now
remove custom .init_time hooks.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-tegra at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-tegra/tegra.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 4da271d..2e21928 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -16,7 +16,6 @@
  *
  */
 
-#include <linux/clocksource.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -33,7 +32,6 @@
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 #include <linux/usb/tegra_usb_phy.h>
-#include <linux/clk-provider.h>
 #include <linux/clk/tegra.h>
 
 #include <asm/mach-types.h>
@@ -84,12 +82,6 @@ out:
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
 }
 
-static void __init tegra_dt_init_time(void)
-{
-	of_clk_init(NULL);
-	clocksource_of_init();
-}
-
 static void __init paz00_init(void)
 {
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
@@ -129,7 +121,6 @@ DT_MACHINE_START(TEGRA_DT, "NVIDIA Tegra SoC (Flattened Device Tree)")
 	.smp		= smp_ops(tegra_smp_ops),
 	.init_early	= tegra_init_early,
 	.init_irq	= tegra_dt_init_irq,
-	.init_time	= tegra_dt_init_time,
 	.init_machine	= tegra_dt_init,
 	.init_late	= tegra_dt_init_late,
 	.restart	= tegra_assert_system_reset,
-- 
1.7.10.4
