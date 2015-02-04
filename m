From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  4 Feb 2015 15:15:12 +0100
Subject: [PATCH v2 2/5] ARM: shmobile: r8a7740: Migrate to generic l2c OF
 initialization
In-Reply-To: <1423059315-28519-1-git-send-email-geert+renesas@glider.be>
References: <1423059315-28519-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1423059315-28519-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate the generic r8a7740 platform from calling l2x0_of_init() to the
generic l2c OF initialization.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2
  - Keep only {,~}L2C_AUX_CTRL_SHARED_OVERRIDE
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index d191cf4197313482..3ebd4dfc8e853a9b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -835,10 +835,6 @@ static void __init r8a7740_generic_init(void)
 {
 	r8a7740_meram_workaround();
 
-#ifdef CONFIG_CACHE_L2X0
-	/* Shared attribute override enable, 32K*8way */
-	l2x0_init(IOMEM(0xf0002000), 0x00400000, 0xc20f0fff);
-#endif
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
@@ -855,6 +851,8 @@ static const char *r8a7740_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
+	.l2c_aux_val	= L2C_AUX_CTRL_SHARED_OVERRIDE,
+	.l2c_aux_mask	= ~L2C_AUX_CTRL_SHARED_OVERRIDE,
 	.map_io		= r8a7740_map_io,
 	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
-- 
1.9.1
