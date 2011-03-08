From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 8 Mar 2011 18:51:10 +0800
Subject: [PATCH 2/2] ARM: mxs/mx28evk: add framebuffer device
In-Reply-To: <1299581470-29854-1-git-send-email-shawn.guo@freescale.com>
References: <1299581470-29854-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1299581470-29854-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/mach-mx28evk.c |   76 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 989c08c..678b646 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -34,6 +34,7 @@ config MACH_MX28EVK
 	select MXS_HAVE_AMBA_DUART
 	select MXS_HAVE_PLATFORM_AUART
 	select MXS_HAVE_PLATFORM_FEC
+	select MXS_HAVE_PLATFORM_MXSFB
 	select MXS_OCOTP
 	default y
 	help
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index 8bb2217..08002d0 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -30,6 +30,8 @@
 
 #define MX28EVK_FLEXCAN_SWITCH	MXS_GPIO_NR(2, 13)
 #define MX28EVK_FEC_PHY_POWER	MXS_GPIO_NR(2, 15)
+#define MX28EVK_BL_ENABLE	MXS_GPIO_NR(3, 18)
+#define MX28EVK_LCD_ENABLE	MXS_GPIO_NR(3, 30)
 #define MX28EVK_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
 
 static const iomux_cfg_t mx28evk_pads[] __initconst = {
@@ -79,6 +81,40 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
 	MX28_PAD_GPMI_CE3N__CAN1_RX,
 	/* transceiver power control */
 	MX28_PAD_SSP1_CMD__GPIO_2_13,
+
+	/* mxsfb (lcdif) */
+	MX28_PAD_LCD_D00__LCD_D0 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D01__LCD_D1 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D02__LCD_D2 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D03__LCD_D3 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D04__LCD_D4 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D05__LCD_D5 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D06__LCD_D6 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D07__LCD_D7 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D08__LCD_D8 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D09__LCD_D9 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D10__LCD_D10 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D11__LCD_D11 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D12__LCD_D12 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D13__LCD_D13 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D14__LCD_D14 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D15__LCD_D15 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D16__LCD_D16 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D17__LCD_D17 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D18__LCD_D18 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D19__LCD_D19 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D20__LCD_D20 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D21__LCD_D21 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D22__LCD_D22 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D23__LCD_D23 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_RD_E__LCD_VSYNC | MXS_PAD_CTRL,
+	MX28_PAD_LCD_WR_RWN__LCD_HSYNC | MXS_PAD_CTRL,
+	MX28_PAD_LCD_RS__LCD_DOTCLK | MXS_PAD_CTRL,
+	MX28_PAD_LCD_CS__LCD_ENABLE | MXS_PAD_CTRL,
+	/* LCD panel enable */
+	MX28_PAD_LCD_RESET__GPIO_3_30 | MXS_PAD_CTRL,
+	/* backlight control */
+	MX28_PAD_PWM2__GPIO_3_18 | MXS_PAD_CTRL,
 };
 
 /* fec */
@@ -196,6 +232,32 @@ static const struct flexcan_platform_data
 	}
 };
 
+/* mxsfb (lcdif) */
+static struct fb_videomode mx28evk_video_modes[] = {
+	{
+		.name		= "Seiko-43WVF1G",
+		.refresh	= 60,
+		.xres		= 800,
+		.yres		= 480,
+		.pixclock	= 29851, /* picosecond (33.5 MHz) */
+		.left_margin	= 89,
+		.right_margin	= 164,
+		.upper_margin	= 23,
+		.lower_margin	= 10,
+		.hsync_len	= 10,
+		.vsync_len	= 10,
+		.sync		= FB_SYNC_DATA_ENABLE_HIGH_ACT |
+				  FB_SYNC_DOTCLK_FAILING_ACT,
+	},
+};
+
+static const struct mxsfb_platform_data mx28evk_mxsfb_pdata __initconst = {
+	.mode_list	= mx28evk_video_modes,
+	.mode_count	= ARRAY_SIZE(mx28evk_video_modes),
+	.default_bpp	= 32,
+	.ld_intf_width	= STMLCDIF_24BIT,
+};
+
 static void __init mx28evk_init(void)
 {
 	int ret;
@@ -221,6 +283,20 @@ static void __init mx28evk_init(void)
 		mx28_add_flexcan(0, &mx28evk_flexcan_pdata[0]);
 		mx28_add_flexcan(1, &mx28evk_flexcan_pdata[1]);
 	}
+
+	ret = gpio_request_one(MX28EVK_LCD_ENABLE, GPIOF_DIR_OUT, "lcd-enable");
+	if (ret)
+		pr_warn("failed to request gpio lcd-enable: %d\n", ret);
+	else
+		gpio_set_value(MX28EVK_LCD_ENABLE, 1);
+
+	ret = gpio_request_one(MX28EVK_BL_ENABLE, GPIOF_DIR_OUT, "bl-enable");
+	if (ret)
+		pr_warn("failed to request gpio bl-enable: %d\n", ret);
+	else
+		gpio_set_value(MX28EVK_BL_ENABLE, 1);
+
+	mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
 }
 
 static void __init mx28evk_timer_init(void)
-- 
1.7.1
