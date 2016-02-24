From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Feb 2016 10:21:29 +0900
Subject: [PATCH 4/6] ARM: shmobile: emev2: Remove legacy machine_desc.map_io()
 callback
In-Reply-To: <cover.1456275652.git.horms+renesas@verge.net.au>
References: <cover.1456275652.git.horms+renesas@verge.net.au>
Message-ID: <247ac89b99102f79483f7e08b9a94911f9b482d9.1456275652.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Commit FIXME ("ARM: shmobile: Consolidate SCU mapping code") removed the
last user of the static mapping on emev2-based systems.  Remove the
mapping and the legacy machine_desc.map_io() callback.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-emev2.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index 10b7cb5dcb3a..0829d0215c38 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -20,23 +20,6 @@
 #include <asm/mach/map.h>
 #include "common.h"
 
-static struct map_desc emev2_io_desc[] __initdata = {
-#ifdef CONFIG_SMP
-	/* 2M mapping for SCU + L2 controller */
-	{
-		.virtual	= 0xf0000000,
-		.pfn		= __phys_to_pfn(0x1e000000),
-		.length		= SZ_2M,
-		.type		= MT_DEVICE
-	},
-#endif
-};
-
-static void __init emev2_map_io(void)
-{
-	iotable_init(emev2_io_desc, ARRAY_SIZE(emev2_io_desc));
-}
-
 static const char *const emev2_boards_compat_dt[] __initconst = {
 	"renesas,emev2",
 	NULL,
@@ -46,7 +29,6 @@ extern const struct smp_operations emev2_smp_ops;
 
 DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.smp		= smp_ops(emev2_smp_ops),
-	.map_io		= emev2_map_io,
 	.init_early	= shmobile_init_delay,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= emev2_boards_compat_dt,
-- 
2.1.4
