From: maz@misterjones.org (Marc Zyngier)
Date: Sat, 10 Apr 2010 21:32:38 +0100
Subject: [PATCH 1/2] ixp4xx: base support for Arcom Vulcan
Message-ID: <1270931559-9414-1-git-send-email-maz@misterjones.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds some basic support for the Arcom Vulcan (ixp425 based).

Supported devices include:
- XR16L551 serial ports
- External watchdog
- Flash
- SRAM
- 1-wire id

Signed-off-by: Marc Zyngier <maz@misterjones.org>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/Kconfig        |    8 +
 arch/arm/mach-ixp4xx/Makefile       |    1 +
 arch/arm/mach-ixp4xx/vulcan-setup.c |  246 +++++++++++++++++++++++++++++++++++
 3 files changed, 255 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ixp4xx/vulcan-setup.c

diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index 9e5070d..6f991c5 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -140,6 +140,14 @@ config MACH_FSG
 	  FSG-3 device. For more information on this platform,
 	  see http://www.nslu2-linux.org/wiki/FSG3/HomePage
 
+config MACH_ARCOM_VULCAN
+	bool
+	prompt "Arcom/Eurotech Vulcan"
+	select PCI
+	help
+	  Say 'Y' here if you want your kernel to support Arcom's
+	  Vulcan board.
+
 #
 # Certain registers and IRQs are only enabled if supporting IXP465 CPUs
 #
diff --git a/arch/arm/mach-ixp4xx/Makefile b/arch/arm/mach-ixp4xx/Makefile
index 47d1f60..ab39693 100644
--- a/arch/arm/mach-ixp4xx/Makefile
+++ b/arch/arm/mach-ixp4xx/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_MACH_GATEWAY7001)	+= gateway7001-setup.o
 obj-$(CONFIG_MACH_WG302V2)	+= wg302v2-setup.o
 obj-$(CONFIG_MACH_FSG)		+= fsg-setup.o
 obj-$(CONFIG_MACH_GORAMO_MLR)	+= goramo_mlr.o
+obj-$(CONFIG_MACH_ARCOM_VULCAN)	+= vulcan-setup.o
 
 obj-$(CONFIG_PCI)		+= $(obj-pci-$(CONFIG_PCI)) common-pci.o
 obj-$(CONFIG_IXP4XX_QMGR)	+= ixp4xx_qmgr.o
diff --git a/arch/arm/mach-ixp4xx/vulcan-setup.c b/arch/arm/mach-ixp4xx/vulcan-setup.c
new file mode 100644
index 0000000..465cc5c
--- /dev/null
+++ b/arch/arm/mach-ixp4xx/vulcan-setup.c
@@ -0,0 +1,246 @@
+/*
+ * arch/arm/mach-ixp4xx/vulcan-setup.c
+ *
+ * Arcom/Eurotech Vulcan board-setup
+ *
+ * Copyright (C) 2010 Marc Zyngier <maz@misterjones.org>
+ *
+ * based on fsg-setup.c:
+ *	Copyright (C) 2008 Rod Whitby <rod@whitby.id.au>
+ */
+
+#include <linux/if_ether.h>
+#include <linux/irq.h>
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+#include <linux/io.h>
+#include <linux/w1-gpio.h>
+#include <linux/mtd/plat-ram.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/flash.h>
+
+static struct flash_platform_data vulcan_flash_data = {
+	.map_name	= "cfi_probe",
+	.width		= 2,
+};
+
+static struct resource vulcan_flash_resource = {
+	.flags			= IORESOURCE_MEM,
+};
+
+static struct platform_device vulcan_flash = {
+	.name			= "IXP4XX-Flash",
+	.id			= 0,
+	.dev = {
+		.platform_data	= &vulcan_flash_data,
+	},
+	.resource		= &vulcan_flash_resource,
+	.num_resources		= 1,
+};
+
+static struct platdata_mtd_ram vulcan_sram_data = {
+	.mapname	= "Vulcan SRAM",
+	.bankwidth	= 1,
+};
+
+static struct resource vulcan_sram_resource = {
+	.flags			= IORESOURCE_MEM,
+};
+
+static struct platform_device vulcan_sram = {
+	.name			= "mtd-ram",
+	.id			= 0,
+	.dev = {
+		.platform_data	= &vulcan_sram_data,
+	},
+	.resource		= &vulcan_sram_resource,
+	.num_resources		= 1,
+};
+
+static struct resource vulcan_uart_resources[] = {
+	[0] = {
+		.start		= IXP4XX_UART1_BASE_PHYS,
+		.end		= IXP4XX_UART1_BASE_PHYS + 0x0fff,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= IXP4XX_UART2_BASE_PHYS,
+		.end		= IXP4XX_UART2_BASE_PHYS + 0x0fff,
+		.flags		= IORESOURCE_MEM,
+	},
+	[2] = {
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct plat_serial8250_port vulcan_uart_data[] = {
+	[0] = {
+		.mapbase	= IXP4XX_UART1_BASE_PHYS,
+		.membase	= (char *)IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
+		.irq		= IRQ_IXP4XX_UART1,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= IXP4XX_UART_XTAL,
+	},
+	[1] = {
+		.mapbase	= IXP4XX_UART2_BASE_PHYS,
+		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+		.irq		= IRQ_IXP4XX_UART2,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= IXP4XX_UART_XTAL,
+	},
+	[2] = {
+		.irq		= IXP4XX_GPIO_IRQ(4),
+		.irqflags	= IRQF_TRIGGER_LOW,
+		.flags		= UPF_IOREMAP | UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.iotype		= UPIO_MEM,
+		.uartclk	= 1843200,
+	},
+	[3] = {
+		.irq		= IXP4XX_GPIO_IRQ(4),
+		.irqflags	= IRQF_TRIGGER_LOW,
+		.flags		= UPF_IOREMAP | UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.iotype		= UPIO_MEM,
+		.uartclk	= 1843200,
+	},
+	{ }
+};
+
+static struct platform_device vulcan_uart = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM,
+	.dev = {
+		.platform_data	= vulcan_uart_data,
+	},
+	.resource		= vulcan_uart_resources,
+	.num_resources		= ARRAY_SIZE(vulcan_uart_resources),
+};
+
+static struct eth_plat_info vulcan_plat_eth[] = {
+	[0] = {
+		.phy		= 0,
+		.rxq		= 3,
+		.txreadyq	= 20,
+	},
+	[1] = {
+		.phy		= 1,
+		.rxq		= 4,
+		.txreadyq	= 21,
+	},
+};
+
+static struct platform_device vulcan_eth[] = {
+	[0] = {
+		.name			= "ixp4xx_eth",
+		.id			= IXP4XX_ETH_NPEB,
+		.dev = {
+			.platform_data	= &vulcan_plat_eth[0],
+		},
+	},
+	[1] = {
+		.name			= "ixp4xx_eth",
+		.id			= IXP4XX_ETH_NPEC,
+		.dev = {
+			.platform_data	= &vulcan_plat_eth[1],
+		},
+	},
+};
+
+static struct resource vulcan_max6369_resource = {
+	.flags			= IORESOURCE_MEM,
+};
+
+static struct platform_device vulcan_max6369 = {
+	.name			= "max6369_wdt",
+	.id			= -1,
+	.resource		= &vulcan_max6369_resource,
+	.num_resources		= 1,
+};
+
+static struct w1_gpio_platform_data vulcan_w1_gpio_pdata = {
+	.pin			= 14,
+};
+
+static struct platform_device vulcan_w1_gpio = {
+	.name			= "w1-gpio",
+	.id			= 0,
+	.dev			= {
+		.platform_data	= &vulcan_w1_gpio_pdata,
+	},
+};
+
+static struct platform_device *vulcan_devices[] __initdata = {
+	&vulcan_uart,
+	&vulcan_flash,
+	&vulcan_sram,
+	&vulcan_max6369,
+	&vulcan_eth[0],
+	&vulcan_eth[1],
+	&vulcan_w1_gpio,
+};
+
+static void __init vulcan_init(void)
+{
+	ixp4xx_sys_init();
+
+	/* Flash is spread over both CS0 and CS1 */
+	vulcan_flash_resource.start	 = IXP4XX_EXP_BUS_BASE(0);
+	vulcan_flash_resource.end	 = IXP4XX_EXP_BUS_BASE(0) + SZ_32M - 1;
+	*IXP4XX_EXP_CS0 = IXP4XX_EXP_BUS_CS_EN		|
+			  IXP4XX_EXP_BUS_STROBE_T(3)	|
+			  IXP4XX_EXP_BUS_SIZE(0xF)	|
+			  IXP4XX_EXP_BUS_BYTE_RD16	|
+			  IXP4XX_EXP_BUS_WR_EN;
+	*IXP4XX_EXP_CS1 = *IXP4XX_EXP_CS0;
+
+	/* SRAM on CS2, (256kB, 8bit, writable) */
+	vulcan_sram_resource.start	= IXP4XX_EXP_BUS_BASE(2);
+	vulcan_sram_resource.end	= IXP4XX_EXP_BUS_BASE(2) + SZ_256K - 1;
+	*IXP4XX_EXP_CS2 = IXP4XX_EXP_BUS_CS_EN		|
+			  IXP4XX_EXP_BUS_STROBE_T(1)	|
+			  IXP4XX_EXP_BUS_HOLD_T(2)	|
+			  IXP4XX_EXP_BUS_SIZE(9)	|
+			  IXP4XX_EXP_BUS_SPLT_EN	|
+			  IXP4XX_EXP_BUS_WR_EN		|
+			  IXP4XX_EXP_BUS_BYTE_EN;
+
+	/* XR16L2551 on CS3 (Moto style, 512 bytes, 8bits, writable) */
+	vulcan_uart_resources[2].start	= IXP4XX_EXP_BUS_BASE(3);
+	vulcan_uart_resources[2].end	= IXP4XX_EXP_BUS_BASE(3) + 16 - 1;
+	vulcan_uart_data[2].mapbase	= vulcan_uart_resources[2].start;
+	vulcan_uart_data[3].mapbase	= vulcan_uart_data[2].mapbase + 8;
+	*IXP4XX_EXP_CS3 = IXP4XX_EXP_BUS_CS_EN		|
+			  IXP4XX_EXP_BUS_STROBE_T(3)	|
+			  IXP4XX_EXP_BUS_CYCLES(IXP4XX_EXP_BUS_CYCLES_MOTOROLA)|
+			  IXP4XX_EXP_BUS_WR_EN		|
+			  IXP4XX_EXP_BUS_BYTE_EN;
+
+	/* GPIOS on CS4 (512 bytes, 8bits, writable) */
+	*IXP4XX_EXP_CS4 = IXP4XX_EXP_BUS_CS_EN		|
+			  IXP4XX_EXP_BUS_WR_EN		|
+			  IXP4XX_EXP_BUS_BYTE_EN;
+
+	/* max6369 on CS5 (512 bytes, 8bits, writable) */
+	vulcan_max6369_resource.start	= IXP4XX_EXP_BUS_BASE(5);
+	vulcan_max6369_resource.end	= IXP4XX_EXP_BUS_BASE(5);
+	*IXP4XX_EXP_CS5 = IXP4XX_EXP_BUS_CS_EN		|
+			  IXP4XX_EXP_BUS_WR_EN		|
+			  IXP4XX_EXP_BUS_BYTE_EN;
+
+	platform_add_devices(vulcan_devices, ARRAY_SIZE(vulcan_devices));
+}
+
+MACHINE_START(ARCOM_VULCAN, "Arcom/Eurotech Vulcan")
+	/* Maintainer: Marc Zyngier <maz@misterjones.org> */
+	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
+	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xfffc,
+	.map_io		= ixp4xx_map_io,
+	.init_irq	= ixp4xx_init_irq,
+	.timer		= &ixp4xx_timer,
+	.boot_params	= 0x0100,
+	.init_machine	= vulcan_init,
+MACHINE_END
-- 
1.7.0.4
