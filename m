From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 18 Jan 2010 08:45:17 +0000
Subject: [PATCH] ARM: S3C24XX: Add mci platform data set call
	s3c24xx_mci_set_platdata().
In-Reply-To: <1263804317-8996-1-git-send-email-ben-linux@fluff.org>
References: <1263804317-8996-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1263804317-8996-8-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a s3c24xx_mci_set_platdata() call for all the machine files that have
platform data for the MCI driver. This brings the MCI device into line with
the other devices with __initdata and a specific call to ensure the right
structure type is being passed.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/mach-h1940.c       |    5 ++---
 arch/arm/mach-s3c2440/mach-at2440evb.c   |    5 ++---
 arch/arm/mach-s3c2440/mach-mini2440.c    |    3 +--
 arch/arm/plat-s3c24xx/devs.c             |   12 ++++++++++++
 arch/arm/plat-s3c24xx/include/plat/mci.h |    9 +++++++++
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 3f9217d..fbedd07 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -196,7 +196,7 @@ static struct platform_device h1940_device_bluetooth = {
 	.id               = -1,
 };
 
-static struct s3c24xx_mci_pdata h1940_mmc_cfg = {
+static struct s3c24xx_mci_pdata h1940_mmc_cfg __initdata = {
 	.gpio_detect   = S3C2410_GPF(5),
 	.gpio_wprotect = S3C2410_GPH(8),
 	.set_power     = NULL,
@@ -311,12 +311,11 @@ static void __init h1940_init(void)
 	u32 tmp;
 
 	s3c24xx_fb_set_platdata(&h1940_fb_info);
+	s3c24xx_mci_set_platdata(&h1940_mmc_cfg);
  	s3c24xx_udc_set_platdata(&h1940_udc_cfg);
 	s3c24xx_ts_set_platdata(&h1940_ts_cfg);
 	s3c_i2c0_set_platdata(NULL);
 
-	s3c_device_sdi.dev.platform_data = &h1940_mmc_cfg;
-
 	/* Turn off suspend on both USB ports, and switch the
 	 * selectable USB port to USB device mode. */
 
diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
index 0defde6..8472579 100644
--- a/arch/arm/mach-s3c2440/mach-at2440evb.c
+++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
@@ -165,7 +165,7 @@ static struct platform_device at2440evb_device_eth = {
 	},
 };
 
-static struct s3c24xx_mci_pdata at2440evb_mci_pdata = {
+static struct s3c24xx_mci_pdata at2440evb_mci_pdata __initdata = {
 	.gpio_detect	= S3C2410_GPG(10),
 };
 
@@ -216,8 +216,6 @@ static struct platform_device *at2440evb_devices[] __initdata = {
 
 static void __init at2440evb_map_io(void)
 {
-	s3c_device_sdi.dev.platform_data = &at2440evb_mci_pdata;
-
 	s3c24xx_init_io(at2440evb_iodesc, ARRAY_SIZE(at2440evb_iodesc));
 	s3c24xx_init_clocks(16934400);
 	s3c24xx_init_uarts(at2440evb_uartcfgs, ARRAY_SIZE(at2440evb_uartcfgs));
@@ -226,6 +224,7 @@ static void __init at2440evb_map_io(void)
 static void __init at2440evb_init(void)
 {
 	s3c24xx_fb_set_platdata(&at2440evb_fb_info);
+	s3c24xx_mci_set_platdata(&at2440evb_mci_pdata);
 	s3c_nand_set_platdata(&at2440evb_nand_info);
 	s3c_i2c0_set_platdata(NULL);
 
diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index 65ea3b5..571b176 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -528,8 +528,6 @@ static void __init mini2440_map_io(void)
 	s3c24xx_init_io(mini2440_iodesc, ARRAY_SIZE(mini2440_iodesc));
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(mini2440_uartcfgs, ARRAY_SIZE(mini2440_uartcfgs));
-
-	s3c_device_sdi.dev.platform_data = &mini2440_mmc_cfg;
 }
 
 /*
@@ -675,6 +673,7 @@ static void __init mini2440_init(void)
 	}
 
 	s3c24xx_udc_set_platdata(&mini2440_udc_cfg);
+	s3c24xx_mci_set_platdata(&mini2440_mmc_cfg);
 	s3c_nand_set_platdata(&mini2440_nand_info);
 	s3c_i2c0_set_platdata(NULL);
 
diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 38c358c..3acb534 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -351,6 +351,18 @@ struct platform_device s3c_device_sdi = {
 
 EXPORT_SYMBOL(s3c_device_sdi);
 
+void s3c24xx_mci_set_platdata(struct s3c24xx_mci_pdata *pdata)
+{
+	struct s3c24xx_mci_pdata *npd;
+
+	npd = kmemdup(pdata, sizeof(struct s3c24xx_mci_pdata), GFP_KERNEL);
+	if (!npd)
+		printk(KERN_ERR "%s: no memory to copy pdata", __func__);
+
+	s3c_device_sdi.dev.platform_data = npd;
+}
+
+
 /* SPI (0) */
 
 static struct resource s3c_spi0_resource[] = {
diff --git a/arch/arm/plat-s3c24xx/include/plat/mci.h b/arch/arm/plat-s3c24xx/include/plat/mci.h
index 36aaa10..2ac2b21 100644
--- a/arch/arm/plat-s3c24xx/include/plat/mci.h
+++ b/arch/arm/plat-s3c24xx/include/plat/mci.h
@@ -40,4 +40,13 @@ struct s3c24xx_mci_pdata {
 				     unsigned short vdd);
 };
 
+/**
+ * s3c24xx_mci_set_platdata - set platform data for mmc/sdi device
+ * @pdata: The platform data
+ *
+ * Copy the platform data supplied by @pdata so that this can be marked
+ * __initdata.
+ */
+extern void s3c24xx_mci_set_platdata(struct s3c24xx_mci_pdata *pdata);
+
 #endif /* _ARCH_NCI_H */
-- 
1.6.0.4
