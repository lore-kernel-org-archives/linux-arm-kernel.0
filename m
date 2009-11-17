From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Nov 2009 22:15:44 +0100
Subject: [PATCH 05/10] IXP4xx: move NAS100D platform macros to the platform
	code.
Message-ID: <1258492549-16873-5-git-send-email-khc@pm.waw.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Ha?asa <khc@pm.waw.pl>

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/include/mach/hardware.h |    1 -
 arch/arm/mach-ixp4xx/include/mach/irqs.h     |    9 ----
 arch/arm/mach-ixp4xx/include/mach/nas100d.h  |   52 --------------------------
 arch/arm/mach-ixp4xx/nas100d-pci.c           |   17 ++++++++-
 arch/arm/mach-ixp4xx/nas100d-setup.c         |   16 +++++++-
 5 files changed, 31 insertions(+), 64 deletions(-)
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/nas100d.h

diff --git a/arch/arm/mach-ixp4xx/include/mach/hardware.h b/arch/arm/mach-ixp4xx/include/mach/hardware.h
index b949cd2..05db635 100644
--- a/arch/arm/mach-ixp4xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp4xx/include/mach/hardware.h
@@ -45,7 +45,6 @@
 
 /* Platform specific details */
 #include "prpmc1100.h"
-#include "nas100d.h"
 #include "dsmg600.h"
 #include "fsg.h"
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/irqs.h b/arch/arm/mach-ixp4xx/include/mach/irqs.h
index b7e372e..dff26af 100644
--- a/arch/arm/mach-ixp4xx/include/mach/irqs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/irqs.h
@@ -79,15 +79,6 @@
 #define	IRQ_PRPMC1100_PCI_INTD	IRQ_IXP4XX_GPIO8
 
 /*
- * NAS100D board IRQs
- */
-#define        IRQ_NAS100D_PCI_INTA    IRQ_IXP4XX_GPIO11
-#define        IRQ_NAS100D_PCI_INTB    IRQ_IXP4XX_GPIO10
-#define        IRQ_NAS100D_PCI_INTC    IRQ_IXP4XX_GPIO9
-#define        IRQ_NAS100D_PCI_INTD    IRQ_IXP4XX_GPIO8
-#define        IRQ_NAS100D_PCI_INTE    IRQ_IXP4XX_GPIO7
-
-/*
  * D-Link DSM-G600 RevA board IRQs
  */
 #define        IRQ_DSMG600_PCI_INTA    IRQ_IXP4XX_GPIO11
diff --git a/arch/arm/mach-ixp4xx/include/mach/nas100d.h b/arch/arm/mach-ixp4xx/include/mach/nas100d.h
deleted file mode 100644
index 3771d62..0000000
--- a/arch/arm/mach-ixp4xx/include/mach/nas100d.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * arch/arm/mach-ixp4xx/include/mach/nas100d.h
- *
- * NAS100D platform specific definitions
- *
- * Copyright (c) 2005 Tower Technologies
- *
- * Author: Alessandro Zummo <a.zummo@towertech.it>
- *
- * based on ixdp425.h:
- *	Copyright 2004 (c) MontaVista, Software, Inc.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H__
-#error "Do not include this directly, instead #include <mach/hardware.h>"
-#endif
-
-#define NAS100D_SDA_PIN		5
-#define NAS100D_SCL_PIN		6
-
-/*
- * NAS100D PCI IRQs
- */
-#define NAS100D_PCI_MAX_DEV	3
-#define NAS100D_PCI_IRQ_LINES	3
-
-
-/* PCI controller GPIO to IRQ pin mappings */
-#define NAS100D_PCI_INTA_PIN	11
-#define NAS100D_PCI_INTB_PIN	10
-#define NAS100D_PCI_INTC_PIN	9
-#define NAS100D_PCI_INTD_PIN	8
-#define NAS100D_PCI_INTE_PIN	7
-
-/* Buttons */
-
-#define NAS100D_PB_GPIO         14   /* power button */
-#define NAS100D_RB_GPIO         4    /* reset button */
-
-/* Power control */
-
-#define NAS100D_PO_GPIO         12   /* power off */
-
-/* LEDs */
-
-#define NAS100D_LED_WLAN_GPIO	0
-#define NAS100D_LED_DISK_GPIO	3
-#define NAS100D_LED_PWR_GPIO	15
diff --git a/arch/arm/mach-ixp4xx/nas100d-pci.c b/arch/arm/mach-ixp4xx/nas100d-pci.c
index 1088426..ac04fc1 100644
--- a/arch/arm/mach-ixp4xx/nas100d-pci.c
+++ b/arch/arm/mach-ixp4xx/nas100d-pci.c
@@ -18,10 +18,25 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/irq.h>
-
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
+#define NAS100D_PCI_MAX_DEV	3
+#define NAS100D_PCI_IRQ_LINES	3
+
+/* PCI controller GPIO to IRQ pin mappings */
+#define NAS100D_PCI_INTA_PIN	11
+#define NAS100D_PCI_INTB_PIN	10
+#define NAS100D_PCI_INTC_PIN	9
+#define NAS100D_PCI_INTD_PIN	8
+#define NAS100D_PCI_INTE_PIN	7
+
+#define IRQ_NAS100D_PCI_INTA    IRQ_IXP4XX_GPIO11
+#define IRQ_NAS100D_PCI_INTB    IRQ_IXP4XX_GPIO10
+#define IRQ_NAS100D_PCI_INTC    IRQ_IXP4XX_GPIO9
+#define IRQ_NAS100D_PCI_INTD    IRQ_IXP4XX_GPIO8
+#define IRQ_NAS100D_PCI_INTE    IRQ_IXP4XX_GPIO7
+
 void __init nas100d_pci_preinit(void)
 {
 	set_irq_type(IRQ_NAS100D_PCI_INTA, IRQ_TYPE_LEVEL_LOW);
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index 921c947..e3ee880 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -29,12 +29,26 @@
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
 #include <linux/io.h>
-
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/gpio.h>
 
+#define NAS100D_SDA_PIN		5
+#define NAS100D_SCL_PIN		6
+
+/* Buttons */
+#define NAS100D_PB_GPIO         14   /* power button */
+#define NAS100D_RB_GPIO         4    /* reset button */
+
+/* Power control */
+#define NAS100D_PO_GPIO         12   /* power off */
+
+/* LEDs */
+#define NAS100D_LED_WLAN_GPIO	0
+#define NAS100D_LED_DISK_GPIO	3
+#define NAS100D_LED_PWR_GPIO	15
+
 static struct flash_platform_data nas100d_flash_data = {
 	.map_name		= "cfi_probe",
 	.width			= 2,
-- 
1.6.5.2
