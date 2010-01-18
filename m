From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 18 Jan 2010 08:45:15 +0000
Subject: [PATCH] ARM: SAMSUNG: Add platform data registration for OHCI
In-Reply-To: <1263804317-8996-1-git-send-email-ben-linux@fluff.org>
References: <1263804317-8996-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1263804317-8996-6-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a platform data helper for the OHCI device

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/usb-simtec.c           |    4 ++--
 arch/arm/mach-s3c2442/mach-gta02.c           |    5 ++---
 arch/arm/plat-s3c/include/plat/usb-control.h |    2 ++
 arch/arm/plat-samsung/dev-usb.c              |   21 ++++++++++++++++++++-
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c2410/usb-simtec.c b/arch/arm/mach-s3c2410/usb-simtec.c
index 199bb4f..29bd3d9 100644
--- a/arch/arm/mach-s3c2410/usb-simtec.c
+++ b/arch/arm/mach-s3c2410/usb-simtec.c
@@ -91,7 +91,7 @@ static void usb_simtec_enableoc(struct s3c2410_hcd_info *info, int on)
 	}
 }
 
-static struct s3c2410_hcd_info usb_simtec_info = {
+static struct s3c2410_hcd_info usb_simtec_info __initdata = {
 	.port[0]	= {
 		.flags	= S3C_HCDFLG_USED
 	},
@@ -127,6 +127,6 @@ int usb_simtec_init(void)
 	gpio_direction_output(S3C2410_GPB(4), 1);
 	gpio_direction_input(S3C2410_GPG(10));
 
-	s3c_device_ohci.dev.platform_data = &usb_simtec_info;
+	s3c_ohci_set_platdata(&usb_simtec_info);
 	return 0;
 }
diff --git a/arch/arm/mach-s3c2442/mach-gta02.c b/arch/arm/mach-s3c2442/mach-gta02.c
index 825800b..45799c6 100644
--- a/arch/arm/mach-s3c2442/mach-gta02.c
+++ b/arch/arm/mach-s3c2442/mach-gta02.c
@@ -544,7 +544,7 @@ static struct platform_device gta02_bl_dev = {
 
 
 /* USB */
-static struct s3c2410_hcd_info gta02_usb_info = {
+static struct s3c2410_hcd_info gta02_usb_info __initdata = {
 	.port[0]	= {
 		.flags	= S3C_HCDFLG_USED,
 	},
@@ -623,9 +623,8 @@ static void __init gta02_machine_init(void)
 	INIT_DELAYED_WORK(&gta02_charger_work, gta02_charger_worker);
 #endif
 
-	s3c_device_ohci.dev.platform_data = &gta02_usb_info;
-
 	s3c24xx_udc_set_platdata(&gta02_udc_cfg);
+	s3c_ohci_set_platdata(&gta02_usb_info);
 	s3c_nand_set_platdata(&gta02_nand_info);
 	s3c_i2c0_set_platdata(NULL);
 
diff --git a/arch/arm/plat-s3c/include/plat/usb-control.h b/arch/arm/plat-s3c/include/plat/usb-control.h
index 822c87f..a6a57bf 100644
--- a/arch/arm/plat-s3c/include/plat/usb-control.h
+++ b/arch/arm/plat-s3c/include/plat/usb-control.h
@@ -38,4 +38,6 @@ static void inline s3c2410_usb_report_oc(struct s3c2410_hcd_info *info, int port
 	}
 }
 
+extern void s3c_ohci_set_platdata(struct s3c2410_hcd_info *info);
+
 #endif /*__ASM_ARCH_USBCONTROL_H */
diff --git a/arch/arm/plat-samsung/dev-usb.c b/arch/arm/plat-samsung/dev-usb.c
index 431ae5d..8816565 100644
--- a/arch/arm/plat-samsung/dev-usb.c
+++ b/arch/arm/plat-samsung/dev-usb.c
@@ -19,7 +19,7 @@
 #include <mach/map.h>
 
 #include <plat/devs.h>
-
+#include <plat/usb-control.h>
 
 static struct resource s3c_usb_resource[] = {
 	[0] = {
@@ -48,3 +48,22 @@ struct platform_device s3c_device_ohci = {
 };
 
 EXPORT_SYMBOL(s3c_device_ohci);
+
+/**
+ * s3c_ohci_set_platdata - initialise OHCI device platform data
+ * @info: The platform data.
+ *
+ * This call copies the @info passed in and sets the device .platform_data
+ * field to that copy. The @info is copied so that the original can be marked
+ * __initdata.
+ */
+void __init s3c_ohci_set_platdata(struct s3c2410_hcd_info *info)
+{
+	struct s3c2410_hcd_info *npd;
+
+	npd = kmemdup(info, sizeof(struct s3c2410_hcd_info), GFP_KERNEL);
+	if (!npd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+
+	s3c_device_ohci.dev.platform_data = npd;
+}
-- 
1.6.0.4
