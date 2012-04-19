From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Apr 2012 19:20:34 -0700
Subject: [PATCH 5/7] ARM: SAMSUNG: move platform device for s5p uart into
 plat-samsung
In-Reply-To: <1334802036-16768-1-git-send-email-kgene.kim@samsung.com>
References: <1334802036-16768-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1334802036-16768-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s5p/Kconfig                          |    4 -
 arch/arm/plat-s5p/Makefile                         |    1 -
 arch/arm/plat-samsung/Kconfig                      |    6 ++
 arch/arm/plat-samsung/Makefile                     |    1 +
 .../dev-uart.c => plat-samsung/s5p-dev-uart.c}     |   78 ++++----------------
 5 files changed, 22 insertions(+), 68 deletions(-)
 rename arch/arm/{plat-s5p/dev-uart.c => plat-samsung/s5p-dev-uart.c} (57%)

diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 795790d..33d9bc8 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -23,10 +23,6 @@ config PLAT_S5P
 	help
 	  Base platform code for Samsung's S5P series SoC.
 
-config S5P_DEV_UART
-	def_bool y
-	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210)
-
 config S5P_DEV_FIMC0
 	bool
 	help
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 0a2ce38..1dc6b1c 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -12,6 +12,5 @@ obj-				:=
 
 # devices
 
-obj-$(CONFIG_S5P_DEV_UART)	+= dev-uart.o
 obj-$(CONFIG_S5P_DEV_MFC)	+= dev-mfc.o
 obj-$(CONFIG_S5P_SETUP_MIPIPHY)	+= setup-mipiphy.o
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index f27b295..0f112a7 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -146,6 +146,12 @@ config S3C_GPIO_TRACK
 	  Internal configuration option to enable the s3c specific gpio
 	  chip tracking if the platform requires it.
 
+# uart options
+
+config S5P_DEV_UART
+	def_bool y
+	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210)
+
 # ADC driver
 
 config S3C_ADC
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 6217c41..b20047b 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -36,6 +36,7 @@ obj-y				+= platformdata.o
 
 obj-y				+= devs.o
 obj-y				+= dev-uart.o
+obj-$(CONFIG_S5P_DEV_UART)	+= s5p-dev-uart.o
 
 obj-$(CONFIG_SAMSUNG_DEV_BACKLIGHT)	+= dev-backlight.o
 
diff --git a/arch/arm/plat-s5p/dev-uart.c b/arch/arm/plat-samsung/s5p-dev-uart.c
similarity index 57%
rename from arch/arm/plat-s5p/dev-uart.c
rename to arch/arm/plat-samsung/s5p-dev-uart.c
index c9308db..cafa3de 100644
--- a/arch/arm/plat-s5p/dev-uart.c
+++ b/arch/arm/plat-samsung/s5p-dev-uart.c
@@ -1,6 +1,5 @@
-/* linux/arch/arm/plat-s5p/dev-uart.c
- *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+/*
+ * Copyright (c) 2009,2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
  * Base S5P UART resource and device definitions
@@ -14,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/ioport.h>
 #include <linux/platform_device.h>
 
 #include <asm/mach/arch.h>
@@ -26,86 +26,38 @@
  /* Serial port registrations */
 
 static struct resource s5p_uart0_resource[] = {
-	[0] = {
-		.start	= S5P_PA_UART0,
-		.end	= S5P_PA_UART0 + S5P_SZ_UART - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_UART0,
-		.end	= IRQ_UART0,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(S5P_PA_UART0, S5P_SZ_UART),
+	[1] = DEFINE_RES_IRQ(IRQ_UART0),
 };
 
 static struct resource s5p_uart1_resource[] = {
-	[0] = {
-		.start	= S5P_PA_UART1,
-		.end	= S5P_PA_UART1 + S5P_SZ_UART - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_UART1,
-		.end	= IRQ_UART1,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(S5P_PA_UART1, S5P_SZ_UART),
+	[1] = DEFINE_RES_IRQ(IRQ_UART1),
 };
 
 static struct resource s5p_uart2_resource[] = {
-	[0] = {
-		.start	= S5P_PA_UART2,
-		.end	= S5P_PA_UART2 + S5P_SZ_UART - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_UART2,
-		.end	= IRQ_UART2,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(S5P_PA_UART2, S5P_SZ_UART),
+	[1] = DEFINE_RES_IRQ(IRQ_UART2),
 };
 
 static struct resource s5p_uart3_resource[] = {
 #if CONFIG_SERIAL_SAMSUNG_UARTS > 3
-	[0] = {
-		.start	= S5P_PA_UART3,
-		.end	= S5P_PA_UART3 + S5P_SZ_UART - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_UART3,
-		.end	= IRQ_UART3,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(S5P_PA_UART3, S5P_SZ_UART),
+	[1] = DEFINE_RES_IRQ(IRQ_UART3),
 #endif
 };
 
 static struct resource s5p_uart4_resource[] = {
 #if CONFIG_SERIAL_SAMSUNG_UARTS > 4
-	[0] = {
-		.start	= S5P_PA_UART4,
-		.end	= S5P_PA_UART4 + S5P_SZ_UART - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_UART4,
-		.end	= IRQ_UART4,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(S5P_PA_UART4, S5P_SZ_UART),
+	[1] = DEFINE_RES_IRQ(IRQ_UART4),
 #endif
 };
 
 static struct resource s5p_uart5_resource[] = {
 #if CONFIG_SERIAL_SAMSUNG_UARTS > 5
-	[0] = {
-		.start	= S5P_PA_UART5,
-		.end	= S5P_PA_UART5 + S5P_SZ_UART - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_UART5,
-		.end	= IRQ_UART5,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(S5P_PA_UART5, S5P_SZ_UART),
+	[1] = DEFINE_RES_IRQ(IRQ_UART5),
 #endif
 };
 
-- 
1.7.2.3
