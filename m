From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 13 Jun 2011 14:39:43 +0800
Subject: [PATCH 4/6] arm: footbridge: consolidation code of Compaq Personal
	Server
In-Reply-To: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
References: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1307947185-5159-5-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

move PCI code to board file

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-footbridge/Makefile       |    3 --
 arch/arm/mach-footbridge/personal-pci.c |   56 -------------------------------
 arch/arm/mach-footbridge/personal.c     |   46 +++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 59 deletions(-)
 delete mode 100644 arch/arm/mach-footbridge/personal-pci.c

diff --git a/arch/arm/mach-footbridge/Makefile b/arch/arm/mach-footbridge/Makefile
index 68f7988..d2172a9 100644
--- a/arch/arm/mach-footbridge/Makefile
+++ b/arch/arm/mach-footbridge/Makefile
@@ -9,8 +9,6 @@ obj-m			:=
 obj-n			:=
 obj-			:=
 
-pci-$(CONFIG_ARCH_PERSONAL_SERVER) += personal-pci.o
-
 leds-$(CONFIG_ARCH_EBSA285) += ebsa285-leds.o
 leds-$(CONFIG_ARCH_NETWINDER) += netwinder-leds.o
 
@@ -19,7 +17,6 @@ obj-$(CONFIG_ARCH_EBSA285) += ebsa285.o dc21285-timer.o
 obj-$(CONFIG_ARCH_NETWINDER) += netwinder.o isa-timer.o
 obj-$(CONFIG_ARCH_PERSONAL_SERVER) += personal.o dc21285-timer.o
 
-obj-$(CONFIG_PCI)	+=$(pci-y)
 obj-$(CONFIG_LEDS)	+=$(leds-y)
 
 obj-$(CONFIG_ISA)	+= isa.o isa-rtc.o
diff --git a/arch/arm/mach-footbridge/personal-pci.c b/arch/arm/mach-footbridge/personal-pci.c
deleted file mode 100644
index d5fca95..0000000
--- a/arch/arm/mach-footbridge/personal-pci.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * linux/arch/arm/mach-footbridge/personal-pci.c
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
-static int irqmap_personal_server[] __initdata = {
-	IRQ_IN0, IRQ_IN1, IRQ_IN2, IRQ_IN3, 0, 0, 0,
-	IRQ_DOORBELLHOST, IRQ_DMA1, IRQ_DMA2, IRQ_PCI
-};
-
-static int __init personal_server_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
-{
-	unsigned char line;
-
-	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &line);
-
-	if (line > 0x40 && line <= 0x5f) {
-		/* line corresponds to the bit controlling this interrupt
-		 * in the footbridge.  Ignore the first 8 interrupt bits,
-		 * look up the rest in the map.  IN0 is bit number 8
-		 */
-		return irqmap_personal_server[(line & 0x1f) - 8];
-	} else if (line == 0) {
-		/* no interrupt */
-		return 0;
-	} else
-		return irqmap_personal_server[(line - 1) & 3];
-}
-
-static struct hw_pci personal_server_pci __initdata = {
-	.map_irq		= personal_server_map_irq,
-	.nr_controllers		= 1,
-	.setup			= dc21285_setup,
-	.scan			= dc21285_scan_bus,
-	.preinit		= dc21285_preinit,
-	.postinit		= dc21285_postinit,
-};
-
-static int __init personal_pci_init(void)
-{
-	if (machine_is_personal_server())
-		pci_common_init(&personal_server_pci);
-	return 0;
-}
-
-subsys_initcall(personal_pci_init);
diff --git a/arch/arm/mach-footbridge/personal.c b/arch/arm/mach-footbridge/personal.c
index 3285e91..b41e593 100644
--- a/arch/arm/mach-footbridge/personal.c
+++ b/arch/arm/mach-footbridge/personal.c
@@ -3,9 +3,13 @@
  *
  * Personal server (Skiff) machine fixup
  */
+#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
+#include <linux/pci.h>
 
+#include <asm/irq.h>
+#include <asm/mach/pci.h>
 #include <asm/hardware/dec21285.h>
 #include <asm/mach-types.h>
 
@@ -13,6 +17,48 @@
 
 #include "common.h"
 
+static int irqmap_personal_server[] __initdata = {
+	IRQ_IN0, IRQ_IN1, IRQ_IN2, IRQ_IN3, 0, 0, 0,
+	IRQ_DOORBELLHOST, IRQ_DMA1, IRQ_DMA2, IRQ_PCI
+};
+
+static int __init personal_server_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	unsigned char line;
+
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &line);
+
+	if (line > 0x40 && line <= 0x5f) {
+		/* line corresponds to the bit controlling this interrupt
+		 * in the footbridge.  Ignore the first 8 interrupt bits,
+		 * look up the rest in the map.  IN0 is bit number 8
+		 */
+		return irqmap_personal_server[(line & 0x1f) - 8];
+	} else if (line == 0) {
+		/* no interrupt */
+		return 0;
+	} else
+		return irqmap_personal_server[(line - 1) & 3];
+}
+
+static struct hw_pci personal_server_pci __initdata = {
+	.map_irq		= personal_server_map_irq,
+	.nr_controllers		= 1,
+	.setup			= dc21285_setup,
+	.scan			= dc21285_scan_bus,
+	.preinit		= dc21285_preinit,
+	.postinit		= dc21285_postinit,
+};
+
+static int __init personal_pci_init(void)
+{
+	if (machine_is_personal_server())
+		pci_common_init(&personal_server_pci);
+	return 0;
+}
+
+subsys_initcall(personal_pci_init);
+
 MACHINE_START(PERSONAL_SERVER, "Compaq-PersonalServer")
 	/* Maintainer: Jamey Hicks / George France */
 	.boot_params	= 0x00000100,
-- 
1.7.5
