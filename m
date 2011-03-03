From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 3 Mar 2011 22:13:38 +0800
Subject: [PATCH v2] ARM: mxs/mx28evk: add flexcan devices
Message-ID: <1299161618-10387-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/mach-mx28evk.c |   55 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 895d066..cdbe18b 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -33,6 +33,7 @@ config MACH_MX28EVK
 	select MXS_HAVE_AMBA_DUART
 	select MXS_HAVE_PLATFORM_AUART
 	select MXS_HAVE_PLATFORM_FEC
+	select MXS_HAVE_PLATFORM_FLEXCAN
 	select MXS_OCOTP
 	default y
 	help
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index 1f0b708..652ce0e 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -28,6 +28,7 @@
 #include "devices-mx28.h"
 #include "gpio.h"
 
+#define MX28EVK_FLEXCAN_SWITCH	MXS_GPIO_NR(2, 13)
 #define MX28EVK_FEC_PHY_POWER	MXS_GPIO_NR(2, 15)
 #define MX28EVK_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
 
@@ -95,6 +96,15 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
 	/* phy reset line */
 	MX28_PAD_ENET0_RX_CLK__GPIO_4_13 |
 		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+
+	/* flexcan0 */
+	MX28_PAD_GPMI_RDY2__CAN0_TX,
+	MX28_PAD_GPMI_RDY3__CAN0_RX,
+	/* flexcan1 */
+	MX28_PAD_GPMI_CE2N__CAN1_TX,
+	MX28_PAD_GPMI_CE3N__CAN1_RX,
+	/* transceiver power control */
+	MX28_PAD_SSP1_CMD__GPIO_2_13,
 };
 
 /* fec */
@@ -178,8 +188,44 @@ error:
 	return -ETIMEDOUT;
 }
 
+/*
+ * MX28EVK_FLEXCAN_SWITCH is shared between both flexcan controllers
+ */
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
+static const struct flexcan_platform_data
+		mx28evk_flexcan_pdata[] __initconst = {
+	{
+		.transceiver_switch = mx28evk_flexcan0_switch,
+	}, {
+		.transceiver_switch = mx28evk_flexcan1_switch,
+	}
+};
+
 static void __init mx28evk_init(void)
 {
+	int ret;
+
 	mxs_iomux_setup_multiple_pads(mx28evk_pads, ARRAY_SIZE(mx28evk_pads));
 
 	mx28_add_duart();
@@ -192,6 +238,15 @@ static void __init mx28evk_init(void)
 	mx28evk_fec_reset();
 	mx28_add_fec(0, &mx28_fec_pdata[0]);
 	mx28_add_fec(1, &mx28_fec_pdata[1]);
+
+	ret = gpio_request_one(MX28EVK_FLEXCAN_SWITCH, GPIOF_DIR_OUT,
+				"flexcan-switch");
+	if (ret) {
+		pr_err("failed to request gpio flexcan-switch: %d\n", ret);
+	} else {
+		mx28_add_flexcan(0, &mx28evk_flexcan_pdata[0]);
+		mx28_add_flexcan(1, &mx28evk_flexcan_pdata[1]);
+	}
 }
 
 static void __init mx28evk_timer_init(void)
-- 
1.7.1
