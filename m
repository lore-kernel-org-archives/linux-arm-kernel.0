From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Nov 2009 22:15:40 +0100
Subject: [PATCH 01/10] IXP4xx: move IXDP425 platform macros to the platform
	code.
Message-ID: <1258492549-16873-1-git-send-email-khc@pm.waw.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Ha?asa <khc@pm.waw.pl>

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/include/mach/hardware.h |    1 -
 arch/arm/mach-ixp4xx/include/mach/irqs.h     |    8 -----
 arch/arm/mach-ixp4xx/include/mach/ixdp425.h  |   39 --------------------------
 arch/arm/mach-ixp4xx/ixdp425-pci.c           |   17 ++++++++++-
 arch/arm/mach-ixp4xx/ixdp425-setup.c         |   12 ++++++-
 5 files changed, 25 insertions(+), 52 deletions(-)
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/ixdp425.h

diff --git a/arch/arm/mach-ixp4xx/include/mach/hardware.h b/arch/arm/mach-ixp4xx/include/mach/hardware.h
index f822b22..30ca67b 100644
--- a/arch/arm/mach-ixp4xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp4xx/include/mach/hardware.h
@@ -44,7 +44,6 @@
 #include "platform.h"
 
 /* Platform specific details */
-#include "ixdp425.h"
 #include "avila.h"
 #include "coyote.h"
 #include "prpmc1100.h"
diff --git a/arch/arm/mach-ixp4xx/include/mach/irqs.h b/arch/arm/mach-ixp4xx/include/mach/irqs.h
index f4d74de..4bb6d66 100644
--- a/arch/arm/mach-ixp4xx/include/mach/irqs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/irqs.h
@@ -71,14 +71,6 @@
 #define	XSCALE_PMU_IRQ		(IRQ_IXP4XX_XSCALE_PMU)
 
 /*
- * IXDP425 board IRQs
- */
-#define	IRQ_IXDP425_PCI_INTA	IRQ_IXP4XX_GPIO11
-#define	IRQ_IXDP425_PCI_INTB	IRQ_IXP4XX_GPIO10
-#define	IRQ_IXDP425_PCI_INTC	IRQ_IXP4XX_GPIO9
-#define	IRQ_IXDP425_PCI_INTD	IRQ_IXP4XX_GPIO8
-
-/*
  * Gateworks Avila board IRQs
  */
 #define	IRQ_AVILA_PCI_INTA	IRQ_IXP4XX_GPIO11
diff --git a/arch/arm/mach-ixp4xx/include/mach/ixdp425.h b/arch/arm/mach-ixp4xx/include/mach/ixdp425.h
deleted file mode 100644
index 2cafe65..0000000
--- a/arch/arm/mach-ixp4xx/include/mach/ixdp425.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * arch/arm/mach-ixp4xx/include/mach/ixdp425.h
- *
- * IXDP425 platform specific definitions
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
-#define	IXDP425_SDA_PIN		7
-#define	IXDP425_SCL_PIN		6
-
-/*
- * IXDP425 PCI IRQs
- */
-#define IXDP425_PCI_MAX_DEV	4
-#define IXDP425_PCI_IRQ_LINES	4
-
-
-/* PCI controller GPIO to IRQ pin mappings */
-#define IXDP425_PCI_INTA_PIN	11
-#define IXDP425_PCI_INTB_PIN	10
-#define	IXDP425_PCI_INTC_PIN	9
-#define	IXDP425_PCI_INTD_PIN	8
-
-/* NAND Flash pins */
-#define	IXDP425_NAND_NCE_PIN	12
-
-#define	IXDP425_NAND_CMD_BYTE	0x01
-#define	IXDP425_NAND_ADDR_BYTE	0x02
diff --git a/arch/arm/mach-ixp4xx/ixdp425-pci.c b/arch/arm/mach-ixp4xx/ixdp425-pci.c
index 64c29aa..dc8b588 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-pci.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-pci.c
@@ -1,5 +1,5 @@
 /*
- * arch/arm/mach-ixp4xx/ixdp425-pci.c 
+ * arch/arm/mach-ixp4xx/ixdp425-pci.c
  *
  * IXDP425 board-level PCI initialization
  *
@@ -19,12 +19,25 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/delay.h>
-
 #include <asm/mach/pci.h>
 #include <asm/irq.h>
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 
+#define IXDP425_PCI_MAX_DEV	4
+#define IXDP425_PCI_IRQ_LINES	4
+
+/* PCI controller GPIO to IRQ pin mappings */
+#define IXDP425_PCI_INTA_PIN	11
+#define IXDP425_PCI_INTB_PIN	10
+#define IXDP425_PCI_INTC_PIN	9
+#define IXDP425_PCI_INTD_PIN	8
+
+#define IRQ_IXDP425_PCI_INTA	IRQ_IXP4XX_GPIO11
+#define IRQ_IXDP425_PCI_INTB	IRQ_IXP4XX_GPIO10
+#define IRQ_IXDP425_PCI_INTC	IRQ_IXP4XX_GPIO9
+#define IRQ_IXDP425_PCI_INTD	IRQ_IXP4XX_GPIO8
+
 void __init ixdp425_pci_preinit(void)
 {
 	set_irq_type(IRQ_IXDP425_PCI_INTA, IRQ_TYPE_LEVEL_LOW);
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index f4a0c1b..bbb7689 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -1,7 +1,7 @@
 /*
  * arch/arm/mach-ixp4xx/ixdp425-setup.c
  *
- * IXDP425/IXCDP1100 board-setup 
+ * IXDP425/IXCDP1100 board-setup
  *
  * Copyright (C) 2003-2005 MontaVista Software, Inc.
  *
@@ -21,7 +21,6 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
-
 #include <asm/types.h>
 #include <asm/setup.h>
 #include <asm/memory.h>
@@ -31,6 +30,15 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
+#define IXDP425_SDA_PIN		7
+#define IXDP425_SCL_PIN		6
+
+/* NAND Flash pins */
+#define IXDP425_NAND_NCE_PIN	12
+
+#define IXDP425_NAND_CMD_BYTE	0x01
+#define IXDP425_NAND_ADDR_BYTE	0x02
+
 static struct flash_platform_data ixdp425_flash_data = {
 	.map_name	= "cfi_probe",
 	.width		= 2,
-- 
1.6.5.2
