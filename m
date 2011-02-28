From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 28 Feb 2011 17:40:05 +0100
Subject: [PATCH 2/2] arm: mxs: tx28: add i2c bus and connected RTC
In-Reply-To: <1298911205-3070-1-git-send-email-w.sang@pengutronix.de>
References: <1298911205-3070-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1298911205-3070-3-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mxs/Kconfig     |    1 +
 arch/arm/mach-mxs/mach-tx28.c |   10 ++++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 895d066..4f0b673 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -45,6 +45,7 @@ config MODULE_TX28
 	select MXS_HAVE_AMBA_DUART
 	select MXS_HAVE_PLATFORM_AUART
 	select MXS_HAVE_PLATFORM_FEC
+	select MXS_HAVE_PLATFORM_MXS_I2C
 	select MXS_HAVE_PLATFORM_MXS_PWM
 
 config MACH_TX28
diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
index b609b84..b65e371 100644
--- a/arch/arm/mach-mxs/mach-tx28.c
+++ b/arch/arm/mach-mxs/mach-tx28.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_gpio.h>
+#include <linux/i2c.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -140,6 +141,12 @@ static struct spi_board_info tx28_spi_board_info[] = {
 	},
 };
 
+static struct i2c_board_info tx28_stk5v3_i2c_boardinfo[] __initdata = {
+	{
+		I2C_BOARD_INFO("ds1339", 0x68),
+	},
+};
+
 static void __init tx28_stk5v3_init(void)
 {
 	mxs_iomux_setup_multiple_pads(tx28_stk5v3_pads,
@@ -154,6 +161,9 @@ static void __init tx28_stk5v3_init(void)
 			ARRAY_SIZE(tx28_spi_board_info));
 	mxs_add_platform_device("leds-gpio", 0, NULL, 0,
 			&tx28_stk5v3_led_data, sizeof(tx28_stk5v3_led_data));
+	mx28_add_mxs_i2c(0);
+	i2c_register_board_info(0, tx28_stk5v3_i2c_boardinfo,
+			ARRAY_SIZE(tx28_stk5v3_i2c_boardinfo));
 }
 
 static void __init tx28_timer_init(void)
-- 
1.7.2.3
