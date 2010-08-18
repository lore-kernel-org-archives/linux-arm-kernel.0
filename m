From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 18 Aug 2010 18:20:24 +0200
Subject: [PATCH|RESEND 1/2] mx35_3ds: add physmap-flash NOR at CS0
In-Reply-To: <1282146406-2901-2-git-send-email-m.grzeschik@pengutronix.de>
References: <1282146406-2901-2-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1282148424-8769-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

The mx35_3ds comes with 64 MiByte for NOR flash at CS0, add physmap-flash
platform device for it.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/mach-mx3/mach-mx35_3ds.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index 1c30d72..73149b8 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -1,5 +1,6 @@
 /*
  * Copyright 2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright (C) 2009 Marc Kleine-Budde, Pengutronix
  *
  * Author: Fabio Estevam <fabio.estevam@freescale.com>
  *
@@ -27,6 +28,8 @@
 #include <linux/gpio.h>
 #include <linux/fsl_devices.h>
 
+#include <linux/mtd/physmap.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -43,8 +46,29 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
+static struct physmap_flash_data mx35pdk_flash_data = {
+	.width  = 2,
+};
+
+static struct resource mx35pdk_flash_resource = {
+	.start	= MX35_CS0_BASE_ADDR,
+	.end	= MX35_CS0_BASE_ADDR + SZ_64M - 1,
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct platform_device mx35pdk_flash = {
+	.name	= "physmap-flash",
+	.id	= 0,
+	.dev	= {
+		.platform_data  = &mx35pdk_flash_data,
+	},
+	.resource = &mx35pdk_flash_resource,
+	.num_resources = 1,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&mxc_fec_device,
+	&mx35pdk_flash,
 };
 
 static struct pad_desc mx35pdk_pads[] = {
-- 
1.7.1
