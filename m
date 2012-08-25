From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 25 Aug 2012 14:20:41 +0200
Subject: [PATCH 1/3] ARM: S3C24XX: Convert users of s3c2410_gpio_setpin to
 gpiolib API
In-Reply-To: <1345897243-15619-1-git-send-email-sylvester.nawrocki@gmail.com>
References: <1345897243-15619-1-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <1345897243-15619-2-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a prerequisite for removal of deprecated s3c2410_gpio* API
from the Samsung gpiolib driver.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Guillaume Gourat <guillaume.gourat@nexvision.tv>
Cc: Michel Pollet <buserror@gmail.com>
Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 arch/arm/mach-s3c24xx/mach-anubis.c   |    3 ++-
 arch/arm/mach-s3c24xx/mach-jive.c     |   12 ++++++------
 arch/arm/mach-s3c24xx/mach-mini2440.c |    4 ++--
 arch/arm/mach-s3c24xx/mach-nexcoder.c |   22 +++++++++++-----------
 arch/arm/mach-s3c24xx/mach-osiris.c   |    7 ++++---
 5 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index 5a7d0c0..0c7ed7a 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -424,7 +424,8 @@ static void __init anubis_map_io(void)
 		anubis_nand_sets[0].nr_partitions = ARRAY_SIZE(anubis_default_nand_part_large);
 	} else {
 		/* ensure that the GPIO is setup */
-		s3c2410_gpio_setpin(S3C2410_GPA(0), 1);
+		gpio_request_one(S3C2410_GPA(0), GPIOF_OUT_INIT_HIGH, NULL);
+		gpio_free(S3C2410_GPA(0));
 	}
 }
 
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index ae73ba3..4713347 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -512,8 +512,8 @@ static void jive_power_off(void)
 {
 	printk(KERN_INFO "powering system down...\n");
 
-	s3c2410_gpio_setpin(S3C2410_GPC(5), 1);
-	s3c_gpio_cfgpin(S3C2410_GPC(5), S3C2410_GPIO_OUTPUT);
+	gpio_request_one(S3C2410_GPC(5), GPIOF_OUT_INIT_HIGH, NULL);
+	gpio_free(S3C2410_GPC(5));
 }
 
 static void __init jive_machine_init(void)
@@ -623,11 +623,11 @@ static void __init jive_machine_init(void)
 	gpio_request(S3C2410_GPB(7), "jive spi");
 	gpio_direction_output(S3C2410_GPB(7), 1);
 
-	s3c2410_gpio_setpin(S3C2410_GPB(6), 0);
-	s3c_gpio_cfgpin(S3C2410_GPB(6), S3C2410_GPIO_OUTPUT);
+	gpio_request_one(S3C2410_GPB(6), GPIOF_OUT_INIT_LOW, NULL);
+	gpio_free(S3C2410_GPB(6));
 
-	s3c2410_gpio_setpin(S3C2410_GPG(8), 1);
-	s3c_gpio_cfgpin(S3C2410_GPG(8), S3C2410_GPIO_OUTPUT);
+	gpio_request_one(S3C2410_GPG(8), GPIOF_OUT_INIT_HIGH, NULL);
+	gpio_free(S3C2410_GPG(8));
 
 	/* initialise the WM8750 spi */
 
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index bd6d252..734bbfe 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -638,9 +638,9 @@ static void __init mini2440_init(void)
 	gpio_free(S3C2410_GPG(4));
 
 	/* remove pullup on optional PWM backlight -- unused on 3.5 and 7"s */
+	gpio_request_one(S3C2410_GPB(1), GPIOF_IN, NULL);
 	s3c_gpio_setpull(S3C2410_GPB(1), S3C_GPIO_PULL_UP);
-	s3c2410_gpio_setpin(S3C2410_GPB(1), 0);
-	s3c_gpio_cfgpin(S3C2410_GPB(1), S3C2410_GPIO_INPUT);
+	gpio_free(S3C2410_GPB(1));
 
 	/* mark the key as input, without pullups (there is one on the board) */
 	for (i = 0; i < ARRAY_SIZE(mini2440_buttons); i++) {
diff --git a/arch/arm/mach-s3c24xx/mach-nexcoder.c b/arch/arm/mach-s3c24xx/mach-nexcoder.c
index 5c05ba1..a71a551 100644
--- a/arch/arm/mach-s3c24xx/mach-nexcoder.c
+++ b/arch/arm/mach-s3c24xx/mach-nexcoder.c
@@ -119,17 +119,17 @@ static struct platform_device *nexcoder_devices[] __initdata = {
 
 static void __init nexcoder_sensorboard_init(void)
 {
-	// Initialize SCCB bus
-	s3c2410_gpio_setpin(S3C2410_GPE(14), 1); // IICSCL
-	s3c_gpio_cfgpin(S3C2410_GPE(14), S3C2410_GPIO_OUTPUT);
-	s3c2410_gpio_setpin(S3C2410_GPE(15), 1); // IICSDA
-	s3c_gpio_cfgpin(S3C2410_GPE(15), S3C2410_GPIO_OUTPUT);
-
-	// Power up the sensor board
-	s3c2410_gpio_setpin(S3C2410_GPF(1), 1);
-	s3c_gpio_cfgpin(S3C2410_GPF(1), S3C2410_GPIO_OUTPUT); // CAM_GPIO7 => nLDO_PWRDN
-	s3c2410_gpio_setpin(S3C2410_GPF(2), 0);
-	s3c_gpio_cfgpin(S3C2410_GPF(2), S3C2410_GPIO_OUTPUT); // CAM_GPIO6 => CAM_PWRDN
+	/* Initialize SCCB bus */
+	gpio_request_one(S3C2410_GPE(14), GPIOF_OUT_INIT_HIGH, NULL);
+	gpio_free(S3C2410_GPE(14)); /* IICSCL */
+	gpio_request_one(S3C2410_GPE(15), GPIOF_OUT_INIT_HIGH, NULL);
+	gpio_free(S3C2410_GPE(15)); /* IICSDA */
+
+	/* Power up the sensor board */
+	gpio_request_one(S3C2410_GPF(1), GPIOF_OUT_INIT_HIGH, NULL);
+	gpio_free(S3C2410_GPF(1)); /* CAM_GPIO7 => nLDO_PWRDN */
+	gpio_request_one(S3C2410_GPF(2), GPIOF_OUT_INIT_LOW, NULL);
+	gpio_free(S3C2410_GPF(2)); /* CAM_GPIO6 => CAM_PWRDN */
 }
 
 static void __init nexcoder_map_io(void)
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index 95d0772..c0fb3c1 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -274,8 +274,8 @@ static int osiris_pm_suspend(void)
 	__raw_writeb(tmp, OSIRIS_VA_CTRL0);
 
 	/* ensure that an nRESET is not generated on resume. */
-	s3c2410_gpio_setpin(S3C2410_GPA(21), 1);
-	s3c_gpio_cfgpin(S3C2410_GPA(21), S3C2410_GPIO_OUTPUT);
+	gpio_request_one(S3C2410_GPA(21), GPIOF_OUT_INIT_HIGH, NULL);
+	gpio_free(S3C2410_GPA(21));
 
 	return 0;
 }
@@ -396,7 +396,8 @@ static void __init osiris_map_io(void)
 		osiris_nand_sets[0].nr_partitions = ARRAY_SIZE(osiris_default_nand_part_large);
 	} else {
 		/* write-protect line to the NAND */
-		s3c2410_gpio_setpin(S3C2410_GPA(0), 1);
+		gpio_request_one(S3C2410_GPA(0), GPIOF_OUT_INIT_HIGH, NULL);
+		gpio_free(S3C2410_GPA(0));
 	}
 
 	/* fix bus configuration (nBE settings wrong on ABLE pre v2.20) */
-- 
1.7.4.1
