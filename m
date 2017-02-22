From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 22 Feb 2017 15:13:24 +0100
Subject: [PATCH v3 5/6] ARM: davinci: add pdata-quirks for da850-evm vpif
 display
In-Reply-To: <1487772805-19021-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487772805-19021-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1487772805-19021-6-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similarly to vpif capture: we need to register the vpif display driver
and the corresponding adv7343 encoder in pdata-quirks as the DT
support is not complete - there isn't currently a way to define the
output_routing in the V4L2 drivers (c.f. s_routing) via DT.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/pdata-quirks.c | 72 ++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
index cf88195..e2160ce 100644
--- a/arch/arm/mach-davinci/pdata-quirks.c
+++ b/arch/arm/mach-davinci/pdata-quirks.c
@@ -11,6 +11,7 @@
 #include <linux/of_platform.h>
 
 #include <media/i2c/tvp514x.h>
+#include <media/i2c/adv7343.h>
 
 #include <mach/common.h>
 #include <mach/da8xx.h>
@@ -105,7 +106,7 @@ static struct vpif_capture_config da850_vpif_capture_config = {
 	.card_name = "DA850/OMAP-L138 Video Capture",
 };
 
-static void __init da850_vpif_legacy_init(void)
+static void __init da850_vpif_capture_legacy_init(void)
 {
 	int ret;
 
@@ -119,6 +120,70 @@ static void __init da850_vpif_legacy_init(void)
 			__func__, ret);
 }
 
+static struct adv7343_platform_data adv7343_pdata = {
+	.mode_config = {
+		.dac = { 1, 1, 1 },
+	},
+	.sd_config = {
+		.sd_dac_out = { 1 },
+	},
+};
+
+static struct vpif_subdev_info da850_vpif_subdev[] = {
+	{
+		.name = "adv7343",
+		.board_info = {
+			I2C_BOARD_INFO("adv7343", 0x2a),
+			.platform_data = &adv7343_pdata,
+		},
+	},
+};
+
+static const struct vpif_output da850_ch0_outputs[] = {
+	{
+		.output = {
+			.index = 0,
+			.name = "Composite",
+			.type = V4L2_OUTPUT_TYPE_ANALOG,
+			.capabilities = V4L2_OUT_CAP_STD,
+			.std = V4L2_STD_ALL,
+		},
+		.subdev_name = "adv7343",
+		.output_route = ADV7343_COMPOSITE_ID,
+	},
+	{
+		.output = {
+			.index = 1,
+			.name = "S-Video",
+			.type = V4L2_OUTPUT_TYPE_ANALOG,
+			.capabilities = V4L2_OUT_CAP_STD,
+			.std = V4L2_STD_ALL,
+		},
+		.subdev_name = "adv7343",
+		.output_route = ADV7343_SVIDEO_ID,
+	},
+};
+
+static struct vpif_display_config da850_vpif_display_config = {
+	.subdevinfo   = da850_vpif_subdev,
+	.subdev_count = ARRAY_SIZE(da850_vpif_subdev),
+	.chan_config[0] = {
+		.outputs = da850_ch0_outputs,
+		.output_count = ARRAY_SIZE(da850_ch0_outputs),
+	},
+	.card_name    = "DA850/OMAP-L138 Video Display",
+};
+
+static void __init da850_vpif_display_legacy_init(void)
+{
+	int ret;
+
+	ret = da850_register_vpif_display(&da850_vpif_display_config);
+	if (ret)
+		pr_warn("%s: VPIF display setup failed: %d\n",
+			__func__, ret);
+}
+
 static void pdata_quirks_check(struct pdata_init *quirks)
 {
 	while (quirks->compatible) {
@@ -131,8 +196,9 @@ static void pdata_quirks_check(struct pdata_init *quirks)
 }
 
 static struct pdata_init pdata_quirks[] __initdata = {
-	{ "ti,da850-lcdk", da850_vpif_legacy_init, },
-	{ "ti,da850-evm", da850_vpif_legacy_init, },
+	{ "ti,da850-lcdk", da850_vpif_capture_legacy_init, },
+	{ "ti,da850-evm", da850_vpif_display_legacy_init, },
+	{ "ti,da850-evm", da850_vpif_capture_legacy_init, },
 	{ /* sentinel */ },
 };
 
-- 
2.9.3
