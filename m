From: p.paneri@samsung.com (p.paneri at samsung.com)
Date: Tue, 21 Jun 2011 12:33:47 +0530
Subject: [RFC][PATCH 5/5] ARM: S5P64x0: Adding OTG device for smdk6440
In-Reply-To: <1308639827-2121-1-git-send-email-p.paneri@samsung.com>
References: <1308639827-2121-1-git-send-email-p.paneri@samsung.com>
Message-ID: <1308639827-2121-6-git-send-email-p.paneri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Praveen Paneri <p.paneri@samsung.com>

Selected DWC OTG for smdk6440 and added platform specific
data in machine file.

Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
---
 arch/arm/Kconfig                      |    1 +
 arch/arm/mach-s5p64x0/mach-smdk6440.c |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..e98bb53 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -728,6 +728,7 @@ config ARCH_S5P64X0
 	select HAVE_SCHED_CLOCK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
+	select S3C_DEV_DWC_OTG
 	help
 	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
 	  SMDK6450.
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 2d559f1..515e252 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -46,6 +46,7 @@
 #include <plat/adc.h>
 #include <plat/ts.h>
 #include <plat/s5p-time.h>
+#include <plat/otg.h>
 
 #define SMDK6440_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -130,6 +131,27 @@ static struct platform_device smdk6440_backlight_device = {
 	},
 };
 
+/* USB OTG */
+#define S3C_DEV_RX_FIFO_SIZ	(4096>>2)
+#define S3C_DEV_NPTX_FIFO_SIZ	(4096>>2)
+#define S3C_HOST_RX_FIFO_SIZ	0x0000010D
+#define S3C_HOST_NPTX_FIFO_SIZ	0x0080010D
+#define S3C_HOST_CH_NUM		12
+
+static struct s5p_otg_platdata smdk6440_otg_pdata = {
+	.dev_rx_fifo_size	= S3C_DEV_RX_FIFO_SIZ,
+	.dev_nptx_fifo_size	= S3C_DEV_NPTX_FIFO_SIZ,
+	.host_rx_fifo_size	= S3C_HOST_RX_FIFO_SIZ,
+	.host_nptx_fifo_size	= S3C_HOST_NPTX_FIFO_SIZ,
+	.host_ch_num		= S3C_HOST_CH_NUM,
+};
+
+static void __init smdk6440_otg_init(void)
+{
+	struct s5p_otg_platdata *pdata = &smdk6440_otg_pdata;
+
+	s5p_otg_set_platdata(pdata);
+}
 static struct platform_device *smdk6440_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_rtc,
@@ -141,6 +163,7 @@ static struct platform_device *smdk6440_devices[] __initdata = {
 	&s5p6440_device_iis,
 	&s3c_device_timer[1],
 	&smdk6440_backlight_device,
+	&s3c_device_usb_hsotg,
 };
 
 static struct s3c2410_platform_i2c s5p6440_i2c0_data __initdata = {
@@ -193,6 +216,7 @@ static void __init smdk6440_machine_init(void)
 			ARRAY_SIZE(smdk6440_i2c_devs0));
 	i2c_register_board_info(1, smdk6440_i2c_devs1,
 			ARRAY_SIZE(smdk6440_i2c_devs1));
+	smdk6440_otg_init();
 
 	platform_add_devices(smdk6440_devices, ARRAY_SIZE(smdk6440_devices));
 }
-- 
1.7.0.4
