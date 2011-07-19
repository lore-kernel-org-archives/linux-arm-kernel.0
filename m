From: banajit.g@samsung.com (Banajit Goswami)
Date: Tue, 19 Jul 2011 17:35:06 +0530
Subject: [PATCH 7/7] ARM: S3C24XX: Use generic s3c_set_platdata for devices
In-Reply-To: <1311077106-28351-1-git-send-email-banajit.g@samsung.com>
References: <1311077106-28351-1-git-send-email-banajit.g@samsung.com>
Message-ID: <1311077106-28351-8-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call the generic s3c_set_platdata for various set_platdata functions
of S3C24XX

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
 arch/arm/plat-s3c24xx/devs.c |   38 +++++++-------------------------------
 1 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 7366799..a76bf2d 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -150,9 +150,8 @@ void __init s3c24xx_fb_set_platdata(struct s3c2410fb_mach_info *pd)
 {
 	struct s3c2410fb_mach_info *npd;
 
-	npd = kmemdup(pd, sizeof(*npd), GFP_KERNEL);
+	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_lcd);
 	if (npd) {
-		s3c_device_lcd.dev.platform_data = npd;
 		npd->displays = kmemdup(pd->displays,
 			sizeof(struct s3c2410fb_display) * npd->num_displays,
 			GFP_KERNEL);
@@ -188,12 +187,10 @@ struct platform_device s3c_device_ts = {
 };
 EXPORT_SYMBOL(s3c_device_ts);
 
-static struct s3c2410_ts_mach_info s3c2410ts_info;
-
 void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *hard_s3c2410ts_info)
 {
-	memcpy(&s3c2410ts_info, hard_s3c2410ts_info, sizeof(struct s3c2410_ts_mach_info));
-	s3c_device_ts.dev.platform_data = &s3c2410ts_info;
+	s3c_set_platdata(hard_s3c2410ts_info,
+			 sizeof(struct s3c2410_ts_mach_info), &s3c_device_ts);
 }
 
 /* USB Device (Gadget)*/
@@ -223,15 +220,7 @@ EXPORT_SYMBOL(s3c_device_usbgadget);
 
 void __init s3c24xx_udc_set_platdata(struct s3c2410_udc_mach_info *pd)
 {
-	struct s3c2410_udc_mach_info *npd;
-
-	npd = kmalloc(sizeof(*npd), GFP_KERNEL);
-	if (npd) {
-		memcpy(npd, pd, sizeof(*npd));
-		s3c_device_usbgadget.dev.platform_data = npd;
-	} else {
-		printk(KERN_ERR "no memory for udc platform data\n");
-	}
+	s3c_set_platdata(pd, sizeof(*pd), &s3c_device_usbgadget);
 }
 
 /* USB High Speed 2.0 Device (Gadget) */
@@ -263,15 +252,7 @@ struct platform_device s3c_device_usb_hsudc = {
 
 void __init s3c24xx_hsudc_set_platdata(struct s3c24xx_hsudc_platdata *pd)
 {
-	struct s3c24xx_hsudc_platdata *npd;
-
-	npd = kmalloc(sizeof(*npd), GFP_KERNEL);
-	if (npd) {
-		memcpy(npd, pd, sizeof(*npd));
-		s3c_device_usb_hsudc.dev.platform_data = npd;
-	} else {
-		printk(KERN_ERR "no memory for udc platform data\n");
-	}
+	s3c_set_platdata(pd, sizeof(*pd), &s3c_device_usb_hsudc);
 }
 
 /* IIS */
@@ -383,13 +364,8 @@ EXPORT_SYMBOL(s3c_device_sdi);
 
 void __init s3c24xx_mci_set_platdata(struct s3c24xx_mci_pdata *pdata)
 {
-	struct s3c24xx_mci_pdata *npd;
-
-	npd = kmemdup(pdata, sizeof(struct s3c24xx_mci_pdata), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory to copy pdata", __func__);
-
-	s3c_device_sdi.dev.platform_data = npd;
+	s3c_set_platdata(pdata, sizeof(struct s3c24xx_mci_pdata),
+			 &s3c_device_sdi);
 }
 
 
-- 
1.7.2.3
