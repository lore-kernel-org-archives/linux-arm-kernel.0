From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Fri, 18 Mar 2011 16:11:55 +0100
Subject: [PATCH v2 8/9] lpc2k: Add UART, SSP, and MCI devices
In-Reply-To: <1300461116-6028-1-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300461116-6028-1-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <1300461116-6028-9-git-send-email-ithamar.adema@team-embedded.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds devices for which the drivers are already in the tree. For
the relevant devices, let the ea2478devkit board set them up.

Signed-off-by: Ithamar R. Adema <ithamar.adema@team-embedded.nl>
---
no changes since v1.
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-lpc2k/Makefile                |    2 +-
 arch/arm/mach-lpc2k/common.h                |    4 +
 arch/arm/mach-lpc2k/devices.c               |  174 +++++++++++++++++++++++++++
 arch/arm/mach-lpc2k/include/mach/hardware.h |    6 +
 arch/arm/mach-lpc2k/mach-ea2478devkit.c     |   20 +++
 6 files changed, 206 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-lpc2k/devices.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index de826e9..603839f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -496,6 +496,7 @@ config ARCH_LPC2K
 	depends on !MMU
 	select CPU_ARM7TDMI
 	select ARM_VIC
+	select ARM_AMBA
 	select CLKDEV_LOOKUP
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-lpc2k/Makefile b/arch/arm/mach-lpc2k/Makefile
index 93e27fb..aa2b353 100644
--- a/arch/arm/mach-lpc2k/Makefile
+++ b/arch/arm/mach-lpc2k/Makefile
@@ -1,3 +1,3 @@
 obj-y	:= clock.o irq.o gpio.o mfp.o time.o
 
-obj-$(CONFIG_MACH_EA2478DEVKIT) += mach-ea2478devkit.o
+obj-$(CONFIG_MACH_EA2478DEVKIT) += mach-ea2478devkit.o devices.o
diff --git a/arch/arm/mach-lpc2k/common.h b/arch/arm/mach-lpc2k/common.h
index 6b775d9..1d4c21e 100644
--- a/arch/arm/mach-lpc2k/common.h
+++ b/arch/arm/mach-lpc2k/common.h
@@ -16,6 +16,10 @@ extern void lpc2k_init_clocks(unsigned long xtal, unsigned long rtc);
 extern void lpc2k_mfp_config(unsigned long *mfp_cfgs, int num);
 extern void lpc2k_init_irq(void);
 
+extern void lpc2k_add_uart(int nr);
+extern void lpc2k_add_ssp(int nr, void *platform_data);
+extern void lpc2k_add_mci(void *platform_data, int pwr_high);
+
 extern struct sys_timer lpc2k_timer;
 
 #endif /* LPC2K_COMMON_H */
diff --git a/arch/arm/mach-lpc2k/devices.c b/arch/arm/mach-lpc2k/devices.c
new file mode 100644
index 0000000..8855e8a
--- /dev/null
+++ b/arch/arm/mach-lpc2k/devices.c
@@ -0,0 +1,174 @@
+/*
+ * Copyright (C) 2011 Team Embeded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <linux/amba/bus.h>
+#include <linux/amba/mmci.h>
+#include <linux/amba/pl022.h>
+
+#include <mach/hardware.h>
+
+/* System Control Block - System Controls and Status register */
+#define SCS		0x1a0
+
+#define __IORESOURCE_MEM_16K(x)	{	\
+	.start = x,			\
+	.end   = x + SZ_16K - 1,	\
+	.flags = IORESOURCE_MEM,	\
+	}
+
+#define __IORESOURCE_IRQ(x)	{	\
+	.start = x,			\
+	. end  = x,			\
+	}
+
+/* UARTs
+ *   0/1 are available on all LPC2Ks
+ *   2/3 are available on LPC23XX and up.
+ *
+ * NOTE: the dev.init_name assignment is there so we can use the clk API to
+ *       retrieve and enable the clock, since dev_name() is called from
+ *       the clk_get implementation before the platform device is registered.
+ */
+
+#define LPC2K_UART(uartnum) \
+	static struct plat_serial8250_port lpc2k_pdata_uart##uartnum[] = { \
+		{ \
+			.mapbase	= APB_UART##uartnum##_BASE, \
+			.membase	= (void __iomem *) \
+						APB_UART##uartnum##_BASE, \
+			.irq		= IRQ_LPC2K_UART##uartnum, \
+			.flags		= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF, \
+			.iotype		= UPIO_MEM, \
+			.regshift	= 2, \
+			.uartclk	= 0, \
+		}, \
+		{ }, \
+	}; \
+	static struct resource lpc2k_resources_uart##uartnum[] = { \
+		[0] = __IORESOURCE_MEM_16K(APB_UART##uartnum##_BASE), \
+		[1] = __IORESOURCE_IRQ(IRQ_LPC2K_UART##uartnum), \
+	}; \
+	static struct platform_device lpc2k_device_uart##uartnum = { \
+		.dev = { \
+			.init_name = "serial8250." __stringify(uartnum), \
+			.platform_data = lpc2k_pdata_uart##uartnum, \
+		}, \
+		.name		= "serial8250", \
+		.id		= uartnum, \
+		.resource	= lpc2k_resources_uart##uartnum, \
+		.num_resources	= ARRAY_SIZE(lpc2k_resources_uart##uartnum), \
+	}
+
+
+LPC2K_UART(0);
+LPC2K_UART(1);
+LPC2K_UART(2);
+LPC2K_UART(3);
+
+static struct platform_device *uarts[] __initdata = {
+	&lpc2k_device_uart0,
+	&lpc2k_device_uart1,
+	&lpc2k_device_uart2,
+	&lpc2k_device_uart3,
+};
+
+void __init lpc2k_add_uart(int nr)
+{
+	struct platform_device *pdev;
+	struct clk *clk;
+	int res;
+
+	BUG_ON(nr < 0 || nr > ARRAY_SIZE(uarts));
+	pdev = uarts[nr];
+
+	clk = clk_get(&pdev->dev, NULL);
+	BUG_ON(IS_ERR(clk));
+	clk_enable(clk);
+	((struct plat_serial8250_port *)pdev->dev.platform_data)->uartclk =
+		clk_get_rate(clk);
+	clk_put(clk);
+
+	res = platform_device_register(pdev);
+	if (res)
+		dev_err(&pdev->dev, "Unable to register: %d\n", res);
+}
+
+/* SSP, aka pl022
+ *
+ * 1-only available on enhanced LPC21XX and LPC22XX.
+ * 0/1 available on LPC23XX and up.
+ */
+
+static struct amba_device lpc2k_device_ssp0 = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.init_name = "ssp0",
+	},
+	.res = __IORESOURCE_MEM_16K(APB_SSP0_BASE),
+	.irq = { IRQ_LPC2K_SPI0, NO_IRQ },
+};
+
+static struct amba_device lpc2k_device_ssp1 = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.init_name = "ssp1",
+	},
+	.res = __IORESOURCE_MEM_16K(APB_SSP1_BASE),
+	.irq = { IRQ_LPC2K_SPI1, NO_IRQ },
+};
+
+void __init lpc2k_add_ssp(int nr, void *platform_data)
+{
+	struct amba_device *adev;
+	int res;
+
+	BUG_ON(nr < 0 || nr > 1);
+	adev = nr ? &lpc2k_device_ssp1 : &lpc2k_device_ssp0;
+	adev->dev.platform_data = platform_data;
+
+	res = amba_device_register(adev, &iomem_resource);
+	if (res)
+		dev_err(&adev->dev, "Unable to register: %d\n", res);
+}
+
+/* SD/MMC, aka pl180/1
+ *
+ * Available on LPC23XX and up.
+ */
+
+static struct amba_device lpc2k_device_mci = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.init_name = "mci",
+	},
+	.res = __IORESOURCE_MEM_16K(APB_MCI_BASE),
+	.irq = { IRQ_LPC2K_MCI, NO_IRQ },
+};
+
+void __init lpc2k_add_mci(void *platform_data, int pwr_high)
+{
+	int res;
+	u32 scs;
+
+	/* Set MCIPWR pin to be active high or low */
+	scs = ioread32(APB_SCB_BASE + SCS);
+	scs = pwr_high ? scs | (1 << 3) : scs & ~(1 << 3);
+	iowrite32(scs, APB_SCB_BASE + SCS);
+
+	lpc2k_device_mci.dev.platform_data = platform_data;
+	res = amba_device_register(&lpc2k_device_mci, &iomem_resource);
+	if (res)
+		dev_err(&lpc2k_device_mci.dev, "Unable to register: %d\n", res);
+}
diff --git a/arch/arm/mach-lpc2k/include/mach/hardware.h b/arch/arm/mach-lpc2k/include/mach/hardware.h
index 1a20126..b2e3a18 100644
--- a/arch/arm/mach-lpc2k/include/mach/hardware.h
+++ b/arch/arm/mach-lpc2k/include/mach/hardware.h
@@ -20,8 +20,14 @@
 #define APB_TIMER0_BASE		0xe0004000
 #define APB_TIMER1_BASE		0xe0008000
 #define APB_UART0_BASE		0xe000c000
+#define APB_UART1_BASE		0xe0010000
 #define APB_GPIO_BASE		0xe0028000
 #define APB_PINSEL_BASE		0xe002c000
+#define APB_SSP1_BASE		0xe0030000
+#define APB_SSP0_BASE		0xe0068000
+#define APB_UART2_BASE		0xe0078000
+#define APB_UART3_BASE		0xe007c000
+#define APB_MCI_BASE		0xe008c000
 #define APB_SCB_BASE		0xe01fc000
 #define APH_VIC_BASE		0xfffff000
 
diff --git a/arch/arm/mach-lpc2k/mach-ea2478devkit.c b/arch/arm/mach-lpc2k/mach-ea2478devkit.c
index bc9c980..3685eb2 100644
--- a/arch/arm/mach-lpc2k/mach-ea2478devkit.c
+++ b/arch/arm/mach-lpc2k/mach-ea2478devkit.c
@@ -8,6 +8,8 @@
  */
 
 #include <linux/module.h>
+#include <linux/amba/pl022.h>
+#include <linux/amba/mmci.h>
 #include <linux/io.h>
 
 #include <asm/mach/arch.h>
@@ -95,9 +97,27 @@ static unsigned long mfp_cfgs[] __initdata = {
 	GPIO44_MCIDAT3,
 };
 
+static struct pl022_ssp_controller ssp0_plat_data = {
+	.bus_id = 0,
+	.enable_dma = 0,
+	.num_chipselect = 1,
+};
+
+static struct mmci_platform_data mci_plat_data = {
+	.ocr_mask = MMC_VDD_32_33 | MMC_VDD_33_34,
+	.capabilities = MMC_CAP_4_BIT_DATA,
+	.f_max = 200000,
+	.gpio_cd = -1,
+	.gpio_wp = -1,
+};
+
 void __init ea2478devkit_init_machine(void)
 {
 	lpc2k_mfp_config(mfp_cfgs, ARRAY_SIZE(mfp_cfgs));
+
+	lpc2k_add_uart(0);
+	lpc2k_add_ssp(0, &ssp0_plat_data);
+	lpc2k_add_mci(&mci_plat_data, 0 /* active low */);
 }
 
 static void __init ea2478devkit_init_irq(void)
-- 
1.7.1
