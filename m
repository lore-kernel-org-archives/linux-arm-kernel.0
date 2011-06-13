From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 13 Jun 2011 14:39:40 +0800
Subject: [PATCH 1/6] arm: footbridge: consolidation code of CATS machine
In-Reply-To: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
References: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1307947185-5159-2-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

move PCI code to board file

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-footbridge/Makefile   |    3 +-
 arch/arm/mach-footbridge/cats-hw.c  |   95 -----------------------
 arch/arm/mach-footbridge/cats-pci.c |   58 --------------
 arch/arm/mach-footbridge/cats.c     |  143 +++++++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+), 155 deletions(-)
 delete mode 100644 arch/arm/mach-footbridge/cats-hw.c
 delete mode 100644 arch/arm/mach-footbridge/cats-pci.c
 create mode 100644 arch/arm/mach-footbridge/cats.c

diff --git a/arch/arm/mach-footbridge/Makefile b/arch/arm/mach-footbridge/Makefile
index 3afb1b2..e0a8b21 100644
--- a/arch/arm/mach-footbridge/Makefile
+++ b/arch/arm/mach-footbridge/Makefile
@@ -9,7 +9,6 @@ obj-m			:=
 obj-n			:=
 obj-			:=
 
-pci-$(CONFIG_ARCH_CATS) += cats-pci.o
 pci-$(CONFIG_ARCH_EBSA285_HOST) += ebsa285-pci.o
 pci-$(CONFIG_ARCH_NETWINDER) += netwinder-pci.o
 pci-$(CONFIG_ARCH_PERSONAL_SERVER) += personal-pci.o
@@ -17,7 +16,7 @@ pci-$(CONFIG_ARCH_PERSONAL_SERVER) += personal-pci.o
 leds-$(CONFIG_ARCH_EBSA285) += ebsa285-leds.o
 leds-$(CONFIG_ARCH_NETWINDER) += netwinder-leds.o
 
-obj-$(CONFIG_ARCH_CATS) += cats-hw.o isa-timer.o
+obj-$(CONFIG_ARCH_CATS) += cats.o isa-timer.o
 obj-$(CONFIG_ARCH_EBSA285) += ebsa285.o dc21285-timer.o
 obj-$(CONFIG_ARCH_NETWINDER) += netwinder-hw.o isa-timer.o
 obj-$(CONFIG_ARCH_PERSONAL_SERVER) += personal.o dc21285-timer.o
diff --git a/arch/arm/mach-footbridge/cats-hw.c b/arch/arm/mach-footbridge/cats-hw.c
deleted file mode 100644
index 5b1a8db..0000000
--- a/arch/arm/mach-footbridge/cats-hw.c
+++ /dev/null
@@ -1,95 +0,0 @@
-/*
- * linux/arch/arm/mach-footbridge/cats-hw.c
- *
- * CATS machine fixup
- *
- * Copyright (C) 1998, 1999 Russell King, Phil Blundell
- */
-#include <linux/ioport.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/screen_info.h>
-#include <linux/io.h>
-#include <linux/spinlock.h>
-
-#include <asm/hardware/dec21285.h>
-#include <asm/mach-types.h>
-#include <asm/setup.h>
-
-#include <asm/mach/arch.h>
-
-#include "common.h"
-
-#define CFG_PORT	0x370
-#define INDEX_PORT	(CFG_PORT)
-#define DATA_PORT	(CFG_PORT + 1)
-
-static int __init cats_hw_init(void)
-{
-	if (machine_is_cats()) {
-		/* Set Aladdin to CONFIGURE mode */
-		outb(0x51, CFG_PORT);
-		outb(0x23, CFG_PORT);
-
-		/* Select logical device 3 */
-		outb(0x07, INDEX_PORT);
-		outb(0x03, DATA_PORT);
-
-		/* Set parallel port to DMA channel 3, ECP+EPP1.9, 
-		   enable EPP timeout */
-		outb(0x74, INDEX_PORT);
-		outb(0x03, DATA_PORT);
-	
-		outb(0xf0, INDEX_PORT);
-		outb(0x0f, DATA_PORT);
-
-		outb(0xf1, INDEX_PORT);
-		outb(0x07, DATA_PORT);
-
-		/* Select logical device 4 */
-		outb(0x07, INDEX_PORT);
-		outb(0x04, DATA_PORT);
-
-		/* UART1 high speed mode */
-		outb(0xf0, INDEX_PORT);
-		outb(0x02, DATA_PORT);
-
-		/* Select logical device 5 */
-		outb(0x07, INDEX_PORT);
-		outb(0x05, DATA_PORT);
-
-		/* UART2 high speed mode */
-		outb(0xf0, INDEX_PORT);
-		outb(0x02, DATA_PORT);
-
-		/* Set Aladdin to RUN mode */
-		outb(0xbb, CFG_PORT);
-	}
-
-	return 0;
-}
-
-__initcall(cats_hw_init);
-
-/*
- * CATS uses soft-reboot by default, since
- * hard reboots fail on early boards.
- */
-static void __init
-fixup_cats(struct machine_desc *desc, struct tag *tags,
-	   char **cmdline, struct meminfo *mi)
-{
-	screen_info.orig_video_lines  = 25;
-	screen_info.orig_video_points = 16;
-	screen_info.orig_y = 24;
-}
-
-MACHINE_START(CATS, "Chalice-CATS")
-	/* Maintainer: Philip Blundell */
-	.boot_params	= 0x00000100,
-	.soft_reboot	= 1,
-	.fixup		= fixup_cats,
-	.map_io		= footbridge_map_io,
-	.init_irq	= footbridge_init_irq,
-	.timer		= &isa_timer,
-MACHINE_END
diff --git a/arch/arm/mach-footbridge/cats-pci.c b/arch/arm/mach-footbridge/cats-pci.c
deleted file mode 100644
index ae3e1c8..0000000
--- a/arch/arm/mach-footbridge/cats-pci.c
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * linux/arch/arm/mach-footbridge/cats-pci.c
- *
- * PCI bios-type initialisation for PCI machines
- *
- * Bits taken from various places.
- */
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-
-#include <asm/irq.h>
-#include <asm/mach/pci.h>
-#include <asm/mach-types.h>
-
-/* cats host-specific stuff */
-static int irqmap_cats[] __initdata = { IRQ_PCI, IRQ_IN0, IRQ_IN1, IRQ_IN3 };
-
-static int __init cats_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
-{
-	if (dev->irq >= 255)
-		return -1;	/* not a valid interrupt. */
-
-	if (dev->irq >= 128)
-		return dev->irq & 0x1f;
-
-	if (dev->irq >= 1 && dev->irq <= 4)
-		return irqmap_cats[dev->irq - 1];
-
-	if (dev->irq != 0)
-		printk("PCI: device %02x:%02x has unknown irq line %x\n",
-		       dev->bus->number, dev->devfn, dev->irq);
-
-	return -1;
-}
-
-/*
- * why not the standard PCI swizzle?  does this prevent 4-port tulip
- * cards being used (ie, pci-pci bridge based cards)?
- */
-static struct hw_pci cats_pci __initdata = {
-	.swizzle		= NULL,
-	.map_irq		= cats_map_irq,
-	.nr_controllers		= 1,
-	.setup			= dc21285_setup,
-	.scan			= dc21285_scan_bus,
-	.preinit		= dc21285_preinit,
-	.postinit		= dc21285_postinit,
-};
-
-static int __init cats_pci_init(void)
-{
-	if (machine_is_cats())
-		pci_common_init(&cats_pci);
-	return 0;
-}
-
-subsys_initcall(cats_pci_init);
diff --git a/arch/arm/mach-footbridge/cats.c b/arch/arm/mach-footbridge/cats.c
new file mode 100644
index 0000000..3f643f4
--- /dev/null
+++ b/arch/arm/mach-footbridge/cats.c
@@ -0,0 +1,143 @@
+/*
+ * linux/arch/arm/mach-footbridge/cats.c
+ *
+ * CATS machine fixup
+ *
+ * Copyright (C) 1998, 1999 Russell King, Phil Blundell
+ */
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/screen_info.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/pci.h>
+
+#include <asm/irq.h>
+#include <asm/mach/pci.h>
+#include <asm/hardware/dec21285.h>
+#include <asm/mach-types.h>
+#include <asm/setup.h>
+
+#include <asm/mach/arch.h>
+
+#include "common.h"
+
+#define CFG_PORT	0x370
+#define INDEX_PORT	(CFG_PORT)
+#define DATA_PORT	(CFG_PORT + 1)
+
+static int __init cats_init(void)
+{
+	if (machine_is_cats()) {
+		/* Set Aladdin to CONFIGURE mode */
+		outb(0x51, CFG_PORT);
+		outb(0x23, CFG_PORT);
+
+		/* Select logical device 3 */
+		outb(0x07, INDEX_PORT);
+		outb(0x03, DATA_PORT);
+
+		/* Set parallel port to DMA channel 3, ECP+EPP1.9, 
+		   enable EPP timeout */
+		outb(0x74, INDEX_PORT);
+		outb(0x03, DATA_PORT);
+	
+		outb(0xf0, INDEX_PORT);
+		outb(0x0f, DATA_PORT);
+
+		outb(0xf1, INDEX_PORT);
+		outb(0x07, DATA_PORT);
+
+		/* Select logical device 4 */
+		outb(0x07, INDEX_PORT);
+		outb(0x04, DATA_PORT);
+
+		/* UART1 high speed mode */
+		outb(0xf0, INDEX_PORT);
+		outb(0x02, DATA_PORT);
+
+		/* Select logical device 5 */
+		outb(0x07, INDEX_PORT);
+		outb(0x05, DATA_PORT);
+
+		/* UART2 high speed mode */
+		outb(0xf0, INDEX_PORT);
+		outb(0x02, DATA_PORT);
+
+		/* Set Aladdin to RUN mode */
+		outb(0xbb, CFG_PORT);
+	}
+
+	return 0;
+}
+
+__initcall(cats_init);
+
+/*
+ * CATS uses soft-reboot by default, since
+ * hard reboots fail on early boards.
+ */
+static void __init
+fixup_cats(struct machine_desc *desc, struct tag *tags,
+	   char **cmdline, struct meminfo *mi)
+{
+	screen_info.orig_video_lines  = 25;
+	screen_info.orig_video_points = 16;
+	screen_info.orig_y = 24;
+}
+
+/* cats host-specific PCI stuff */
+static int irqmap_cats[] __initdata = { IRQ_PCI, IRQ_IN0, IRQ_IN1, IRQ_IN3 };
+
+static int __init cats_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	if (dev->irq >= 255)
+		return -1;	/* not a valid interrupt. */
+
+	if (dev->irq >= 128)
+		return dev->irq & 0x1f;
+
+	if (dev->irq >= 1 && dev->irq <= 4)
+		return irqmap_cats[dev->irq - 1];
+
+	if (dev->irq != 0)
+		printk("PCI: device %02x:%02x has unknown irq line %x\n",
+		       dev->bus->number, dev->devfn, dev->irq);
+
+	return -1;
+}
+
+/*
+ * why not the standard PCI swizzle?  does this prevent 4-port tulip
+ * cards being used (ie, pci-pci bridge based cards)?
+ */
+static struct hw_pci cats_pci __initdata = {
+	.swizzle		= NULL,
+	.map_irq		= cats_map_irq,
+	.nr_controllers		= 1,
+	.setup			= dc21285_setup,
+	.scan			= dc21285_scan_bus,
+	.preinit		= dc21285_preinit,
+	.postinit		= dc21285_postinit,
+};
+
+static int __init cats_pci_init(void)
+{
+	if (machine_is_cats())
+		pci_common_init(&cats_pci);
+	return 0;
+}
+
+subsys_initcall(cats_pci_init);
+
+
+MACHINE_START(CATS, "Chalice-CATS")
+	/* Maintainer: Philip Blundell */
+	.boot_params	= 0x00000100,
+	.soft_reboot	= 1,
+	.fixup		= fixup_cats,
+	.map_io		= footbridge_map_io,
+	.init_irq	= footbridge_init_irq,
+	.timer		= &isa_timer,
+MACHINE_END
-- 
1.7.5
