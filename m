From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 16 Feb 2017 19:21:22 +0100
Subject: [PATCH 2/4] ARM: davinci: da8xx: add pdata-quirks for VPIF capture
In-Reply-To: <1487269285-6948-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487269285-6948-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1487269285-6948-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@baylibre.com>

For da8xx DT platforms, use pdata-quirks to add legacy platform data for
vpif_capture driver.

Passing legacy platform_data is required until the V4L2 framework, and
subdevice drivers (such as the tvp514x) grow a way of selecting input
and output routing  (c.f. V4L2 s_routing API)

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/mach-davinci/da8xx-dt.c     |   1 +
 arch/arm/mach-davinci/pdata-quirks.c | 111 +++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index e3cef50..5699ce3 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -53,6 +53,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,da830-musb", 0x01e00000, "musb-da8xx", NULL),
 	OF_DEV_AUXDATA("ti,da830-usb-phy", 0x01c1417c, "da8xx-usb-phy", NULL),
 	OF_DEV_AUXDATA("ti,da850-ahci", 0x01e18000, "ahci_da850", NULL),
+	OF_DEV_AUXDATA("ti,da850-vpif", 0x01e17000, "vpif", NULL),
 	{}
 };
 
diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
index 5b57da4..3ca773f 100644
--- a/arch/arm/mach-davinci/pdata-quirks.c
+++ b/arch/arm/mach-davinci/pdata-quirks.c
@@ -10,13 +10,118 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 
+#include <media/i2c/tvp514x.h>
+
 #include <mach/common.h>
+#include <mach/da8xx.h>
 
 struct pdata_init {
 	const char *compatible;
 	void (*fn)(void);
 };
 
+#if IS_ENABLED(CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE)
+
+#define TVP5147_CH0		"tvp514x-0"
+#define TVP5147_CH1		"tvp514x-1"
+
+/* VPIF capture configuration */
+static struct tvp514x_platform_data tvp5146_pdata = {
+		.clk_polarity = 0,
+		.hs_polarity  = 1,
+		.vs_polarity  = 1,
+};
+
+#define TVP514X_STD_ALL (V4L2_STD_NTSC | V4L2_STD_PAL)
+
+static const struct vpif_input da850_ch0_inputs[] = {
+	{
+		.input = {
+			.index = 0,
+			.name  = "Composite",
+			.type  = V4L2_INPUT_TYPE_CAMERA,
+			.capabilities = V4L2_IN_CAP_STD,
+			.std   = TVP514X_STD_ALL,
+		},
+		.input_route = INPUT_CVBS_VI2B,
+		.output_route = OUTPUT_10BIT_422_EMBEDDED_SYNC,
+		.subdev_name = TVP5147_CH0,
+	},
+};
+
+static const struct vpif_input da850_ch1_inputs[] = {
+	{
+		.input = {
+			.index = 0,
+			.name  = "S-Video",
+			.type  = V4L2_INPUT_TYPE_CAMERA,
+			.capabilities = V4L2_IN_CAP_STD,
+			.std   = TVP514X_STD_ALL,
+		},
+		.input_route = INPUT_SVIDEO_VI2C_VI1C,
+		.output_route = OUTPUT_10BIT_422_EMBEDDED_SYNC,
+		.subdev_name = TVP5147_CH1,
+	},
+};
+
+static struct vpif_subdev_info da850_vpif_capture_sdev_info[] = {
+	{
+		.name = TVP5147_CH0,
+		.board_info = {
+			I2C_BOARD_INFO("tvp5146", 0x5d),
+			.platform_data = &tvp5146_pdata,
+		},
+	},
+	{
+		.name = TVP5147_CH1,
+		.board_info = {
+			I2C_BOARD_INFO("tvp5146", 0x5c),
+			.platform_data = &tvp5146_pdata,
+		},
+	},
+};
+
+static struct vpif_capture_config da850_vpif_capture_config = {
+	.subdev_info = da850_vpif_capture_sdev_info,
+	.subdev_count = ARRAY_SIZE(da850_vpif_capture_sdev_info),
+	.chan_config[0] = {
+		.inputs = da850_ch0_inputs,
+		.input_count = ARRAY_SIZE(da850_ch0_inputs),
+		.vpif_if = {
+			.if_type = VPIF_IF_BT656,
+			.hd_pol  = 1,
+			.vd_pol  = 1,
+			.fid_pol = 0,
+		},
+	},
+	.chan_config[1] = {
+		.inputs = da850_ch1_inputs,
+		.input_count = ARRAY_SIZE(da850_ch1_inputs),
+		.vpif_if = {
+			.if_type = VPIF_IF_BT656,
+			.hd_pol  = 1,
+			.vd_pol  = 1,
+			.fid_pol = 0,
+		},
+	},
+	.card_name = "DA850/OMAP-L138 Video Capture",
+};
+
+static void __init da850_vpif_legacy_init(void)
+{
+	int ret;
+
+	/* LCDK doesn't have the 2nd TVP514x on CH1 */
+	if (of_machine_is_compatible("ti,da850-lcdk"))
+		da850_vpif_capture_config.subdev_count = 1;
+
+	ret = da850_register_vpif_capture(&da850_vpif_capture_config);
+	if (ret)
+		pr_warn("%s: VPIF capture setup failed: %d\n",
+			__func__, ret);
+}
+#endif
+
 static void pdata_quirks_check(struct pdata_init *quirks)
 {
 	while (quirks->compatible) {
@@ -30,6 +135,12 @@ static void pdata_quirks_check(struct pdata_init *quirks)
 }
 
 static struct pdata_init pdata_quirks[] __initdata = {
+#if IS_ENABLED(CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE)
+	{ "ti,da850-lcdk", da850_vpif_legacy_init, },
+#if defined(CONFIG_DA850_UI_SD_VIDEO_PORT)
+	{ "ti,da850-evm", da850_vpif_legacy_init, },
+#endif
+#endif
 	{ /* sentinel */ },
 };
 
-- 
2.9.3
