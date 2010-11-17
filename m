From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:04 +0100
Subject: [PATCH 36/51] ARM: mx25: dynamically allocate mx2-camera devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-36-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/Makefile                     |    2 +-
 arch/arm/mach-mx25/devices-imx25.h              |    4 ++
 arch/arm/mach-mx25/devices.c                    |   45 -----------------------
 arch/arm/mach-mx25/devices.h                    |    1 -
 arch/arm/plat-mxc/devices/platform-mx2-camera.c |   23 +++++++++---
 5 files changed, 22 insertions(+), 53 deletions(-)
 delete mode 100644 arch/arm/mach-mx25/devices.c

diff --git a/arch/arm/mach-mx25/Makefile b/arch/arm/mach-mx25/Makefile
index d9e46ce..f7f7648 100644
--- a/arch/arm/mach-mx25/Makefile
+++ b/arch/arm/mach-mx25/Makefile
@@ -1,4 +1,4 @@
-obj-y				:= mm.o devices.o
+obj-y				:= mm.o
 obj-$(CONFIG_ARCH_MX25)		+= clock.o
 obj-$(CONFIG_MACH_MX25_3DS)	+= mach-mx25_3ds.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX25)		+= mach-cpuimx25.o
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index bf70548..953e1ce 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -59,6 +59,10 @@ extern const struct imx_imx_uart_1irq_data imx25_imx_uart_data[] __initconst;
 #define imx25_add_imx_uart3(pdata)	imx25_add_imx_uart(3, pdata)
 #define imx25_add_imx_uart4(pdata)	imx25_add_imx_uart(4, pdata)
 
+extern const struct imx_mx2_camera_data imx25_mx2_camera_data __initconst;
+#define imx25_add_mx2_camera(pdata)	\
+	imx_add_mx2_camera(&imx25_mx2_camera_data, pdata)
+
 extern const struct imx_mxc_ehci_data imx25_mxc_ehci_otg_data __initconst;
 #define imx25_add_mxc_ehci_otg(pdata)	\
 	imx_add_mxc_ehci(&imx25_mxc_ehci_otg_data, pdata)
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
deleted file mode 100644
index 12f31ef..0000000
--- a/arch/arm/mach-mx25/devices.c
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * Copyright 2009 Sascha Hauer, <kernel@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor,
- * Boston, MA  02110-1301, USA.
- */
-
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/gpio.h>
-#include <mach/mx25.h>
-#include <mach/irqs.h>
-
-static struct resource mx25_csi_resources[] = {
-	{
-		.start	= MX25_CSI_BASE_ADDR,
-		.end	= MX25_CSI_BASE_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= MX25_INT_CSI,
-		.flags	= IORESOURCE_IRQ
-	},
-};
-
-struct platform_device mx25_csi_device = {
-	.name	= "mx2-camera",
-	.id	= 0,
-	.num_resources	= ARRAY_SIZE(mx25_csi_resources),
-	.resource	= mx25_csi_resources,
-	.dev		= {
-		.coherent_dma_mask = 0xffffffff,
-	},
-};
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index fbb75ff..e69de29 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -1 +0,0 @@
-extern struct platform_device mx25_csi_device;
diff --git a/arch/arm/plat-mxc/devices/platform-mx2-camera.c b/arch/arm/plat-mxc/devices/platform-mx2-camera.c
index a18c803..b3f4828 100644
--- a/arch/arm/plat-mxc/devices/platform-mx2-camera.c
+++ b/arch/arm/plat-mxc/devices/platform-mx2-camera.c
@@ -12,6 +12,12 @@
 #define imx_mx2_camera_data_entry_single(soc)				\
 	{								\
 		.iobasecsi = soc ## _CSI_BASE_ADDR,			\
+		.iosizecsi = SZ_4K,					\
+		.irqcsi = soc ## _INT_CSI,				\
+	}
+#define imx_mx2_camera_data_entry_single_emma(soc)			\
+	{								\
+		.iobasecsi = soc ## _CSI_BASE_ADDR,			\
 		.iosizecsi = SZ_32,					\
 		.irqcsi = soc ## _INT_CSI,				\
 		.iobaseemmaprp = soc ## _EMMAPRP_BASE_ADDR,		\
@@ -19,9 +25,14 @@
 		.irqemmaprp = soc ## _INT_EMMAPRP,			\
 	}
 
+#ifdef CONFIG_SOC_IMX25
+const struct imx_mx2_camera_data imx25_mx2_camera_data __initconst =
+	imx_mx2_camera_data_entry_single(MX25);
+#endif /* ifdef CONFIG_SOC_IMX25 */
+
 #ifdef CONFIG_SOC_IMX27
 const struct imx_mx2_camera_data imx27_mx2_camera_data __initconst =
-	imx_mx2_camera_data_entry_single(MX27);
+	imx_mx2_camera_data_entry_single_emma(MX27);
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
 struct platform_device *__init imx_add_mx2_camera(
@@ -34,20 +45,20 @@ struct platform_device *__init imx_add_mx2_camera(
 			.end = data->iobasecsi + data->iosizecsi - 1,
 			.flags = IORESOURCE_MEM,
 		}, {
-			.start = data->iobaseemmaprp,
-			.end = data->iobaseemmaprp + data->iosizeemmaprp - 1,
-			.flags = IORESOURCE_MEM,
-		}, {
 			.start = data->irqcsi,
 			.end = data->irqcsi,
 			.flags = IORESOURCE_IRQ,
 		}, {
+			.start = data->iobaseemmaprp,
+			.end = data->iobaseemmaprp + data->iosizeemmaprp - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
 			.start = data->irqemmaprp,
 			.end = data->irqemmaprp,
 			.flags = IORESOURCE_IRQ,
 		},
 	};
 	return imx_add_platform_device_dmamask("mx2-camera", 0,
-			res, ARRAY_SIZE(res),
+			res, data->iobaseemmaprp ? 4 : 2,
 			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
 }
-- 
1.7.2.3
