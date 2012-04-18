From: marex@denx.de (Marek Vasut)
Date: Wed, 18 Apr 2012 19:46:34 +0200
Subject: [PATCH 10/10] MXS: Enable USB on MX28EVK
In-Reply-To: <1334771194-18688-1-git-send-email-marex@denx.de>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334771194-18688-1-git-send-email-marex@denx.de>
Message-ID: <1334771194-18688-11-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chen Peter-B29397 <B29397@freescale.com>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Li Frank-B20596 <B20596@freescale.com>
Cc: Lin Tony-B19295 <B19295@freescale.com>
Cc: Linux USB <linux-usb@vger.kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Subodh Nijsure <snijsure@grid-net.com>
Cc: Tony Lin <tony.lin@freescale.com>
Cc: Wolfgang Denk <wd@denx.de>
---
 arch/arm/mach-mxs/Kconfig        |    2 ++
 arch/arm/mach-mxs/mach-mx28evk.c |   10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 05f6e84..5083db3 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -53,6 +53,8 @@ config MACH_MX28EVK
 	select MXS_HAVE_PLATFORM_MXS_SAIF
 	select MXS_HAVE_PLATFORM_MXS_I2C
 	select MXS_HAVE_PLATFORM_RTC_STMP3XXX
+	select MXS_HAVE_PLATFORM_USB
+	select USB_ARCH_HAS_EHCI
 	select MXS_OCOTP
 	help
 	  Include support for MX28EVK platform. This includes specific
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index e386c14..8bdd416 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -37,6 +37,7 @@
 #define MX28EVK_BL_ENABLE	MXS_GPIO_NR(3, 18)
 #define MX28EVK_LCD_ENABLE	MXS_GPIO_NR(3, 30)
 #define MX28EVK_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
+#define MX28EVK_USB1_PWR_EN	MXS_GPIO_NR(3, 8)
 
 #define MX28EVK_MMC0_WRITE_PROTECT	MXS_GPIO_NR(2, 12)
 #define MX28EVK_MMC1_WRITE_PROTECT	MXS_GPIO_NR(0, 28)
@@ -186,6 +187,8 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
 
 	/* led */
 	MX28_PAD_AUART1_TX__GPIO_3_5 | MXS_PAD_CTRL,
+	/* usb1 */
+	MX28_PAD_AUART2_RX__GPIO_3_8 | MXS_PAD_CTRL,
 
 	/* I2C */
 	MX28_PAD_I2C0_SCL__I2C0_SCL |
@@ -451,6 +454,13 @@ static void __init mx28evk_init(void)
 	mx28_add_mxs_mmc(0, &mx28evk_mmc_pdata[0]);
 	mx28_add_mxs_mmc(1, &mx28evk_mmc_pdata[1]);
 
+	ret = gpio_request_one(MX28EVK_USB1_PWR_EN, GPIOF_OUT_INIT_HIGH,
+				"usb1-power-en");
+	if (ret)
+		pr_warn("failed to request gpio usb1-power-en %d\n", ret);
+
+	mx28_add_mxs_usbh(1);
+
 	mx28_add_rtc_stmp3xxx();
 
 	gpio_led_register_device(0, &mx28evk_led_data);
-- 
1.7.9.5
