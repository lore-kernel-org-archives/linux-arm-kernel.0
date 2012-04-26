From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Apr 2012 11:17:36 +0100
Subject: [PATCH 3/8] ARM: PCI: integrator: use common PCI swizzle
In-Reply-To: <20120426101626.GE24211@n2100.arm.linux.org.uk>
References: <20120426101626.GE24211@n2100.arm.linux.org.uk>
Message-ID: <E1SNLlY-00080t-3w@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Integrator swizzle function is almost the same as the standard PCI
swizzle, except for an initial check for pin = 0.  Make the integrator
swizzle function a wrapper around the standard PCI swizzle function so
we preseve this behaviour while using common code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/pci.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-integrator/pci.c b/arch/arm/mach-integrator/pci.c
index f1ca9c1..5715c63 100644
--- a/arch/arm/mach-integrator/pci.c
+++ b/arch/arm/mach-integrator/pci.c
@@ -70,21 +70,10 @@
  */
 static u8 __init integrator_swizzle(struct pci_dev *dev, u8 *pinp)
 {
-	int pin = *pinp;
+	if (*pinp == 0)
+		*pinp = 1;
 
-	if (pin == 0)
-		pin = 1;
-
-	while (dev->bus->self) {
-		pin = pci_swizzle_interrupt_pin(dev, pin);
-		/*
-		 * move up the chain of bridges, swizzling as we go.
-		 */
-		dev = dev->bus->self;
-	}
-	*pinp = pin;
-
-	return PCI_SLOT(dev->devfn);
+	return pci_std_swizzle(dev, pinp);
 }
 
 static int irq_tab[4] __initdata = {
-- 
1.7.4.4
