From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 07:19:18 +0100
Subject: [PATCH 8/9] ARM: S3C24XX: Use s3c_set_platdata() helper
In-Reply-To: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
References: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275027559-29278-9-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f8b5ea089d5a447a8933a6540ceeccbcb78f9e53 added a helper
to copy and set platform data, so let's replace the various sites
in the Samsung support where this is happening.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c24xx/devs.c |   23 ++++-------------------
 1 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 452e184..028c8bd 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -149,9 +149,8 @@ void __init s3c24xx_fb_set_platdata(struct s3c2410fb_mach_info *pd)
 {
 	struct s3c2410fb_mach_info *npd;
 
-	npd = kmemdup(pd, sizeof(*npd), GFP_KERNEL);
+	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_lcd);
 	if (npd) {
-		s3c_device_lcd.dev.platform_data = npd;
 		npd->displays = kmemdup(pd->displays,
 			sizeof(struct s3c2410fb_display) * npd->num_displays,
 			GFP_KERNEL);
@@ -223,15 +222,7 @@ EXPORT_SYMBOL(s3c_device_usbgadget);
 
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
 
 /* IIS */
@@ -341,15 +332,9 @@ struct platform_device s3c_device_sdi = {
 
 EXPORT_SYMBOL(s3c_device_sdi);
 
-void __init s3c24xx_mci_set_platdata(struct s3c24xx_mci_pdata *pdata)
+void __init s3c24xx_mci_set_platdata(struct s3c24xx_mci_pdata *pd)
 {
-	struct s3c24xx_mci_pdata *npd;
-
-	npd = kmemdup(pdata, sizeof(struct s3c24xx_mci_pdata), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory to copy pdata", __func__);
-
-	s3c_device_sdi.dev.platform_data = npd;
+	s3c_set_platdata(pd, sizeof(struct s3c24xx_mci_pdata), &s3c_device_sdi);
 }
 
 
-- 
1.6.3.3
