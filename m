From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 Jul 2013 16:36:19 +0900
Subject: [PATCH 07/11] ARM: shmobile: EMEV2 map_io update
In-Reply-To: <cover.1374478037.git.horms+renesas@verge.net.au>
References: <cover.1374478037.git.horms+renesas@verge.net.au>
Message-ID: <0ea2b5389ab1b63aa880c5735c15be0b26b91b1a.1374478037.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the EMEV2 struct map_desc to exclude the SMU
and also include the ->map_io() callback in the DT
version of EMEV2 board support.

The EMEV2 SMP code can these days perform ioremap()
early on without the SMU information in the io_desc[].

To correctly support SMP in case of DT-only board
support then the ->map_io() callback is needed.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-emev2.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index 6fa485d..19980be 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -38,13 +38,6 @@
 
 static struct map_desc emev2_io_desc[] __initdata = {
 #ifdef CONFIG_SMP
-	/* 128K entity map for 0xe0100000 (SMU) */
-	{
-		.virtual	= 0xe0100000,
-		.pfn		= __phys_to_pfn(0xe0100000),
-		.length		= SZ_128K,
-		.type		= MT_DEVICE
-	},
 	/* 2M mapping for SCU + L2 controller */
 	{
 		.virtual	= 0xf0000000,
@@ -211,6 +204,7 @@ static const char *emev2_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.smp		= smp_ops(emev2_smp_ops),
+	.map_io		= emev2_map_io,
 	.init_early	= emev2_init_delay,
 	.dt_compat	= emev2_boards_compat_dt,
 MACHINE_END
-- 
1.8.2.1
