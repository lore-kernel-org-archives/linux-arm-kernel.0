From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:18 +0900
Subject: [PATCH 06/16] ARM: shmobile: lager-reference: Add DU device
In-Reply-To: <cover.1392960310.git.horms+renesas@verge.net.au>
References: <cover.1392960310.git.horms+renesas@verge.net.au>
Message-ID: <433aa851d4b32dc3b3de1e84dc20b57e157b25b9.1392960310.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The DU device has no DT bindings yet, instantiate it as a platform
device for now.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
[horms+renesas at verge.net.au: omitted DTS portion]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 66 ++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 634ef15..6ba8b3b 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -20,13 +20,72 @@
 
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/rcar-du.h>
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <mach/rcar-gen2.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 
+/* DU */
+static struct rcar_du_encoder_data lager_du_encoders[] = {
+	{
+		.type = RCAR_DU_ENCODER_VGA,
+		.output = RCAR_DU_OUTPUT_DPAD0,
+	}, {
+		.type = RCAR_DU_ENCODER_NONE,
+		.output = RCAR_DU_OUTPUT_LVDS1,
+		.connector.lvds.panel = {
+			.width_mm = 210,
+			.height_mm = 158,
+			.mode = {
+				.clock = 65000,
+				.hdisplay = 1024,
+				.hsync_start = 1048,
+				.hsync_end = 1184,
+				.htotal = 1344,
+				.vdisplay = 768,
+				.vsync_start = 771,
+				.vsync_end = 777,
+				.vtotal = 806,
+				.flags = 0,
+			},
+		},
+	},
+};
+
+static struct rcar_du_platform_data lager_du_pdata = {
+	.encoders = lager_du_encoders,
+	.num_encoders = ARRAY_SIZE(lager_du_encoders),
+};
+
+static const struct resource du_resources[] __initconst = {
+	DEFINE_RES_MEM(0xfeb00000, 0x70000),
+	DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
+	DEFINE_RES_MEM_NAMED(0xfeb94000, 0x1c, "lvds.1"),
+	DEFINE_RES_IRQ(gic_spi(256)),
+	DEFINE_RES_IRQ(gic_spi(268)),
+	DEFINE_RES_IRQ(gic_spi(269)),
+};
+
+static void __init lager_add_du_device(void)
+{
+	struct platform_device_info info = {
+		.name = "rcar-du-r8a7790",
+		.id = -1,
+		.res = du_resources,
+		.num_res = ARRAY_SIZE(du_resources),
+		.data = &lager_du_pdata,
+		.size_data = sizeof(lager_du_pdata),
+		.dma_mask = DMA_BIT_MASK(32),
+	};
+
+	platform_device_register_full(&info);
+}
+
 static void __init lager_add_standard_devices(void)
 {
 #ifdef CONFIG_COMMON_CLK
@@ -50,6 +109,11 @@ static void __init lager_add_standard_devices(void)
 		{ "scif1", NULL, "sh-sci.7" },
 		{ "hscif0", NULL, "sh-sci.8" },
 		{ "hscif1", NULL, "sh-sci.9" },
+		{ "du0", "du.0", "rcar-du-r8a7790" },
+		{ "du1", "du.1", "rcar-du-r8a7790" },
+		{ "du2", "du.2", "rcar-du-r8a7790" },
+		{ "lvds0", "lvds.0", "rcar-du-r8a7790" },
+		{ "lvds1", "lvds.1", "rcar-du-r8a7790" },
 	};
 	struct clk *clk;
 	unsigned int i;
@@ -68,6 +132,8 @@ static void __init lager_add_standard_devices(void)
 
 	r8a7790_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	lager_add_du_device();
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
-- 
1.8.5.2
