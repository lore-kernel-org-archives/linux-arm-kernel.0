From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2012 15:17:51 +0900
Subject: [PATCH] ARM: shmobile: armadillo800eva: Add support RTC
In-Reply-To: <1347517071-30647-1-git-send-email-horms@verge.net.au>
References: <1347517071-30647-1-git-send-email-horms@verge.net.au>
Message-ID: <1347517071-30647-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

The armadillo800eva has S35390A which is RTC. This is controlled
using I2C of GPIO.
This commit supports RTC of armadillo800eva.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/armadillo800eva_defconfig     |    3 +++
 arch/arm/mach-shmobile/board-armadillo800eva.c |   25 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 7d87184..05f523d 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -85,6 +85,7 @@ CONFIG_SERIAL_SH_SCI_NR_UARTS=8
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
+CONFIG_I2C_GPIO=y
 CONFIG_I2C_SH_MOBILE=y
 # CONFIG_HWMON is not set
 CONFIG_MEDIA_SUPPORT=y
@@ -120,6 +121,8 @@ CONFIG_USB_ETH=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
 CONFIG_MMC_SH_MMCIF=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_S35390A=y
 CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
 CONFIG_UIO=y
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index cf10f92..81dfb88 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -37,6 +37,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
+#include <linux/i2c-gpio.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a7740.h>
@@ -876,6 +877,21 @@ static struct platform_device fsi_hdmi_device = {
 	},
 };
 
+/* RTC: RTC connects i2c-gpio. */
+static struct i2c_gpio_platform_data i2c_gpio_data = {
+	.sda_pin	= GPIO_PORT208,
+	.scl_pin	= GPIO_PORT91,
+	.udelay		= 5, /* 100 kHz */
+};
+
+static struct platform_device i2c_gpio_device = {
+	.name = "i2c-gpio",
+	.id = 2,
+	.dev = {
+		.platform_data = &i2c_gpio_data,
+	},
+};
+
 /* I2C */
 static struct i2c_board_info i2c0_devices[] = {
 	{
@@ -887,6 +903,13 @@ static struct i2c_board_info i2c0_devices[] = {
 	},
 };
 
+static struct i2c_board_info i2c2_devices[] = {
+	{
+		I2C_BOARD_INFO("s35390a", 0x30),
+		.type = "s35390a",
+	},
+};
+
 /*
  * board devices
  */
@@ -903,6 +926,7 @@ static struct platform_device *eva_devices[] __initdata = {
 	&fsi_device,
 	&fsi_hdmi_device,
 	&fsi_wm8978_device,
+	&i2c_gpio_device,
 };
 
 static void __init eva_clock_init(void)
@@ -1173,6 +1197,7 @@ static void __init eva_init(void)
 #endif
 
 	i2c_register_board_info(0, i2c0_devices, ARRAY_SIZE(i2c0_devices));
+	i2c_register_board_info(2, i2c2_devices, ARRAY_SIZE(i2c2_devices));
 
 	r8a7740_add_standard_devices();
 
-- 
1.7.10.4
