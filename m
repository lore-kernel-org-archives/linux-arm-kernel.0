From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 30 Jun 2012 14:08:54 +0200
Subject: [PATCH 02/10] ARM: S3C24XX: Convert SMDK board file to the gpiolib API
In-Reply-To: <1341058142-30438-1-git-send-email-sylvester.nawrocki@gmail.com>
References: <1341058142-30438-1-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <1341058142-30438-3-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace SoC specific GPIO functions with the gpiolib API. The LED
gpios are freed right after they are initially configured so they
can be acquired in the s3c24xx_led driver.

This change is required for converting the s3c24xx_led driver
to the gpiolib API.

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
This change is only compile tested, since I don't have the board.
Thus it would be good if someone could test this and provide
a Tested-by tag.
---
 arch/arm/mach-s3c24xx/common-smdk.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common-smdk.c b/arch/arm/mach-s3c24xx/common-smdk.c
index 084604b..87e75a2 100644
--- a/arch/arm/mach-s3c24xx/common-smdk.c
+++ b/arch/arm/mach-s3c24xx/common-smdk.c
@@ -182,19 +182,21 @@ static struct platform_device __initdata *smdk_devs[] = {
 	&smdk_led7,
 };
 
+static const struct gpio smdk_led_gpios[] = {
+	{ S3C2410_GPF(4), GPIOF_OUT_INIT_HIGH, NULL },
+	{ S3C2410_GPF(5), GPIOF_OUT_INIT_HIGH, NULL },
+	{ S3C2410_GPF(6), GPIOF_OUT_INIT_HIGH, NULL },
+	{ S3C2410_GPF(7), GPIOF_OUT_INIT_HIGH, NULL },
+};
+
 void __init smdk_machine_init(void)
 {
 	/* Configure the LEDs (even if we have no LED support)*/
 
-	s3c_gpio_cfgpin(S3C2410_GPF(4), S3C2410_GPIO_OUTPUT);
-	s3c_gpio_cfgpin(S3C2410_GPF(5), S3C2410_GPIO_OUTPUT);
-	s3c_gpio_cfgpin(S3C2410_GPF(6), S3C2410_GPIO_OUTPUT);
-	s3c_gpio_cfgpin(S3C2410_GPF(7), S3C2410_GPIO_OUTPUT);
-
-	s3c2410_gpio_setpin(S3C2410_GPF(4), 1);
-	s3c2410_gpio_setpin(S3C2410_GPF(5), 1);
-	s3c2410_gpio_setpin(S3C2410_GPF(6), 1);
-	s3c2410_gpio_setpin(S3C2410_GPF(7), 1);
+	int ret = gpio_request_array(smdk_led_gpios,
+				     ARRAY_SIZE(smdk_led_gpios));
+	if (!WARN_ON(ret < 0))
+		gpio_free_array(smdk_led_gpios, ARRAY_SIZE(smdk_led_gpios));
 
 	if (machine_is_smdk2443())
 		smdk_nand_info.twrph0 = 50;
-- 
1.7.4.1
