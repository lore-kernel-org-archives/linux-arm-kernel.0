From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Nov 2009 22:15:41 +0100
Subject: [PATCH 02/10] IXP4xx: move AVILA platform macros to the platform code.
Message-ID: <1258492549-16873-2-git-send-email-khc@pm.waw.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Ha?asa <khc@pm.waw.pl>

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/avila-pci.c             |   16 ++++++++++-
 arch/arm/mach-ixp4xx/avila-setup.c           |    4 ++-
 arch/arm/mach-ixp4xx/include/mach/avila.h    |   39 --------------------------
 arch/arm/mach-ixp4xx/include/mach/hardware.h |    1 -
 arch/arm/mach-ixp4xx/include/mach/irqs.h     |    9 ------
 5 files changed, 18 insertions(+), 51 deletions(-)
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/avila.h

diff --git a/arch/arm/mach-ixp4xx/avila-pci.c b/arch/arm/mach-ixp4xx/avila-pci.c
index 08d65dc..14df8cf 100644
--- a/arch/arm/mach-ixp4xx/avila-pci.c
+++ b/arch/arm/mach-ixp4xx/avila-pci.c
@@ -22,12 +22,26 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/delay.h>
-
 #include <asm/mach/pci.h>
 #include <asm/irq.h>
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 
+#define AVILA_PCI_MAX_DEV	4
+#define LOFT_PCI_MAX_DEV	6
+#define AVILA_PCI_IRQ_LINES	4
+
+/* PCI controller GPIO to IRQ pin mappings */
+#define AVILA_PCI_INTA_PIN	11
+#define AVILA_PCI_INTB_PIN	10
+#define AVILA_PCI_INTC_PIN	9
+#define AVILA_PCI_INTD_PIN	8
+
+#define IRQ_AVILA_PCI_INTA	IRQ_IXP4XX_GPIO11
+#define IRQ_AVILA_PCI_INTB	IRQ_IXP4XX_GPIO10
+#define IRQ_AVILA_PCI_INTC	IRQ_IXP4XX_GPIO9
+#define IRQ_AVILA_PCI_INTD	IRQ_IXP4XX_GPIO8
+
 void __init avila_pci_preinit(void)
 {
 	set_irq_type(IRQ_AVILA_PCI_INTA, IRQ_TYPE_LEVEL_LOW);
diff --git a/arch/arm/mach-ixp4xx/avila-setup.c b/arch/arm/mach-ixp4xx/avila-setup.c
index 797995c..6e558a7 100644
--- a/arch/arm/mach-ixp4xx/avila-setup.c
+++ b/arch/arm/mach-ixp4xx/avila-setup.c
@@ -19,7 +19,6 @@
 #include <linux/serial_8250.h>
 #include <linux/slab.h>
 #include <linux/i2c-gpio.h>
-
 #include <asm/types.h>
 #include <asm/setup.h>
 #include <asm/memory.h>
@@ -29,6 +28,9 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
+#define AVILA_SDA_PIN	7
+#define AVILA_SCL_PIN	6
+
 static struct flash_platform_data avila_flash_data = {
 	.map_name	= "cfi_probe",
 	.width		= 2,
diff --git a/arch/arm/mach-ixp4xx/include/mach/avila.h b/arch/arm/mach-ixp4xx/include/mach/avila.h
deleted file mode 100644
index 1640cb6..0000000
--- a/arch/arm/mach-ixp4xx/include/mach/avila.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * arch/arm/mach-ixp4xx/include/mach/avila.h
- *
- * Gateworks Avila platform specific definitions
- *
- * Author: Michael-Luke Jones <mlj28@cam.ac.uk>
- *
- * Based on ixdp425.h
- * Author: Deepak Saxena <dsaxena@plexity.net>
- *
- * Copyright 2004 (c) MontaVista, Software, Inc.
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
-#define	AVILA_SDA_PIN		7
-#define	AVILA_SCL_PIN		6
-
-/*
- * AVILA PCI IRQs
- */
-#define AVILA_PCI_MAX_DEV	4
-#define LOFT_PCI_MAX_DEV    6
-#define AVILA_PCI_IRQ_LINES	4
-
-
-/* PCI controller GPIO to IRQ pin mappings */
-#define AVILA_PCI_INTA_PIN	11
-#define AVILA_PCI_INTB_PIN	10
-#define AVILA_PCI_INTC_PIN	9
-#define AVILA_PCI_INTD_PIN	8
-
-
diff --git a/arch/arm/mach-ixp4xx/include/mach/hardware.h b/arch/arm/mach-ixp4xx/include/mach/hardware.h
index 30ca67b..72b7543 100644
--- a/arch/arm/mach-ixp4xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp4xx/include/mach/hardware.h
@@ -44,7 +44,6 @@
 #include "platform.h"
 
 /* Platform specific details */
-#include "avila.h"
 #include "coyote.h"
 #include "prpmc1100.h"
 #include "nslu2.h"
diff --git a/arch/arm/mach-ixp4xx/include/mach/irqs.h b/arch/arm/mach-ixp4xx/include/mach/irqs.h
index 4bb6d66..5cb19fe 100644
--- a/arch/arm/mach-ixp4xx/include/mach/irqs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/irqs.h
@@ -71,15 +71,6 @@
 #define	XSCALE_PMU_IRQ		(IRQ_IXP4XX_XSCALE_PMU)
 
 /*
- * Gateworks Avila board IRQs
- */
-#define	IRQ_AVILA_PCI_INTA	IRQ_IXP4XX_GPIO11
-#define	IRQ_AVILA_PCI_INTB	IRQ_IXP4XX_GPIO10
-#define	IRQ_AVILA_PCI_INTC	IRQ_IXP4XX_GPIO9
-#define	IRQ_AVILA_PCI_INTD	IRQ_IXP4XX_GPIO8
-
-
-/*
  * PrPMC1100 Board IRQs
  */
 #define	IRQ_PRPMC1100_PCI_INTA	IRQ_IXP4XX_GPIO11
-- 
1.6.5.2
