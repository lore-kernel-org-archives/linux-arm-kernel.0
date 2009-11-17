From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Nov 2009 22:15:43 +0100
Subject: [PATCH 04/10] IXP4xx: move NSLU2 platform macros to the platform code.
Message-ID: <1258492549-16873-4-git-send-email-khc@pm.waw.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Ha?asa <khc@pm.waw.pl>

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/include/mach/hardware.h |    1 -
 arch/arm/mach-ixp4xx/include/mach/irqs.h     |    7 ---
 arch/arm/mach-ixp4xx/include/mach/nslu2.h    |   55 --------------------------
 arch/arm/mach-ixp4xx/nslu2-pci.c             |   13 ++++++-
 arch/arm/mach-ixp4xx/nslu2-setup.c           |   21 +++++++++-
 5 files changed, 32 insertions(+), 65 deletions(-)
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/nslu2.h

diff --git a/arch/arm/mach-ixp4xx/include/mach/hardware.h b/arch/arm/mach-ixp4xx/include/mach/hardware.h
index 1fbed65..b949cd2 100644
--- a/arch/arm/mach-ixp4xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp4xx/include/mach/hardware.h
@@ -45,7 +45,6 @@
 
 /* Platform specific details */
 #include "prpmc1100.h"
-#include "nslu2.h"
 #include "nas100d.h"
 #include "dsmg600.h"
 #include "fsg.h"
diff --git a/arch/arm/mach-ixp4xx/include/mach/irqs.h b/arch/arm/mach-ixp4xx/include/mach/irqs.h
index e4c6cca..b7e372e 100644
--- a/arch/arm/mach-ixp4xx/include/mach/irqs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/irqs.h
@@ -79,13 +79,6 @@
 #define	IRQ_PRPMC1100_PCI_INTD	IRQ_IXP4XX_GPIO8
 
 /*
- * NSLU2 board IRQs
- */
-#define        IRQ_NSLU2_PCI_INTA      IRQ_IXP4XX_GPIO11
-#define        IRQ_NSLU2_PCI_INTB      IRQ_IXP4XX_GPIO10
-#define        IRQ_NSLU2_PCI_INTC      IRQ_IXP4XX_GPIO9
-
-/*
  * NAS100D board IRQs
  */
 #define        IRQ_NAS100D_PCI_INTA    IRQ_IXP4XX_GPIO11
diff --git a/arch/arm/mach-ixp4xx/include/mach/nslu2.h b/arch/arm/mach-ixp4xx/include/mach/nslu2.h
deleted file mode 100644
index 85d00ad..0000000
--- a/arch/arm/mach-ixp4xx/include/mach/nslu2.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * arch/arm/mach-ixp4xx/include/mach/nslu2.h
- *
- * NSLU2 platform specific definitions
- *
- * Author: Mark Rakes <mrakes AT mac.com>
- * Maintainers: http://www.nslu2-linux.org
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
-#define NSLU2_SDA_PIN		7
-#define NSLU2_SCL_PIN		6
-
-/*
- * NSLU2 PCI IRQs
- */
-#define NSLU2_PCI_MAX_DEV	3
-#define NSLU2_PCI_IRQ_LINES	3
-
-
-/* PCI controller GPIO to IRQ pin mappings */
-#define NSLU2_PCI_INTA_PIN	11
-#define NSLU2_PCI_INTB_PIN	10
-#define NSLU2_PCI_INTC_PIN	9
-#define NSLU2_PCI_INTD_PIN	8
-
-/* NSLU2 Timer */
-#define NSLU2_FREQ 66000000
-
-/* Buttons */
-
-#define NSLU2_PB_GPIO		5	/* power button */
-#define NSLU2_PO_GPIO		8	/* power off */
-#define NSLU2_RB_GPIO		12	/* reset button */
-
-/* Buzzer */
-
-#define NSLU2_GPIO_BUZZ		4
-
-/* LEDs */
-
-#define NSLU2_LED_RED_GPIO	0
-#define NSLU2_LED_GRN_GPIO	1
-#define NSLU2_LED_DISK1_GPIO	3
-#define NSLU2_LED_DISK2_GPIO	2
diff --git a/arch/arm/mach-ixp4xx/nslu2-pci.c b/arch/arm/mach-ixp4xx/nslu2-pci.c
index 4429b84..9665bb0 100644
--- a/arch/arm/mach-ixp4xx/nslu2-pci.c
+++ b/arch/arm/mach-ixp4xx/nslu2-pci.c
@@ -18,10 +18,21 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/irq.h>
-
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
+#define NSLU2_PCI_MAX_DEV	3
+#define NSLU2_PCI_IRQ_LINES	3
+
+/* PCI controller GPIO to IRQ pin mappings */
+#define NSLU2_PCI_INTA_PIN	11
+#define NSLU2_PCI_INTB_PIN	10
+#define NSLU2_PCI_INTC_PIN	9
+#define NSLU2_PCI_INTD_PIN	8
+#define IRQ_NSLU2_PCI_INTA      IRQ_IXP4XX_GPIO11
+#define IRQ_NSLU2_PCI_INTB      IRQ_IXP4XX_GPIO10
+#define IRQ_NSLU2_PCI_INTC      IRQ_IXP4XX_GPIO9
+
 void __init nslu2_pci_preinit(void)
 {
 	set_irq_type(IRQ_NSLU2_PCI_INTA, IRQ_TYPE_LEVEL_LOW);
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index ff6a08d..c14e003 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -26,13 +26,32 @@
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
 #include <linux/io.h>
-
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/time.h>
 #include <asm/gpio.h>
 
+#define NSLU2_SDA_PIN		7
+#define NSLU2_SCL_PIN		6
+
+/* NSLU2 Timer */
+#define NSLU2_FREQ 66000000
+
+/* Buttons */
+#define NSLU2_PB_GPIO		5	/* power button */
+#define NSLU2_PO_GPIO		8	/* power off */
+#define NSLU2_RB_GPIO		12	/* reset button */
+
+/* Buzzer */
+#define NSLU2_GPIO_BUZZ		4
+
+/* LEDs */
+#define NSLU2_LED_RED_GPIO	0
+#define NSLU2_LED_GRN_GPIO	1
+#define NSLU2_LED_DISK1_GPIO	3
+#define NSLU2_LED_DISK2_GPIO	2
+
 static struct flash_platform_data nslu2_flash_data = {
 	.map_name		= "cfi_probe",
 	.width			= 2,
-- 
1.6.5.2
