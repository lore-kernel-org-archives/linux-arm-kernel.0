From: marex@denx.de (Marek Vasut)
Date: Tue, 15 May 2012 10:23:39 +0200
Subject: [PATCH 8/8] MXS: Enable USB on M28EVK
In-Reply-To: <1337070219-3630-1-git-send-email-marex@denx.de>
References: <1337070219-3630-1-git-send-email-marex@denx.de>
Message-ID: <1337070219-3630-9-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the first USB port on M28EVK board.

NOTE: The platform data here are not used, they should be replaced when the phy
      driver evolves.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chen Peter-B29397 <B29397@freescale.com>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Li Frank-B20596 <B20596@freescale.com>
Cc: Linux USB <linux-usb@vger.kernel.org>
Cc: Liu JunJie-B08287 <B08287@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Shi Make-B15407 <B15407@freescale.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Subodh Nijsure <snijsure@grid-net.com>
Cc: Wolfgang Denk <wd@denx.de>
---
 arch/arm/mach-mxs/Kconfig       |    2 ++
 arch/arm/mach-mxs/mach-m28evk.c |   19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index c57f996..05f6e84 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -81,6 +81,8 @@ config MODULE_M28
 	select MXS_HAVE_PLATFORM_MXS_I2C
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXSFB
+	select MXS_HAVE_PLATFORM_USB
+	select USB_ARCH_HAS_EHCI
 	select MXS_OCOTP
 
 config MODULE_APX4
diff --git a/arch/arm/mach-mxs/mach-m28evk.c b/arch/arm/mach-mxs/mach-m28evk.c
index 06d7996..fc2dd2d 100644
--- a/arch/arm/mach-mxs/mach-m28evk.c
+++ b/arch/arm/mach-mxs/mach-m28evk.c
@@ -39,6 +39,8 @@
 
 #define MX28EVK_BL_ENABLE	MXS_GPIO_NR(3, 18)
 #define M28EVK_LCD_ENABLE	MXS_GPIO_NR(3, 28)
+#define M28EVK_USB_ENABLE	MXS_GPIO_NR(3, 13)
+#define M28EVK_USBOTG_ENABLE	MXS_GPIO_NR(3, 12)
 
 #define MX28EVK_MMC0_WRITE_PROTECT	MXS_GPIO_NR(2, 12)
 #define MX28EVK_MMC1_WRITE_PROTECT	MXS_GPIO_NR(0, 28)
@@ -210,6 +212,16 @@ static const iomux_cfg_t m28evk_pads[] __initconst = {
 
 	/* Backlight */
 	MX28_PAD_PWM3__GPIO_3_28 | MXS_PAD_CTRL,
+
+	/* USB */
+	MX28_PAD_SSP2_SS2__USB0_OVERCURRENT,
+	MX28_PAD_SSP2_SS1__USB1_OVERCURRENT,
+	MX28_PAD_PWM2__USB0_ID |
+		MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP,
+	MX28_PAD_AUART3_TX__GPIO_3_13 |
+		MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP,
+	MX28_PAD_AUART3_RX__GPIO_3_12 |
+		MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP,
 };
 
 /* led */
@@ -292,6 +304,11 @@ static const struct mxsfb_platform_data m28evk_mxsfb_pdata __initconst = {
 	.ld_intf_width	= STMLCDIF_18BIT,
 };
 
+static struct mxs_usb_platform_data m28_usb_data = {
+	.gpio_vbus		= M28EVK_USBOTG_ENABLE,
+	.gpio_vbus_inverted	= 1,
+};
+
 static struct at24_platform_data m28evk_eeprom = {
 	.byte_len = 16384,
 	.page_size = 32,
@@ -344,6 +361,8 @@ static void __init m28evk_init(void)
 	mx28_add_mxs_i2c(0);
 	i2c_register_board_info(0, m28_stk5v3_i2c_boardinfo,
 			ARRAY_SIZE(m28_stk5v3_i2c_boardinfo));
+
+	mx28_add_mxs_usbh(0, &m28_usb_data);
 }
 
 static void __init m28evk_timer_init(void)
-- 
1.7.10
