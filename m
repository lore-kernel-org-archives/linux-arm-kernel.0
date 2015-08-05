From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  5 Aug 2015 10:58:09 +0200
Subject: [PATCH v4 5/6] ARM: shmobile: r8a7740: Migrate to generic l2c OF
 initialization
In-Reply-To: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
References: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1438765090-823-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate the generic r8a7740 platform from calling l2x0_of_init() to the
generic l2c OF initialization.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - This depends on commit eeedcea69e927857 ("ARM: 8395/1: l2c: Add
    support for the "arm,shared-override" property"), which is queued
    for 4.3 in arm/for-next,

v3:
  - Use 0/~0 now DT supports "arm,shared-override",

v2:
  - Keep only {,~}L2C_AUX_CTRL_SHARED_OVERRIDE.
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 0c8f80c5b04df34d..7b16c12e3f816f7f 100644
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
1.9.1
