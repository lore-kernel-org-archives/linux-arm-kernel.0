From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 28 Feb 2017 17:01:58 +0100
Subject: [PATCH v4 4/6] ARM: davinci: da8xx: add pdata-quirks for VPIF capture
In-Reply-To: <1488297720-4558-1-git-send-email-bgolaszewski@baylibre.com>
References: <1488297720-4558-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1488297720-4558-5-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@baylibre.com>

For da8xx DT platforms, use pdata-quirks to add legacy platform data for
vpif_capture driver.

Passing legacy platform_data is required until the V4L2 framework, and
subdevice drivers (such as the tvp514x) grow a way of selecting input
and output routing  (c.f. V4L2 s_routing API)

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
[Bartosz:
    - removed unnecessary #ifdefs
    - split the init function into two separate routines for the lcdk
      and evm boards]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/pdata-quirks.c | 111 +++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
index 36fb217..4a9603d 100644
--- a/arch/arm/mach-davinci/pdata-quirks.c
+++ b/arch/arm/mach-davinci/pdata-quirks.c
@@ -10,13 +10,122 @@
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
+static void __init da850_vpif_legacy_register_capture(void)
+{
+	int ret;
+
+	ret = da850_register_vpif_capture(&da850_vpif_capture_config);
+	if (ret)
+		pr_warn("%s: VPIF capture setup failed: %d\n",
+			__func__, ret);
+}
+
+static void __init da850_vpif_capture_legacy_init_lcdk(void)
+{
+	da850_vpif_capture_config.subdev_count = 1;
+	da850_vpif_legacy_register_capture();
+}
+
+static void __init da850_vpif_capture_legacy_init_evm(void)
+{
+	da850_vpif_legacy_register_capture();
+}
+
 static void pdata_quirks_check(struct pdata_init *quirks)
 {
 	while (quirks->compatible) {
@@ -29,6 +138,8 @@ static void pdata_quirks_check(struct pdata_init *quirks)
 }
 
 static struct pdata_init pdata_quirks[] __initdata = {
+	{ "ti,da850-lcdk", da850_vpif_capture_legacy_init_lcdk, },
+	{ "ti,da850-evm", da850_vpif_capture_legacy_init_evm, },
 	{ /* sentinel */ },
 };
 
-- 
2.9.3
