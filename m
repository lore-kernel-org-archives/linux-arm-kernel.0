From: weitway@gmail.com (weitway at gmail.com)
Date: Wed, 13 Apr 2011 23:53:36 +0800
Subject: [PATCH 7/7] ARM: i.MX53 loco: add pwm backlight device
In-Reply-To: <1302710016-3569-1-git-send-email-weitway@gmail.com>
References: <1302710016-3569-1-git-send-email-weitway@gmail.com>
Message-ID: <1302710016-3569-7-git-send-email-weitway@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Chen <b02280@freescale.com>

Signed-off-by: Jason Chen <b02280@freescale.com>
---
 arch/arm/mach-mx5/Kconfig           |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c |   11 +++++++++++
 arch/arm/mach-mx5/devices-imx53.h   |    4 ++++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 5d141a7..ea95245 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -166,6 +166,7 @@ config MACH_MX53_LOCO
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_MXC_PWM
 	select IMX_HAVE_PLATFORM_IMX_IPUV3
 	help
 	  Include support for MX53 LOCO platform. This includes specific
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index a499917..2c2fac6 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -23,6 +23,7 @@
 #include <linux/fec.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/pwm_backlight.h>
 #include <video/imx-ipu-v3.h>
 
 #include <mach/common.h>
@@ -208,6 +209,13 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
+static struct platform_pwm_backlight_data loco_pwm_backlight_data = {
+	.pwm_id = 1,
+	.max_brightness = 255,
+	.dft_brightness = 128,
+	.pwm_period_ns = 50000,
+};
+
 static struct ipuv3_fb_platform_data loco_fb0_data = {
 	.interface_pix_fmt = IPU_PIX_FMT_RGB565,
 	.flags = IMX_IPU_FB_USE_MODEDB | IMX_IPU_FB_USE_OVERLAY,
@@ -238,6 +246,9 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(2, NULL);
 
+	imx53_add_mxc_pwm(1);
+	imx53_add_mxc_pwm_backlight(0, &loco_pwm_backlight_data);
+
 	imx53_add_ipuv3(&ipu_data);
 }
 
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index fd591ff..3a0982b 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -38,6 +38,10 @@ extern const struct imx_mxc_pwm_data imx53_mxc_pwm_data[] __initconst;
 #define imx53_add_mxc_pwm(id)	\
 	imx_add_mxc_pwm(&imx53_mxc_pwm_data[id])
 
+#define imx53_add_mxc_pwm_backlight(id, pdata)			\
+	platform_device_register_resndata(NULL, "pwm-backlight",\
+			id, NULL, 0, pdata, sizeof(*pdata));
+
 extern const struct imx_ipuv3_data imx53_ipuv3_data __initconst;
 #define imx53_add_ipuv3(pdata)	\
 	imx_add_ipuv3(&imx53_ipuv3_data, pdata)
-- 
1.7.1
