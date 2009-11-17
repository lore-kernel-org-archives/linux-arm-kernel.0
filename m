From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Nov 2009 22:15:48 +0100
Subject: [PATCH 09/10] IXP4xx: move Gemtek GTWX5715 platform macros to the
	platform code.
Message-ID: <1258492549-16873-9-git-send-email-khc@pm.waw.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Ha?asa <khc@pm.waw.pl>

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/gtwx5715-pci.c          |   18 ++++-
 arch/arm/mach-ixp4xx/gtwx5715-setup.c        |   30 ++++++-
 arch/arm/mach-ixp4xx/include/mach/gtwx5715.h |  116 --------------------------
 3 files changed, 43 insertions(+), 121 deletions(-)
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/gtwx5715.h

diff --git a/arch/arm/mach-ixp4xx/gtwx5715-pci.c b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
index 7b8a2c3..6801185 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-pci.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
@@ -26,14 +26,26 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
-
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
-#include <mach/gtwx5715.h>
 #include <asm/mach/pci.h>
 
+#define GTWX5715_PCI_SLOT0_DEVID	0
+#define GTWX5715_PCI_SLOT0_INTA_GPIO	10
+#define GTWX5715_PCI_SLOT0_INTB_GPIO	11
+#define GTWX5715_PCI_SLOT0_INTA_IRQ	IRQ_IXP4XX_GPIO10
+#define GTWX5715_PCI_SLOT0_INTB_IRQ	IRQ_IXP4XX_GPIO11
+
+#define GTWX5715_PCI_SLOT1_DEVID	1
+#define GTWX5715_PCI_SLOT1_INTA_GPIO	11
+#define GTWX5715_PCI_SLOT1_INTB_GPIO	10
+#define GTWX5715_PCI_SLOT1_INTA_IRQ	IRQ_IXP4XX_GPIO11
+#define GTWX5715_PCI_SLOT1_INTB_IRQ	IRQ_IXP4XX_GPIO10
+
+#define GTWX5715_PCI_SLOT_COUNT		2
+#define GTWX5715_PCI_INT_PIN_COUNT	2
+
 /*
- * The exact GPIO pins and IRQs are defined in arch-ixp4xx/gtwx5715.h
  * Slot 0 isn't actually populated with a card connector but
  * we initialize it anyway in case a future version has the
  * slot populated or someone with good soldering skills has
diff --git a/arch/arm/mach-ixp4xx/gtwx5715-setup.c b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
index 25c21d6..0bc7185 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-setup.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
@@ -28,7 +28,6 @@
 #include <linux/tty.h>
 #include <linux/serial_8250.h>
 #include <linux/slab.h>
-
 #include <asm/types.h>
 #include <asm/setup.h>
 #include <asm/memory.h>
@@ -37,7 +36,34 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
-#include <mach/gtwx5715.h>
+
+/* GPIO 5,6,7 and 12 are hard wired to the Kendin KS8995M Switch
+   and operate as an SPI type interface.  The details of the interface
+   are available on Kendin/Micrel's web site. */
+
+#define GTWX5715_KSSPI_SELECT	5
+#define GTWX5715_KSSPI_TXD	6
+#define GTWX5715_KSSPI_CLOCK	7
+#define GTWX5715_KSSPI_RXD	12
+
+/* The "reset" button is wired to GPIO 3.
+   The GPIO is brought "low" when the button is pushed. */
+
+#define GTWX5715_BUTTON_GPIO	3
+
+/* Board Label      Front Label
+   LED1             Power
+   LED2             Wireless-G
+   LED3             not populated but could be
+   LED4             Internet
+   LED5 - LED8      Controlled by KS8995M Switch
+   LED9             DMZ */
+
+#define GTWX5715_LED1_GPIO	2
+#define GTWX5715_LED2_GPIO	9
+#define GTWX5715_LED3_GPIO	8
+#define GTWX5715_LED4_GPIO	1
+#define GTWX5715_LED9_GPIO	4
 
 /*
  * Xscale UART registers are 32 bits wide with only the least
diff --git a/arch/arm/mach-ixp4xx/include/mach/gtwx5715.h b/arch/arm/mach-ixp4xx/include/mach/gtwx5715.h
deleted file mode 100644
index 5d5e201..0000000
--- a/arch/arm/mach-ixp4xx/include/mach/gtwx5715.h
+++ /dev/null
@@ -1,116 +0,0 @@
-/*
- * arch/arm/mach-ixp4xx/include/mach/gtwx5715.h
- *
- * Gemtek GTWX5715 Gateway (Linksys WRV54G)
- *
- * Copyright 2004 (c) George T. Joseph
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H__
-#error "Do not include this directly, instead #include <mach/hardware.h>"
-#endif
-#include "irqs.h"
-
-#define GTWX5715_GPIO0	0
-#define GTWX5715_GPIO1	1
-#define GTWX5715_GPIO2	2
-#define GTWX5715_GPIO3	3
-#define GTWX5715_GPIO4	4
-#define GTWX5715_GPIO5	5
-#define GTWX5715_GPIO6	6
-#define GTWX5715_GPIO7	7
-#define GTWX5715_GPIO8	8
-#define GTWX5715_GPIO9	9
-#define GTWX5715_GPIO10	10
-#define GTWX5715_GPIO11	11
-#define GTWX5715_GPIO12	12
-#define GTWX5715_GPIO13	13
-#define GTWX5715_GPIO14	14
-
-#define GTWX5715_GPIO0_IRQ			IRQ_IXP4XX_GPIO0
-#define GTWX5715_GPIO1_IRQ			IRQ_IXP4XX_GPIO1
-#define GTWX5715_GPIO2_IRQ			IRQ_IXP4XX_GPIO2
-#define GTWX5715_GPIO3_IRQ			IRQ_IXP4XX_GPIO3
-#define GTWX5715_GPIO4_IRQ			IRQ_IXP4XX_GPIO4
-#define GTWX5715_GPIO5_IRQ			IRQ_IXP4XX_GPIO5
-#define GTWX5715_GPIO6_IRQ			IRQ_IXP4XX_GPIO6
-#define GTWX5715_GPIO7_IRQ			IRQ_IXP4XX_GPIO7
-#define GTWX5715_GPIO8_IRQ			IRQ_IXP4XX_GPIO8
-#define GTWX5715_GPIO9_IRQ			IRQ_IXP4XX_GPIO9
-#define GTWX5715_GPIO10_IRQ		IRQ_IXP4XX_GPIO10
-#define GTWX5715_GPIO11_IRQ		IRQ_IXP4XX_GPIO11
-#define GTWX5715_GPIO12_IRQ		IRQ_IXP4XX_GPIO12
-#define GTWX5715_GPIO13_IRQ		IRQ_IXP4XX_SW_INT1
-#define GTWX5715_GPIO14_IRQ		IRQ_IXP4XX_SW_INT2
-
-/* PCI controller GPIO to IRQ pin mappings
-
-			INTA	INTB
-SLOT 0	10		11
-SLOT 1	11		10
-
-*/
-
-#define	GTWX5715_PCI_SLOT0_DEVID	0
-#define	GTWX5715_PCI_SLOT0_INTA_GPIO	GTWX5715_GPIO10
-#define	GTWX5715_PCI_SLOT0_INTB_GPIO	GTWX5715_GPIO11
-#define	GTWX5715_PCI_SLOT0_INTA_IRQ	GTWX5715_GPIO10_IRQ
-#define	GTWX5715_PCI_SLOT0_INTB_IRQ	GTWX5715_GPIO11_IRQ
-
-#define	GTWX5715_PCI_SLOT1_DEVID	1
-#define	GTWX5715_PCI_SLOT1_INTA_GPIO	GTWX5715_GPIO11
-#define	GTWX5715_PCI_SLOT1_INTB_GPIO	GTWX5715_GPIO10
-#define	GTWX5715_PCI_SLOT1_INTA_IRQ	GTWX5715_GPIO11_IRQ
-#define	GTWX5715_PCI_SLOT1_INTB_IRQ	GTWX5715_GPIO10_IRQ
-
-#define GTWX5715_PCI_SLOT_COUNT			2
-#define GTWX5715_PCI_INT_PIN_COUNT		2
-
-/*
- * GPIO 5,6,7 and12 are hard wired to the Kendin KS8995M Switch
- * and operate as an SPI type interface.  The details of the interface
- * are available on Kendin/Micrel's web site.
- */
-
-#define GTWX5715_KSSPI_SELECT	GTWX5715_GPIO5
-#define GTWX5715_KSSPI_TXD		GTWX5715_GPIO6
-#define GTWX5715_KSSPI_CLOCK	GTWX5715_GPIO7
-#define GTWX5715_KSSPI_RXD		GTWX5715_GPIO12
-
-/*
- * The "reset" button is wired to GPIO 3.
- * The GPIO is brought "low" when the button is pushed.
- */
-
-#define GTWX5715_BUTTON_GPIO	GTWX5715_GPIO3
-#define GTWX5715_BUTTON_IRQ	GTWX5715_GPIO3_IRQ
-
-/*
- *  Board Label      Front Label
- *  LED1             Power
- *  LED2             Wireless-G
- *  LED3             not populated but could be
- *  LED4             Internet
- *  LED5 - LED8      Controlled by KS8995M Switch
- *  LED9             DMZ
- */
-
-#define GTWX5715_LED1_GPIO		GTWX5715_GPIO2
-#define GTWX5715_LED2_GPIO		GTWX5715_GPIO9
-#define GTWX5715_LED3_GPIO		GTWX5715_GPIO8
-#define GTWX5715_LED4_GPIO		GTWX5715_GPIO1
-#define GTWX5715_LED9_GPIO		GTWX5715_GPIO4
-- 
1.6.5.2
