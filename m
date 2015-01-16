From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:35:23 +0900
Subject: [PATCH 11/17] ARM: shmobile: sh73a0: Introduce generic setup callback
In-Reply-To: <cover.1421371996.git.horms+renesas@verge.net.au>
References: <cover.1421371996.git.horms+renesas@verge.net.au>
Message-ID: <fcbd924a694351eb1583e8fa3671c7353b43b67d.1421371996.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add a generic sh73a0 machine setup callback for the upcoming
sh73a0 multiplatform case. Cache needs to be configured, and
legacy clocks must be omitted.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 354cab1..34b5a78 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -30,6 +30,7 @@
 #include <linux/platform_data/sh_ipmmu.h>
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
 
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
@@ -779,8 +780,6 @@ void __init sh73a0_add_early_devices(void)
 	shmobile_setup_console();
 }
 
-#ifdef CONFIG_USE_OF
-
 void __init sh73a0_add_standard_devices_dt(void)
 {
 	/* clocks are setup late during boot in the case of DT */
@@ -797,6 +796,17 @@ static void sh73a0_restart(enum reboot_mode mode, const char *cmd)
 	writel((1 << 31), RESCNT2);
 }
 
+#ifdef CONFIG_USE_OF
+
+static void __init sh73a0_generic_init(void)
+{
+#ifdef CONFIG_CACHE_L2X0
+	/* Shared attribute override enable, 64K*8way */
+	l2x0_init(IOMEM(0xf0100000), 0x00400000, 0xc20f0fff);
+#endif
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
 static const char *sh73a0_boards_compat_dt[] __initdata = {
 	"renesas,sh73a0",
 	NULL,
@@ -806,7 +816,7 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
 	.init_early	= shmobile_init_delay,
-	.init_machine	= sh73a0_add_standard_devices_dt,
+	.init_machine	= sh73a0_generic_init,
 	.init_late	= shmobile_init_late,
 	.restart	= sh73a0_restart,
 	.dt_compat	= sh73a0_boards_compat_dt,
-- 
2.1.4
