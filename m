From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 13 Jun 2011 14:39:41 +0800
Subject: [PATCH 2/6] arm: footbridge: consolidation code of EBSA285 machine
In-Reply-To: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
References: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1307947185-5159-3-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

move PCI code to board file

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-footbridge/Makefile      |    1 -
 arch/arm/mach-footbridge/ebsa285-pci.c |   48 --------------------------------
 arch/arm/mach-footbridge/ebsa285.c     |   38 +++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 49 deletions(-)
 delete mode 100644 arch/arm/mach-footbridge/ebsa285-pci.c

diff --git a/arch/arm/mach-footbridge/Makefile b/arch/arm/mach-footbridge/Makefile
index e0a8b21..e051668 100644
--- a/arch/arm/mach-footbridge/Makefile
+++ b/arch/arm/mach-footbridge/Makefile
@@ -9,7 +9,6 @@ obj-m			:=
 obj-n			:=
 obj-			:=
 
-pci-$(CONFIG_ARCH_EBSA285_HOST) += ebsa285-pci.o
 pci-$(CONFIG_ARCH_NETWINDER) += netwinder-pci.o
 pci-$(CONFIG_ARCH_PERSONAL_SERVER) += personal-pci.o
 
diff --git a/arch/arm/mach-footbridge/ebsa285-pci.c b/arch/arm/mach-footbridge/ebsa285-pci.c
deleted file mode 100644
index e5ab5bd..0000000
--- a/arch/arm/mach-footbridge/ebsa285-pci.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * linux/arch/arm/mach-footbridge/ebsa285-pci.c
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
-static int irqmap_ebsa285[] __initdata = { IRQ_IN3, IRQ_IN1, IRQ_IN0, IRQ_PCI };
-
-static int __init ebsa285_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
-{
-	if (dev->vendor == PCI_VENDOR_ID_CONTAQ &&
-	    dev->device == PCI_DEVICE_ID_CONTAQ_82C693)
-		switch (PCI_FUNC(dev->devfn)) {
-		case 1:	return 14;
-		case 2:	return 15;
-		case 3:	return 12;
-		}
-
-	return irqmap_ebsa285[(slot + pin) & 3];
-}
-
-static struct hw_pci ebsa285_pci __initdata = {
-	.swizzle		= pci_std_swizzle,
-	.map_irq		= ebsa285_map_irq,
-	.nr_controllers		= 1,
-	.setup			= dc21285_setup,
-	.scan			= dc21285_scan_bus,
-	.preinit		= dc21285_preinit,
-	.postinit		= dc21285_postinit,
-};
-
-static int __init ebsa285_init_pci(void)
-{
-	if (machine_is_ebsa285())
-		pci_common_init(&ebsa285_pci);
-	return 0;
-}
-
-subsys_initcall(ebsa285_init_pci);
diff --git a/arch/arm/mach-footbridge/ebsa285.c b/arch/arm/mach-footbridge/ebsa285.c
index 2ef69ff..fc91c85 100644
--- a/arch/arm/mach-footbridge/ebsa285.c
+++ b/arch/arm/mach-footbridge/ebsa285.c
@@ -5,7 +5,11 @@
  */
 #include <linux/init.h>
 #include <linux/spinlock.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
 
+#include <asm/irq.h>
+#include <asm/mach/pci.h>
 #include <asm/hardware/dec21285.h>
 #include <asm/mach-types.h>
 
@@ -13,6 +17,40 @@
 
 #include "common.h"
 
+static int irqmap_ebsa285[] __initdata = { IRQ_IN3, IRQ_IN1, IRQ_IN0, IRQ_PCI };
+
+static int __init ebsa285_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	if (dev->vendor == PCI_VENDOR_ID_CONTAQ &&
+	    dev->device == PCI_DEVICE_ID_CONTAQ_82C693)
+		switch (PCI_FUNC(dev->devfn)) {
+		case 1:	return 14;
+		case 2:	return 15;
+		case 3:	return 12;
+		}
+
+	return irqmap_ebsa285[(slot + pin) & 3];
+}
+
+static struct hw_pci ebsa285_pci __initdata = {
+	.swizzle		= pci_std_swizzle,
+	.map_irq		= ebsa285_map_irq,
+	.nr_controllers		= 1,
+	.setup			= dc21285_setup,
+	.scan			= dc21285_scan_bus,
+	.preinit		= dc21285_preinit,
+	.postinit		= dc21285_postinit,
+};
+
+static int __init ebsa285_init_pci(void)
+{
+	if (machine_is_ebsa285())
+		pci_common_init(&ebsa285_pci);
+	return 0;
+}
+
+subsys_initcall(ebsa285_init_pci);
+
 MACHINE_START(EBSA285, "EBSA285")
 	/* Maintainer: Russell King */
 	.boot_params	= 0x00000100,
-- 
1.7.5
