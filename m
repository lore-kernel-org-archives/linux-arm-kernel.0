From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:48:59 +0200
Subject: [PATCH 03/61] ARM: mx1: don't use deprecated symbol names
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx1/Makefile       |    1 -
 arch/arm/mach-mx1/clock.c        |    3 +-
 arch/arm/mach-mx1/crm_regs.h     |    4 +-
 arch/arm/mach-mx1/devices.c      |  117 +++++++++++++++++++-------------------
 arch/arm/mach-mx1/generic.c      |   13 ++--
 arch/arm/mach-mx1/mach-mx1ads.c  |   12 ++--
 arch/arm/mach-mx1/mach-scb9328.c |   12 ++--
 7 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/arch/arm/mach-mx1/Makefile b/arch/arm/mach-mx1/Makefile
index fc2ddf8..297d172 100644
--- a/arch/arm/mach-mx1/Makefile
+++ b/arch/arm/mach-mx1/Makefile
@@ -4,7 +4,6 @@
 
 # Object file lists.
 
-EXTRA_CFLAGS += -DIMX_NEEDS_DEPRECATED_SYMBOLS
 obj-y			+= generic.o clock.o devices.o
 
 # Support for CMOS sensor interface
diff --git a/arch/arm/mach-mx1/clock.c b/arch/arm/mach-mx1/clock.c
index 6cf2d4a..610b88d 100644
--- a/arch/arm/mach-mx1/clock.c
+++ b/arch/arm/mach-mx1/clock.c
@@ -596,7 +596,8 @@ int __init mx1_clocks_init(unsigned long fref)
 	clk_enable(&hclk);
 	clk_enable(&fclk);
 
-	mxc_timer_init(&gpt_clk, IO_ADDRESS(TIM1_BASE_ADDR), TIM1_INT);
+	mxc_timer_init(&gpt_clk, MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR),
+			MX1_TIM1_INT);
 
 	return 0;
 }
diff --git a/arch/arm/mach-mx1/crm_regs.h b/arch/arm/mach-mx1/crm_regs.h
index 22e866f..13e81e6 100644
--- a/arch/arm/mach-mx1/crm_regs.h
+++ b/arch/arm/mach-mx1/crm_regs.h
@@ -9,8 +9,8 @@
 #ifndef __ARCH_ARM_MACH_MX1_CRM_REGS_H__
 #define __ARCH_ARM_MACH_MX1_CRM_REGS_H__
 
-#define CCM_BASE	IO_ADDRESS(CCM_BASE_ADDR)
-#define SCM_BASE	IO_ADDRESS(SCM_BASE_ADDR)
+#define CCM_BASE	MX1_IO_ADDRESS(MX1_CCM_BASE_ADDR)
+#define SCM_BASE	MX1_IO_ADDRESS(MX1_SCM_BASE_ADDR)
 
 /* CCM register addresses */
 #define CCM_CSCR	(CCM_BASE + 0x0)
diff --git a/arch/arm/mach-mx1/devices.c b/arch/arm/mach-mx1/devices.c
index b6be29d..8064f2c 100644
--- a/arch/arm/mach-mx1/devices.c
+++ b/arch/arm/mach-mx1/devices.c
@@ -21,6 +21,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <mach/irqs.h>
@@ -34,20 +35,20 @@ static struct resource imx_csi_resources[] = {
 		.end    = 0x00224010,
 		.flags  = IORESOURCE_MEM,
 	}, {
-		.start  = CSI_INT,
-		.end    = CSI_INT,
+		.start  = MX1_CSI_INT,
+		.end    = MX1_CSI_INT,
 		.flags  = IORESOURCE_IRQ,
 	},
 };
 
-static u64 imx_csi_dmamask = 0xffffffffUL;
+static u64 imx_csi_dmamask = DMA_BIT_MASK(32);
 
 struct platform_device imx_csi_device = {
 	.name           = "mx1-camera",
 	.id             = 0, /* This is used to put cameras on this interface */
 	.dev		= {
 		.dma_mask = &imx_csi_dmamask,
-		.coherent_dma_mask = 0xffffffff,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.resource       = imx_csi_resources,
 	.num_resources  = ARRAY_SIZE(imx_csi_resources),
@@ -59,8 +60,8 @@ static struct resource imx_i2c_resources[] = {
 		.end    = 0x00217010,
 		.flags  = IORESOURCE_MEM,
 	}, {
-		.start  = I2C_INT,
-		.end    = I2C_INT,
+		.start  = MX1_I2C_INT,
+		.end    = MX1_I2C_INT,
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -74,21 +75,21 @@ struct platform_device imx_i2c_device = {
 
 static struct resource imx_uart1_resources[] = {
 	{
-		.start	= UART1_BASE_ADDR,
-		.end	= UART1_BASE_ADDR + 0xD0,
-		.flags	= IORESOURCE_MEM,
+		.start = MX1_UART1_BASE_ADDR,
+		.end = MX1_UART1_BASE_ADDR + 0xD0,
+		.flags = IORESOURCE_MEM,
 	}, {
-		.start	= UART1_MINT_RX,
-		.end	= UART1_MINT_RX,
-		.flags	= IORESOURCE_IRQ,
+		.start = MX1_UART1_MINT_RX,
+		.end = MX1_UART1_MINT_RX,
+		.flags = IORESOURCE_IRQ,
 	}, {
-		.start	= UART1_MINT_TX,
-		.end	= UART1_MINT_TX,
-		.flags	= IORESOURCE_IRQ,
+		.start = MX1_UART1_MINT_TX,
+		.end = MX1_UART1_MINT_TX,
+		.flags = IORESOURCE_IRQ,
 	}, {
-		.start	= UART1_MINT_RTS,
-		.end	= UART1_MINT_RTS,
-		.flags	= IORESOURCE_IRQ,
+		.start = MX1_UART1_MINT_RTS,
+		.end = MX1_UART1_MINT_RTS,
+		.flags = IORESOURCE_IRQ,
 	},
 };
 
@@ -101,21 +102,21 @@ struct platform_device imx_uart1_device = {
 
 static struct resource imx_uart2_resources[] = {
 	{
-		.start	= UART2_BASE_ADDR,
-		.end	= UART2_BASE_ADDR + 0xD0,
-		.flags	= IORESOURCE_MEM,
+		.start = MX1_UART2_BASE_ADDR,
+		.end = MX1_UART2_BASE_ADDR + 0xD0,
+		.flags = IORESOURCE_MEM,
 	}, {
-		.start	= UART2_MINT_RX,
-		.end	= UART2_MINT_RX,
-		.flags	= IORESOURCE_IRQ,
+		.start = MX1_UART2_MINT_RX,
+		.end = MX1_UART2_MINT_RX,
+		.flags = IORESOURCE_IRQ,
 	}, {
-		.start	= UART2_MINT_TX,
-		.end	= UART2_MINT_TX,
-		.flags	= IORESOURCE_IRQ,
+		.start = MX1_UART2_MINT_TX,
+		.end = MX1_UART2_MINT_TX,
+		.flags = IORESOURCE_IRQ,
 	}, {
-		.start	= UART2_MINT_RTS,
-		.end	= UART2_MINT_RTS,
-		.flags	= IORESOURCE_IRQ,
+		.start = MX1_UART2_MINT_RTS,
+		.end = MX1_UART2_MINT_RTS,
+		.flags = IORESOURCE_IRQ,
 	},
 };
 
@@ -132,12 +133,12 @@ static struct resource imx_rtc_resources[] = {
 		.end    = 0x00204024,
 		.flags  = IORESOURCE_MEM,
 	}, {
-		.start  = RTC_INT,
-		.end    = RTC_INT,
+		.start  = MX1_RTC_INT,
+		.end    = MX1_RTC_INT,
 		.flags  = IORESOURCE_IRQ,
 	}, {
-		.start  = RTC_SAMINT,
-		.end    = RTC_SAMINT,
+		.start  = MX1_RTC_SAMINT,
+		.end    = MX1_RTC_SAMINT,
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -155,8 +156,8 @@ static struct resource imx_wdt_resources[] = {
 		.end    = 0x00201008,
 		.flags  = IORESOURCE_MEM,
 	}, {
-		.start  = WDT_INT,
-		.end    = WDT_INT,
+		.start  = MX1_WDT_INT,
+		.end    = MX1_WDT_INT,
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -174,32 +175,32 @@ static struct resource imx_usb_resources[] = {
 		.end	= 0x00212148,
 		.flags	= IORESOURCE_MEM,
 	}, {
-		.start	= USBD_INT0,
-		.end	= USBD_INT0,
+		.start	= MX1_USBD_INT0,
+		.end	= MX1_USBD_INT0,
 		.flags	= IORESOURCE_IRQ,
 	}, {
-		.start	= USBD_INT1,
-		.end	= USBD_INT1,
+		.start	= MX1_USBD_INT1,
+		.end	= MX1_USBD_INT1,
 		.flags	= IORESOURCE_IRQ,
 	}, {
-		.start	= USBD_INT2,
-		.end	= USBD_INT2,
+		.start	= MX1_USBD_INT2,
+		.end	= MX1_USBD_INT2,
 		.flags	= IORESOURCE_IRQ,
 	}, {
-		.start	= USBD_INT3,
-		.end	= USBD_INT3,
+		.start	= MX1_USBD_INT3,
+		.end	= MX1_USBD_INT3,
 		.flags	= IORESOURCE_IRQ,
 	}, {
-		.start	= USBD_INT4,
-		.end	= USBD_INT4,
+		.start	= MX1_USBD_INT4,
+		.end	= MX1_USBD_INT4,
 		.flags	= IORESOURCE_IRQ,
 	}, {
-		.start	= USBD_INT5,
-		.end	= USBD_INT5,
+		.start	= MX1_USBD_INT5,
+		.end	= MX1_USBD_INT5,
 		.flags	= IORESOURCE_IRQ,
 	}, {
-		.start	= USBD_INT6,
-		.end	= USBD_INT6,
+		.start	= MX1_USBD_INT6,
+		.end	= MX1_USBD_INT6,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -215,23 +216,23 @@ struct platform_device imx_usb_device = {
 static struct mxc_gpio_port imx_gpio_ports[] = {
 	{
 		.chip.label = "gpio-0",
-		.base = (void __iomem *)IO_ADDRESS(GPIO_BASE_ADDR),
-		.irq = GPIO_INT_PORTA,
+		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR),
+		.irq = MX1_GPIO_INT_PORTA,
 		.virtual_irq_start = MXC_GPIO_IRQ_START,
 	}, {
 		.chip.label = "gpio-1",
-		.base = (void __iomem *)IO_ADDRESS(GPIO_BASE_ADDR + 0x100),
-		.irq = GPIO_INT_PORTB,
+		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x100),
+		.irq = MX1_GPIO_INT_PORTB,
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 32,
 	}, {
 		.chip.label = "gpio-2",
-		.base = (void __iomem *)IO_ADDRESS(GPIO_BASE_ADDR + 0x200),
-		.irq = GPIO_INT_PORTC,
+		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x200),
+		.irq = MX1_GPIO_INT_PORTC,
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 64,
 	}, {
 		.chip.label = "gpio-3",
-		.base = (void __iomem *)IO_ADDRESS(GPIO_BASE_ADDR + 0x300),
-		.irq = GPIO_INT_PORTD,
+		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x300),
+		.irq = MX1_GPIO_INT_PORTD,
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 96,
 	}
 };
diff --git a/arch/arm/mach-mx1/generic.c b/arch/arm/mach-mx1/generic.c
index 7f9fc10..5a745d9 100644
--- a/arch/arm/mach-mx1/generic.c
+++ b/arch/arm/mach-mx1/generic.c
@@ -31,23 +31,22 @@
 
 static struct map_desc imx_io_desc[] __initdata = {
 	{
-		.virtual	= IMX_IO_BASE,
-		.pfn		= __phys_to_pfn(IMX_IO_PHYS),
-		.length		= IMX_IO_SIZE,
-		.type		= MT_DEVICE
+		.virtual = MX1_IO_BASE_ADDR_VIRT,
+		.pfn = __phys_to_pfn(MX1_IO_BASE_ADDR),
+		.length = MX1_IO_SIZE,
+		.type = MT_DEVICE
 	}
 };
 
 void __init mx1_map_io(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX1);
-	mxc_arch_reset_init(IO_ADDRESS(WDT_BASE_ADDR));
+	mxc_arch_reset_init(MX1_IO_ADDRESS(MX1_WDT_BASE_ADDR));
 
 	iotable_init(imx_io_desc, ARRAY_SIZE(imx_io_desc));
 }
 
 void __init mx1_init_irq(void)
 {
-	mxc_init_irq(IO_ADDRESS(AVIC_BASE_ADDR));
+	mxc_init_irq(MX1_IO_ADDRESS(MX1_AVIC_BASE_ADDR));
 }
-
diff --git a/arch/arm/mach-mx1/mach-mx1ads.c b/arch/arm/mach-mx1/mach-mx1ads.c
index 51f3cfd..27c8222 100644
--- a/arch/arm/mach-mx1/mach-mx1ads.c
+++ b/arch/arm/mach-mx1/mach-mx1ads.c
@@ -75,8 +75,8 @@ static struct physmap_flash_data mx1ads_flash_data = {
 };
 
 static struct resource flash_resource = {
-	.start	= IMX_CS0_PHYS,
-	.end	= IMX_CS0_PHYS + SZ_32M - 1,
+	.start	= MX1_CS0_PHYS,
+	.end	= MX1_CS0_PHYS + SZ_32M - 1,
 	.flags	= IORESOURCE_MEM,
 };
 
@@ -145,8 +145,8 @@ struct sys_timer mx1ads_timer = {
 
 MACHINE_START(MX1ADS, "Freescale MX1ADS")
 	/* Maintainer: Sascha Hauer, Pengutronix */
-	.phys_io	= IMX_IO_PHYS,
-	.io_pg_offst	= (IMX_IO_BASE >> 18) & 0xfffc,
+	.phys_io	= MX1_IO_BASE_ADDR,
+	.io_pg_offst	= (MX1_IO_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params	= MX1_PHYS_OFFSET + 0x100,
 	.map_io		= mx1_map_io,
 	.init_irq	= mx1_init_irq,
@@ -155,8 +155,8 @@ MACHINE_START(MX1ADS, "Freescale MX1ADS")
 MACHINE_END
 
 MACHINE_START(MXLADS, "Freescale MXLADS")
-	.phys_io	= IMX_IO_PHYS,
-	.io_pg_offst	= (IMX_IO_BASE >> 18) & 0xfffc,
+	.phys_io	= MX1_IO_BASE_ADDR,
+	.io_pg_offst	= (MX1_IO_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params	= MX1_PHYS_OFFSET + 0x100,
 	.map_io		= mx1_map_io,
 	.init_irq	= mx1_init_irq,
diff --git a/arch/arm/mach-mx1/mach-scb9328.c b/arch/arm/mach-mx1/mach-scb9328.c
index 7587a7a..7c6bbe8 100644
--- a/arch/arm/mach-mx1/mach-scb9328.c
+++ b/arch/arm/mach-mx1/mach-scb9328.c
@@ -31,8 +31,8 @@
  * This scb9328 has a 32MiB flash
  */
 static struct resource flash_resource = {
-	.start	= IMX_CS0_PHYS,
-	.end	= IMX_CS0_PHYS + (32 * 1024 * 1024) - 1,
+	.start	= MX1_CS0_PHYS,
+	.end	= MX1_CS0_PHYS + (32 * 1024 * 1024) - 1,
 	.flags	= IORESOURCE_MEM,
 };
 
@@ -70,13 +70,13 @@ static struct dm9000_plat_data dm9000_platdata = {
 static struct resource dm9000x_resources[] = {
 	{
 		.name	= "address area",
-		.start	= IMX_CS5_PHYS,
-		.end	= IMX_CS5_PHYS + 1,
+		.start	= MX1_CS5_PHYS,
+		.end	= MX1_CS5_PHYS + 1,
 		.flags	= IORESOURCE_MEM,	/* address access */
 	}, {
 		.name	= "data area",
-		.start	= IMX_CS5_PHYS + 4,
-		.end	= IMX_CS5_PHYS + 5,
+		.start	= MX1_CS5_PHYS + 4,
+		.end	= MX1_CS5_PHYS + 5,
 		.flags	= IORESOURCE_MEM,	/* data access */
 	}, {
 		.start	= IRQ_GPIOC(3),
-- 
1.7.1
