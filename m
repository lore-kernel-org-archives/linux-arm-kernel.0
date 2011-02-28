From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 28 Feb 2011 12:17:26 +0100
Subject: [PATCH v2 09/09] ARM: s3c2440: gta02: Add touchscreen support
In-Reply-To: <1297043521-21903-9-git-send-email-lars@metafoo.de>
References: <1297043521-21903-9-git-send-email-lars@metafoo.de>
Message-ID: <1298891846-7487-1-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds registers the s3c touchscreen and adc devices to add touchscreen
support for the gta02.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/arm/mach-s3c2440/mach-gta02.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 640ca68..12193ad 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -89,6 +89,8 @@
 #include <plat/udc.h>
 #include <plat/gpio-cfg.h>
 #include <plat/iic.h>
+#include <plat/ts.h>
+
 
 static struct pcf50633 *gta02_pcf;
 
@@ -480,6 +482,13 @@ static struct s3c2410_hcd_info gta02_usb_info __initdata = {
 	},
 };
 
+/* Touchscreen */
+static struct s3c2410_ts_mach_info gta02_ts_info = {
+	.delay			= 10000,
+	.presc			= 0xff, /* slow as we can go */
+	.oversampling_shift	= 2,
+};
+
 /* Buttons */
 static struct gpio_keys_button gta02_buttons[] = {
 	{
@@ -533,6 +542,8 @@ static struct platform_device *gta02_devices[] __initdata = {
 	&samsung_asoc_dma,
 	&s3c_device_i2c0,
 	&gta02_buttons_device,
+	&s3c_device_adc,
+	&s3c_device_ts,
 };
 
 /* These guys DO need to be children of PMU. */
@@ -595,6 +606,7 @@ static void __init gta02_machine_init(void)
 #endif
 
 	s3c24xx_udc_set_platdata(&gta02_udc_cfg);
+	s3c24xx_ts_set_platdata(&gta02_ts_info);
 	s3c_ohci_set_platdata(&gta02_usb_info);
 	s3c_nand_set_platdata(&gta02_nand_info);
 	s3c_i2c0_set_platdata(NULL);
-- 
1.7.2.3
