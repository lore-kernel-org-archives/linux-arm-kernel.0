From: maz@misterjones.org (Marc Zyngier)
Date: Sat, 10 Apr 2010 21:32:39 +0100
Subject: [PATCH 2/2] ixp4xx/vulcan: add PCI support
In-Reply-To: <1270931559-9414-1-git-send-email-maz@misterjones.org>
References: <1270931559-9414-1-git-send-email-maz@misterjones.org>
Message-ID: <1270931559-9414-2-git-send-email-maz@misterjones.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PCI support for the Vulcan board, supporting USB and CF ports.
The PC/104 bus (actually a hack on the second CarBus slot) is not
currently supported.

Signed-off-by: Marc Zyngier <maz@misterjones.org>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/Makefile     |    1 +
 arch/arm/mach-ixp4xx/vulcan-pci.c |   73 +++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ixp4xx/vulcan-pci.c

diff --git a/arch/arm/mach-ixp4xx/Makefile b/arch/arm/mach-ixp4xx/Makefile
index ab39693..d807fc3 100644
--- a/arch/arm/mach-ixp4xx/Makefile
+++ b/arch/arm/mach-ixp4xx/Makefile
@@ -16,6 +16,7 @@ obj-pci-$(CONFIG_MACH_DSMG600)		+= dsmg600-pci.o
 obj-pci-$(CONFIG_MACH_GATEWAY7001)	+= gateway7001-pci.o
 obj-pci-$(CONFIG_MACH_WG302V2)		+= wg302v2-pci.o
 obj-pci-$(CONFIG_MACH_FSG)		+= fsg-pci.o
+obj-pci-$(CONFIG_MACH_ARCOM_VULCAN)	+= vulcan-pci.o
 
 obj-y	+= common.o
 
diff --git a/arch/arm/mach-ixp4xx/vulcan-pci.c b/arch/arm/mach-ixp4xx/vulcan-pci.c
new file mode 100644
index 0000000..f3111c6
--- /dev/null
+++ b/arch/arm/mach-ixp4xx/vulcan-pci.c
@@ -0,0 +1,73 @@
+/*
+ * arch/arch/mach-ixp4xx/vulcan-pci.c
+ *
+ * Vulcan board-level PCI initialization
+ *
+ * Copyright (C) 2010 Marc Zyngier <maz@misterjones.org>
+ *
+ * based on ixdp425-pci.c:
+ *	Copyright (C) 2002 Intel Corporation.
+ *	Copyright (C) 2003-2004 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <asm/mach/pci.h>
+#include <asm/mach-types.h>
+
+/* PCI controller GPIO to IRQ pin mappings */
+#define INTA	2
+#define INTB	3
+
+void __init vulcan_pci_preinit(void)
+{
+#ifndef CONFIG_IXP4XX_INDIRECT_PCI
+	/*
+	 * Cardbus bridge wants way more than the SoC can actually offer,
+	 * and leaves the whole PCI bus in a mess. Artificially limit it
+	 * to 8MB per region. Of course indirect mode doesn't have this
+	 * limitation...
+	 */
+	pci_cardbus_mem_size = SZ_8M;
+	pr_info("Vulcan PCI: limiting CardBus memory size to %dMB\n",
+		(int)(pci_cardbus_mem_size >> 20));
+#endif
+	set_irq_type(IXP4XX_GPIO_IRQ(INTA), IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(IXP4XX_GPIO_IRQ(INTB), IRQ_TYPE_LEVEL_LOW);
+	ixp4xx_pci_preinit();
+}
+
+static int __init vulcan_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	if (slot == 1)
+		return IXP4XX_GPIO_IRQ(INTA);
+
+	if (slot == 2)
+		return IXP4XX_GPIO_IRQ(INTB);
+
+	return -1;
+}
+
+struct hw_pci vulcan_pci __initdata = {
+	.nr_controllers	= 1,
+	.preinit	= vulcan_pci_preinit,
+	.swizzle	= pci_std_swizzle,
+	.setup		= ixp4xx_setup,
+	.scan		= ixp4xx_scan_bus,
+	.map_irq	= vulcan_map_irq,
+};
+
+int __init vulcan_pci_init(void)
+{
+	if (machine_is_arcom_vulcan())
+		pci_common_init(&vulcan_pci);
+	return 0;
+}
+
+subsys_initcall(vulcan_pci_init);
-- 
1.7.0.4
