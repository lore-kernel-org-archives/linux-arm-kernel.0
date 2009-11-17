From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Nov 2009 22:15:42 +0100
Subject: [PATCH 03/10] IXP4xx: move Coyote platform macros to the platform
	code.
Message-ID: <1258492549-16873-3-git-send-email-khc@pm.waw.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Ha?asa <khc@pm.waw.pl>

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/coyote-pci.c            |   12 ++++++++-
 arch/arm/mach-ixp4xx/coyote-setup.c          |    9 +++++++
 arch/arm/mach-ixp4xx/include/mach/coyote.h   |   33 --------------------------
 arch/arm/mach-ixp4xx/include/mach/hardware.h |    1 -
 arch/arm/mach-ixp4xx/include/mach/irqs.h     |    7 -----
 5 files changed, 19 insertions(+), 43 deletions(-)
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/coyote.h

diff --git a/arch/arm/mach-ixp4xx/coyote-pci.c b/arch/arm/mach-ixp4xx/coyote-pci.c
index efddf01..624f8fe 100644
--- a/arch/arm/mach-ixp4xx/coyote-pci.c
+++ b/arch/arm/mach-ixp4xx/coyote-pci.c
@@ -18,13 +18,21 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/irq.h>
-
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
-
 #include <asm/mach/pci.h>
 
+#define COYOTE_PCI_SLOT0_DEVID	14
+#define COYOTE_PCI_SLOT1_DEVID	15
+
+/* PCI controller GPIO to IRQ pin mappings */
+#define COYOTE_PCI_SLOT0_PIN	6
+#define COYOTE_PCI_SLOT1_PIN	11
+
+#define IRQ_COYOTE_PCI_SLOT0	IRQ_IXP4XX_GPIO6
+#define IRQ_COYOTE_PCI_SLOT1	IRQ_IXP4XX_GPIO11
+
 void __init coyote_pci_preinit(void)
 {
 	set_irq_type(IRQ_COYOTE_PCI_SLOT0, IRQ_TYPE_LEVEL_LOW);
diff --git a/arch/arm/mach-ixp4xx/coyote-setup.c b/arch/arm/mach-ixp4xx/coyote-setup.c
index aab1954..25bf5ad 100644
--- a/arch/arm/mach-ixp4xx/coyote-setup.c
+++ b/arch/arm/mach-ixp4xx/coyote-setup.c
@@ -25,6 +25,15 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
+#define COYOTE_IDE_BASE_PHYS	IXP4XX_EXP_BUS_BASE(3)
+#define COYOTE_IDE_BASE_VIRT	0xFFFE1000
+#define COYOTE_IDE_REGION_SIZE	0x1000
+
+#define COYOTE_IDE_DATA_PORT	0xFFFE10E0
+#define COYOTE_IDE_CTRL_PORT	0xFFFE10FC
+#define COYOTE_IDE_ERROR_PORT	0xFFFE10E2
+#define IRQ_COYOTE_IDE		IRQ_IXP4XX_GPIO5
+
 static struct flash_platform_data coyote_flash_data = {
 	.map_name	= "cfi_probe",
 	.width		= 2,
diff --git a/arch/arm/mach-ixp4xx/include/mach/coyote.h b/arch/arm/mach-ixp4xx/include/mach/coyote.h
deleted file mode 100644
index 717ac6d..0000000
--- a/arch/arm/mach-ixp4xx/include/mach/coyote.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * arch/arm/mach-ixp4xx/include/mach/coyote.h
- *
- * ADI Engineering platform specific definitions
- *
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
-/* PCI controller GPIO to IRQ pin mappings */
-#define	COYOTE_PCI_SLOT0_PIN	6
-#define	COYOTE_PCI_SLOT1_PIN	11
-
-#define	COYOTE_PCI_SLOT0_DEVID	14
-#define	COYOTE_PCI_SLOT1_DEVID	15
-
-#define	COYOTE_IDE_BASE_PHYS	IXP4XX_EXP_BUS_BASE(3)
-#define	COYOTE_IDE_BASE_VIRT	0xFFFE1000
-#define	COYOTE_IDE_REGION_SIZE	0x1000
-
-#define	COYOTE_IDE_DATA_PORT	0xFFFE10E0
-#define	COYOTE_IDE_CTRL_PORT	0xFFFE10FC
-#define	COYOTE_IDE_ERROR_PORT	0xFFFE10E2
-
diff --git a/arch/arm/mach-ixp4xx/include/mach/hardware.h b/arch/arm/mach-ixp4xx/include/mach/hardware.h
index 72b7543..1fbed65 100644
--- a/arch/arm/mach-ixp4xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp4xx/include/mach/hardware.h
@@ -44,7 +44,6 @@
 #include "platform.h"
 
 /* Platform specific details */
-#include "coyote.h"
 #include "prpmc1100.h"
 #include "nslu2.h"
 #include "nas100d.h"
diff --git a/arch/arm/mach-ixp4xx/include/mach/irqs.h b/arch/arm/mach-ixp4xx/include/mach/irqs.h
index 5cb19fe..e4c6cca 100644
--- a/arch/arm/mach-ixp4xx/include/mach/irqs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/irqs.h
@@ -79,13 +79,6 @@
 #define	IRQ_PRPMC1100_PCI_INTD	IRQ_IXP4XX_GPIO8
 
 /*
- * ADI Coyote Board IRQs
- */
-#define	IRQ_COYOTE_PCI_SLOT0	IRQ_IXP4XX_GPIO6
-#define	IRQ_COYOTE_PCI_SLOT1	IRQ_IXP4XX_GPIO11
-#define	IRQ_COYOTE_IDE		IRQ_IXP4XX_GPIO5
-
-/*
  * NSLU2 board IRQs
  */
 #define        IRQ_NSLU2_PCI_INTA      IRQ_IXP4XX_GPIO11
-- 
1.6.5.2
