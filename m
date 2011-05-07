From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 7 May 2011 22:26:53 +0200
Subject: [PATCH 2/4] ARM: S3C24XX: Add plaform device definition for USB
	High-Speed gadget controller.
In-Reply-To: <201105072223.44163.heiko@sntech.de>
References: <Pine.LNX.4.44L0.1104141313210.2487-100000@iolanthe.rowland.org>
	<20110416145830.GA8811@kroah.com>
	<201105072223.44163.heiko@sntech.de>
Message-ID: <201105072226.53556.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

S3C2416, S3C2443 and S3C2450 includes a USB High-Speed Gadget controller module.
This patch adds the following for supporting this controller.

1. Definition for USB High-Speed controller base address.
2. Platform device instantiation.
3. Declaration for platform data structure.
4. Functionality to setup platform data for the controller.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s3c2410/include/mach/map.h  |    4 +++
 arch/arm/plat-s3c24xx/devs.c              |   41 +++++++++++++++++++++++++++++
 arch/arm/plat-s3c24xx/include/plat/udc.h  |   17 ++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h |    1 +
 4 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/map.h b/arch/arm/mach-s3c2410/include/mach/map.h
index 25bbf5a..425552d 100644
--- a/arch/arm/mach-s3c2410/include/mach/map.h
+++ b/arch/arm/mach-s3c2410/include/mach/map.h
@@ -21,6 +21,10 @@
 /* USB host controller */
 #define S3C2410_PA_USBHOST (0x49000000)
 
+/* S3C2416/S3C2443/S3C2450 High-Speed USB Gadget */
+#define S3C2416_PA_HSUDC	(0x49800000)
+#define S3C2416_SZ_HSUDC	(SZ_4K)
+
 /* DMA controller */
 #define S3C2410_PA_DMA	   (0x4B000000)
 #define S3C24XX_SZ_DMA	   SZ_1M
diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 268f3ed..7366799 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -233,6 +234,46 @@ void __init s3c24xx_udc_set_platdata(struct s3c2410_udc_mach_info *pd)
 	}
 }
 
+/* USB High Speed 2.0 Device (Gadget) */
+static struct resource s3c_hsudc_resource[] = {
+	[0] = {
+		.start	= S3C2416_PA_HSUDC,
+		.end	= S3C2416_PA_HSUDC + S3C2416_SZ_HSUDC - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_USBD,
+		.end	= IRQ_USBD,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static u64 s3c_hsudc_dmamask = DMA_BIT_MASK(32);
+
+struct platform_device s3c_device_usb_hsudc = {
+	.name		= "s3c-hsudc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_hsudc_resource),
+	.resource	= s3c_hsudc_resource,
+	.dev		= {
+		.dma_mask		= &s3c_hsudc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init s3c24xx_hsudc_set_platdata(struct s3c24xx_hsudc_platdata *pd)
+{
+	struct s3c24xx_hsudc_platdata *npd;
+
+	npd = kmalloc(sizeof(*npd), GFP_KERNEL);
+	if (npd) {
+		memcpy(npd, pd, sizeof(*npd));
+		s3c_device_usb_hsudc.dev.platform_data = npd;
+	} else {
+		printk(KERN_ERR "no memory for udc platform data\n");
+	}
+}
+
 /* IIS */
 
 static struct resource s3c_iis_resource[] = {
diff --git a/arch/arm/plat-s3c24xx/include/plat/udc.h b/arch/arm/plat-s3c24xx/include/plat/udc.h
index 80457c6..f6388424 100644
--- a/arch/arm/plat-s3c24xx/include/plat/udc.h
+++ b/arch/arm/plat-s3c24xx/include/plat/udc.h
@@ -37,4 +37,21 @@ struct s3c2410_udc_mach_info {
 
 extern void __init s3c24xx_udc_set_platdata(struct s3c2410_udc_mach_info *);
 
+/**
+ * s3c24xx_hsudc_platdata - Platform data for USB High-Speed gadget controller.
+ * @epnum: Number of endpoints to be instantiated by the controller driver.
+ * @gpio_init: Platform specific USB related GPIO initialization.
+ * @gpio_uninit: Platform specific USB releted GPIO uninitialzation.
+ *
+ * Representation of platform data for the S3C24XX USB 2.0 High Speed gadget
+ * controllers.
+ */
+struct s3c24xx_hsudc_platdata {
+	unsigned int	epnum;
+	void		(*gpio_init)(void);
+	void		(*gpio_uninit)(void);
+};
+
+extern void __init s3c24xx_hsudc_set_platdata(struct s3c24xx_hsudc_platdata *pd);
+
 #endif /* __ASM_ARM_ARCH_UDC_H */
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 3f38deb..39818d8 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -88,6 +88,7 @@ extern struct platform_device s3c64xx_device_onenand1;
 extern struct platform_device s5p_device_onenand;
 
 extern struct platform_device s3c_device_usbgadget;
+extern struct platform_device s3c_device_usb_hsudc;
 extern struct platform_device s3c_device_usb_hsotg;
 
 extern struct platform_device s5pv210_device_ac97;
-- 
1.7.2.3
