From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 07:19:17 +0100
Subject: [PATCH 7/9] ARM: SAMSUNG: Use s3c_set_platdata() helper
In-Reply-To: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
References: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275027559-29278-8-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f8b5ea089d5a447a8933a6540ceeccbcb78f9e53 added a helper
to copy and set platform data, so let's replace the various sites
in the Samsung support where this is happening.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/dev-fb.c      |   13 +------------
 arch/arm/plat-samsung/dev-hwmon.c   |   13 +------------
 arch/arm/plat-samsung/dev-i2c0.c    |   12 ++++--------
 arch/arm/plat-samsung/dev-i2c1.c    |   12 ++++--------
 arch/arm/plat-samsung/dev-onenand.c |    8 ++------
 arch/arm/plat-samsung/dev-ts.c      |   14 ++------------
 arch/arm/plat-samsung/dev-usb.c     |   12 +++---------
 7 files changed, 17 insertions(+), 67 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-fb.c b/arch/arm/plat-samsung/dev-fb.c
index bf60204..f63190c 100644
--- a/arch/arm/plat-samsung/dev-fb.c
+++ b/arch/arm/plat-samsung/dev-fb.c
@@ -58,16 +58,5 @@ struct platform_device s3c_device_fb = {
 
 void __init s3c_fb_set_platdata(struct s3c_fb_platdata *pd)
 {
-	struct s3c_fb_platdata *npd;
-
-	if (!pd) {
-		printk(KERN_ERR "%s: no platform data\n", __func__);
-		return;
-	}
-
-	npd = kmemdup(pd, sizeof(struct s3c_fb_platdata), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-
-	s3c_device_fb.dev.platform_data = npd;
+	s3c_set_platdata(pd, sizeof(struct s3c_fb_platdata), &s3c_device_fb);
 }
diff --git a/arch/arm/plat-samsung/dev-hwmon.c b/arch/arm/plat-samsung/dev-hwmon.c
index b3ffb95..580f580 100644
--- a/arch/arm/plat-samsung/dev-hwmon.c
+++ b/arch/arm/plat-samsung/dev-hwmon.c
@@ -27,16 +27,5 @@ struct platform_device s3c_device_hwmon = {
 
 void __init s3c_hwmon_set_platdata(struct s3c_hwmon_pdata *pd)
 {
-	struct s3c_hwmon_pdata *npd;
-
-	if (!pd) {
-		printk(KERN_ERR "%s: no platform data\n", __func__);
-		return;
-	}
-
-	npd = kmemdup(pd, sizeof(struct s3c_hwmon_pdata), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-
-	s3c_device_hwmon.dev.platform_data = npd;
+	s3c_set_platdata(pd, sizeof(struct s3c_hwmon_pdata), &s3c_device_hwmon);
 }
diff --git a/arch/arm/plat-samsung/dev-i2c0.c b/arch/arm/plat-samsung/dev-i2c0.c
index 1ec1ef9..6256c0d 100644
--- a/arch/arm/plat-samsung/dev-i2c0.c
+++ b/arch/arm/plat-samsung/dev-i2c0.c
@@ -58,16 +58,12 @@ static struct s3c2410_platform_i2c default_i2c_data0 __initdata = {
 
 void __init s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *pd)
 {
-	struct s3c2410_platform_i2c *npd;
-
 	if (!pd)
 		pd = &default_i2c_data0;
 
-	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	else if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c0_cfg_gpio;
+	if (!pd->cfg_gpio)
+		pd->cfg_gpio = s3c_i2c0_cfg_gpio;
 
-	s3c_device_i2c0.dev.platform_data = npd;
+	s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			 &s3c_device_i2c0);
 }
diff --git a/arch/arm/plat-samsung/dev-i2c1.c b/arch/arm/plat-samsung/dev-i2c1.c
index f97905f..cb63223 100644
--- a/arch/arm/plat-samsung/dev-i2c1.c
+++ b/arch/arm/plat-samsung/dev-i2c1.c
@@ -55,16 +55,12 @@ static struct s3c2410_platform_i2c default_i2c_data1 __initdata = {
 
 void __init s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *pd)
 {
-	struct s3c2410_platform_i2c *npd;
-
 	if (!pd)
 		pd = &default_i2c_data1;
 
-	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	else if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c1_cfg_gpio;
+	if (!pd->cfg_gpio)
+		pd->cfg_gpio = s3c_i2c1_cfg_gpio;
 
-	s3c_device_i2c1.dev.platform_data = npd;
+	s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			 &s3c_device_i2c1);
 }
diff --git a/arch/arm/plat-samsung/dev-onenand.c b/arch/arm/plat-samsung/dev-onenand.c
index 45ec732..a16e878 100644
--- a/arch/arm/plat-samsung/dev-onenand.c
+++ b/arch/arm/plat-samsung/dev-onenand.c
@@ -46,10 +46,6 @@ struct platform_device s3c_device_onenand = {
 
 void s3c_onenand_set_platdata(struct onenand_platform_data *pdata)
 {
-	struct onenand_platform_data *pd;
-
-	pd = kmemdup(pdata, sizeof(struct onenand_platform_data), GFP_KERNEL);
-	if (!pd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	s3c_device_onenand.dev.platform_data = pd;
+	s3c_set_platdata(pdata, sizeof(struct onenand_platform_data),
+			 &s3c_device_onenand);
 }
diff --git a/arch/arm/plat-samsung/dev-ts.c b/arch/arm/plat-samsung/dev-ts.c
index 236ef84..db0432d 100644
--- a/arch/arm/plat-samsung/dev-ts.c
+++ b/arch/arm/plat-samsung/dev-ts.c
@@ -45,17 +45,7 @@ struct platform_device s3c_device_ts = {
 
 void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *pd)
 {
-	struct s3c2410_ts_mach_info *npd;
-
-	if (!pd) {
-		printk(KERN_ERR "%s: no platform data\n", __func__);
-		return;
-	}
-
-	npd = kmemdup(pd, sizeof(struct s3c2410_ts_mach_info), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-
-	s3c_device_ts.dev.platform_data = npd;
+	s3c_set_platdata(pd, sizeof(struct s3c2410_ts_mach_info),
+			 &s3c_device_ts);
 }
 EXPORT_SYMBOL(s3c24xx_ts_set_platdata);
diff --git a/arch/arm/plat-samsung/dev-usb.c b/arch/arm/plat-samsung/dev-usb.c
index 0e0a3bf..591c53c 100644
--- a/arch/arm/plat-samsung/dev-usb.c
+++ b/arch/arm/plat-samsung/dev-usb.c
@@ -52,19 +52,13 @@ EXPORT_SYMBOL(s3c_device_ohci);
 
 /**
  * s3c_ohci_set_platdata - initialise OHCI device platform data
- * @info: The platform data.
+ * @pd: The platform data.
  *
  * This call copies the @info passed in and sets the device .platform_data
  * field to that copy. The @info is copied so that the original can be marked
  * __initdata.
  */
-void __init s3c_ohci_set_platdata(struct s3c2410_hcd_info *info)
+void __init s3c_ohci_set_platdata(struct s3c2410_hcd_info *pd)
 {
-	struct s3c2410_hcd_info *npd;
-
-	npd = kmemdup(info, sizeof(struct s3c2410_hcd_info), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-
-	s3c_device_ohci.dev.platform_data = npd;
+	s3c_set_platdata(pd, sizeof(struct s3c2410_hcd_info), &s3c_device_ohci);
 }
-- 
1.6.3.3
