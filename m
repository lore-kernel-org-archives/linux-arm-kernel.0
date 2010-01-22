From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 22 Jan 2010 23:47:11 +0100
Subject: [PATCH 2/4] ARM: SAMSUNG: Rename s3c24xx touchscreen interface to s3c
Message-ID: <b2e8f9f71001221447k897b5cfs213447084543ee55@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: SAMSUNG: Rename s3c24xx touchscreen interface to s3c

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c2410/mach-h1940.c      |    4 ++--
 arch/arm/plat-s3c24xx/devs.c            |   10 +++++-----
 arch/arm/plat-samsung/include/plat/ts.h |    4 ++--
 drivers/input/touchscreen/s3c2410_ts.c  |    4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-h1940.c
b/arch/arm/mach-s3c2410/mach-h1940.c
index 75e3ffb..76392f2 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -141,7 +141,7 @@ static struct s3c2410_udc_mach_info h1940_udc_cfg
__initdata = {
 	.vbus_pin_inverted	= 1,
 };

-static struct s3c2410_ts_mach_info h1940_ts_cfg __initdata = {
+static struct s3c_ts_mach_info h1940_ts_cfg __initdata = {
 		.delay = 10000,
 		.presc = 49,
 		.oversampling_shift = 2,
@@ -313,7 +313,7 @@ static void __init h1940_init(void)
 	s3c24xx_fb_set_platdata(&h1940_fb_info);
 	s3c24xx_mci_set_platdata(&h1940_mmc_cfg);
  	s3c24xx_udc_set_platdata(&h1940_udc_cfg);
-	s3c24xx_ts_set_platdata(&h1940_ts_cfg);
+	s3c_ts_set_platdata(&h1940_ts_cfg);
 	s3c_i2c0_set_platdata(NULL);

 	/* Turn off suspend on both USB ports, and switch the
diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 3e55bdd..f1c1426 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -163,14 +163,14 @@ struct platform_device s3c_device_ts = {
 };
 EXPORT_SYMBOL(s3c_device_ts);

-static struct s3c2410_ts_mach_info s3c2410ts_info;
+static struct s3c_ts_mach_info s3c2410ts_info;

-void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info
*hard_s3c2410ts_info)
+void __init s3c_ts_set_platdata(struct s3c_ts_mach_info *hard_s3cts_info)
 {
-	memcpy(&s3c2410ts_info, hard_s3c2410ts_info, sizeof(struct
s3c2410_ts_mach_info));
-	s3c_device_ts.dev.platform_data = &s3c2410ts_info;
+	memcpy(&s3cts_info, hard_s3cts_info, sizeof(struct s3c_ts_mach_info));
+	s3c_device_ts.dev.platform_data = &s3cts_info;
 }
-EXPORT_SYMBOL(s3c24xx_ts_set_platdata);
+EXPORT_SYMBOL(s3c_ts_set_platdata);

 /* USB Device (Gadget)*/

diff --git a/arch/arm/plat-samsung/include/plat/ts.h
b/arch/arm/plat-samsung/include/plat/ts.h
index 8a51675..ed5a1d7 100644
--- a/arch/arm/plat-samsung/include/plat/ts.h
+++ b/arch/arm/plat-samsung/include/plat/ts.h
@@ -10,12 +10,12 @@
 #ifndef __ASM_ARM_TS_H
 #define __ASM_ARM_TS_H

-struct s3c2410_ts_mach_info {
+struct s3c_ts_mach_info {
        int             delay;
        int             presc;
        int             oversampling_shift;
 };

-extern void s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *);
+extern void s3c_ts_set_platdata(struct s3c_ts_mach_info *);

 #endif /* __ASM_ARM_TS_H */
diff --git a/drivers/input/touchscreen/s3c2410_ts.c
b/drivers/input/touchscreen/s3c2410_ts.c
index 0cd0ca6..3debbc2 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -247,7 +247,7 @@ static void s3c24xx_ts_select(struct
s3c_adc_client *client, unsigned select)
  */
 static int __devinit s3c2410ts_probe(struct platform_device *pdev)
 {
-	struct s3c2410_ts_mach_info *info;
+	struct s3c_ts_mach_info *info;
 	struct device *dev = &pdev->dev;
 	struct input_dev *input_dev;
 	struct resource *res;
@@ -398,7 +398,7 @@ static int s3c2410ts_suspend(struct device *dev)
 static int s3c2410ts_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct s3c2410_ts_mach_info *info = pdev->dev.platform_data;
+	struct s3c_ts_mach_info *info = pdev->dev.platform_data;

 	clk_enable(ts.clock);

-- 
1.6.6.1
