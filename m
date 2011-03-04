From: b02280@freescale.com (Jason Chen)
Date: Fri, 4 Mar 2011 10:51:26 +0800
Subject: [PATCH] ARM: mx53/loco: add pwm backlight device
Message-ID: <1299207086-11000-1-git-send-email-b02280@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Chen <b02280@freescale.com>
---
 arch/arm/mach-mx5/Kconfig           |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c |   11 +++++++++++
 arch/arm/mach-mx5/devices-imx53.h   |    4 ++++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index f065a0d..baf5223 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -162,6 +162,7 @@ config MACH_MX53_LOCO
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_PWM
 	help
 	  Include support for MX53 LOCO platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 160899e..3b0b200 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -23,6 +23,7 @@
 #include <linux/fec.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/pwm_backlight.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
@@ -203,6 +204,13 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
+static struct platform_pwm_backlight_data loco_pwm_backlight_data = {
+	.pwm_id = 1,
+	.max_brightness = 255,
+	.dft_brightness = 128,
+	.pwm_period_ns = 50000,
+};
+
 static void __init mx53_loco_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
@@ -213,6 +221,9 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_imx2_wdt(0, NULL);
 	imx53_add_imx_i2c(0, &mx53_loco_i2c_data);
 	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
+
+	imx53_add_mxc_pwm(1);
+	imx53_add_mxc_pwm_backlight(0, &loco_pwm_backlight_data);
 }
 
 static void __init mx53_loco_timer_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index 5a1d6c9..a2dc8b6 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -37,3 +37,7 @@ extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[] __initconst;
 extern const struct imx_mxc_pwm_data imx53_mxc_pwm_data[] __initconst;
 #define imx53_add_mxc_pwm(id)	\
 	imx_add_mxc_pwm(&imx53_mxc_pwm_data[id])
+
+#define imx53_add_mxc_pwm_backlight(id, pdata)			\
+	platform_device_register_resndata(NULL, "pwm-backlight",\
+			id, NULL, 0, pdata, sizeof(*pdata));
-- 
1.7.1
