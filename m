From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:46:59 +0900
Subject: [PATCH 6/6] ARM: shmobile: sh73a0: disable legacy clock initialization
In-Reply-To: <cover.1419809955.git.horms+renesas@verge.net.au>
References: <cover.1419809955.git.horms+renesas@verge.net.au>
Message-ID: <09bd745b555c262d1e2c851777317f3adf3cf3d4.1419809955.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Disables sh73a0_clock_init() if CCF is enabled.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 93ebe34..354cab1 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -763,7 +763,9 @@ void __init __weak sh73a0_register_twd(void) { }
 void __init sh73a0_earlytimer_init(void)
 {
 	shmobile_init_delay();
+#ifndef CONFIG_COMMON_CLK
 	sh73a0_clock_init();
+#endif
 	shmobile_earlytimer_init();
 	sh73a0_register_twd();
 }
@@ -782,8 +784,9 @@ void __init sh73a0_add_early_devices(void)
 void __init sh73a0_add_standard_devices_dt(void)
 {
 	/* clocks are setup late during boot in the case of DT */
+#ifndef CONFIG_COMMON_CLK
 	sh73a0_clock_init();
-
+#endif
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
2.1.3
