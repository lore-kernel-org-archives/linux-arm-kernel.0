From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Apr 2012 11:17:56 +0100
Subject: [PATCH 4/8] ARM: PCI: versatile: fix PCI interrupt setup
In-Reply-To: <20120426101626.GE24211@n2100.arm.linux.org.uk>
References: <20120426101626.GE24211@n2100.arm.linux.org.uk>
Message-ID: <E1SNLls-00080x-7W@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is at odds with the documentation in the file; it says pin 1 on
slots 24,25,26,27 map to IRQs 27,28,29,30, but the function will always
be entered with slot=0 due to the lack of swizzle function.  Fix this
function to behave as the comments say, and use the standard PCI
swizzle.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-versatile/pci.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index d2268be..24dd4b1 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -339,15 +339,13 @@ static int __init versatile_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	 *  26     1     29
 	 *  27     1     30
 	 */
-	irq = 27 + ((slot + pin - 1) & 3);
-
-	printk("PCI map irq: slot %d, pin %d, devslot %d, irq: %d\n",slot,pin,devslot,irq);
+	irq = 27 + ((slot - 24 + pin - 1) & 3);
 
 	return irq;
 }
 
 static struct hw_pci versatile_pci __initdata = {
-	.swizzle		= NULL,
+	.swizzle		= pci_std_swizzle,
 	.map_irq		= versatile_map_irq,
 	.nr_controllers		= 1,
 	.setup			= pci_versatile_setup,
-- 
1.7.4.4
