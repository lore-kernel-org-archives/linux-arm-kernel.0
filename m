From: marex@denx.de (Marek Vasut)
Date: Tue, 17 Apr 2012 12:15:50 +0200
Subject: [PATCH 7/8] MXS: Enable USB on M28EVK
In-Reply-To: <1334657751-27678-1-git-send-email-marex@denx.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
Message-ID: <1334657751-27678-8-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the second USB port on M28EVK board.

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
 arch/arm/mach-mxs/Kconfig       |    2 ++
 arch/arm/mach-mxs/mach-m28evk.c |   10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 9dbf29f..5b5566c 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -83,6 +83,8 @@ config MODULE_M28
 	select MXS_HAVE_PLATFORM_MXS_LRADC
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXSFB
+	select MXS_HAVE_PLATFORM_USB
+	select USB_ARCH_HAS_EHCI
 	select MXS_OCOTP
 
 config MODULE_APX4
diff --git a/arch/arm/mach-mxs/mach-m28evk.c b/arch/arm/mach-mxs/mach-m28evk.c
index f32fadb..a1850bc 100644
--- a/arch/arm/mach-mxs/mach-m28evk.c
+++ b/arch/arm/mach-mxs/mach-m28evk.c
@@ -212,6 +212,11 @@ static const iomux_cfg_t m28evk_pads[] __initconst = {
 
 	/* Backlight */
 	MX28_PAD_PWM3__GPIO_3_28 | MXS_PAD_CTRL,
+
+	/* USB */
+	MX28_PAD_SSP2_SS1__USB1_OVERCURRENT,
+	MX28_PAD_AUART3_TX__GPIO_3_13 |
+		MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP,
 };
 
 /* led */
@@ -377,6 +382,11 @@ static void __init m28evk_init(void)
 	mx28_add_ts(&touch_pdata);
 
 	mx28_add_gpmi_nand(&m28evk_gpmi_nand_data);
+
+	gpio_request(MXS_GPIO_NR(3, 13), "USB");
+	gpio_direction_output(MXS_GPIO_NR(3, 13), 0);
+
+	mx28_add_mxs_usbh(1);
 }
 
 static void __init m28evk_timer_init(void)
-- 
1.7.9.5
