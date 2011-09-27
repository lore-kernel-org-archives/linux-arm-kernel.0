From: jaccon.bastiaansen@gmail.com (Jaccon Bastiaansen)
Date: Tue, 27 Sep 2011 20:27:56 +0200
Subject: [PATCH V2] Add platform driver support to the CS890x driver
In-Reply-To: <20110913074626.GM28624@pengutronix.de>
References: <20110913074626.GM28624@pengutronix.de>
Message-ID: <1317148076-14931-1-git-send-email-jaccon.bastiaansen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CS89x0 ethernet controller is used on a number of evaluation
boards, such as the MX31ADS. The current driver has memory address and
IRQ settings for each board on which this controller is used. Driver
updates are therefore required to support other boards that also use
the CS89x0. To avoid these driver updates, a better mechanism
(platform driver support) is added to communicate the board dependent
settings to the driver.

Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
---
 arch/arm/mach-imx/mach-mx31ads.c               |   40 ++++++-
 arch/arm/mach-ixp2000/ixdp2x01.c               |   24 +++-
 arch/arm/mach-ixp2000/pci.c                    |    3 +-
 arch/arm/mach-ixp23xx/ixdp2351.c               |   21 +++
 arch/arm/mach-ixp23xx/pci.c                    |    3 +-
 arch/arm/plat-mxc/include/mach/board-mx31ads.h |   33 -----
 drivers/net/Kconfig                            |   16 ++-
 drivers/net/Space.c                            |    2 +-
 drivers/net/cs89x0.c                           |  175 +++++++++++++++---------
 9 files changed, 210 insertions(+), 107 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx31ads.h

diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index f4dee02..007bd38 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -28,7 +28,6 @@
 #include <asm/memory.h>
 #include <asm/mach/map.h>
 #include <mach/common.h>
-#include <mach/board-mx31ads.h>
 #include <mach/iomux-mx3.h>
 
 #ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
@@ -62,6 +61,7 @@
 #define PBC_INTMASK_CLEAR_REG	(PBC_INTMASK_CLEAR + PBC_BASE_ADDRESS)
 #define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_4)
 
+#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
 #define MXC_IRQ_TO_EXPIO(irq)	((irq) - MXC_EXP_IO_BASE)
 
 #define EXPIO_INT_XUART_INTA	(MXC_EXP_IO_BASE + 10)
@@ -69,6 +69,18 @@
 
 #define MXC_MAX_EXP_IO_LINES	16
 
+
+/* Base address of PBC controller */
+#define PBC_BASE_ADDRESS        MX31_CS4_BASE_ADDR_VIRT
+
+/* Offsets for the PBC Controller register */
+
+/* Ethernet Controller IO addresses */
+#define PBC_CS8900A_IOBASE      0x020000
+#define CS8900A_START		(PBC_BASE_ADDRESS + PBC_CS8900A_IOBASE + 0x300)
+
+#define EXPIO_INT_ENET_INT	(MXC_EXP_IO_BASE + 8)
+
 /*
  * The serial port definition structure.
  */
@@ -101,11 +113,36 @@ static struct platform_device serial_device = {
 	},
 };
 
+static struct resource mx31ads_cs8900_resources[] = {
+	{
+		.start	= (u32)CS8900A_START,
+		.end	= (u32)CS8900A_START + 0x1000 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= EXPIO_INT_ENET_INT,
+		.end	= EXPIO_INT_ENET_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mx31ads_cs8900_device = {
+	.name		= "cs89x0",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(mx31ads_cs8900_resources),
+	.resource	= mx31ads_cs8900_resources,
+};
+
 static int __init mxc_init_extuart(void)
 {
 	return platform_device_register(&serial_device);
 }
 
+static void __init mxc_init_ext_ethernet(void)
+{
+	platform_device_register(&mx31ads_cs8900_device);
+}
+
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -520,6 +557,7 @@ static void __init mx31ads_init(void)
 	mxc_init_imx_uart();
 	mxc_init_i2c();
 	mxc_init_audio();
+	mxc_init_ext_ethernet();
 }
 
 static void __init mx31ads_timer_init(void)
diff --git a/arch/arm/mach-ixp2000/ixdp2x01.c b/arch/arm/mach-ixp2000/ixdp2x01.c
index 84835b2..1ec4a74 100644
--- a/arch/arm/mach-ixp2000/ixdp2x01.c
+++ b/arch/arm/mach-ixp2000/ixdp2x01.c
@@ -394,9 +394,31 @@ static struct platform_device ixdp2x01_i2c_controller = {
 	.num_resources	= 0
 };
 
+static struct resource ixdp2x01_cs8900_resources[] = {
+	{
+		.start	= (u32)IXDP2X01_CS8900_VIRT_BASE,
+		.end	= (u32)IXDP2X01_CS8900_VIRT_BASE + 0x1000 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_IXDP2X01_CS8900,
+		.end	= IRQ_IXDP2X01_CS8900,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ixdp2x01_cs8900 = {
+	.name		= "cs89x0",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ixdp2x01_cs8900_resources),
+	.resource	= ixdp2x01_cs8900_resources,
+};
+
+
 static struct platform_device *ixdp2x01_devices[] __initdata = {
 	&ixdp2x01_flash,
-	&ixdp2x01_i2c_controller
+	&ixdp2x01_i2c_controller,
+	&ixdp2x01_cs8900
 };
 
 static void __init ixdp2x01_init_machine(void)
diff --git a/arch/arm/mach-ixp2000/pci.c b/arch/arm/mach-ixp2000/pci.c
index f797c5f..54bf1b8 100644
--- a/arch/arm/mach-ixp2000/pci.c
+++ b/arch/arm/mach-ixp2000/pci.c
@@ -130,7 +130,8 @@ static struct pci_ops ixp2000_pci_ops = {
 	.write	= ixp2000_pci_write_config
 };
 
-struct pci_bus *ixp2000_pci_scan_bus(int nr, struct pci_sys_data *sysdata)
+struct pci_bus __devinit
+*ixp2000_pci_scan_bus(int nr, struct pci_sys_data *sysdata)
 {
 	return pci_scan_bus(sysdata->busnr, &ixp2000_pci_ops, sysdata);
 }
diff --git a/arch/arm/mach-ixp23xx/ixdp2351.c b/arch/arm/mach-ixp23xx/ixdp2351.c
index 8dcba17..d559110 100644
--- a/arch/arm/mach-ixp23xx/ixdp2351.c
+++ b/arch/arm/mach-ixp23xx/ixdp2351.c
@@ -311,6 +311,26 @@ static struct platform_device ixdp2351_flash = {
 	.resource	= &ixdp2351_flash_resource,
 };
 
+static struct resource ixdp2351_cs8900_resources[] = {
+	{
+		.start	= (u32)IXDP2351_VIRT_CS8900_BASE,
+		.end	= (u32)IXDP2351_VIRT_CS8900_BASE + 0x1000 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_IXDP2351_CS8900,
+		.end	= IRQ_IXDP2351_CS8900,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ixdp2351_cs8900 = {
+	.name		= "cs89x0",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ixdp2351_cs8900_resources),
+	.resource	= ixdp2351_cs8900_resources,
+};
+
 static void __init ixdp2351_init(void)
 {
 	platform_device_register(&ixdp2351_flash);
@@ -323,6 +343,7 @@ static void __init ixdp2351_init(void)
 	IXP23XX_EXP_CS0[2] |= IXP23XX_FLASH_WRITABLE;
 	IXP23XX_EXP_CS0[3] |= IXP23XX_FLASH_WRITABLE;
 
+	platform_device_register(&ixdp2351_cs8900);
 	ixp23xx_sys_init();
 }
 
diff --git a/arch/arm/mach-ixp23xx/pci.c b/arch/arm/mach-ixp23xx/pci.c
index 563819a..f82bb91 100644
--- a/arch/arm/mach-ixp23xx/pci.c
+++ b/arch/arm/mach-ixp23xx/pci.c
@@ -141,7 +141,8 @@ struct pci_ops ixp23xx_pci_ops = {
 	.write	= ixp23xx_pci_write_config,
 };
 
-struct pci_bus *ixp23xx_pci_scan_bus(int nr, struct pci_sys_data *sysdata)
+struct pci_bus __devinit
+*ixp23xx_pci_scan_bus(int nr, struct pci_sys_data *sysdata)
 {
 	return pci_scan_bus(sysdata->busnr, &ixp23xx_pci_ops, sysdata);
 }
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31ads.h b/arch/arm/plat-mxc/include/mach/board-mx31ads.h
deleted file mode 100644
index 94b60dd..0000000
--- a/arch/arm/plat-mxc/include/mach/board-mx31ads.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_MXC_BOARD_MX31ADS_H__
-#define __ASM_ARCH_MXC_BOARD_MX31ADS_H__
-
-#include <mach/hardware.h>
-
-/*
- * These symbols are used by drivers/net/cs89x0.c.
- * This is ugly as hell, but we have to provide them until
- * someone fixed the driver.
- */
-
-/* Base address of PBC controller */
-#define PBC_BASE_ADDRESS        MX31_CS4_BASE_ADDR_VIRT
-/* Offsets for the PBC Controller register */
-
-/* Ethernet Controller IO base address */
-#define PBC_CS8900A_IOBASE      0x020000
-
-#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
-
-#define EXPIO_INT_ENET_INT	(MXC_EXP_IO_BASE + 8)
-
-#endif /* __ASM_ARCH_MXC_BOARD_MX31ADS_H__ */
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 93359fa..2873f86 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1497,8 +1497,7 @@ config FORCEDETH
 
 config CS89x0
 	tristate "CS89x0 support"
-	depends on NET_ETHERNET && (ISA || EISA || MACH_IXDP2351 \
-		|| ARCH_IXDP2X01 || MACH_MX31ADS || MACH_QQ2440)
+	depends on NET_ETHERNET
 	---help---
 	  Support for CS89x0 chipset based Ethernet cards. If you have a
 	  network (Ethernet) card of this type, say Y and read the
@@ -1509,10 +1508,15 @@ config CS89x0
 	  To compile this driver as a module, choose M here. The module
 	  will be called cs89x0.
 
-config CS89x0_NONISA_IRQ
-	def_bool y
-	depends on CS89x0 != n
-	depends on MACH_IXDP2351 || ARCH_IXDP2X01 || MACH_MX31ADS || MACH_QQ2440
+config CS89x0_PLATFORM
+	bool "CS89x0 platform driver support"
+	depends on CS89x0
+	help
+	  Say Y to compile the cs890x0 driver as a platform driver. This
+	  makes this driver suitable for use on certain evaluation boards
+	  such as the IMX21ADS.
+
+	  If you are unsure, say N.
 
 config TC35815
 	tristate "TOSHIBA TC35815 Ethernet support"
diff --git a/drivers/net/Space.c b/drivers/net/Space.c
index 068c356..3c53ab1 100644
--- a/drivers/net/Space.c
+++ b/drivers/net/Space.c
@@ -189,7 +189,7 @@ static struct devprobe2 isa_probes[] __initdata = {
 #ifdef CONFIG_SEEQ8005
 	{seeq8005_probe, 0},
 #endif
-#ifdef CONFIG_CS89x0
+#if defined(CONFIG_CS89x0) && !defined(CONFIG_CS89x0_PLATFORM)
  	{cs89x0_probe, 0},
 #endif
 #ifdef CONFIG_AT1700
diff --git a/drivers/net/cs89x0.c b/drivers/net/cs89x0.c
index 537a4b2..b7fb3bc 100644
--- a/drivers/net/cs89x0.c
+++ b/drivers/net/cs89x0.c
@@ -12,6 +12,14 @@
         The author may be reached at nelson at crynwr.com, Crynwr
         Software, 521 Pleasant Valley Rd., Potsdam, NY 13676
 
+Sources
+
+	Crynwr packet driver epktisa.
+
+	Crystal Semiconductor data sheets.
+
+
+
   Changelog:
 
   Mike Cruse        : mcruse at cti-ltd.com
@@ -98,39 +106,14 @@
   Domenico Andreoli : cavokz at gmail.com
                     : QQ2440 platform support
 
+  Jaccon Bastiaansen: jaccon.bastiaansen at gmail.com
+		    : added platform driver support
 */
 
-/* Always include 'config.h' first in case the user wants to turn on
-   or override something. */
-#include <linux/module.h>
-
-/*
- * Set this to zero to disable DMA code
- *
- * Note that even if DMA is turned off we still support the 'dma' and  'use_dma'
- * module options so we don't break any startup scripts.
- */
-#ifndef CONFIG_ISA_DMA_API
-#define ALLOW_DMA	0
-#else
-#define ALLOW_DMA	1
-#endif
-
-/*
- * Set this to zero to remove all the debug statements via
- * dead code elimination
- */
-#define DEBUGGING	1
-
-/*
-  Sources:
-
-	Crynwr packet driver epktisa.
-
-	Crystal Semiconductor data sheets.
-
-*/
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/module.h>
+#include <linux/printk.h>
 #include <linux/errno.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -147,21 +130,36 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/gfp.h>
-
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#if ALLOW_DMA
+#include <linux/platform_device.h>
+#include "cs89x0.h"
+
+/*
+ * Set this to zero to disable DMA code
+ *
+ * Note that even if DMA is turned off we still support the 'dma' and  'use_dma'
+ * module options so we don't break any startup scripts.
+ */
+#ifndef CONFIG_ISA_DMA_API
+#define ALLOW_DMA	0
+#else
+#define ALLOW_DMA	1
 #include <asm/dma.h>
 #endif
 
-#include "cs89x0.h"
-
-static char version[] __initdata =
-"cs89x0.c: v2.4.3-pre1 Russell Nelson <nelson@crynwr.com>, Andrew Morton\n";
+/*
+ * Set this to zero to remove all the debug statements via
+ * dead code elimination
+ */
+#define DEBUGGING	1
 
 #define DRV_NAME "cs89x0"
 
+static char version[] =
+"cs89x0.c: v2.4.3-pre1 Russell Nelson <nelson@crynwr.com>, Andrew Morton\n";
+
 /* First, a few definitions that the brave might change.
    A zero-terminated list of I/O addresses to be probed. Some special flags..
       Addr & 1 = Read back the address port, look for signature and reset
@@ -173,22 +171,9 @@ static char version[] __initdata =
 /* The cs8900 has 4 IRQ pins, software selectable. cs8900_irq_map maps
    them to system IRQ numbers. This mapping is card specific and is set to
    the configuration of the Cirrus Eval board for this chip. */
-#if defined(CONFIG_MACH_IXDP2351)
-static unsigned int netcard_portlist[] __used __initdata = {IXDP2351_VIRT_CS8900_BASE, 0};
-static unsigned int cs8900_irq_map[] = {IRQ_IXDP2351_CS8900, 0, 0, 0};
-#elif defined(CONFIG_ARCH_IXDP2X01)
-static unsigned int netcard_portlist[] __used __initdata = {IXDP2X01_CS8900_VIRT_BASE, 0};
-static unsigned int cs8900_irq_map[] = {IRQ_IXDP2X01_CS8900, 0, 0, 0};
-#elif defined(CONFIG_MACH_QQ2440)
-#include <mach/qq2440.h>
-static unsigned int netcard_portlist[] __used __initdata = { QQ2440_CS8900_VIRT_BASE + 0x300, 0 };
-static unsigned int cs8900_irq_map[] = { QQ2440_CS8900_IRQ, 0, 0, 0 };
-#elif defined(CONFIG_MACH_MX31ADS)
-#include <mach/board-mx31ads.h>
-static unsigned int netcard_portlist[] __used __initdata = {
-	PBC_BASE_ADDRESS + PBC_CS8900A_IOBASE + 0x300, 0
-};
-static unsigned cs8900_irq_map[] = {EXPIO_INT_ENET_INT, 0, 0, 0};
+#if defined(CONFIG_CS89x0_PLATFORM)
+static unsigned int netcard_portlist[] __used __initdata = {0, 0};
+static unsigned int cs8900_irq_map[] = {0, 0, 0, 0};
 #else
 static unsigned int netcard_portlist[] __used __initdata =
    { 0x300, 0x320, 0x340, 0x360, 0x200, 0x220, 0x240, 0x260, 0x280, 0x2a0, 0x2c0, 0x2e0, 0};
@@ -424,7 +409,7 @@ writereg(struct net_device *dev, u16 regno, u16 value)
 	writeword(dev->base_addr, DATA_PORT, value);
 }
 
-static int __init
+static int
 wait_eeprom_ready(struct net_device *dev)
 {
 	int timeout = jiffies;
@@ -437,7 +422,7 @@ wait_eeprom_ready(struct net_device *dev)
 	return 0;
 }
 
-static int __init
+static int
 get_eeprom_data(struct net_device *dev, int off, int len, int *buffer)
 {
 	int i;
@@ -455,7 +440,7 @@ get_eeprom_data(struct net_device *dev, int off, int len, int *buffer)
         return 0;
 }
 
-static int  __init
+static int
 get_eeprom_cksum(int off, int len, int *buffer)
 {
 	int i, cksum;
@@ -503,7 +488,7 @@ static const struct net_device_ops net_ops = {
    Return 0 on success.
  */
 
-static int __init
+static int
 cs89x0_probe1(struct net_device *dev, int ioaddr, int modular)
 {
 	struct net_local *lp = netdev_priv(dev);
@@ -529,9 +514,6 @@ cs89x0_probe1(struct net_device *dev, int ioaddr, int modular)
 		lp->force = g_cs89x0_media__force;
 #endif
 
-#if defined(CONFIG_MACH_QQ2440)
-		lp->force |= FORCE_RJ45 | FORCE_FULL;
-#endif
         }
 
 	/* Grab the region so we can find another board if autoIRQ fails. */
@@ -737,7 +719,7 @@ cs89x0_probe1(struct net_device *dev, int ioaddr, int modular)
 	} else {
 		i = lp->isa_config & INT_NO_MASK;
 		if (lp->chip_type == CS8900) {
-#ifdef CONFIG_CS89x0_NONISA_IRQ
+#ifdef CONFIG_CS89x0_PLATFORM
 		        i = cs8900_irq_map[0];
 #else
 			/* Translate the IRQ using the IRQ mapping table. */
@@ -1228,7 +1210,7 @@ net_open(struct net_device *dev)
 	}
 	else
 	{
-#ifndef CONFIG_CS89x0_NONISA_IRQ
+#ifndef CONFIG_CS89x0_PLATFORM
 		if (((1 << dev->irq) & lp->irq_map) == 0) {
 			printk(KERN_ERR "%s: IRQ %d is not in our map of allowable IRQs, which is %x\n",
                                dev->name, dev->irq, lp->irq_map);
@@ -1746,7 +1728,7 @@ static int set_mac_address(struct net_device *dev, void *p)
 	return 0;
 }
 
-#ifdef MODULE
+#if defined(MODULE) && !defined(CONFIG_CS89x0_PLATFORM)
 
 static struct net_device *dev_cs89x0;
 
@@ -1900,7 +1882,74 @@ cleanup_module(void)
 	release_region(dev_cs89x0->base_addr, NETCARD_IO_EXTENT);
 	free_netdev(dev_cs89x0);
 }
-#endif /* MODULE */
+#endif /* MODULE && !CONFIG_CS89x0_PLATFORM */
+
+#ifdef CONFIG_CS89x0_PLATFORM
+static int cs89x0_platform_probe(struct platform_device *pdev)
+{
+	struct net_device *dev = alloc_etherdev(sizeof(struct net_local));
+	struct resource *mem_res;
+	struct resource *irq_res;
+	int err;
+
+	if (!dev)
+		return -ENODEV;
+
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (mem_res == NULL || irq_res == NULL) {
+		pr_warning("memory and/or interrupt resource missing.\n");
+		err = -ENOENT;
+		goto out;
+	}
+
+	cs8900_irq_map[0] = irq_res->start;
+	err = cs89x0_probe1(dev, mem_res->start, 0);
+	if (err) {
+		pr_warning("no cs8900 or cs8920 detected.\n");
+		goto out;
+	}
+
+	platform_set_drvdata(pdev, dev);
+	return 0;
+out:
+	free_netdev(dev);
+	return err;
+}
+
+static int cs89x0_platform_remove(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+
+	unregister_netdev(dev);
+	free_netdev(dev);
+	return 0;
+}
+
+static struct platform_driver cs89x0_platform_driver = {
+	.driver	= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe	= cs89x0_platform_probe,
+	.remove	= cs89x0_platform_remove,
+};
+
+static int __init cs89x0_init(void)
+{
+	return platform_driver_register(&cs89x0_platform_driver);
+}
+
+module_init(cs89x0_init);
+
+static void __exit cs89x0_cleanup(void)
+{
+	platform_driver_unregister(&cs89x0_platform_driver);
+}
+
+module_exit(cs89x0_cleanup);
+
+#endif
 
 /*
  * Local variables:
-- 
1.7.1
