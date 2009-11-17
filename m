From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Nov 2009 22:15:45 +0100
Subject: [PATCH 06/10] IXP4xx: move DSM G600 platform macros to the platform
	code.
Message-ID: <1258492549-16873-6-git-send-email-khc@pm.waw.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Ha?asa <khc@pm.waw.pl>

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/dsmg600-pci.c           |   19 +++++++++-
 arch/arm/mach-ixp4xx/dsmg600-setup.c         |   17 ++++++++
 arch/arm/mach-ixp4xx/include/mach/dsmg600.h  |   52 --------------------------
 arch/arm/mach-ixp4xx/include/mach/hardware.h |    1 -
 arch/arm/mach-ixp4xx/include/mach/irqs.h     |   10 -----
 5 files changed, 35 insertions(+), 64 deletions(-)
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/dsmg600.h

diff --git a/arch/arm/mach-ixp4xx/dsmg600-pci.c b/arch/arm/mach-ixp4xx/dsmg600-pci.c
index 926d15f..29a9e41 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-pci.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-pci.c
@@ -19,10 +19,27 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/irq.h>
-
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
+#define DSMG600_PCI_MAX_DEV	4
+#define DSMG600_PCI_IRQ_LINES	3
+
+/* PCI controller GPIO to IRQ pin mappings */
+#define DSMG600_PCI_INTA_PIN	11
+#define DSMG600_PCI_INTB_PIN	10
+#define DSMG600_PCI_INTC_PIN	9
+#define DSMG600_PCI_INTD_PIN	8
+#define DSMG600_PCI_INTE_PIN	7
+#define DSMG600_PCI_INTF_PIN	6
+
+#define IRQ_DSMG600_PCI_INTA	IRQ_IXP4XX_GPIO11
+#define IRQ_DSMG600_PCI_INTB	IRQ_IXP4XX_GPIO10
+#define IRQ_DSMG600_PCI_INTC	IRQ_IXP4XX_GPIO9
+#define IRQ_DSMG600_PCI_INTD	IRQ_IXP4XX_GPIO8
+#define IRQ_DSMG600_PCI_INTE	IRQ_IXP4XX_GPIO7
+#define IRQ_DSMG600_PCI_INTF	IRQ_IXP4XX_GPIO6
+
 void __init dsmg600_pci_preinit(void)
 {
 	set_irq_type(IRQ_DSMG600_PCI_INTA, IRQ_TYPE_LEVEL_LOW);
diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index a51bfa6..7c1fa54 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -33,6 +33,23 @@
 #include <asm/mach/time.h>
 #include <asm/gpio.h>
 
+#define DSMG600_SDA_PIN		5
+#define DSMG600_SCL_PIN		4
+
+/* DSM-G600 Timer Setting */
+#define DSMG600_FREQ		66000000
+
+/* Buttons */
+#define DSMG600_PB_GPIO		15	/* power button */
+#define DSMG600_RB_GPIO		3	/* reset button */
+
+/* Power control */
+#define DSMG600_PO_GPIO		2	/* power off */
+
+/* LEDs */
+#define DSMG600_LED_PWR_GPIO	0
+#define DSMG600_LED_WLAN_GPIO	14
+
 static struct flash_platform_data dsmg600_flash_data = {
 	.map_name		= "cfi_probe",
 	.width			= 2,
diff --git a/arch/arm/mach-ixp4xx/include/mach/dsmg600.h b/arch/arm/mach-ixp4xx/include/mach/dsmg600.h
deleted file mode 100644
index dc087a3..0000000
--- a/arch/arm/mach-ixp4xx/include/mach/dsmg600.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * DSM-G600 platform specific definitions
- *
- * Copyright (C) 2006 Tower Technologies
- * Author: Alessandro Zummo <a.zummo@towertech.it>
- *
- * based on ixdp425.h:
- *	Copyright 2004 (C) MontaVista, Software, Inc.
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H__
-#error "Do not include this directly, instead #include <mach/hardware.h>"
-#endif
-
-#define DSMG600_SDA_PIN		5
-#define DSMG600_SCL_PIN		4
-
-/*
- * DSMG600 PCI IRQs
- */
-#define DSMG600_PCI_MAX_DEV	4
-#define DSMG600_PCI_IRQ_LINES	3
-
-
-/* PCI controller GPIO to IRQ pin mappings */
-#define DSMG600_PCI_INTA_PIN	11
-#define DSMG600_PCI_INTB_PIN	10
-#define DSMG600_PCI_INTC_PIN	9
-#define DSMG600_PCI_INTD_PIN	8
-#define DSMG600_PCI_INTE_PIN	7
-#define DSMG600_PCI_INTF_PIN	6
-
-/* DSM-G600 Timer Setting */
-#define DSMG600_FREQ 66000000
-
-/* Buttons */
-
-#define DSMG600_PB_GPIO		15	/* power button */
-#define DSMG600_RB_GPIO		3	/* reset button */
-
-/* Power control */
-
-#define DSMG600_PO_GPIO		2	/* power off */
-
-/* LEDs */
-
-#define DSMG600_LED_PWR_GPIO	0
-#define DSMG600_LED_WLAN_GPIO	14
diff --git a/arch/arm/mach-ixp4xx/include/mach/hardware.h b/arch/arm/mach-ixp4xx/include/mach/hardware.h
index 05db635..555b8e1 100644
--- a/arch/arm/mach-ixp4xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp4xx/include/mach/hardware.h
@@ -45,7 +45,6 @@
 
 /* Platform specific details */
 #include "prpmc1100.h"
-#include "dsmg600.h"
 #include "fsg.h"
 
 #endif  /* _ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-ixp4xx/include/mach/irqs.h b/arch/arm/mach-ixp4xx/include/mach/irqs.h
index dff26af..20053be 100644
--- a/arch/arm/mach-ixp4xx/include/mach/irqs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/irqs.h
@@ -79,16 +79,6 @@
 #define	IRQ_PRPMC1100_PCI_INTD	IRQ_IXP4XX_GPIO8
 
 /*
- * D-Link DSM-G600 RevA board IRQs
- */
-#define        IRQ_DSMG600_PCI_INTA    IRQ_IXP4XX_GPIO11
-#define        IRQ_DSMG600_PCI_INTB    IRQ_IXP4XX_GPIO10
-#define        IRQ_DSMG600_PCI_INTC    IRQ_IXP4XX_GPIO9
-#define        IRQ_DSMG600_PCI_INTD    IRQ_IXP4XX_GPIO8
-#define        IRQ_DSMG600_PCI_INTE    IRQ_IXP4XX_GPIO7
-#define        IRQ_DSMG600_PCI_INTF    IRQ_IXP4XX_GPIO6
-
-/*
  * Freecom FSG-3 Board IRQs
  */
 #define        IRQ_FSG_PCI_INTA        IRQ_IXP4XX_GPIO6
-- 
1.6.5.2
