From: liuj97@gmail.com (Jiang Liu)
Date: Sun, 26 May 2013 23:53:17 +0800
Subject: [PATCH v3, part2 20/20] PCI,
 ARM: use hotplug-safe PCI bus iterators to walk PCI buses
In-Reply-To: <1369583597-3801-1-git-send-email-jiang.liu@huawei.com>
References: <1369583597-3801-1-git-send-email-jiang.liu@huawei.com>
Message-ID: <1369583597-3801-21-git-send-email-jiang.liu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enhance ARM architecture specific code to use new hotplug-safe PCI
bus iterators to walk PCI buses.

Change pcibios_report_status implementation so that it doesn't access
pci_root_buses global list. The pci_root_buses list will be scheduled
to be removed.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/kernel/bios32.c           | 13 +------------
 arch/arm/mach-footbridge/dc21285.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index b2ed73c..50ebbe8 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -22,7 +22,7 @@ static int debug_pci;
  * We can't use pci_find_device() here since we are
  * called from interrupt context.
  */
-static void pcibios_bus_report_status(struct pci_bus *bus, u_int status_mask, int warn)
+void pcibios_bus_report_status(struct pci_bus *bus, u_int status_mask, int warn)
 {
 	struct pci_dev *dev;
 
@@ -55,17 +55,6 @@ static void pcibios_bus_report_status(struct pci_bus *bus, u_int status_mask, in
 			pcibios_bus_report_status(dev->subordinate, status_mask, warn);
 }
 
-void pcibios_report_status(u_int status_mask, int warn)
-{
-	struct list_head *l;
-
-	list_for_each(l, &pci_root_buses) {
-		struct pci_bus *bus = pci_bus_b(l);
-
-		pcibios_bus_report_status(bus, status_mask, warn);
-	}
-}
-
 /*
  * We don't use this to fix the device, but initialisation of it.
  * It's not the correct use for this, but it works.
diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index a7cd2cf..a0f1d01 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -35,7 +35,16 @@
 				  PCI_STATUS_PARITY) << 16)
 
 extern int setup_arm_irq(int, struct irqaction *);
-extern void pcibios_report_status(u_int status_mask, int warn);
+extern void pcibios_report_bus_status(struct pci_bus *bus, u_int status_mask,
+				      int warn);
+
+static struct pci_bus *dc21285_root_bus;
+
+static void pcibios_report_status(u_int status_mask, int warn)
+{
+	if (dc21285_root_bus)
+		pcibios_report_bus_status(dc21285_root_bus, status_mask, warn);
+}
 
 static unsigned long
 dc21285_base_address(struct pci_bus *bus, unsigned int devfn)
@@ -376,5 +385,6 @@ void __init dc21285_preinit(void)
 
 void __init dc21285_postinit(void)
 {
+	dc21285_root_bus = pci_get_next_root_bus(NULL);
 	register_isa_ports(DC21285_PCI_MEM, DC21285_PCI_IO, 0);
 }
-- 
1.8.1.2
