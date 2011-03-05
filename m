From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 6 Mar 2011 00:40:20 +0800
Subject: [PATCH 2/4] ARM: mxs/mx28evk: add framebuffer device
In-Reply-To: <1299343222-30670-1-git-send-email-shawn.guo@freescale.com>
References: <1299343222-30670-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1299343222-30670-3-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/clock-mx28.c   |    2 +
 arch/arm/mach-mxs/mach-mx28evk.c |   78 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 4f0b673..cffd860 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -33,6 +33,7 @@ config MACH_MX28EVK
 	select MXS_HAVE_AMBA_DUART
 	select MXS_HAVE_PLATFORM_AUART
 	select MXS_HAVE_PLATFORM_FEC
+	select MXS_HAVE_PLATFORM_MXSFB
 	select MXS_OCOTP
 	default y
 	help
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 8277056..56bd164 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -750,6 +750,8 @@ int __init mx28_clocks_init(void)
 	clk_enable(&emi_clk);
 	clk_enable(&uart_clk);
 
+	clk_set_parent(&lcdif_clk, &ref_pix_clk);
+
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	mxs_timer_init(&clk32k_clk, MX28_INT_TIMER0);
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index 987e3d5..2102ffd 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -29,6 +29,8 @@
 #include "gpio.h"
 
 #define MX28EVK_FEC_PHY_POWER	MXS_GPIO_NR(2, 15)
+#define MX28EVK_BL_ENABLE	MXS_GPIO_NR(3, 18)
+#define MX28EVK_LCD_ENABLE	MXS_GPIO_NR(3, 30)
 #define MX28EVK_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
 
 static const iomux_cfg_t mx28evk_pads[] __initconst = {
@@ -69,6 +71,40 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
 	MX28_PAD_SSP1_DATA3__GPIO_2_15 | MXS_PAD_CTRL,
 	/* phy reset line */
 	MX28_PAD_ENET0_RX_CLK__GPIO_4_13 | MXS_PAD_CTRL,
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
@@ -152,8 +188,36 @@ error:
 	return -ETIMEDOUT;
 }
 
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
+	int ret;
+
 	mxs_iomux_setup_multiple_pads(mx28evk_pads, ARRAY_SIZE(mx28evk_pads));
 
 	mx28_add_duart();
@@ -166,6 +230,20 @@ static void __init mx28evk_init(void)
 	mx28evk_fec_reset();
 	mx28_add_fec(0, &mx28_fec_pdata[0]);
 	mx28_add_fec(1, &mx28_fec_pdata[1]);
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
