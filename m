From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Apr 2012 11:17:16 +0100
Subject: [PATCH 2/8] ARM: PCI: footbridge: provide a 'no swizzle' function
 for CATS
In-Reply-To: <20120426101626.GE24211@n2100.arm.linux.org.uk>
References: <20120426101626.GE24211@n2100.arm.linux.org.uk>
Message-ID: <E1SNLlE-00080m-0Q@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CATS sets its swizzle function to zero, which at the moment means
that no swizzling is required.  Make this explicit for CATS.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-footbridge/cats-pci.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-footbridge/cats-pci.c b/arch/arm/mach-footbridge/cats-pci.c
index 32321f6..dc13c87 100644
--- a/arch/arm/mach-footbridge/cats-pci.c
+++ b/arch/arm/mach-footbridge/cats-pci.c
@@ -16,6 +16,11 @@
 /* cats host-specific stuff */
 static int irqmap_cats[] __initdata = { IRQ_PCI, IRQ_IN0, IRQ_IN1, IRQ_IN3 };
 
+static u8 cats_no_swizzle(struct pci_dev *dev, u8 *pin)
+{
+	return 0;
+}
+
 static int __init cats_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	if (dev->irq >= 255)
@@ -39,7 +44,7 @@ static int __init cats_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
  * cards being used (ie, pci-pci bridge based cards)?
  */
 static struct hw_pci cats_pci __initdata = {
-	.swizzle		= NULL,
+	.swizzle		= cats_no_swizzle,
 	.map_irq		= cats_map_irq,
 	.nr_controllers		= 1,
 	.setup			= dc21285_setup,
-- 
1.7.4.4
