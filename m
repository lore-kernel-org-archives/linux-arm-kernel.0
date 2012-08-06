From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 Aug 2012 23:42:45 +0800
Subject: [PATCH 2/6] ARM: mxs: use auxdata to pass flexcan_switch function hook
In-Reply-To: <1344267769-31166-1-git-send-email-shawn.guo@linaro.org>
References: <1344267769-31166-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344267769-31166-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some efforts going on to have flexcan_switch function
implemented in flexcan driver, so that this platform function hook
can be saved for device tree boot.  But due to the mx28evk board
design oddness that two flexcan transceivers share one switch gpio,
we have to come up a separate and generic gpio-switch driver to handle
all these gpio switch use cases.

Before that happens, we choose to use auxdata to pass flexcan_switch
function hook, so that the DT conversion is not blocked there.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/mach-mxs.c |   44 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 6ba37df..1bfff30 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -12,6 +12,7 @@
 
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/can/platform/flexcan.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
@@ -103,9 +104,40 @@ static struct fb_videomode apx4devkit_video_modes[] = {
 
 static struct mxsfb_platform_data mxsfb_pdata __initdata;
 
+/*
+ * MX28EVK_FLEXCAN_SWITCH is shared between both flexcan controllers
+ */
+#define MX28EVK_FLEXCAN_SWITCH	MXS_GPIO_NR(2, 13)
+
+static int flexcan0_en, flexcan1_en;
+
+static void mx28evk_flexcan_switch(void)
+{
+	if (flexcan0_en || flexcan1_en)
+		gpio_set_value(MX28EVK_FLEXCAN_SWITCH, 1);
+	else
+		gpio_set_value(MX28EVK_FLEXCAN_SWITCH, 0);
+}
+
+static void mx28evk_flexcan0_switch(int enable)
+{
+	flexcan0_en = enable;
+	mx28evk_flexcan_switch();
+}
+
+static void mx28evk_flexcan1_switch(int enable)
+{
+	flexcan1_en = enable;
+	mx28evk_flexcan_switch();
+}
+
+static struct flexcan_platform_data flexcan_pdata[2];
+
 static struct of_dev_auxdata mxs_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("fsl,imx23-lcdif", 0x80030000, NULL, &mxsfb_pdata),
 	OF_DEV_AUXDATA("fsl,imx28-lcdif", 0x80030000, NULL, &mxsfb_pdata),
+	OF_DEV_AUXDATA("fsl,imx28-flexcan", 0x80032000, NULL, &flexcan_pdata[0]),
+	OF_DEV_AUXDATA("fsl,imx28-flexcan", 0x80034000, NULL, &flexcan_pdata[1]),
 	{ /* sentinel */ }
 };
 
@@ -245,6 +277,15 @@ static void __init imx28_evk_init(void)
 	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
 }
 
+static void __init imx28_evk_post_init(void)
+{
+	if (!gpio_request_one(MX28EVK_FLEXCAN_SWITCH, GPIOF_DIR_OUT,
+			      "flexcan-switch")) {
+		flexcan_pdata[0].transceiver_switch = mx28evk_flexcan0_switch;
+		flexcan_pdata[1].transceiver_switch = mx28evk_flexcan1_switch;
+	}
+}
+
 static void __init m28evk_init(void)
 {
 	enable_clk_enet_out();
@@ -366,6 +407,9 @@ static void __init mxs_machine_init(void)
 
 	if (of_machine_is_compatible("karo,tx28"))
 		tx28_post_init();
+
+	if (of_machine_is_compatible("fsl,imx28-evk"))
+		imx28_evk_post_init();
 }
 
 static const char *imx23_dt_compat[] __initdata = {
-- 
1.7.5.4
