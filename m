From: robherring2@gmail.com (Rob Herring)
Date: Sun, 21 Aug 2011 14:01:12 -0500
Subject: [PATCH 2/2] ARM: orion5x: fix build error in dns323_pci_map_irq
Message-ID: <1313953272-24733-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

orion5x fails to build with the following error:
arch/arm/mach-orion5x/dns323-setup.c: In function ?dns323_pci_map_irq?:
arch/arm/mach-orion5x/dns323-setup.c:80:28: error: expected expression before ?const?
arch/arm/mach-orion5x/dns323-setup.c:80:28: error: too few arguments to function ?orion5x_pci_map_irq?

This appears to be a search and replace error introduced from this commit:

commit d5341942d784134f2997b3ff82cd63cf71d1f932
Author:
Date:   Fri Jun 10 15:30:21 2011 +0100

    PCI: Make the struct pci_dev * argument of pci_fixup_irqs const.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-orion5x/dns323-setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index a6eddae..c105556 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -77,7 +77,7 @@ static int __init dns323_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	/*
 	 * Check for devices with hard-wired IRQs.
 	 */
-	irq = orion5x_pci_map_irq(const dev, slot, pin);
+	irq = orion5x_pci_map_irq(dev, slot, pin);
 	if (irq != -1)
 		return irq;
 
-- 
1.7.4.1
