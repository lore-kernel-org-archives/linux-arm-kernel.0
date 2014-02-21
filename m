From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:20 +0900
Subject: [PATCH 08/16] ARM: shmobile: koelsch-reference: Add DU device
In-Reply-To: <cover.1392960310.git.horms+renesas@verge.net.au>
References: <cover.1392960310.git.horms+renesas@verge.net.au>
Message-ID: <14c5ce178ee46b205ff4e9087d5ecba298798edc.1392960310.git.horms+renesas@verge.net.au>
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
 arch/arm/mach-shmobile/board-koelsch-reference.c | 59 ++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 42c6eb4..267fe83 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -21,13 +21,67 @@
 
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/rcar-du.h>
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <mach/rcar-gen2.h>
 #include <mach/r8a7791.h>
 #include <asm/mach/arch.h>
 
+/* DU */
+static struct rcar_du_encoder_data koelsch_du_encoders[] = {
+	{
+		.type = RCAR_DU_ENCODER_NONE,
+		.output = RCAR_DU_OUTPUT_LVDS0,
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
+static struct rcar_du_platform_data koelsch_du_pdata = {
+	.encoders = koelsch_du_encoders,
+	.num_encoders = ARRAY_SIZE(koelsch_du_encoders),
+};
+
+static const struct resource du_resources[] __initconst = {
+	DEFINE_RES_MEM(0xfeb00000, 0x40000),
+	DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
+	DEFINE_RES_IRQ(gic_spi(256)),
+	DEFINE_RES_IRQ(gic_spi(268)),
+};
+
+static void __init koelsch_add_du_device(void)
+{
+	struct platform_device_info info = {
+		.name = "rcar-du-r8a7791",
+		.id = -1,
+		.res = du_resources,
+		.num_res = ARRAY_SIZE(du_resources),
+		.data = &koelsch_du_pdata,
+		.size_data = sizeof(koelsch_du_pdata),
+		.dma_mask = DMA_BIT_MASK(32),
+	};
+
+	platform_device_register_full(&info);
+}
+
 static void __init koelsch_add_standard_devices(void)
 {
 #ifdef CONFIG_COMMON_CLK
@@ -56,6 +110,9 @@ static void __init koelsch_add_standard_devices(void)
 		{ "scifa3", NULL, "sh-sci.12" },
 		{ "scifa4", NULL, "sh-sci.13" },
 		{ "scifa5", NULL, "sh-sci.14" },
+		{ "du0", "du.0", "rcar-du-r8a7791" },
+		{ "du1", "du.1", "rcar-du-r8a7791" },
+		{ "lvds0", "lvds.0", "rcar-du-r8a7791" },
 	};
 	struct clk *clk;
 	unsigned int i;
@@ -73,6 +130,8 @@ static void __init koelsch_add_standard_devices(void)
 #endif
 	r8a7791_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	koelsch_add_du_device();
 }
 
 static const char * const koelsch_boards_compat_dt[] __initconst = {
-- 
1.8.5.2
