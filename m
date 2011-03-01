From: b02280@freescale.com (Jason Chen)
Date: Tue, 1 Mar 2011 14:30:18 +0800
Subject: [PATCH 2/2] ARM MX53_LOCO: add pwm backlight device
In-Reply-To: <1298961018-8988-1-git-send-email-b02280@freescale.com>
References: <1298961018-8988-1-git-send-email-b02280@freescale.com>
Message-ID: <1298961018-8988-2-git-send-email-b02280@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Chen <b02280@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_loco.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 160899e..6c42185 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -23,6 +23,7 @@
 #include <linux/fec.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/pwm_backlight.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
@@ -35,6 +36,7 @@
 
 #include "crm_regs.h"
 #include "devices-imx53.h"
+#include "devices.h"
 
 #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
 
@@ -203,6 +205,13 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
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
@@ -213,6 +222,10 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_imx2_wdt(0, NULL);
 	imx53_add_imx_i2c(0, &mx53_loco_i2c_data);
 	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
+
+	imx53_add_mxc_pwm(1);
+	mxc_register_device(&mxc_pwm1_backlight_device,
+			&loco_pwm_backlight_data);
 }
 
 static void __init mx53_loco_timer_init(void)
-- 
1.7.1
