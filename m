From: robherring2@gmail.com (Rob Herring)
Date: Thu, 27 Mar 2014 17:46:36 -0500
Subject: [PATCH 1/3] ARM: hackup pcibios support for commmon bridge code
In-Reply-To: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
References: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
Message-ID: <1395960398-4238-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/kernel/bios32.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 317da88..31ec14a 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/of_pci.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -337,6 +338,15 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		u16 cmd;
 
+		/* Ignore fully discovered devices */
+		if (dev->is_added)
+			continue;
+
+		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
+
+		/* Read default IRQs and fixup if necessary */
+		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		cmd |= features;
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
@@ -681,3 +691,56 @@ void __init pci_map_io_early(unsigned long pfn)
 	pci_io_desc.pfn = pfn;
 	iotable_init(&pci_io_desc, 1);
 }
+
+struct ioresource {
+	struct list_head list;
+	phys_addr_t start;
+	resource_size_t size;
+};
+
+static LIST_HEAD(io_list);
+
+int pci_register_io_range(phys_addr_t address, resource_size_t size)
+{
+	struct ioresource *res;
+	resource_size_t allocated_size = 0;
+
+	/* find if the range has not been already allocated */
+	list_for_each_entry(res, &io_list, list) {
+		if (address >= res->start &&
+			address + size <= res->start + size)
+			return 0;
+		allocated_size += res->size;
+	}
+
+	/* range not already registered, check for space */
+	if (allocated_size + size > IO_SPACE_LIMIT)
+		return -E2BIG;
+
+	/* add the range in the list */
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+	res->start = address;
+	res->size = size;
+
+	list_add_tail(&res->list, &io_list);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_register_io_range);
+
+unsigned long pci_address_to_pio(phys_addr_t address)
+{
+	struct ioresource *res;
+
+	list_for_each_entry(res, &io_list, list) {
+		if (address >= res->start &&
+			address < res->start + res->size) {
+			return res->start - address;
+		}
+	}
+
+	return (unsigned long)-1;
+}
+EXPORT_SYMBOL_GPL(pci_address_to_pio);
-- 
1.8.3.2
