From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 21:21:58 +0200
Subject: [PATCH 09/11] ARM: pci: always export pcibios_bus_to_resource
In-Reply-To: <1317496920-7764-1-git-send-email-arnd@arndb.de>
References: <1317496920-7764-1-git-send-email-arnd@arndb.de>
Message-ID: <1317496920-7764-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some PCI drivers call pcibios_bus_to_resource directly,
but it is only exported when CONFIG_HOTPLUG is set,
because it was initially mean for pccard support.

Moving the export out of the #ifdef lets us avoid these
build errors:

ERROR: "pcibios_bus_to_resource" [drivers/video/vt8623fb.ko] undefined!
ERROR: "pcibios_bus_to_resource" [drivers/video/arkfb.ko] undefined!
ERROR: "pcibios_bus_to_resource" [drivers/video/s3fb.ko] undefined!

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/bios32.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index d6df359..c0d9203 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -412,6 +412,9 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	printk(KERN_INFO "PCI: bus%d: Fast back to back transfers %sabled\n",
 		bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");
 }
+#ifdef CONFIG_HOTPLUG
+EXPORT_SYMBOL(pcibios_fixup_bus);
+#endif
 
 /*
  * Convert from Linux-centric to bus-centric addresses for bridge devices.
@@ -431,6 +434,7 @@ pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 	region->start = res->start - offset;
 	region->end   = res->end - offset;
 }
+EXPORT_SYMBOL(pcibios_resource_to_bus);
 
 void __devinit
 pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
@@ -447,12 +451,7 @@ pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 	res->start = region->start + offset;
 	res->end   = region->end + offset;
 }
-
-#ifdef CONFIG_HOTPLUG
-EXPORT_SYMBOL(pcibios_fixup_bus);
-EXPORT_SYMBOL(pcibios_resource_to_bus);
 EXPORT_SYMBOL(pcibios_bus_to_resource);
-#endif
 
 /*
  * Swizzle the device pin each time we cross a bridge.
-- 
1.7.5.4
