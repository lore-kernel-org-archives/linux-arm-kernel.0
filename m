From: valentin.ilie@gmail.com (Valentin Ilie)
Date: Mon,  2 Sep 2013 18:23:14 +0300
Subject: [PATCH] ARM: mach-iop32x: iq31244: Replace if-then-else with a switch
 statement
Message-ID: <1378135394-31092-1-git-send-email-valentin.ilie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert a compound if-else blob to a switch statement.

Signed-off-by: Valentin Ilie <valentin.ilie@gmail.com>
---
 arch/arm/mach-iop32x/iq31244.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-iop32x/iq31244.c b/arch/arm/mach-iop32x/iq31244.c
index f2cd296..3415f11 100644
--- a/arch/arm/mach-iop32x/iq31244.c
+++ b/arch/arm/mach-iop32x/iq31244.c
@@ -101,28 +101,21 @@ void __init iq31244_map_io(void)
 static int __init
 ep80219_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	int irq;
-
-	if (slot == 0) {
-		/* CFlash */
-		irq = IRQ_IOP32X_XINT1;
-	} else if (slot == 1) {
-		/* 82551 Pro 100 */
-		irq = IRQ_IOP32X_XINT0;
-	} else if (slot == 2) {
-		/* PCI-X Slot */
-		irq = IRQ_IOP32X_XINT3;
-	} else if (slot == 3) {
-		/* SATA */
-		irq = IRQ_IOP32X_XINT2;
-	} else {
+	switch (slot) {
+	case 0: /* CFlash */
+		return IRQ_IOP32X_XINT1;
+	case 1: /* 82551 Pro 100 */
+		return IRQ_IOP32X_XINT0;
+	case 2: /* PCI-X Slot */
+		return IRQ_IOP32X_XINT3;
+	case 3: /* SATA */
+		return IRQ_IOP32X_XINT2;
+	default:
 		printk(KERN_ERR "ep80219_pci_map_irq() called for unknown "
 			"device PCI:%d:%d:%d\n", dev->bus->number,
 			PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-		irq = -1;
+		return -1;
 	}
-
-	return irq;
 }
 
 static struct hw_pci ep80219_pci __initdata = {
-- 
1.8.1.2
