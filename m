From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 06 Oct 2011 15:30:10 +0900
Subject: [PATCH RE-SEND 3/5] ARM: S5P: To merge devs.c files to one devs.c
Message-ID: <00e901cc83f1$659b3810$30d1a830$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves regarding s5p dev files to one devs.c file
in plat-samsung directory and this help to keep it more
easily.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/i2c-hdmiphy.h |   16 -
 arch/arm/mach-s5pv210/include/mach/i2c-hdmiphy.h |   16 -
 arch/arm/plat-s5p/Makefile                       |   12 -
 arch/arm/plat-s5p/dev-csis0.c                    |   34 --
 arch/arm/plat-s5p/dev-csis1.c                    |   34 --
 arch/arm/plat-s5p/dev-ehci.c                     |   57 ---
 arch/arm/plat-s5p/dev-fimc0.c                    |   43 --
 arch/arm/plat-s5p/dev-fimc1.c                    |   43 --
 arch/arm/plat-s5p/dev-fimc2.c                    |   43 --
 arch/arm/plat-s5p/dev-fimc3.c                    |   43 --
 arch/arm/plat-s5p/dev-fimd0.c                    |   67 ---
 arch/arm/plat-s5p/dev-i2c-hdmiphy.c              |   59 ---
 arch/arm/plat-s5p/dev-mfc.c                      |   50 ---
 arch/arm/plat-s5p/dev-onenand.c                  |   45 --
 arch/arm/plat-s5p/dev-pmu.c                      |   36 --
 arch/arm/plat-s5p/dev-tv.c                       |   98 -----
 arch/arm/plat-samsung/devs.c                     |  468 ++++++++++++++++++++++
 17 files changed, 468 insertions(+), 696 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/include/mach/i2c-hdmiphy.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/i2c-hdmiphy.h
 delete mode 100644 arch/arm/plat-s5p/dev-csis0.c
 delete mode 100644 arch/arm/plat-s5p/dev-csis1.c
 delete mode 100644 arch/arm/plat-s5p/dev-ehci.c
 delete mode 100644 arch/arm/plat-s5p/dev-fimc0.c
 delete mode 100644 arch/arm/plat-s5p/dev-fimc1.c
 delete mode 100644 arch/arm/plat-s5p/dev-fimc2.c
 delete mode 100644 arch/arm/plat-s5p/dev-fimc3.c
 delete mode 100644 arch/arm/plat-s5p/dev-fimd0.c
 delete mode 100644 arch/arm/plat-s5p/dev-i2c-hdmiphy.c
 delete mode 100644 arch/arm/plat-s5p/dev-onenand.c
 delete mode 100644 arch/arm/plat-s5p/dev-pmu.c
 delete mode 100644 arch/arm/plat-s5p/dev-tv.c

diff --git a/arch/arm/mach-exynos4/include/mach/i2c-hdmiphy.h b/arch/arm/mach-exynos4/include/mach/i2c-hdmiphy.h
deleted file mode 100644
index 9dbe317..0000000
--- a/arch/arm/mach-exynos4/include/mach/i2c-hdmiphy.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * Copyright (C) 2011 Samsung Electronics Co., Ltd.
- *
- * S5P series i2c hdmiphy helper definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef PLAT_S5P_I2C_HDMIPHY_H_
-#define PLAT_S5P_I2C_HDMIPHY_H_
-
-#define S5P_I2C_HDMIPHY_BUS_NUM		(8)
-
-#endif
diff --git a/arch/arm/mach-s5pv210/include/mach/i2c-hdmiphy.h b/arch/arm/mach-s5pv210/include/mach/i2c-hdmiphy.h
deleted file mode 100644
index 6afa624..0000000
--- a/arch/arm/mach-s5pv210/include/mach/i2c-hdmiphy.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * Copyright (C) 2011 Samsung Electronics Co., Ltd.
- *
- * S5P series i2c hdmiphy helper definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef PLAT_S5P_I2C_HDMIPHY_H_
-#define PLAT_S5P_I2C_HDMIPHY_H_
-
-#define S5P_I2C_HDMIPHY_BUS_NUM		(3)
-
-#endif
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 06401dc..8763440 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -12,7 +12,6 @@ obj-				:=
 
 # Core files
 
-obj-y				+= dev-pmu.o
 obj-y				+= dev-uart.o
 obj-y				+= cpu.o
 obj-y				+= clock.o
@@ -26,15 +25,4 @@ obj-$(CONFIG_S5P_HRT) 		+= s5p-time.o
 
 # devices
 obj-$(CONFIG_S5P_DEV_MFC)	+= dev-mfc.o
-obj-$(CONFIG_S5P_DEV_FIMC0)	+= dev-fimc0.o
-obj-$(CONFIG_S5P_DEV_FIMC1)	+= dev-fimc1.o
-obj-$(CONFIG_S5P_DEV_FIMC2)	+= dev-fimc2.o
-obj-$(CONFIG_S5P_DEV_FIMC3)	+= dev-fimc3.o
-obj-$(CONFIG_S5P_DEV_FIMD0)	+= dev-fimd0.o
-obj-$(CONFIG_S5P_DEV_I2C_HDMIPHY) += dev-i2c-hdmiphy.o
-obj-$(CONFIG_S5P_DEV_ONENAND)	+= dev-onenand.o
-obj-$(CONFIG_S5P_DEV_CSIS0)	+= dev-csis0.o
-obj-$(CONFIG_S5P_DEV_CSIS1)	+= dev-csis1.o
-obj-$(CONFIG_S5P_DEV_TV)	+= dev-tv.o
-obj-$(CONFIG_S5P_DEV_USB_EHCI)	+= dev-ehci.o
 obj-$(CONFIG_S5P_SETUP_MIPIPHY)	+= setup-mipiphy.o
diff --git a/arch/arm/plat-s5p/dev-csis0.c b/arch/arm/plat-s5p/dev-csis0.c
deleted file mode 100644
index e3aabef..0000000
--- a/arch/arm/plat-s5p/dev-csis0.c
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * Copyright (C) 2010-2011 Samsung Electronics Co., Ltd.
- *
- * S5P series device definition for MIPI-CSIS channel 0
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <mach/map.h>
-
-static struct resource s5p_mipi_csis0_resource[] = {
-	[0] = {
-		.start = S5P_PA_MIPI_CSIS0,
-		.end   = S5P_PA_MIPI_CSIS0 + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_MIPI_CSIS0,
-		.end   = IRQ_MIPI_CSIS0,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device s5p_device_mipi_csis0 = {
-	.name		  = "s5p-mipi-csis",
-	.id		  = 0,
-	.num_resources	  = ARRAY_SIZE(s5p_mipi_csis0_resource),
-	.resource	  = s5p_mipi_csis0_resource,
-};
diff --git a/arch/arm/plat-s5p/dev-csis1.c b/arch/arm/plat-s5p/dev-csis1.c
deleted file mode 100644
index 08b91b5..0000000
--- a/arch/arm/plat-s5p/dev-csis1.c
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * Copyright (C) 2010-2011 Samsung Electronics Co., Ltd.
- *
- * S5P series device definition for MIPI-CSIS channel 1
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <mach/map.h>
-
-static struct resource s5p_mipi_csis1_resource[] = {
-	[0] = {
-		.start = S5P_PA_MIPI_CSIS1,
-		.end   = S5P_PA_MIPI_CSIS1 + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_MIPI_CSIS1,
-		.end   = IRQ_MIPI_CSIS1,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s5p_device_mipi_csis1 = {
-	.name		  = "s5p-mipi-csis",
-	.id		  = 1,
-	.num_resources	  = ARRAY_SIZE(s5p_mipi_csis1_resource),
-	.resource	  = s5p_mipi_csis1_resource,
-};
diff --git a/arch/arm/plat-s5p/dev-ehci.c b/arch/arm/plat-s5p/dev-ehci.c
deleted file mode 100644
index 94080ff..0000000
--- a/arch/arm/plat-s5p/dev-ehci.c
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * Copyright (C) 2011 Samsung Electronics Co.Ltd
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
-
-#include <linux/platform_device.h>
-#include <mach/irqs.h>
-#include <mach/map.h>
-#include <plat/devs.h>
-#include <plat/ehci.h>
-#include <plat/usb-phy.h>
-
-/* USB EHCI Host Controller registration */
-static struct resource s5p_ehci_resource[] = {
-	[0] = {
-		.start	= S5P_PA_EHCI,
-		.end	= S5P_PA_EHCI + SZ_256 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_USB_HOST,
-		.end	= IRQ_USB_HOST,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static u64 s5p_device_ehci_dmamask = 0xffffffffUL;
-
-struct platform_device s5p_device_ehci = {
-	.name		= "s5p-ehci",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s5p_ehci_resource),
-	.resource	= s5p_ehci_resource,
-	.dev		= {
-		.dma_mask = &s5p_device_ehci_dmamask,
-		.coherent_dma_mask = 0xffffffffUL
-	}
-};
-
-void __init s5p_ehci_set_platdata(struct s5p_ehci_platdata *pd)
-{
-	struct s5p_ehci_platdata *npd;
-
-	npd = s3c_set_platdata(pd, sizeof(struct s5p_ehci_platdata),
-			&s5p_device_ehci);
-
-	if (!npd->phy_init)
-		npd->phy_init = s5p_usb_phy_init;
-	if (!npd->phy_exit)
-		npd->phy_exit = s5p_usb_phy_exit;
-}
diff --git a/arch/arm/plat-s5p/dev-fimc0.c b/arch/arm/plat-s5p/dev-fimc0.c
deleted file mode 100644
index 608770f..0000000
--- a/arch/arm/plat-s5p/dev-fimc0.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/* linux/arch/arm/plat-s5p/dev-fimc0.c
- *
- * Copyright (c) 2010 Samsung Electronics
- *
- * Base S5P FIMC0 resource and device definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <mach/map.h>
-
-static struct resource s5p_fimc0_resource[] = {
-	[0] = {
-		.start	= S5P_PA_FIMC0,
-		.end	= S5P_PA_FIMC0 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_FIMC0,
-		.end	= IRQ_FIMC0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 s5p_fimc0_dma_mask = DMA_BIT_MASK(32);
-
-struct platform_device s5p_device_fimc0 = {
-	.name		= "s5p-fimc",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(s5p_fimc0_resource),
-	.resource	= s5p_fimc0_resource,
-	.dev		= {
-		.dma_mask		= &s5p_fimc0_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
diff --git a/arch/arm/plat-s5p/dev-fimc1.c b/arch/arm/plat-s5p/dev-fimc1.c
deleted file mode 100644
index 76e3a97..0000000
--- a/arch/arm/plat-s5p/dev-fimc1.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/* linux/arch/arm/plat-s5p/dev-fimc1.c
- *
- * Copyright (c) 2010 Samsung Electronics
- *
- * Base S5P FIMC1 resource and device definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <mach/map.h>
-
-static struct resource s5p_fimc1_resource[] = {
-	[0] = {
-		.start	= S5P_PA_FIMC1,
-		.end	= S5P_PA_FIMC1 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_FIMC1,
-		.end	= IRQ_FIMC1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 s5p_fimc1_dma_mask = DMA_BIT_MASK(32);
-
-struct platform_device s5p_device_fimc1 = {
-	.name		= "s5p-fimc",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(s5p_fimc1_resource),
-	.resource	= s5p_fimc1_resource,
-	.dev		= {
-		.dma_mask		= &s5p_fimc1_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
diff --git a/arch/arm/plat-s5p/dev-fimc2.c b/arch/arm/plat-s5p/dev-fimc2.c
deleted file mode 100644
index 24d2981..0000000
--- a/arch/arm/plat-s5p/dev-fimc2.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/* linux/arch/arm/plat-s5p/dev-fimc2.c
- *
- * Copyright (c) 2010 Samsung Electronics
- *
- * Base S5P FIMC2 resource and device definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <mach/map.h>
-
-static struct resource s5p_fimc2_resource[] = {
-	[0] = {
-		.start	= S5P_PA_FIMC2,
-		.end	= S5P_PA_FIMC2 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_FIMC2,
-		.end	= IRQ_FIMC2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 s5p_fimc2_dma_mask = DMA_BIT_MASK(32);
-
-struct platform_device s5p_device_fimc2 = {
-	.name		= "s5p-fimc",
-	.id		= 2,
-	.num_resources	= ARRAY_SIZE(s5p_fimc2_resource),
-	.resource	= s5p_fimc2_resource,
-	.dev		= {
-		.dma_mask		= &s5p_fimc2_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
diff --git a/arch/arm/plat-s5p/dev-fimc3.c b/arch/arm/plat-s5p/dev-fimc3.c
deleted file mode 100644
index ef31bec..0000000
--- a/arch/arm/plat-s5p/dev-fimc3.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/* linux/arch/arm/plat-s5p/dev-fimc3.c
- *
- * Copyright (c) 2010 Samsung Electronics
- *
- * Base S5P FIMC3 resource and device definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <mach/map.h>
-
-static struct resource s5p_fimc3_resource[] = {
-	[0] = {
-		.start	= S5P_PA_FIMC3,
-		.end	= S5P_PA_FIMC3 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_FIMC3,
-		.end	= IRQ_FIMC3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 s5p_fimc3_dma_mask = DMA_BIT_MASK(32);
-
-struct platform_device s5p_device_fimc3 = {
-	.name		= "s5p-fimc",
-	.id		= 3,
-	.num_resources	= ARRAY_SIZE(s5p_fimc3_resource),
-	.resource	= s5p_fimc3_resource,
-	.dev		= {
-		.dma_mask		= &s5p_fimc3_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
diff --git a/arch/arm/plat-s5p/dev-fimd0.c b/arch/arm/plat-s5p/dev-fimd0.c
deleted file mode 100644
index f728bb5..0000000
--- a/arch/arm/plat-s5p/dev-fimd0.c
+++ /dev/null
@@ -1,67 +0,0 @@
-/* linux/arch/arm/plat-s5p/dev-fimd0.c
- *
- * Copyright (c) 2009-2011 Samsung Electronics Co., Ltd.
- *             http://www.samsung.com
- *
- * Core file for Samsung Display Controller (FIMD) driver
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-#include <linux/fb.h>
-#include <linux/gfp.h>
-#include <linux/dma-mapping.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/fb.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-static struct resource s5p_fimd0_resource[] = {
-	[0] = {
-		.start	= S5P_PA_FIMD0,
-		.end	= S5P_PA_FIMD0 + SZ_32K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_FIMD0_VSYNC,
-		.end	= IRQ_FIMD0_VSYNC,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_FIMD0_FIFO,
-		.end	= IRQ_FIMD0_FIFO,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= IRQ_FIMD0_SYSTEM,
-		.end	= IRQ_FIMD0_SYSTEM,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 fimd0_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device s5p_device_fimd0 = {
-	.name		= "s5p-fb",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(s5p_fimd0_resource),
-	.resource	= s5p_fimd0_resource,
-	.dev		= {
-		.dma_mask		= &fimd0_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-void __init s5p_fimd0_set_platdata(struct s3c_fb_platdata *pd)
-{
-	s3c_set_platdata(pd, sizeof(struct s3c_fb_platdata),
-			&s5p_device_fimd0);
-}
diff --git a/arch/arm/plat-s5p/dev-i2c-hdmiphy.c b/arch/arm/plat-s5p/dev-i2c-hdmiphy.c
deleted file mode 100644
index 37343f1..0000000
--- a/arch/arm/plat-s5p/dev-i2c-hdmiphy.c
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P series device definition for i2c for hdmiphy device
- *
- * Based on plat-samsung/dev-i2c7.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-#include <mach/i2c-hdmiphy.h>
-
-#include <plat/regs-iic.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-#include <plat/iic.h>
-
-static struct resource s5p_i2c_resource[] = {
-	[0] = {
-		.start = S5P_PA_IIC_HDMIPHY,
-		.end   = S5P_PA_IIC_HDMIPHY + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_IIC_HDMIPHY,
-		.end   = IRQ_IIC_HDMIPHY,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s5p_device_i2c_hdmiphy = {
-	.name		  = "s3c2440-hdmiphy-i2c",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s5p_i2c_resource),
-	.resource	  = s5p_i2c_resource,
-};
-
-void __init s5p_i2c_hdmiphy_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd) {
-		pd = &default_i2c_data;
-		pd->bus_num = S5P_I2C_HDMIPHY_BUS_NUM;
-	}
-
-	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
-			       &s5p_device_i2c_hdmiphy);
-}
diff --git a/arch/arm/plat-s5p/dev-mfc.c b/arch/arm/plat-s5p/dev-mfc.c
index 94226a0..a30d36b 100644
--- a/arch/arm/plat-s5p/dev-mfc.c
+++ b/arch/arm/plat-s5p/dev-mfc.c
@@ -22,56 +22,6 @@
 #include <plat/irqs.h>
 #include <plat/mfc.h>
 
-static struct resource s5p_mfc_resource[] = {
-	[0] = {
-		.start	= S5P_PA_MFC,
-		.end	= S5P_PA_MFC + SZ_64K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_MFC,
-		.end	= IRQ_MFC,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device s5p_device_mfc = {
-	.name		= "s5p-mfc",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s5p_mfc_resource),
-	.resource	= s5p_mfc_resource,
-};
-
-/*
- * MFC hardware has 2 memory interfaces which are modelled as two separate
- * platform devices to let dma-mapping distinguish between them.
- *
- * MFC parent device (s5p_device_mfc) must be registered before memory
- * interface specific devices (s5p_device_mfc_l and s5p_device_mfc_r).
- */
-
-static u64 s5p_mfc_dma_mask = DMA_BIT_MASK(32);
-
-struct platform_device s5p_device_mfc_l = {
-	.name		= "s5p-mfc-l",
-	.id		= -1,
-	.dev		= {
-		.parent			= &s5p_device_mfc.dev,
-		.dma_mask		= &s5p_mfc_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-struct platform_device s5p_device_mfc_r = {
-	.name		= "s5p-mfc-r",
-	.id		= -1,
-	.dev		= {
-		.parent			= &s5p_device_mfc.dev,
-		.dma_mask		= &s5p_mfc_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
 struct s5p_mfc_reserved_mem {
 	phys_addr_t	base;
 	unsigned long	size;
diff --git a/arch/arm/plat-s5p/dev-onenand.c b/arch/arm/plat-s5p/dev-onenand.c
deleted file mode 100644
index 20336c8..0000000
--- a/arch/arm/plat-s5p/dev-onenand.c
+++ /dev/null
@@ -1,45 +0,0 @@
-/* linux/arch/arm/plat-s5p/dev-onenand.c
- *
- * Copyright 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- *  Copyright (c) 2008-2010 Samsung Electronics
- *  Kyungmin Park <kyungmin.park@samsung.com>
- *
- * S5P series device definition for OneNAND devices
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-static struct resource s5p_onenand_resources[] = {
-	[0] = {
-		.start	= S5P_PA_ONENAND,
-		.end	= S5P_PA_ONENAND + SZ_128K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= S5P_PA_ONENAND_DMA,
-		.end	= S5P_PA_ONENAND_DMA + SZ_8K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start	= IRQ_ONENAND_AUDI,
-		.end	= IRQ_ONENAND_AUDI,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s5p_device_onenand = {
-	.name		= "s5pc110-onenand",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s5p_onenand_resources),
-	.resource	= s5p_onenand_resources,
-};
diff --git a/arch/arm/plat-s5p/dev-pmu.c b/arch/arm/plat-s5p/dev-pmu.c
deleted file mode 100644
index a08576d..0000000
--- a/arch/arm/plat-s5p/dev-pmu.c
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * linux/arch/arm/plat-s5p/dev-pmu.c
- *
- * Copyright (C) 2010 Samsung Electronics Co.Ltd
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
-
-#include <linux/platform_device.h>
-#include <asm/pmu.h>
-#include <mach/irqs.h>
-
-static struct resource s5p_pmu_resource = {
-	.start	= IRQ_PMU,
-	.end	= IRQ_PMU,
-	.flags	= IORESOURCE_IRQ,
-};
-
-struct platform_device s5p_device_pmu = {
-	.name		= "arm-pmu",
-	.id		= ARM_PMU_DEVICE_CPU,
-	.num_resources	= 1,
-	.resource	= &s5p_pmu_resource,
-};
-
-static int __init s5p_pmu_init(void)
-{
-	platform_device_register(&s5p_device_pmu);
-	return 0;
-}
-arch_initcall(s5p_pmu_init);
diff --git a/arch/arm/plat-s5p/dev-tv.c b/arch/arm/plat-s5p/dev-tv.c
deleted file mode 100644
index 361a1b6..0000000
--- a/arch/arm/plat-s5p/dev-tv.c
+++ /dev/null
@@ -1,98 +0,0 @@
-/* linux/arch/arm/plat-s5p/dev-tv.c
- *
- * Copyright (C) 2011 Samsung Electronics Co.Ltd
- * Author: Tomasz Stanislawski <t.stanislaws@samsung.com>
- *
- * S5P series device definition for TV device
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/dma-mapping.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/devs.h>
-
-/* HDMI interface */
-static struct resource s5p_hdmi_resources[] = {
-	[0] = {
-		.start	= S5P_PA_HDMI,
-		.end	= S5P_PA_HDMI + SZ_1M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_HDMI,
-		.end	= IRQ_HDMI,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s5p_device_hdmi = {
-	.name		= "s5p-hdmi",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s5p_hdmi_resources),
-	.resource	= s5p_hdmi_resources,
-};
-EXPORT_SYMBOL(s5p_device_hdmi);
-
-/* SDO interface */
-static struct resource s5p_sdo_resources[] = {
-	[0] = {
-		.start	= S5P_PA_SDO,
-		.end	= S5P_PA_SDO + SZ_64K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_SDO,
-		.end	= IRQ_SDO,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device s5p_device_sdo = {
-	.name		= "s5p-sdo",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s5p_sdo_resources),
-	.resource	= s5p_sdo_resources,
-};
-EXPORT_SYMBOL(s5p_device_sdo);
-
-/* MIXER */
-static struct resource s5p_mixer_resources[] = {
-	[0] = {
-		.start	= S5P_PA_MIXER,
-		.end	= S5P_PA_MIXER + SZ_64K - 1,
-		.flags	= IORESOURCE_MEM,
-		.name	= "mxr"
-	},
-	[1] = {
-		.start	= S5P_PA_VP,
-		.end	= S5P_PA_VP + SZ_64K - 1,
-		.flags	= IORESOURCE_MEM,
-		.name	= "vp"
-	},
-	[2] = {
-		.start	= IRQ_MIXER,
-		.end	= IRQ_MIXER,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "irq"
-	}
-};
-
-static u64 s5p_tv_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device s5p_device_mixer = {
-	.name		= "s5p-mixer",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s5p_mixer_resources),
-	.resource	= s5p_mixer_resources,
-	.dev		= {
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.dma_mask = &s5p_tv_dmamask,
-	}
-};
-EXPORT_SYMBOL(s5p_device_mixer);
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 7a00dee..d8bd7ad 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -22,10 +22,14 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/dma-mapping.h>
+#include <linux/fb.h>
+#include <linux/gfp.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
+#include <linux/ioport.h>
 
 #include <asm/irq.h>
+#include <asm/pmu.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -37,11 +41,15 @@
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
+#include <plat/ehci.h>
 #include <plat/fb.h>
 #include <plat/fb-s3c2410.h>
+#include <plat/iic.h>
 #include <plat/mci.h>
 #include <plat/ts.h>
 #include <plat/udc.h>
+#include <plat/usb-phy.h>
+#include <plat/regs-iic.h>
 #include <plat/regs-serial.h>
 #include <plat/regs-spi.h>
 
@@ -149,6 +157,199 @@ struct platform_device s3c_device_camif = {
 };
 #endif /* CONFIG_CPU_S3C2440 */
 
+/* FIMC */
+
+#ifdef CONFIG_S5P_DEV_FIMC0
+static struct resource s5p_fimc0_resource[] = {
+	[0] = {
+		.start	= S5P_PA_FIMC0,
+		.end	= S5P_PA_FIMC0 + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_FIMC0,
+		.end	= IRQ_FIMC0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s5p_device_fimc0 = {
+	.name		= "s5p-fimc",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s5p_fimc0_resource),
+	.resource	= s5p_fimc0_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+#endif /* CONFIG_S5P_DEV_FIMC0 */
+
+#ifdef CONFIG_S5P_DEV_FIMC1
+static struct resource s5p_fimc1_resource[] = {
+	[0] = {
+		.start	= S5P_PA_FIMC1,
+		.end	= S5P_PA_FIMC1 + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_FIMC1,
+		.end	= IRQ_FIMC1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s5p_device_fimc1 = {
+	.name		= "s5p-fimc",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(s5p_fimc1_resource),
+	.resource	= s5p_fimc1_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+#endif /* CONFIG_S5P_DEV_FIMC1 */
+
+#ifdef CONFIG_S5P_DEV_FIMC2
+static struct resource s5p_fimc2_resource[] = {
+	[0] = {
+		.start	= S5P_PA_FIMC2,
+		.end	= S5P_PA_FIMC2 + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_FIMC2,
+		.end	= IRQ_FIMC2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s5p_device_fimc2 = {
+	.name		= "s5p-fimc",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(s5p_fimc2_resource),
+	.resource	= s5p_fimc2_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+#endif /* CONFIG_S5P_DEV_FIMC2 */
+
+#ifdef CONFIG_S5P_DEV_FIMC3
+static struct resource s5p_fimc3_resource[] = {
+	[0] = {
+		.start	= S5P_PA_FIMC3,
+		.end	= S5P_PA_FIMC3 + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_FIMC3,
+		.end	= IRQ_FIMC3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s5p_device_fimc3 = {
+	.name		= "s5p-fimc",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(s5p_fimc3_resource),
+	.resource	= s5p_fimc3_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+#endif /* CONFIG_S5P_DEV_FIMC3 */
+
+/* FIMD0 */
+
+#ifdef CONFIG_S5P_DEV_FIMD0
+static struct resource s5p_fimd0_resource[] = {
+	[0] = {
+		.start	= S5P_PA_FIMD0,
+		.end	= S5P_PA_FIMD0 + SZ_32K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_FIMD0_VSYNC,
+		.end	= IRQ_FIMD0_VSYNC,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= IRQ_FIMD0_FIFO,
+		.end	= IRQ_FIMD0_FIFO,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= IRQ_FIMD0_SYSTEM,
+		.end	= IRQ_FIMD0_SYSTEM,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s5p_device_fimd0 = {
+	.name		= "s5p-fb",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s5p_fimd0_resource),
+	.resource	= s5p_fimd0_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init s5p_fimd0_set_platdata(struct s3c_fb_platdata *pd)
+{
+	s3c_set_platdata(pd, sizeof(struct s3c_fb_platdata),
+			 &s5p_device_fimd0);
+}
+#endif /* CONFIG_S5P_DEV_FIMD0 */
+
+/* I2C HDMIPHY */
+
+#ifdef CONFIG_S5P_DEV_I2C_HDMIPHY
+static struct resource s5p_i2c_resource[] = {
+	[0] = {
+		.start	= S5P_PA_IIC_HDMIPHY,
+		.end	= S5P_PA_IIC_HDMIPHY + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_IIC_HDMIPHY,
+		.end	= IRQ_IIC_HDMIPHY,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s5p_device_i2c_hdmiphy = {
+	.name		= "s3c2440-hdmiphy-i2c",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5p_i2c_resource),
+	.resource	= s5p_i2c_resource,
+};
+
+void __init s5p_i2c_hdmiphy_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd) {
+		pd = &default_i2c_data;
+
+		if (soc_is_exynos4210())
+			pd->bus_num = 8;
+		else if (soc_is_s5pv210())
+			pd->bus_num = 3;
+		else
+			pd->bus_num = 0;
+	}
+
+	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
+			       &s5p_device_i2c_hdmiphy);
+}
+#endif /* CONFIG_S5P_DEV_I2C_HDMIPHY */
+
 /* I2S */
 
 #ifdef CONFIG_PLAT_S3C24XX
@@ -227,6 +428,104 @@ void __init s3c24xx_fb_set_platdata(struct s3c2410fb_mach_info *pd)
 }
 #endif /* CONFIG_PLAT_S3C24XX */
 
+/* MFC */
+
+#ifdef CONFIG_S5P_DEV_MFC
+static struct resource s5p_mfc_resource[] = {
+	[0] = {
+		.start	= S5P_PA_MFC,
+		.end	= S5P_PA_MFC + SZ_64K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_MFC,
+		.end	= IRQ_MFC,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s5p_device_mfc = {
+	.name		= "s5p-mfc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5p_mfc_resource),
+	.resource	= s5p_mfc_resource,
+};
+
+/*
+ * MFC hardware has 2 memory interfaces which are modelled as two separate
+ * platform devices to let dma-mapping distinguish between them.
+ *
+ * MFC parent device (s5p_device_mfc) must be registered before memory
+ * interface specific devices (s5p_device_mfc_l and s5p_device_mfc_r).
+ */
+
+struct platform_device s5p_device_mfc_l = {
+	.name		= "s5p-mfc-l",
+	.id		= -1,
+	.dev		= {
+		.parent			= &s5p_device_mfc.dev,
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+struct platform_device s5p_device_mfc_r = {
+	.name		= "s5p-mfc-r",
+	.id		= -1,
+	.dev		= {
+		.parent			= &s5p_device_mfc.dev,
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+#endif /* CONFIG_S5P_DEV_MFC */
+
+/* MIPI CSIS */
+
+#ifdef CONFIG_S5P_DEV_CSIS0
+static struct resource s5p_mipi_csis0_resource[] = {
+	[0] = {
+		.start	= S5P_PA_MIPI_CSIS0,
+		.end	= S5P_PA_MIPI_CSIS0 + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_MIPI_CSIS0,
+		.end	= IRQ_MIPI_CSIS0,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s5p_device_mipi_csis0 = {
+	.name		= "s5p-mipi-csis",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s5p_mipi_csis0_resource),
+	.resource	= s5p_mipi_csis0_resource,
+};
+#endif /* CONFIG_S5P_DEV_CSIS0 */
+
+#ifdef CONFIG_S5P_DEV_CSIS1
+static struct resource s5p_mipi_csis1_resource[] = {
+	[0] = {
+		.start	= S5P_PA_MIPI_CSIS1,
+		.end	= S5P_PA_MIPI_CSIS1 + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_MIPI_CSIS1,
+		.end	= IRQ_MIPI_CSIS1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s5p_device_mipi_csis1 = {
+	.name		= "s5p-mipi-csis",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(s5p_mipi_csis1_resource),
+	.resource	= s5p_mipi_csis1_resource,
+};
+#endif
+
 #ifdef CONFIG_S3C64XX_DEV_ONENAND1
 static struct resource s3c64xx_onenand1_resources[] = {
 	[0] = {
@@ -260,6 +559,57 @@ void s3c64xx_onenand1_set_platdata(struct onenand_platform_data *pdata)
 }
 #endif /* CONFIG_S3C64XX_DEV_ONENAND1 */
 
+#ifdef CONFIG_S5P_DEV_ONENAND
+static struct resource s5p_onenand_resources[] = {
+	[0] = {
+		.start	= S5P_PA_ONENAND,
+		.end	= S5P_PA_ONENAND + SZ_128K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= S5P_PA_ONENAND_DMA,
+		.end	= S5P_PA_ONENAND_DMA + SZ_8K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		.start	= IRQ_ONENAND_AUDI,
+		.end	= IRQ_ONENAND_AUDI,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s5p_device_onenand = {
+	.name		= "s5pc110-onenand",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5p_onenand_resources),
+	.resource	= s5p_onenand_resources,
+};
+#endif /* CONFIG_S5P_DEV_ONENAND */
+
+/* PMU */
+
+#ifdef CONFIG_PLAT_S5P
+static struct resource s5p_pmu_resource = {
+	.start	= IRQ_PMU,
+	.end	= IRQ_PMU,
+	.flags	= IORESOURCE_IRQ,
+};
+
+struct platform_device s5p_device_pmu = {
+	.name		= "arm-pmu",
+	.id		= ARM_PMU_DEVICE_CPU,
+	.num_resources	= 1,
+	.resource	= &s5p_pmu_resource,
+};
+
+static int __init s5p_pmu_init(void)
+{
+	platform_device_register(&s5p_device_pmu);
+	return 0;
+}
+arch_initcall(s5p_pmu_init);
+#endif /* CONFIG_PLAT_S5P */
+
 /* RTC */
 
 #ifdef CONFIG_PLAT_S3C24XX
@@ -403,6 +753,83 @@ void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *hard_s3c2410ts_
 }
 #endif /* CONFIG_PLAT_S3C24XX */
 
+/* TV */
+
+#ifdef CONFIG_S5P_DEV_TV
+
+static struct resource s5p_hdmi_resources[] = {
+	[0] = {
+		.start	= S5P_PA_HDMI,
+		.end	= S5P_PA_HDMI + SZ_1M - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_HDMI,
+		.end	= IRQ_HDMI,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s5p_device_hdmi = {
+	.name		= "s5p-hdmi",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5p_hdmi_resources),
+	.resource	= s5p_hdmi_resources,
+};
+
+static struct resource s5p_sdo_resources[] = {
+	[0] = {
+		.start	= S5P_PA_SDO,
+		.end	= S5P_PA_SDO + SZ_64K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_SDO,
+		.end	= IRQ_SDO,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s5p_device_sdo = {
+	.name		= "s5p-sdo",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5p_sdo_resources),
+	.resource	= s5p_sdo_resources,
+};
+
+static struct resource s5p_mixer_resources[] = {
+	[0] = {
+		.start	= S5P_PA_MIXER,
+		.end	= S5P_PA_MIXER + SZ_64K - 1,
+		.flags	= IORESOURCE_MEM,
+		.name	= "mxr"
+	},
+	[1] = {
+		.start	= S5P_PA_VP,
+		.end	= S5P_PA_VP + SZ_64K - 1,
+		.flags	= IORESOURCE_MEM,
+		.name	= "vp"
+	},
+	[2] = {
+		.start	= IRQ_MIXER,
+		.end	= IRQ_MIXER,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "irq"
+	}
+};
+
+struct platform_device s5p_device_mixer = {
+	.name		= "s5p-mixer",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5p_mixer_resources),
+	.resource	= s5p_mixer_resources,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+#endif /* CONFIG_S5P_DEV_TV */
+
 /* USB Device (Gadget) */
 
 #ifdef CONFIG_PLAT_S3C24XX
@@ -432,6 +859,47 @@ void __init s3c24xx_udc_set_platdata(struct s3c2410_udc_mach_info *pd)
 }
 #endif /* CONFIG_PLAT_S3C24XX */
 
+/* USB EHCI Host Controller */
+
+#ifdef CONFIG_S5P_DEV_USB_EHCI
+static struct resource s5p_ehci_resource[] = {
+	[0] = {
+		.start	= S5P_PA_EHCI,
+		.end	= S5P_PA_EHCI + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_USB_HOST,
+		.end	= IRQ_USB_HOST,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s5p_device_ehci = {
+	.name		= "s5p-ehci",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5p_ehci_resource),
+	.resource	= s5p_ehci_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+
+void __init s5p_ehci_set_platdata(struct s5p_ehci_platdata *pd)
+{
+	struct s5p_ehci_platdata *npd;
+
+	npd = s3c_set_platdata(pd, sizeof(struct s5p_ehci_platdata),
+			&s5p_device_ehci);
+
+	if (!npd->phy_init)
+		npd->phy_init = s5p_usb_phy_init;
+	if (!npd->phy_exit)
+		npd->phy_exit = s5p_usb_phy_exit;
+}
+#endif /* CONFIG_S5P_DEV_USB_EHCI */
+
 /* USB High Spped 2.0 Device (Gadget) */
 
 #ifdef CONFIG_PLAT_S3C24XX
-- 
1.7.1
