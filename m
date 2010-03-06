From: karl@hiramoto.org (Karl Hiramoto)
Date: Sat,  6 Mar 2010 16:23:20 +0100
Subject: [PATCH] IXP4XX: Board support for IronGate S.L. NetSurvibox
Message-ID: <1267889000-21604-1-git-send-email-karl@hiramoto.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the necesary code to support the NetSurvibox, and it's PCI mappings.

Signed-off-by: Karl Hiramoto <karl@hiramoto.org>
---
 arch/arm/mach-ixp4xx/Kconfig                   |   56 +++++++++++
 arch/arm/mach-ixp4xx/Makefile                  |    1 +
 arch/arm/mach-ixp4xx/include/mach/uncompress.h |    3 +-
 arch/arm/mach-ixp4xx/ixdp425-setup.c           |   14 +++
 arch/arm/mach-ixp4xx/nsb-pci.c                 |  119 ++++++++++++++++++++++++
 5 files changed, 192 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ixp4xx/nsb-pci.c

diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index 9e5070d..a4acd39 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -153,6 +153,62 @@ config CPU_IXP43X
 	depends on MACH_KIXRP435
 	default y
 
+config ARCH_NSBXXX
+	bool
+	default n
+
+config MACH_NSB
+	bool
+	prompt "IronGate S.L. NetSurvibox 266"
+	depends on ARCH_IXP4XX
+	select PCI
+	select ARCH_NSBXXX
+	help
+		Say 'Y' here if you want your kernel to support Iron Gate S.L.'s
+		NetSurvibox 266  see http://www.iron-gate.net/
+
+		IXP425 - 266mhz
+		64MB SDRAM
+		8MB Flash
+		miniPCI slot 0 available.
+		Realtech 81XX on PCI (uses 8139too)
+		HighPoint IDE controller for Compat Flash on PCI bus (hpt371)
+		Via USB EHCI on PCI bus
+		NPE-B is connected to a ethernet port
+		NPE-C / Utopia bus is on module connector
+		"Console" UART is available on DB-9 ttyS1
+
+
+config MACH_NSB400
+	bool
+	prompt "IronGate S.L. NetSurvibox 400"
+	depends on ARCH_IXP4XX
+	select PCI
+	select ARCH_NSBXXX
+	help
+	Say 'Y' here if you want your kernel to support Iron Gate S.L.'s
+	NetSurvibox 667  see http://www.iron-gate.net/
+
+	IXP435 - 400mhz
+	128MB RAM
+	16MB Flash
+
+
+config MACH_NSB667
+	bool
+	prompt "IronGate S.L. NetSurvibox 667"
+	depends on ARCH_IXP4XX
+	select PCI
+	select ARCH_NSBXXX
+	help
+	Say 'Y' here if you want your kernel to support Iron Gate S.L.'s
+	NetSurvibox 667  see http://www.iron-gate.net/
+
+	IXP435 - 667mhz
+	256MB RAM
+	16MB Flash
+
+
 config MACH_GTWX5715
 	bool "Gemtek WX5715 (Linksys WRV54G)"
 	depends on ARCH_IXP4XX
diff --git a/arch/arm/mach-ixp4xx/Makefile b/arch/arm/mach-ixp4xx/Makefile
index 47d1f60..c21da4c 100644
--- a/arch/arm/mach-ixp4xx/Makefile
+++ b/arch/arm/mach-ixp4xx/Makefile
@@ -12,6 +12,7 @@ obj-pci-$(CONFIG_ARCH_ADI_COYOTE)	+= coyote-pci.o
 obj-pci-$(CONFIG_MACH_GTWX5715)		+= gtwx5715-pci.o
 obj-pci-$(CONFIG_MACH_NSLU2)		+= nslu2-pci.o
 obj-pci-$(CONFIG_MACH_NAS100D)		+= nas100d-pci.o
+obj-pci-$(CONFIG_ARCH_NSBXXX)		+= nsb-pci.o
 obj-pci-$(CONFIG_MACH_DSMG600)		+= dsmg600-pci.o
 obj-pci-$(CONFIG_MACH_GATEWAY7001)	+= gateway7001-pci.o
 obj-pci-$(CONFIG_MACH_WG302V2)		+= wg302v2-pci.o
diff --git a/arch/arm/mach-ixp4xx/include/mach/uncompress.h b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
index 2db0078..ba40021 100644
--- a/arch/arm/mach-ixp4xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
@@ -41,7 +41,8 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	 * Some boards are using UART2 as console
 	 */
 	if (machine_is_adi_coyote() || machine_is_gtwx5715() ||
-			 machine_is_gateway7001() || machine_is_wg302v2())
+			machine_is_gateway7001() || machine_is_wg302v2() ||
+			machine_is_nsb())
 		uart_base = (volatile u32*) IXP4XX_UART2_BASE_PHYS;
 	else
 		uart_base = (volatile u32*) IXP4XX_UART1_BASE_PHYS;
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index bbb7689..2c83b2f 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -267,6 +267,20 @@ MACHINE_START(IXDP425, "Intel IXDP425 Development Platform")
 MACHINE_END
 #endif
 
+#ifdef CONFIG_MACH_NSB
+MACHINE_START(NSB, "IronGate NetSurviBox Network Platform")
+	/* Maintainer: Karl Hiramoto <karl@hiramoto.org>  */
+	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
+	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xfffc,
+	.map_io		= ixp4xx_map_io,
+	.init_irq	= ixp4xx_init_irq,
+	.timer		= &ixp4xx_timer,
+	.boot_params	= 0x0100,
+	.init_machine	= ixdp425_init,
+MACHINE_END
+
+#endif
+
 #ifdef CONFIG_MACH_IXDP465
 MACHINE_START(IXDP465, "Intel IXDP465 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
diff --git a/arch/arm/mach-ixp4xx/nsb-pci.c b/arch/arm/mach-ixp4xx/nsb-pci.c
new file mode 100644
index 0000000..f8f5c1f
--- /dev/null
+++ b/arch/arm/mach-ixp4xx/nsb-pci.c
@@ -0,0 +1,119 @@
+/*
+ * arch/arm/mach-ixp4xx/nsb-pci.c
+ *
+ * nsb  board-level PCI initialization
+ *
+ * Copyright (C) 2010 Iron Gate S.L.
+ *
+ * Based on ixdp425-pci.c
+ *
+ * Maintainer: Karl Hiramoto <karl@hiramoto.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/delay.h>
+#include <asm/mach/pci.h>
+#include <asm/irq.h>
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+
+#define MAX_DEV		4
+#define IRQ_LINES	4
+
+/* PCI controller GPIO to IRQ pin mappings */
+#define INTA		11  // GPIO 11 IRQ 28
+#define INTB		10
+#define INTC		9
+#define INTD		8
+
+#define IRQ_LINES   4
+#define MAX_DEV     4
+
+static void __init nsb_pci_preinit(void)
+{
+	set_irq_type(INTA, IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(INTB, IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(INTC, IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(INTD, IRQ_TYPE_LEVEL_LOW);
+
+	ixp4xx_pci_preinit();
+}
+
+static int __init nsb_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	static int pci_irq_table[MAX_DEV][IRQ_LINES] = {
+		{INTA, INTB, -1 , -1}, // IDE
+		{INTA, INTB, -1,  -1 }, // Mini-PCI
+		{INTA, INTB, INTC, -1}, // USB
+		{INTD, -1, -1, -1}  // Ethernet
+	};
+
+	int irq = -1;
+	if (slot >= 1 && slot <= MAX_DEV &&
+		pin >= 1 && pin <= IRQ_LINES)  {
+			irq = pci_irq_table[slot-1][pin-1];
+	}
+
+	return irq;
+}
+
+
+static int __init nsb400_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	static int pci_irq_table[MAX_DEV][IRQ_LINES] = {
+		{INTB, INTA, -1, -1},  /* Mini-PCI slot 0 J13*/
+		{INTD, INTC, -1, -1},  /* Mini-PCI slot 1 J14*/
+		{INTA, INTB, INTC, INTD},  /* 3.3V PCI slot */
+		{INTA, INTB, INTC, INTD}
+	};
+
+	int irq = -1;
+	if (slot >= 1 && slot <= MAX_DEV &&
+		pin >= 1 && pin <= IRQ_LINES)  {
+			irq = pci_irq_table[slot - 1][pin - 1];
+	}
+	pr_debug("nsb400_map_irq slot=%d pin=%d irq=%d\n", slot, pin, irq);
+
+	return irq;
+}
+struct hw_pci nsb_pci __initdata = {
+	.nr_controllers = 1,
+	.preinit	= nsb_pci_preinit,
+	.swizzle	= pci_std_swizzle,
+	.setup		= ixp4xx_setup,
+	.scan		= ixp4xx_scan_bus,
+	.map_irq	= nsb_map_irq,
+};
+
+struct hw_pci nsb400_pci __initdata = {
+	.nr_controllers = 1,
+	.preinit	= nsb_pci_preinit,
+	.swizzle	= pci_std_swizzle,
+	.setup		= ixp4xx_setup,
+	.scan		= ixp4xx_scan_bus,
+	.map_irq	= nsb400_map_irq,
+};
+
+
+int __init nsb_pci_init(void)
+{
+	if (machine_is_nsb()) {
+		pci_common_init(&nsb_pci);
+	} else if (machine_is_nsb400() || machine_is_nsb667()) {
+		pci_common_init(&nsb400_pci);
+	}
+
+	return 0;
+}
+
+
+subsys_initcall(nsb_pci_init);
+
-- 
1.6.6.2
