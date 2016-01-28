From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 28 Jan 2016 16:17:25 +0100
Subject: [PATCH 1/2] ARM: shmobile: r8a7740: Remove legacy
 machine_desc.map_io() callback
In-Reply-To: <1453994246-12886-1-git-send-email-geert+renesas@glider.be>
References: <1453994246-12886-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1453994246-12886-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 37201ba5c99d0be8 ("ARM: shmobile: r8a7740: Migrate to generic l2c
OF initialization") removed the last user of the legacy "IOMEM()" macro
on r8a7740-based systems. Hence there's no longer a need to set up a
transparent mapping of system I/O registers. Remove the mapping and the
legacy machine_desc.map_io() callback.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 496569f9d578b863..b0f3ce80bb1df294 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -27,25 +27,6 @@
 
 #include "common.h"
 
-static struct map_desc r8a7740_io_desc[] __initdata = {
-	 /*
-	  * for CPGA/INTC/PFC
-	  * 0xe6000000-0xefffffff -> 0xe6000000-0xefffffff
-	  */
-	{
-		.virtual	= 0xe6000000,
-		.pfn		= __phys_to_pfn(0xe6000000),
-		.length		= 160 << 20,
-		.type		= MT_DEVICE_NONSHARED
-	},
-};
-
-static void __init r8a7740_map_io(void)
-{
-	debug_ll_io_init();
-	iotable_init(r8a7740_io_desc, ARRAY_SIZE(r8a7740_io_desc));
-}
-
 /*
  * r8a7740 chip has lasting errata on MERAM buffer.
  * this is work-around for it.
@@ -109,7 +90,6 @@ static const char *const r8a7740_boards_compat_dt[] __initconst = {
 DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
-	.map_io		= r8a7740_map_io,
 	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
 	.init_machine	= r8a7740_generic_init,
-- 
1.9.1
