From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 17 Dec 2011 20:24:46 +0100
Subject: [PATCH 1/7] s3c-hsudc: move platform_data struct to global header
In-Reply-To: <201112172023.05519.heiko@sntech.de>
References: <201112172023.05519.heiko@sntech.de>
Message-ID: <201112172024.47456.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gadget drivers should be compilable on all architectures.
This patch removes one dependency on architecture-specific code.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2416/mach-smdk2416.c    |    1 +
 arch/arm/plat-samsung/devs.c             |    1 +
 arch/arm/plat-samsung/include/plat/udc.h |   15 +------------
 drivers/usb/gadget/s3c-hsudc.c           |    2 +-
 include/linux/usb/s3c-hsudc.h            |   34 ++++++++++++++++++++++++++++++
 5 files changed, 38 insertions(+), 15 deletions(-)
 create mode 100644 include/linux/usb/s3c-hsudc.h

diff --git a/arch/arm/mach-s3c2416/mach-smdk2416.c b/arch/arm/mach-s3c2416/mach-smdk2416.c
index a9eee53..018338a 100644
--- a/arch/arm/mach-s3c2416/mach-smdk2416.c
+++ b/arch/arm/mach-s3c2416/mach-smdk2416.c
@@ -50,6 +50,7 @@
 #include <plat/nand.h>
 #include <plat/sdhci.h>
 #include <plat/udc.h>
+#include <linux/usb/s3c-hsudc.h>
 
 #include <plat/regs-fb-v4.h>
 #include <plat/fb.h>
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 4ca8b57..5468723 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -29,6 +29,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mmc/host.h>
 #include <linux/ioport.h>
+#include <linux/usb/s3c-hsudc.h>
 
 #include <asm/irq.h>
 #include <asm/pmu.h>
diff --git a/arch/arm/plat-samsung/include/plat/udc.h b/arch/arm/plat-samsung/include/plat/udc.h
index 8c22d58..de8e228 100644
--- a/arch/arm/plat-samsung/include/plat/udc.h
+++ b/arch/arm/plat-samsung/include/plat/udc.h
@@ -37,20 +37,7 @@ struct s3c2410_udc_mach_info {
 
 extern void __init s3c24xx_udc_set_platdata(struct s3c2410_udc_mach_info *);
 
-/**
- * s3c24xx_hsudc_platdata - Platform data for USB High-Speed gadget controller.
- * @epnum: Number of endpoints to be instantiated by the controller driver.
- * @gpio_init: Platform specific USB related GPIO initialization.
- * @gpio_uninit: Platform specific USB releted GPIO uninitialzation.
- *
- * Representation of platform data for the S3C24XX USB 2.0 High Speed gadget
- * controllers.
- */
-struct s3c24xx_hsudc_platdata {
-	unsigned int	epnum;
-	void		(*gpio_init)(void);
-	void		(*gpio_uninit)(void);
-};
+struct s3c24xx_hsudc_platdata;
 
 extern void __init s3c24xx_hsudc_set_platdata(struct s3c24xx_hsudc_platdata *pd);
 
diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
index 6f2a041..4c1abb1 100644
--- a/drivers/usb/gadget/s3c-hsudc.c
+++ b/drivers/usb/gadget/s3c-hsudc.c
@@ -28,9 +28,9 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
 #include <linux/prefetch.h>
+#include <linux/usb/s3c-hsudc.h>
 
 #include <mach/regs-s3c2443-clock.h>
-#include <plat/udc.h>
 
 #define S3C_HSUDC_REG(x)	(x)
 
diff --git a/include/linux/usb/s3c-hsudc.h b/include/linux/usb/s3c-hsudc.h
new file mode 100644
index 0000000..6fa1093
--- /dev/null
+++ b/include/linux/usb/s3c-hsudc.h
@@ -0,0 +1,34 @@
+/*
+ * S3C24XX USB 2.0 High-speed USB controller gadget driver
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * The S3C24XX USB 2.0 high-speed USB controller supports upto 9 endpoints.
+ * Each endpoint can be configured as either in or out endpoint. Endpoints
+ * can be configured for Bulk or Interrupt transfer mode.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __LINUX_USB_S3C_HSUDC_H
+#define __LINUX_USB_S3C_HSUDC_H
+
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
+#endif	/* __LINUX_USB_S3C_HSUDC_H */
-- 
1.7.2.3
