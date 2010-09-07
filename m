From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue,  7 Sep 2010 17:32:25 +0300
Subject: [PATCH 2/3] rx1950: add LEDs support
In-Reply-To: <1283869946-28296-1-git-send-email-anarsoul@gmail.com>
References: <1283869946-28296-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1283869946-28296-3-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2440/mach-rx1950.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 1197ab4..3328c86 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -29,6 +29,7 @@
 #include <linux/pwm_backlight.h>
 #include <linux/pwm.h>
 #include <linux/s3c_adc_battery.h>
+#include <linux/leds.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -259,6 +260,37 @@ void rx1950_disable_charger(void)
 	gpio_direction_output(S3C2410_GPJ(3), 0);
 }
 
+static struct gpio_led rx1950_leds_desc[] = {
+	{
+		.name				= "Green",
+		.default_trigger	= "main-battery-charging-or-full",
+		.gpio				= S3C2410_GPA(6),
+	},
+	{
+		.name				= "Red",
+		.default_trigger	= "main-battery-full",
+		.gpio				= S3C2410_GPA(7),
+	},
+	{
+		.name				= "Blue",
+		.default_trigger	= "rx1950-acx-mem",
+		.gpio				= S3C2410_GPA(11),
+	},
+};
+
+static struct gpio_led_platform_data rx1950_leds_pdata = {
+	.num_leds	= ARRAY_SIZE(rx1950_leds_desc),
+	.leds		= rx1950_leds_desc,
+};
+
+static struct platform_device rx1950_leds = {
+	.name	= "leds-gpio",
+	.id		= -1,
+	.dev	= {
+				.platform_data = &rx1950_leds_pdata,
+	},
+};
+
 static struct s3c_adc_bat_pdata rx1950_bat_cfg = {
 	.init = rx1950_bat_init,
 	.exit = rx1950_bat_exit,
@@ -663,6 +695,7 @@ static struct platform_device *rx1950_devices[] __initdata = {
 	&rx1950_device_gpiokeys,
 	&power_supply,
 	&rx1950_battery,
+	&rx1950_leds,
 };
 
 static struct clk *rx1950_clocks[] __initdata = {
-- 
1.7.2.2
