From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Aug 2013 10:37:51 +0900
Subject: [PATCH 1/5] ARM: shmobile: marzen: Add Display Unit support
In-Reply-To: <cover.1377653181.git.horms+renesas@verge.net.au>
References: <cover.1377653181.git.horms+renesas@verge.net.au>
Message-ID: <10fb3616fdff6d4a79bd1360627d07eb223df56f.1377653181.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Support the DU0 VGA and DU1 LVDS outputs. DU1 is connected to a
Mitsubishi AA104XD12 panel (10.4" XGA).

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c | 72 +++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index a7d1010..4fa32cc 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -29,6 +29,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
+#include <linux/platform_data/rcar-du.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
@@ -148,6 +149,63 @@ static struct platform_device hspi_device = {
 	.num_resources	= ARRAY_SIZE(hspi_resources),
 };
 
+/*
+ * DU
+ *
+ * The panel only specifies the [hv]display and [hv]total values. The position
+ * and width of the sync pulses don't matter, they're copied from VESA timings.
+ */
+static struct rcar_du_encoder_data du_encoders[] = {
+	{
+		.type = RCAR_DU_ENCODER_VGA,
+		.output = RCAR_DU_OUTPUT_DPAD0,
+	}, {
+		.type = RCAR_DU_ENCODER_LVDS,
+		.output = RCAR_DU_OUTPUT_DPAD1,
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
+static const struct rcar_du_platform_data du_pdata __initconst = {
+	.encoders = du_encoders,
+	.num_encoders = ARRAY_SIZE(du_encoders),
+};
+
+static const struct resource du_resources[] __initconst = {
+	DEFINE_RES_MEM(0xfff80000, 0x40000),
+	DEFINE_RES_IRQ(gic_iid(0x3f)),
+};
+
+static void __init marzen_add_du_device(void)
+{
+	struct platform_device_info info = {
+		.name = "rcar-du-r8a7779",
+		.id = -1,
+		.res = du_resources,
+		.num_res = ARRAY_SIZE(du_resources),
+		.data = &du_pdata,
+		.size_data = sizeof(du_pdata),
+		.dma_mask = DMA_BIT_MASK(32),
+	};
+
+	platform_device_register_full(&info);
+}
+
 /* LEDS */
 static struct gpio_led marzen_leds[] = {
 	{
@@ -187,6 +245,19 @@ static struct platform_device *marzen_devices[] __initdata = {
 };
 
 static const struct pinctrl_map marzen_pinctrl_map[] = {
+	/* DU (CN10: ARGB0, CN13: LVDS) */
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7779", "pfc-r8a7779",
+				  "du0_rgb888", "du0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7779", "pfc-r8a7779",
+				  "du0_sync_1", "du0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7779", "pfc-r8a7779",
+				  "du0_clk_out_0", "du0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7779", "pfc-r8a7779",
+				  "du1_rgb666", "du1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7779", "pfc-r8a7779",
+				  "du1_sync_1", "du1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7779", "pfc-r8a7779",
+				  "du1_clk_out", "du1"),
 	/* HSPI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-hspi.0", "pfc-r8a7779",
 				  "hspi0", "hspi0"),
@@ -236,6 +307,7 @@ static void __init marzen_init(void)
 	r8a7779_add_standard_devices();
 	r8a7779_add_usb_phy_device(&usb_phy_platform_data);
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
+	marzen_add_du_device();
 }
 
 MACHINE_START(MARZEN, "marzen")
-- 
1.8.3.2
