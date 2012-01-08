From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 8 Jan 2012 22:23:32 +0100
Subject: [PATCH 2/2] S3C24XX: move spi-s3c24xx platdata out of mach
In-Reply-To: <201201082222.11305.heiko@sntech.de>
References: <201201082222.11305.heiko@sntech.de>
Message-ID: <201201082223.32677.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

spi.h now only contains the definition of the platform data structure
for the driver in spi-s3c24xx.c . Therefore it does not need to stay
in include/mach but can instead live in linux/spi/s3c24xx.h .

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2410/include/mach/spi.h |   27 ---------------------------
 arch/arm/mach-s3c2440/mach-gta02.c       |    2 +-
 drivers/spi/spi-s3c24xx.c                |    2 +-
 3 files changed, 2 insertions(+), 29 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/spi.h

diff --git a/arch/arm/mach-s3c2410/include/mach/spi.h b/arch/arm/mach-s3c2410/include/mach/spi.h
deleted file mode 100644
index 2a686c0..0000000
--- a/arch/arm/mach-s3c2410/include/mach/spi.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/spi.h
- *
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2410 - SPI Controller platform_device info
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_SPI_H
-#define __ASM_ARCH_SPI_H __FILE__
-
-struct s3c2410_spi_info {
-	int			 pin_cs;	/* simple gpio cs */
-	unsigned int		 num_cs;	/* total chipselects */
-	int			 bus_num;       /* bus number to use. */
-
-	unsigned int		 use_fiq:1;	/* use fiq */
-
-	void (*gpio_setup)(struct s3c2410_spi_info *spi, int enable);
-	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
-};
-
-#endif /* __ASM_ARCH_SPI_H */
diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index e8d2eb9..236514c 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -38,6 +38,7 @@
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/s3c24xx.h>
 
 #include <linux/mmc/host.h>
 
@@ -73,7 +74,6 @@
 #include <mach/regs-gpioj.h>
 #include <mach/fb.h>
 
-#include <mach/spi.h>
 #include <plat/usb-control.h>
 #include <mach/regs-mem.h>
 #include <mach/hardware.h>
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index fc06453..8ee7d79 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -24,10 +24,10 @@
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
+#include <linux/spi/s3c24xx.h>
 #include <linux/module.h>
 
 #include <plat/regs-spi.h>
-#include <mach/spi.h>
 
 #include <plat/fiq.h>
 #include <asm/fiq.h>
-- 
1.7.2.3
