From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 06 Oct 2011 15:29:41 +0900
Subject: [PATCH RE-SEND 1/5] ARM: S3C24XX: To merge s3c24xx devs.c files to one
	devs.c
Message-ID: <00e701cc83f1$54782a20$fd687e60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves regarding s3c24xx dev files to one devs.c
file in plat-samsung directory and this is required to merge
to plat-samsung.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2410/include/mach/fb.h         |   75 +----
 arch/arm/mach-s3c2410/mach-qt2410.c             |    1 +
 arch/arm/mach-s3c2440/mach-rx1950.c             |    1 +
 arch/arm/plat-s3c24xx/Makefile                  |    2 +-
 arch/arm/plat-s3c24xx/dev-uart.c                |  100 +++++
 arch/arm/plat-s3c24xx/devs.c                    |  528 -----------------------
 arch/arm/plat-samsung/Makefile                  |    3 +-
 arch/arm/plat-samsung/devs.c                    |  431 ++++++++++++++++++
 arch/arm/plat-samsung/include/plat/fb-s3c2410.h |   72 +++
 9 files changed, 609 insertions(+), 604 deletions(-)
 create mode 100644 arch/arm/plat-s3c24xx/dev-uart.c
 delete mode 100644 arch/arm/plat-s3c24xx/devs.c
 create mode 100644 arch/arm/plat-samsung/devs.c
 create mode 100644 arch/arm/plat-samsung/include/plat/fb-s3c2410.h

diff --git a/arch/arm/mach-s3c2410/include/mach/fb.h b/arch/arm/mach-s3c2410/include/mach/fb.h
index eee0654..a957bc8 100644
--- a/arch/arm/mach-s3c2410/include/mach/fb.h
+++ b/arch/arm/mach-s3c2410/include/mach/fb.h
@@ -1,74 +1 @@
-/* arch/arm/mach-s3c2410/include/mach/fb.h
- *
- * Copyright (c) 2004 Arnaud Patard <arnaud.patard@rtp-net.org>
- *
- * Inspired by pxafb.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARM_FB_H
-#define __ASM_ARM_FB_H
-
-#include <mach/regs-lcd.h>
-
-struct s3c2410fb_hw {
-	unsigned long	lcdcon1;
-	unsigned long	lcdcon2;
-	unsigned long	lcdcon3;
-	unsigned long	lcdcon4;
-	unsigned long	lcdcon5;
-};
-
-/* LCD description */
-struct s3c2410fb_display {
-	/* LCD type */
-	unsigned type;
-
-	/* Screen size */
-	unsigned short width;
-	unsigned short height;
-
-	/* Screen info */
-	unsigned short xres;
-	unsigned short yres;
-	unsigned short bpp;
-
-	unsigned pixclock;		/* pixclock in picoseconds */
-	unsigned short left_margin;  /* value in pixels (TFT) or HCLKs (STN) */
-	unsigned short right_margin; /* value in pixels (TFT) or HCLKs (STN) */
-	unsigned short hsync_len;    /* value in pixels (TFT) or HCLKs (STN) */
-	unsigned short upper_margin;	/* value in lines (TFT) or 0 (STN) */
-	unsigned short lower_margin;	/* value in lines (TFT) or 0 (STN) */
-	unsigned short vsync_len;	/* value in lines (TFT) or 0 (STN) */
-
-	/* lcd configuration registers */
-	unsigned long	lcdcon5;
-};
-
-struct s3c2410fb_mach_info {
-
-	struct s3c2410fb_display *displays;	/* attached diplays info */
-	unsigned num_displays;			/* number of defined displays */
-	unsigned default_display;
-
-	/* GPIOs */
-
-	unsigned long	gpcup;
-	unsigned long	gpcup_mask;
-	unsigned long	gpccon;
-	unsigned long	gpccon_mask;
-	unsigned long	gpdup;
-	unsigned long	gpdup_mask;
-	unsigned long	gpdcon;
-	unsigned long	gpdcon_mask;
-
-	/* lpc3600 control register */
-	unsigned long	lpcsel;
-};
-
-extern void __init s3c24xx_fb_set_platdata(struct s3c2410fb_mach_info *);
-
-#endif /* __ASM_ARM_FB_H */
+#include <plat/fb-s3c2410.h>
diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
index f44f775..8ee6f43 100644
--- a/arch/arm/mach-s3c2410/mach-qt2410.c
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c
@@ -49,6 +49,7 @@
 
 #include <mach/regs-gpio.h>
 #include <mach/leds-gpio.h>
+#include <mach/regs-lcd.h>
 #include <plat/regs-serial.h>
 #include <mach/fb.h>
 #include <plat/nand.h>
diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 27ea950..3210299 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -43,6 +43,7 @@
 
 #include <mach/regs-gpio.h>
 #include <mach/regs-gpioj.h>
+#include <mach/regs-lcd.h>
 #include <mach/h1940.h>
 #include <mach/fb.h>
 
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index e4f4649..b2b0112 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -14,7 +14,7 @@ obj-				:=
 
 obj-y				+= cpu.o
 obj-y				+= irq.o
-obj-y				+= devs.o
+obj-y				+= dev-uart.o
 obj-y				+= clock.o
 obj-$(CONFIG_S3C24XX_DCLK)	+= clock-dclk.o
 
diff --git a/arch/arm/plat-s3c24xx/dev-uart.c b/arch/arm/plat-s3c24xx/dev-uart.c
new file mode 100644
index 0000000..9ab22e6
--- /dev/null
+++ b/arch/arm/plat-s3c24xx/dev-uart.c
@@ -0,0 +1,100 @@
+/* linux/arch/arm/plat-s3c24xx/dev-uart.c
+ *
+ * Copyright (c) 2004 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Base S3C24XX UART resource and platform device definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/serial_core.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+#include <mach/hardware.h>
+#include <mach/map.h>
+
+#include <plat/devs.h>
+#include <plat/regs-serial.h>
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
diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
deleted file mode 100644
index a76bf2d..0000000
--- a/arch/arm/plat-s3c24xx/devs.c
+++ /dev/null
@@ -1,528 +0,0 @@
-/* linux/arch/arm/plat-s3c24xx/devs.c
- *
- * Copyright (c) 2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Base S3C24XX platform device definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/timer.h>
-#include <linux/init.h>
-#include <linux/serial_core.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/dma-mapping.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/irq.h>
-#include <mach/fb.h>
-#include <mach/hardware.h>
-#include <mach/dma.h>
-#include <mach/irqs.h>
-#include <asm/irq.h>
-
-#include <plat/regs-serial.h>
-#include <plat/udc.h>
-#include <plat/mci.h>
-
-#include <plat/devs.h>
-#include <plat/cpu.h>
-#include <plat/regs-spi.h>
-#include <plat/ts.h>
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
-
-/* LCD Controller */
-
-static struct resource s3c_lcd_resource[] = {
-	[0] = {
-		.start = S3C24XX_PA_LCD,
-		.end   = S3C24XX_PA_LCD + S3C24XX_SZ_LCD - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_LCD,
-		.end   = IRQ_LCD,
-		.flags = IORESOURCE_IRQ,
-	}
-
-};
-
-static u64 s3c_device_lcd_dmamask = 0xffffffffUL;
-
-struct platform_device s3c_device_lcd = {
-	.name		  = "s3c2410-lcd",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c_lcd_resource),
-	.resource	  = s3c_lcd_resource,
-	.dev              = {
-		.dma_mask		= &s3c_device_lcd_dmamask,
-		.coherent_dma_mask	= 0xffffffffUL
-	}
-};
-
-EXPORT_SYMBOL(s3c_device_lcd);
-
-void __init s3c24xx_fb_set_platdata(struct s3c2410fb_mach_info *pd)
-{
-	struct s3c2410fb_mach_info *npd;
-
-	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_lcd);
-	if (npd) {
-		npd->displays = kmemdup(pd->displays,
-			sizeof(struct s3c2410fb_display) * npd->num_displays,
-			GFP_KERNEL);
-		if (!npd->displays)
-			printk(KERN_ERR "no memory for LCD display data\n");
-	} else {
-		printk(KERN_ERR "no memory for LCD platform data\n");
-	}
-}
-
-/* Touchscreen */
-
-static struct resource s3c_ts_resource[] = {
-	[0] = {
-		.start = S3C24XX_PA_ADC,
-		.end   = S3C24XX_PA_ADC + S3C24XX_SZ_ADC - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_TC,
-		.end   = IRQ_TC,
-		.flags = IORESOURCE_IRQ,
-	},
-
-};
-
-struct platform_device s3c_device_ts = {
-	.name		  = "s3c2410-ts",
-	.id		  = -1,
-	.dev.parent	= &s3c_device_adc.dev,
-	.num_resources	  = ARRAY_SIZE(s3c_ts_resource),
-	.resource	  = s3c_ts_resource,
-};
-EXPORT_SYMBOL(s3c_device_ts);
-
-void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *hard_s3c2410ts_info)
-{
-	s3c_set_platdata(hard_s3c2410ts_info,
-			 sizeof(struct s3c2410_ts_mach_info), &s3c_device_ts);
-}
-
-/* USB Device (Gadget)*/
-
-static struct resource s3c_usbgadget_resource[] = {
-	[0] = {
-		.start = S3C24XX_PA_USBDEV,
-		.end   = S3C24XX_PA_USBDEV + S3C24XX_SZ_USBDEV - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_USBD,
-		.end   = IRQ_USBD,
-		.flags = IORESOURCE_IRQ,
-	}
-
-};
-
-struct platform_device s3c_device_usbgadget = {
-	.name		  = "s3c2410-usbgadget",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c_usbgadget_resource),
-	.resource	  = s3c_usbgadget_resource,
-};
-
-EXPORT_SYMBOL(s3c_device_usbgadget);
-
-void __init s3c24xx_udc_set_platdata(struct s3c2410_udc_mach_info *pd)
-{
-	s3c_set_platdata(pd, sizeof(*pd), &s3c_device_usbgadget);
-}
-
-/* USB High Speed 2.0 Device (Gadget) */
-static struct resource s3c_hsudc_resource[] = {
-	[0] = {
-		.start	= S3C2416_PA_HSUDC,
-		.end	= S3C2416_PA_HSUDC + S3C2416_SZ_HSUDC - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_USBD,
-		.end	= IRQ_USBD,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static u64 s3c_hsudc_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device s3c_device_usb_hsudc = {
-	.name		= "s3c-hsudc",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_hsudc_resource),
-	.resource	= s3c_hsudc_resource,
-	.dev		= {
-		.dma_mask		= &s3c_hsudc_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-void __init s3c24xx_hsudc_set_platdata(struct s3c24xx_hsudc_platdata *pd)
-{
-	s3c_set_platdata(pd, sizeof(*pd), &s3c_device_usb_hsudc);
-}
-
-/* IIS */
-
-static struct resource s3c_iis_resource[] = {
-	[0] = {
-		.start = S3C24XX_PA_IIS,
-		.end   = S3C24XX_PA_IIS + S3C24XX_SZ_IIS -1,
-		.flags = IORESOURCE_MEM,
-	}
-};
-
-static u64 s3c_device_iis_dmamask = 0xffffffffUL;
-
-struct platform_device s3c_device_iis = {
-	.name		  = "s3c24xx-iis",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c_iis_resource),
-	.resource	  = s3c_iis_resource,
-	.dev              = {
-		.dma_mask = &s3c_device_iis_dmamask,
-		.coherent_dma_mask = 0xffffffffUL
-	}
-};
-
-EXPORT_SYMBOL(s3c_device_iis);
-
-/* RTC */
-
-static struct resource s3c_rtc_resource[] = {
-	[0] = {
-		.start = S3C24XX_PA_RTC,
-		.end   = S3C24XX_PA_RTC + 0xff,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_RTC,
-		.end   = IRQ_RTC,
-		.flags = IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start = IRQ_TICK,
-		.end   = IRQ_TICK,
-		.flags = IORESOURCE_IRQ
-	}
-};
-
-struct platform_device s3c_device_rtc = {
-	.name		  = "s3c2410-rtc",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c_rtc_resource),
-	.resource	  = s3c_rtc_resource,
-};
-
-EXPORT_SYMBOL(s3c_device_rtc);
-
-/* ADC */
-
-static struct resource s3c_adc_resource[] = {
-	[0] = {
-		.start = S3C24XX_PA_ADC,
-		.end   = S3C24XX_PA_ADC + S3C24XX_SZ_ADC - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_TC,
-		.end   = IRQ_TC,
-		.flags = IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start = IRQ_ADC,
-		.end   = IRQ_ADC,
-		.flags = IORESOURCE_IRQ,
-	}
-
-};
-
-struct platform_device s3c_device_adc = {
-	.name		  = "s3c24xx-adc",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c_adc_resource),
-	.resource	  = s3c_adc_resource,
-};
-
-/* SDI */
-
-static struct resource s3c_sdi_resource[] = {
-	[0] = {
-		.start = S3C24XX_PA_SDI,
-		.end   = S3C24XX_PA_SDI + S3C24XX_SZ_SDI - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_SDI,
-		.end   = IRQ_SDI,
-		.flags = IORESOURCE_IRQ,
-	}
-
-};
-
-struct platform_device s3c_device_sdi = {
-	.name		  = "s3c2410-sdi",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c_sdi_resource),
-	.resource	  = s3c_sdi_resource,
-};
-
-EXPORT_SYMBOL(s3c_device_sdi);
-
-void __init s3c24xx_mci_set_platdata(struct s3c24xx_mci_pdata *pdata)
-{
-	s3c_set_platdata(pdata, sizeof(struct s3c24xx_mci_pdata),
-			 &s3c_device_sdi);
-}
-
-
-/* SPI (0) */
-
-static struct resource s3c_spi0_resource[] = {
-	[0] = {
-		.start = S3C24XX_PA_SPI,
-		.end   = S3C24XX_PA_SPI + 0x1f,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_SPI0,
-		.end   = IRQ_SPI0,
-		.flags = IORESOURCE_IRQ,
-	}
-
-};
-
-static u64 s3c_device_spi0_dmamask = 0xffffffffUL;
-
-struct platform_device s3c_device_spi0 = {
-	.name		  = "s3c2410-spi",
-	.id		  = 0,
-	.num_resources	  = ARRAY_SIZE(s3c_spi0_resource),
-	.resource	  = s3c_spi0_resource,
-        .dev              = {
-                .dma_mask = &s3c_device_spi0_dmamask,
-                .coherent_dma_mask = 0xffffffffUL
-        }
-};
-
-EXPORT_SYMBOL(s3c_device_spi0);
-
-/* SPI (1) */
-
-static struct resource s3c_spi1_resource[] = {
-	[0] = {
-		.start = S3C24XX_PA_SPI + S3C2410_SPI1,
-		.end   = S3C24XX_PA_SPI + S3C2410_SPI1 + 0x1f,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_SPI1,
-		.end   = IRQ_SPI1,
-		.flags = IORESOURCE_IRQ,
-	}
-
-};
-
-static u64 s3c_device_spi1_dmamask = 0xffffffffUL;
-
-struct platform_device s3c_device_spi1 = {
-	.name		  = "s3c2410-spi",
-	.id		  = 1,
-	.num_resources	  = ARRAY_SIZE(s3c_spi1_resource),
-	.resource	  = s3c_spi1_resource,
-        .dev              = {
-                .dma_mask = &s3c_device_spi1_dmamask,
-                .coherent_dma_mask = 0xffffffffUL
-        }
-};
-
-EXPORT_SYMBOL(s3c_device_spi1);
-
-#ifdef CONFIG_CPU_S3C2440
-
-/* Camif Controller */
-
-static struct resource s3c_camif_resource[] = {
-	[0] = {
-		.start = S3C2440_PA_CAMIF,
-		.end   = S3C2440_PA_CAMIF + S3C2440_SZ_CAMIF - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_CAM,
-		.end   = IRQ_CAM,
-		.flags = IORESOURCE_IRQ,
-	}
-
-};
-
-static u64 s3c_device_camif_dmamask = 0xffffffffUL;
-
-struct platform_device s3c_device_camif = {
-	.name		  = "s3c2440-camif",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c_camif_resource),
-	.resource	  = s3c_camif_resource,
-	.dev              = {
-		.dma_mask = &s3c_device_camif_dmamask,
-		.coherent_dma_mask = 0xffffffffUL
-	}
-};
-
-EXPORT_SYMBOL(s3c_device_camif);
-
-/* AC97 */
-
-static struct resource s3c_ac97_resource[] = {
-	[0] = {
-		.start = S3C2440_PA_AC97,
-		.end   = S3C2440_PA_AC97 + S3C2440_SZ_AC97 -1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_S3C244x_AC97,
-		.end   = IRQ_S3C244x_AC97,
-		.flags = IORESOURCE_IRQ,
-	},
-	[2] = {
-		.name  = "PCM out",
-		.start = DMACH_PCM_OUT,
-		.end   = DMACH_PCM_OUT,
-		.flags = IORESOURCE_DMA,
-	},
-	[3] = {
-		.name  = "PCM in",
-		.start = DMACH_PCM_IN,
-		.end   = DMACH_PCM_IN,
-		.flags = IORESOURCE_DMA,
-	},
-	[4] = {
-		.name  = "Mic in",
-		.start = DMACH_MIC_IN,
-		.end   = DMACH_MIC_IN,
-		.flags = IORESOURCE_DMA,
-	},
-};
-
-static u64 s3c_device_audio_dmamask = 0xffffffffUL;
-
-struct platform_device s3c_device_ac97 = {
-	.name		  = "samsung-ac97",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c_ac97_resource),
-	.resource	  = s3c_ac97_resource,
-	.dev              = {
-		.dma_mask = &s3c_device_audio_dmamask,
-		.coherent_dma_mask = 0xffffffffUL
-	}
-};
-
-EXPORT_SYMBOL(s3c_device_ac97);
-
-/* ASoC I2S */
-
-struct platform_device s3c2412_device_iis = {
-	.name		  = "s3c2412-iis",
-	.id		  = -1,
-	.dev              = {
-		.dma_mask = &s3c_device_audio_dmamask,
-		.coherent_dma_mask = 0xffffffffUL
-	}
-};
-
-EXPORT_SYMBOL(s3c2412_device_iis);
-
-#endif // CONFIG_CPU_S32440
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 5a54354..410a090 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -1,4 +1,4 @@
-# arch/arm/plat-s3c64xx/Makefile
+# arch/arm/plat-samsung/Makefile
 #
 # Copyright 2009 Simtec Electronics
 #
@@ -30,6 +30,7 @@ obj-$(CONFIG_S3C_ADC)	+= adc.o
 
 obj-y				+= platformdata.o
 
+obj-y				+= devs.o
 obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
 obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
 obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
new file mode 100644
index 0000000..f87bc98
--- /dev/null
+++ b/arch/arm/plat-samsung/devs.c
@@ -0,0 +1,431 @@
+/* linux/arch/arm/plat-samsung/devs.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Base SAMSUNG platform device definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/timer.h>
+#include <linux/init.h>
+#include <linux/serial_core.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/irq.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <mach/hardware.h>
+#include <mach/dma.h>
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+#include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/fb.h>
+#include <plat/fb-s3c2410.h>
+#include <plat/mci.h>
+#include <plat/ts.h>
+#include <plat/udc.h>
+#include <plat/regs-serial.h>
+#include <plat/regs-spi.h>
+
+static u64 samsung_device_dma_mask = DMA_BIT_MASK(32);
+
+/* AC97 */
+#ifdef CONFIG_CPU_S3C2440
+static struct resource s3c_ac97_resource[] = {
+	[0] = {
+		.start	= S3C2440_PA_AC97,
+		.end	= S3C2440_PA_AC97 + S3C2440_SZ_AC97 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_S3C244x_AC97,
+		.end	= IRQ_S3C244x_AC97,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.name	= "PCM out",
+		.start	= DMACH_PCM_OUT,
+		.end	= DMACH_PCM_OUT,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.name	= "PCM in",
+		.start	= DMACH_PCM_IN,
+		.end	= DMACH_PCM_IN,
+		.flags	= IORESOURCE_DMA,
+	},
+	[4] = {
+		.name	= "Mic in",
+		.start	= DMACH_MIC_IN,
+		.end	= DMACH_MIC_IN,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+struct platform_device s3c_device_ac97 = {
+	.name		= "samsung-ac97",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_ac97_resource),
+	.resource	= s3c_ac97_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+#endif /* CONFIG_CPU_S3C2440 */
+
+/* ADC */
+
+#ifdef CONFIG_PLAT_S3C24XX
+static struct resource s3c_adc_resource[] = {
+	[0] = {
+		.start	= S3C24XX_PA_ADC,
+		.end	= S3C24XX_PA_ADC + S3C24XX_SZ_ADC - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_TC,
+		.end	= IRQ_TC,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= IRQ_ADC,
+		.end	= IRQ_ADC,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s3c_device_adc = {
+	.name		= "s3c24xx-adc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_adc_resource),
+	.resource	= s3c_adc_resource,
+};
+#endif /* CONFIG_PLAT_S3C24XX */
+
+/* Camif Controller */
+
+#ifdef CONFIG_CPU_S3C2440
+static struct resource s3c_camif_resource[] = {
+	[0] = {
+		.start	= S3C2440_PA_CAMIF,
+		.end	= S3C2440_PA_CAMIF + S3C2440_SZ_CAMIF - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_CAM,
+		.end	= IRQ_CAM,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s3c_device_camif = {
+	.name		= "s3c2440-camif",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_camif_resource),
+	.resource	= s3c_camif_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+#endif /* CONFIG_CPU_S3C2440 */
+
+/* I2S */
+
+#ifdef CONFIG_PLAT_S3C24XX
+static struct resource s3c_iis_resource[] = {
+	[0] = {
+		.start	= S3C24XX_PA_IIS,
+		.end	= S3C24XX_PA_IIS + S3C24XX_SZ_IIS - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+struct platform_device s3c_device_iis = {
+	.name		= "s3c24xx-iis",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_iis_resource),
+	.resource	= s3c_iis_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+#endif /* CONFIG_PLAT_S3C24XX */
+
+#ifdef CONFIG_CPU_S3C2440
+struct platform_device s3c2412_device_iis = {
+	.name		= "s3c2412-iis",
+	.id		= -1,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+#endif /* CONFIG_CPU_S3C2440 */
+
+/* LCD Controller */
+
+#ifdef CONFIG_PLAT_S3C24XX
+static struct resource s3c_lcd_resource[] = {
+	[0] = {
+		.start	= S3C24XX_PA_LCD,
+		.end	= S3C24XX_PA_LCD + S3C24XX_SZ_LCD - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_LCD,
+		.end	= IRQ_LCD,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s3c_device_lcd = {
+	.name		= "s3c2410-lcd",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_lcd_resource),
+	.resource	= s3c_lcd_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+
+void __init s3c24xx_fb_set_platdata(struct s3c2410fb_mach_info *pd)
+{
+	struct s3c2410fb_mach_info *npd;
+
+	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_lcd);
+	if (npd) {
+		npd->displays = kmemdup(pd->displays,
+			sizeof(struct s3c2410fb_display) * npd->num_displays,
+			GFP_KERNEL);
+		if (!npd->displays)
+			printk(KERN_ERR "no memory for LCD display data\n");
+	} else {
+		printk(KERN_ERR "no memory for LCD platform data\n");
+	}
+}
+#endif /* CONFIG_PLAT_S3C24XX */
+
+/* RTC */
+
+#ifdef CONFIG_PLAT_S3C24XX
+static struct resource s3c_rtc_resource[] = {
+	[0] = {
+		.start	= S3C24XX_PA_RTC,
+		.end	= S3C24XX_PA_RTC + 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_RTC,
+		.end	= IRQ_RTC,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= IRQ_TICK,
+		.end	= IRQ_TICK,
+		.flags	= IORESOURCE_IRQ
+	}
+};
+
+struct platform_device s3c_device_rtc = {
+	.name		= "s3c2410-rtc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_rtc_resource),
+	.resource	= s3c_rtc_resource,
+};
+#endif /* CONFIG_PLAT_S3C24XX */
+
+/* SDI */
+
+#ifdef CONFIG_PLAT_S3C24XX
+static struct resource s3c_sdi_resource[] = {
+	[0] = {
+		.start	= S3C24XX_PA_SDI,
+		.end	= S3C24XX_PA_SDI + S3C24XX_SZ_SDI - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_SDI,
+		.end	= IRQ_SDI,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s3c_device_sdi = {
+	.name		= "s3c2410-sdi",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_sdi_resource),
+	.resource	= s3c_sdi_resource,
+};
+
+void __init s3c24xx_mci_set_platdata(struct s3c24xx_mci_pdata *pdata)
+{
+	s3c_set_platdata(pdata, sizeof(struct s3c24xx_mci_pdata),
+			 &s3c_device_sdi);
+}
+#endif /* CONFIG_PLAT_S3C24XX */
+
+/* SPI */
+
+#ifdef CONFIG_PLAT_S3C24XX
+static struct resource s3c_spi0_resource[] = {
+	[0] = {
+		.start	= S3C24XX_PA_SPI,
+		.end	= S3C24XX_PA_SPI + 0x1f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_SPI0,
+		.end	= IRQ_SPI0,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s3c_device_spi0 = {
+	.name		= "s3c2410-spi",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s3c_spi0_resource),
+	.resource	= s3c_spi0_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+
+static struct resource s3c_spi1_resource[] = {
+	[0] = {
+		.start	= S3C24XX_PA_SPI + S3C2410_SPI1,
+		.end	= S3C24XX_PA_SPI + S3C2410_SPI1 + 0x1f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_SPI1,
+		.end	= IRQ_SPI1,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s3c_device_spi1 = {
+	.name		= "s3c2410-spi",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(s3c_spi1_resource),
+	.resource	= s3c_spi1_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+#endif /* CONFIG_PLAT_S3C24XX */
+
+/* Touchscreen */
+
+#ifdef CONFIG_PLAT_S3C24XX
+static struct resource s3c_ts_resource[] = {
+	[0] = {
+		.start	= S3C24XX_PA_ADC,
+		.end	= S3C24XX_PA_ADC + S3C24XX_SZ_ADC - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_TC,
+		.end	= IRQ_TC,
+		.flags	= IORESOURCE_IRQ,
+	},
+
+};
+
+struct platform_device s3c_device_ts = {
+	.name		= "s3c2410-ts",
+	.id		= -1,
+	.dev.parent	= &s3c_device_adc.dev,
+	.num_resources	= ARRAY_SIZE(s3c_ts_resource),
+	.resource	= s3c_ts_resource,
+};
+
+void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *hard_s3c2410ts_info)
+{
+	s3c_set_platdata(hard_s3c2410ts_info,
+			 sizeof(struct s3c2410_ts_mach_info), &s3c_device_ts);
+}
+#endif /* CONFIG_PLAT_S3C24XX */
+
+/* USB Device (Gadget) */
+
+#ifdef CONFIG_PLAT_S3C24XX
+static struct resource s3c_usbgadget_resource[] = {
+	[0] = {
+		.start	= S3C24XX_PA_USBDEV,
+		.end	= S3C24XX_PA_USBDEV + S3C24XX_SZ_USBDEV - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_USBD,
+		.end	= IRQ_USBD,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s3c_device_usbgadget = {
+	.name		= "s3c2410-usbgadget",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_usbgadget_resource),
+	.resource	= s3c_usbgadget_resource,
+};
+
+void __init s3c24xx_udc_set_platdata(struct s3c2410_udc_mach_info *pd)
+{
+	s3c_set_platdata(pd, sizeof(*pd), &s3c_device_usbgadget);
+}
+#endif /* CONFIG_PLAT_S3C24XX */
+
+/* USB High Spped 2.0 Device (Gadget) */
+
+#ifdef CONFIG_PLAT_S3C24XX
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
+struct platform_device s3c_device_usb_hsudc = {
+	.name		= "s3c-hsudc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_hsudc_resource),
+	.resource	= s3c_hsudc_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init s3c24xx_hsudc_set_platdata(struct s3c24xx_hsudc_platdata *pd)
+{
+	s3c_set_platdata(pd, sizeof(*pd), &s3c_device_usb_hsudc);
+}
+#endif /* CONFIG_PLAT_S3C24XX */
diff --git a/arch/arm/plat-samsung/include/plat/fb-s3c2410.h b/arch/arm/plat-samsung/include/plat/fb-s3c2410.h
new file mode 100644
index 0000000..4e5d958
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/fb-s3c2410.h
@@ -0,0 +1,72 @@
+/* arch/arm/plat-samsung/include/plat/fb-s3c2410.h
+ *
+ * Copyright (c) 2004 Arnaud Patard <arnaud.patard@rtp-net.org>
+ *
+ * Inspired by pxafb.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_PLAT_FB_S3C2410_H
+#define __ASM_PLAT_FB_S3C2410_H __FILE__
+
+struct s3c2410fb_hw {
+	unsigned long	lcdcon1;
+	unsigned long	lcdcon2;
+	unsigned long	lcdcon3;
+	unsigned long	lcdcon4;
+	unsigned long	lcdcon5;
+};
+
+/* LCD description */
+struct s3c2410fb_display {
+	/* LCD type */
+	unsigned type;
+
+	/* Screen size */
+	unsigned short width;
+	unsigned short height;
+
+	/* Screen info */
+	unsigned short xres;
+	unsigned short yres;
+	unsigned short bpp;
+
+	unsigned pixclock;		/* pixclock in picoseconds */
+	unsigned short left_margin;  /* value in pixels (TFT) or HCLKs (STN) */
+	unsigned short right_margin; /* value in pixels (TFT) or HCLKs (STN) */
+	unsigned short hsync_len;    /* value in pixels (TFT) or HCLKs (STN) */
+	unsigned short upper_margin;	/* value in lines (TFT) or 0 (STN) */
+	unsigned short lower_margin;	/* value in lines (TFT) or 0 (STN) */
+	unsigned short vsync_len;	/* value in lines (TFT) or 0 (STN) */
+
+	/* lcd configuration registers */
+	unsigned long	lcdcon5;
+};
+
+struct s3c2410fb_mach_info {
+
+	struct s3c2410fb_display *displays;	/* attached diplays info */
+	unsigned num_displays;			/* number of defined displays */
+	unsigned default_display;
+
+	/* GPIOs */
+
+	unsigned long	gpcup;
+	unsigned long	gpcup_mask;
+	unsigned long	gpccon;
+	unsigned long	gpccon_mask;
+	unsigned long	gpdup;
+	unsigned long	gpdup_mask;
+	unsigned long	gpdcon;
+	unsigned long	gpdcon_mask;
+
+	/* lpc3600 control register */
+	unsigned long	lpcsel;
+};
+
+extern void __init s3c24xx_fb_set_platdata(struct s3c2410fb_mach_info *);
+
+#endif /* __ASM_PLAT_FB_S3C2410_H */
-- 
1.7.1
