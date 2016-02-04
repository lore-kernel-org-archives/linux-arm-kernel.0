From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:30 +0100
Subject: [PATCH 36/70] ARM: shmobile: r8a7740: Migrate to generic l2c OF
 initialization
In-Reply-To: <cover.1454595846.git.horms+renesas@verge.net.au>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
Message-ID: <540977ae9746e60cb95bc3d7d6769fd59b6b2cfc.1454595846.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Migrate the generic r8a7740 platform from calling l2x0_of_init() to the
generic l2c OF initialization.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 0c8f80c5b04d..7b16c12e3f81 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -110,10 +110,6 @@ static void __init r8a7740_generic_init(void)
 {
 	r8a7740_meram_workaround();
 
-#ifdef CONFIG_CACHE_L2X0
-	/* Shared attribute override enable, 32K*8way */
-	l2x0_init(IOMEM(0xf0002000), 0x00400000, 0xc20f0fff);
-#endif
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
@@ -123,6 +119,8 @@ static const char *const r8a7740_boards_compat_dt[] __initconst = {
 };
 
 DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
 	.map_io		= r8a7740_map_io,
 	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
-- 
2.7.0.rc3.207.g0ac5344
