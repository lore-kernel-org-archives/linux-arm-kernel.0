From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Nov 2009 22:15:46 +0100
Subject: [PATCH 07/10] IXP4xx: move FSG platform macros to the platform code.
Message-ID: <1258492549-16873-7-git-send-email-khc@pm.waw.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Ha?asa <khc@pm.waw.pl>

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/fsg-pci.c               |   12 ++++++-
 arch/arm/mach-ixp4xx/fsg-setup.c             |    8 ++++-
 arch/arm/mach-ixp4xx/include/mach/fsg.h      |   50 --------------------------
 arch/arm/mach-ixp4xx/include/mach/hardware.h |    1 -
 arch/arm/mach-ixp4xx/include/mach/irqs.h     |    7 ----
 drivers/leds/leds-fsg.c                      |    7 ++++
 6 files changed, 25 insertions(+), 60 deletions(-)
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/fsg.h

diff --git a/arch/arm/mach-ixp4xx/fsg-pci.c b/arch/arm/mach-ixp4xx/fsg-pci.c
index ca12a9c..2a1701b 100644
--- a/arch/arm/mach-ixp4xx/fsg-pci.c
+++ b/arch/arm/mach-ixp4xx/fsg-pci.c
@@ -19,10 +19,20 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/irq.h>
-
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
+#define FSG_PCI_MAX_DEV		3
+#define FSG_PCI_IRQ_LINES	3
+
+/* PCI controller GPIO to IRQ pin mappings */
+#define FSG_PCI_INTA_PIN	6
+#define FSG_PCI_INTB_PIN	7
+#define FSG_PCI_INTC_PIN	5
+#define IRQ_FSG_PCI_INTA	IRQ_IXP4XX_GPIO6
+#define IRQ_FSG_PCI_INTB	IRQ_IXP4XX_GPIO7
+#define IRQ_FSG_PCI_INTC	IRQ_IXP4XX_GPIO5
+
 void __init fsg_pci_preinit(void)
 {
 	set_irq_type(IRQ_FSG_PCI_INTA, IRQ_TYPE_LEVEL_LOW);
diff --git a/arch/arm/mach-ixp4xx/fsg-setup.c b/arch/arm/mach-ixp4xx/fsg-setup.c
index 5add22f..e7f4bef 100644
--- a/arch/arm/mach-ixp4xx/fsg-setup.c
+++ b/arch/arm/mach-ixp4xx/fsg-setup.c
@@ -24,12 +24,18 @@
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
 #include <linux/io.h>
-
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/gpio.h>
 
+#define FSG_SDA_PIN		12
+#define FSG_SCL_PIN		13
+
+#define FSG_SB_GPIO		4	/* sync button */
+#define FSG_RB_GPIO		9	/* reset button */
+#define FSG_UB_GPIO		10	/* usb button */
+
 static struct flash_platform_data fsg_flash_data = {
 	.map_name		= "cfi_probe",
 	.width			= 2,
diff --git a/arch/arm/mach-ixp4xx/include/mach/fsg.h b/arch/arm/mach-ixp4xx/include/mach/fsg.h
deleted file mode 100644
index 1f02b7e..0000000
--- a/arch/arm/mach-ixp4xx/include/mach/fsg.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
- * arch/arm/mach-ixp4xx/include/mach/fsg.h
- *
- * Freecom FSG-3 platform specific definitions
- *
- * Author: Rod Whitby <rod@whitby.id.au>
- * Author: Tomasz Chmielewski <mangoo@wpkg.org>
- * Maintainers: http://www.nslu2-linux.org
- *
- * Based on coyote.h by
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
-#define FSG_SDA_PIN		12
-#define FSG_SCL_PIN		13
-
-/*
- * FSG PCI IRQs
- */
-#define FSG_PCI_MAX_DEV		3
-#define FSG_PCI_IRQ_LINES	3
-
-
-/* PCI controller GPIO to IRQ pin mappings */
-#define FSG_PCI_INTA_PIN	6
-#define FSG_PCI_INTB_PIN	7
-#define FSG_PCI_INTC_PIN	5
-
-/* Buttons */
-
-#define FSG_SB_GPIO		4	/* sync button */
-#define FSG_RB_GPIO		9	/* reset button */
-#define FSG_UB_GPIO		10	/* usb button */
-
-/* LEDs */
-
-#define FSG_LED_WLAN_BIT	0
-#define FSG_LED_WAN_BIT		1
-#define FSG_LED_SATA_BIT	2
-#define FSG_LED_USB_BIT		4
-#define FSG_LED_RING_BIT	5
-#define FSG_LED_SYNC_BIT	7
diff --git a/arch/arm/mach-ixp4xx/include/mach/hardware.h b/arch/arm/mach-ixp4xx/include/mach/hardware.h
index 555b8e1..8558073 100644
--- a/arch/arm/mach-ixp4xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp4xx/include/mach/hardware.h
@@ -45,6 +45,5 @@
 
 /* Platform specific details */
 #include "prpmc1100.h"
-#include "fsg.h"
 
 #endif  /* _ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-ixp4xx/include/mach/irqs.h b/arch/arm/mach-ixp4xx/include/mach/irqs.h
index 20053be..e256997 100644
--- a/arch/arm/mach-ixp4xx/include/mach/irqs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/irqs.h
@@ -78,11 +78,4 @@
 #define	IRQ_PRPMC1100_PCI_INTC	IRQ_IXP4XX_GPIO9
 #define	IRQ_PRPMC1100_PCI_INTD	IRQ_IXP4XX_GPIO8
 
-/*
- * Freecom FSG-3 Board IRQs
- */
-#define        IRQ_FSG_PCI_INTA        IRQ_IXP4XX_GPIO6
-#define        IRQ_FSG_PCI_INTB        IRQ_IXP4XX_GPIO7
-#define        IRQ_FSG_PCI_INTC        IRQ_IXP4XX_GPIO5
-
 #endif
diff --git a/drivers/leds/leds-fsg.c b/drivers/leds/leds-fsg.c
index 5f7c9c5..d11d05b 100644
--- a/drivers/leds/leds-fsg.c
+++ b/drivers/leds/leds-fsg.c
@@ -22,6 +22,13 @@
 #include <mach/hardware.h>
 #include <asm/io.h>
 
+#define FSG_LED_WLAN_BIT	0
+#define FSG_LED_WAN_BIT		1
+#define FSG_LED_SATA_BIT	2
+#define FSG_LED_USB_BIT		4
+#define FSG_LED_RING_BIT	5
+#define FSG_LED_SYNC_BIT	7
+
 static short __iomem *latch_address;
 static unsigned short latch_value;
 
-- 
1.6.5.2
