From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Tue, 16 Nov 2010 10:37:00 -0800 (PST)
Subject: [PATCH 5/5] mx51_babbage: Add PWM support
Message-ID: <398428.51579.qm@web51003.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PWM support on mx51_babbage board.

PWM1_PWMO output can be used to control WVGA LCD backlight brightness.

Tested the PWM1_PWMO duty cycle control via:

echo xxx > /sys/class/backlight/pwm-backlight.0/brightness

,where xxx can vary from 0 to 255.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |???14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 66b07d8..4aba07f 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -22,6 +22,7 @@
 #include <linux/input.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
+#include <linux/pwm_backlight.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
@@ -158,6 +159,9 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
 ??? MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK,
 ??? MX51_PAD_CSPI1_SS0__GPIO_4_24,
 ??? MX51_PAD_CSPI1_SS1__GPIO_4_25,
+
+??? /* PWM1 */
+??? MX51_PAD_GPIO_1_2__PWM1_PWMO,
 };
 
 /* Serial ports */
@@ -337,6 +341,13 @@ static int mx51_babbage_spi_cs[] = {
 ??? BABBAGE_ECSPI1_CS1,
 };
 
+static struct platform_pwm_backlight_data mxc_pwm_backlight_data = {
+??? .pwm_id = 0,
+??? .max_brightness = 255,
+??? .dft_brightness = 128,
+??? .pwm_period_ns = 78770,
+};
+
 static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
 ??? .chipselect? ???= mx51_babbage_spi_cs,
 ??? .num_chipselect = ARRAY_SIZE(mx51_babbage_spi_cs),
@@ -386,6 +397,9 @@ static void __init mxc_board_init(void)
 ??? spi_register_board_info(mx51_babbage_spi_board_info,
 ??? ??? ARRAY_SIZE(mx51_babbage_spi_board_info));
 ??? imx51_add_ecspi(0, &mx51_babbage_spi_pdata);
+??? mxc_register_device(&mxc_pwm0_device, NULL);
+??? mxc_register_device(&mxc_pwm0_backlight_device,
+??? ??? &mxc_pwm_backlight_data);
 }
 
 static void __init mx51_babbage_timer_init(void)
-- 
1.6.0.4






      
