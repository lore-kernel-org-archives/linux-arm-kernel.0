From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:30 +0900
Subject: [PATCH 07/10] ARM: shmobile: lager-reference: Remove DU platform
 device
In-Reply-To: <cover.1415058552.git.horms+renesas@verge.net.au>
References: <cover.1415058552.git.horms+renesas@verge.net.au>
Message-ID: <64d9c22154d77a448944733d1373c8c0af8e0de2.1415058552.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The DU device is now instantiated from the device tree, remove the
corresponding platform device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 80 --------------------------
 1 file changed, 80 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 93f31b7..fa06bdb 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -14,94 +14,15 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
-#include <linux/platform_data/rcar-du.h>
 
 #include <asm/mach/arch.h>
 
-#include "clock.h"
 #include "common.h"
-#include "irqs.h"
 #include "r8a7790.h"
 #include "rcar-gen2.h"
 
-/* DU */
-static struct rcar_du_encoder_data lager_du_encoders[] = {
-	{
-		.type = RCAR_DU_ENCODER_VGA,
-		.output = RCAR_DU_OUTPUT_DPAD0,
-	}, {
-		.type = RCAR_DU_ENCODER_NONE,
-		.output = RCAR_DU_OUTPUT_LVDS1,
-		.connector.lvds.panel = {
-			.width_mm = 210,
-			.height_mm = 158,
-			.mode = {
-				.pixelclock = 65000000,
-				.hactive = 1024,
-				.hfront_porch = 20,
-				.hback_porch = 160,
-				.hsync_len = 136,
-				.vactive = 768,
-				.vfront_porch = 3,
-				.vback_porch = 29,
-				.vsync_len = 6,
-			},
-		},
-	},
-};
-
-static struct rcar_du_platform_data lager_du_pdata = {
-	.encoders = lager_du_encoders,
-	.num_encoders = ARRAY_SIZE(lager_du_encoders),
-};
-
-static const struct resource du_resources[] __initconst = {
-	DEFINE_RES_MEM(0xfeb00000, 0x70000),
-	DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
-	DEFINE_RES_MEM_NAMED(0xfeb94000, 0x1c, "lvds.1"),
-	DEFINE_RES_IRQ(gic_spi(256)),
-	DEFINE_RES_IRQ(gic_spi(268)),
-	DEFINE_RES_IRQ(gic_spi(269)),
-};
-
-static void __init lager_add_du_device(void)
-{
-	struct platform_device_info info = {
-		.name = "rcar-du-r8a7790",
-		.id = -1,
-		.res = du_resources,
-		.num_res = ARRAY_SIZE(du_resources),
-		.data = &lager_du_pdata,
-		.size_data = sizeof(lager_du_pdata),
-		.dma_mask = DMA_BIT_MASK(32),
-	};
-
-	platform_device_register_full(&info);
-}
-
-/*
- * This is a really crude hack to provide clkdev support to platform
- * devices until they get moved to DT.
- */
-static const struct clk_name clk_names[] __initconst = {
-	{ "du0", "du.0", "rcar-du-r8a7790" },
-	{ "du1", "du.1", "rcar-du-r8a7790" },
-	{ "du2", "du.2", "rcar-du-r8a7790" },
-	{ "lvds0", "lvds.0", "rcar-du-r8a7790" },
-	{ "lvds1", "lvds.1", "rcar-du-r8a7790" },
-};
-
-static void __init lager_add_standard_devices(void)
-{
-	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-
-	lager_add_du_device();
-}
-
 static const char *lager_boards_compat_dt[] __initdata = {
 	"renesas,lager",
 	"renesas,lager-reference",
@@ -112,7 +33,6 @@ DT_MACHINE_START(LAGER_DT, "lager")
 	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
-	.init_machine	= lager_add_standard_devices,
 	.init_late	= shmobile_init_late,
 	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= lager_boards_compat_dt,
-- 
2.1.1
