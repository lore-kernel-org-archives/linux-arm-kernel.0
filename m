From: nobuhiro.iwamatsu.yj@renesas.com (Nobuhiro Iwamatsu)
Date: Thu, 13 Sep 2012 14:10:10 +0900
Subject: [PATCH v2] ARM: shmobile: armadillo800eva: Add support RTC
Message-ID: <1347513011-18316-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armadillo800eva has S35390A which is RTC. This is controlled
using I2C of GPIO.
This commit supports RTC of armadillo800eva.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 v2: Update and add defconfig for armadillo800eva

 arch/arm/configs/armadillo800eva_defconfig     |   12 +++++-------
 arch/arm/mach-shmobile/board-armadillo800eva.c |   25 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 7d87184..62861bd 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -18,7 +18,6 @@ CONFIG_ARCH_SHMOBILE=y
 CONFIG_ARCH_R8A7740=y
 CONFIG_MACH_ARMADILLO800EVA=y
 # CONFIG_SH_TIMER_TMU is not set
-CONFIG_ARM_THUMB=y
 CONFIG_CPU_BPREDICT_DISABLE=y
 # CONFIG_CACHE_L2X0 is not set
 CONFIG_ARM_ERRATA_430973=y
@@ -85,18 +84,16 @@ CONFIG_SERIAL_SH_SCI_NR_UARTS=8
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
+CONFIG_I2C_GPIO=y
 CONFIG_I2C_SH_MOBILE=y
 # CONFIG_HWMON is not set
 CONFIG_MEDIA_SUPPORT=y
-CONFIG_VIDEO_DEV=y
-# CONFIG_RC_CORE is not set
-# CONFIG_VIDEO_HELPER_CHIPS_AUTO is not set
-# CONFIG_V4L_USB_DRIVERS is not set
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+# CONFIG_USB_GSPCA is not set
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SOC_CAMERA=y
 CONFIG_SOC_CAMERA_MT9T112=y
 CONFIG_VIDEO_SH_MOBILE_CEU=y
-# CONFIG_RADIO_ADAPTERS is not set
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FB_SH_MOBILE_HDMI=y
@@ -111,7 +108,6 @@ CONFIG_LOGO=y
 # CONFIG_SND_DRIVERS is not set
 # CONFIG_SND_ARM is not set
 CONFIG_SND_SOC_SH4_FSI=y
-# CONFIG_HID_SUPPORT is not set
 CONFIG_USB=y
 CONFIG_USB_RENESAS_USBHS=y
 CONFIG_USB_GADGET=y
@@ -120,6 +116,8 @@ CONFIG_USB_ETH=m
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
