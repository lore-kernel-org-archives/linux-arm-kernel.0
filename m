From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 7 May 2012 19:42:11 +0200
Subject: [PATCH 3/5] ARM: S3C24XX: move plat-s3c24xx/dev-uart.c into common.c
In-Reply-To: <201205071939.37433.heiko@sntech.de>
References: <201205071939.37433.heiko@sntech.de>
Message-ID: <201205071942.12082.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The uart devices are used on all s3c24xx machines, so they can reside
in the common code for all machines.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/common.c   |   73 +++++++++++++++++++++++++++
 arch/arm/plat-s3c24xx/Makefile   |    1 -
 arch/arm/plat-s3c24xx/dev-uart.c |  100 --------------------------------------
 3 files changed, 73 insertions(+), 101 deletions(-)
 delete mode 100644 arch/arm/plat-s3c24xx/dev-uart.c

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 755d5f1..bf1cd36 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -876,3 +876,76 @@ struct syscore_ops s3c24xx_irq_syscore_ops = {
 	.suspend	= s3c24xx_irq_suspend,
 	.resume		= s3c24xx_irq_resume,
 };
+
+/* Serial port registrations */
+
+static struct resource s3c2410_uart0_resource[] = {
+	[0] = {
+		.start = S3C2410_PA_UART0,
+		.end   = S3C2410_PA_UART0 + 0x3fff,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_S3CUART_RX0,
+		.end   = IRQ_S3CUART_ERR0,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static struct resource s3c2410_uart1_resource[] = {
+	[0] = {
+		.start = S3C2410_PA_UART1,
+		.end   = S3C2410_PA_UART1 + 0x3fff,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_S3CUART_RX1,
+		.end   = IRQ_S3CUART_ERR1,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static struct resource s3c2410_uart2_resource[] = {
+	[0] = {
+		.start = S3C2410_PA_UART2,
+		.end   = S3C2410_PA_UART2 + 0x3fff,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_S3CUART_RX2,
+		.end   = IRQ_S3CUART_ERR2,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static struct resource s3c2410_uart3_resource[] = {
+	[0] = {
+		.start = S3C2443_PA_UART3,
+		.end   = S3C2443_PA_UART3 + 0x3fff,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_S3CUART_RX3,
+		.end   = IRQ_S3CUART_ERR3,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct s3c24xx_uart_resources s3c2410_uart_resources[] __initdata = {
+	[0] = {
+		.resources	= s3c2410_uart0_resource,
+		.nr_resources	= ARRAY_SIZE(s3c2410_uart0_resource),
+	},
+	[1] = {
+		.resources	= s3c2410_uart1_resource,
+		.nr_resources	= ARRAY_SIZE(s3c2410_uart1_resource),
+	},
+	[2] = {
+		.resources	= s3c2410_uart2_resource,
+		.nr_resources	= ARRAY_SIZE(s3c2410_uart2_resource),
+	},
+	[3] = {
+		.resources	= s3c2410_uart3_resource,
+		.nr_resources	= ARRAY_SIZE(s3c2410_uart3_resource),
+	},
+};
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index 4ed80f2..3b1d7b8 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -12,7 +12,6 @@ obj-				:=
 
 # Core files
 
-obj-y				+= dev-uart.o
 obj-y				+= clock.o
 obj-$(CONFIG_S3C24XX_DCLK)	+= clock-dclk.o
 
diff --git a/arch/arm/plat-s3c24xx/dev-uart.c b/arch/arm/plat-s3c24xx/dev-uart.c
deleted file mode 100644
index 9ab22e6..0000000
--- a/arch/arm/plat-s3c24xx/dev-uart.c
+++ /dev/null
@@ -1,100 +0,0 @@
-/* linux/arch/arm/plat-s3c24xx/dev-uart.c
- *
- * Copyright (c) 2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Base S3C24XX UART resource and platform device definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/serial_core.h>
-#include <linux/platform_device.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/irq.h>
-#include <mach/hardware.h>
-#include <mach/map.h>
-
-#include <plat/devs.h>
-#include <plat/regs-serial.h>
-
-/* Serial port registrations */
-
-static struct resource s3c2410_uart0_resource[] = {
-	[0] = {
-		.start = S3C2410_PA_UART0,
-		.end   = S3C2410_PA_UART0 + 0x3fff,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_S3CUART_RX0,
-		.end   = IRQ_S3CUART_ERR0,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-static struct resource s3c2410_uart1_resource[] = {
-	[0] = {
-		.start = S3C2410_PA_UART1,
-		.end   = S3C2410_PA_UART1 + 0x3fff,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_S3CUART_RX1,
-		.end   = IRQ_S3CUART_ERR1,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-static struct resource s3c2410_uart2_resource[] = {
-	[0] = {
-		.start = S3C2410_PA_UART2,
-		.end   = S3C2410_PA_UART2 + 0x3fff,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_S3CUART_RX2,
-		.end   = IRQ_S3CUART_ERR2,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-static struct resource s3c2410_uart3_resource[] = {
-	[0] = {
-		.start = S3C2443_PA_UART3,
-		.end   = S3C2443_PA_UART3 + 0x3fff,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_S3CUART_RX3,
-		.end   = IRQ_S3CUART_ERR3,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct s3c24xx_uart_resources s3c2410_uart_resources[] __initdata = {
-	[0] = {
-		.resources	= s3c2410_uart0_resource,
-		.nr_resources	= ARRAY_SIZE(s3c2410_uart0_resource),
-	},
-	[1] = {
-		.resources	= s3c2410_uart1_resource,
-		.nr_resources	= ARRAY_SIZE(s3c2410_uart1_resource),
-	},
-	[2] = {
-		.resources	= s3c2410_uart2_resource,
-		.nr_resources	= ARRAY_SIZE(s3c2410_uart2_resource),
-	},
-	[3] = {
-		.resources	= s3c2410_uart3_resource,
-		.nr_resources	= ARRAY_SIZE(s3c2410_uart3_resource),
-	},
-};
-- 
1.7.5.4
