From: broonie@kernel.org (Mark Brown)
Date: Sun, 24 Aug 2014 19:51:34 -0500
Subject: [PATCH] ARM: cns3xxx: Don't allocate PCI addresses on stack
Message-ID: <1408927894-30858-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

The cns3xxx PCIe code allocates a PCI bus structure on the stack, causing
warnings due to the excessibe size of the resulting stack frame:

arch/arm/mach-cns3xxx/pcie.c:311:1: warning: the frame size of 1072 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Avoid this by dynamically allocating the structure, though I am not
convinced that we should be locally creating the struct pci_bus in the
first place.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm/mach-cns3xxx/pcie.c | 49 ++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 413134c..67964f9 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -19,6 +19,7 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/ptrace.h>
+#include <linux/slab.h>
 #include <asm/mach/map.h>
 #include "cns3xxx.h"
 #include "core.h"
@@ -266,11 +267,7 @@ static void __init cns3xxx_pcie_hw_init(struct cns3xxx_pcie *cnspci)
 	struct pci_sys_data sd = {
 		.domain = port,
 	};
-	struct pci_bus bus = {
-		.number = 0,
-		.ops = &cns3xxx_pcie_ops,
-		.sysdata = &sd,
-	};
+	struct pci_bus *bus;
 	u16 mem_base  = cnspci->res_mem.start >> 16;
 	u16 mem_limit = cnspci->res_mem.end   >> 16;
 	u16 io_base   = cnspci->res_io.start  >> 16;
@@ -280,34 +277,46 @@ static void __init cns3xxx_pcie_hw_init(struct cns3xxx_pcie *cnspci)
 	u16 pos;
 	u16 dc;
 
-	pci_bus_write_config_byte(&bus, devfn, PCI_PRIMARY_BUS, 0);
-	pci_bus_write_config_byte(&bus, devfn, PCI_SECONDARY_BUS, 1);
-	pci_bus_write_config_byte(&bus, devfn, PCI_SUBORDINATE_BUS, 1);
+	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
+	if (!bus)
+		return;
+
+	bus->number = 0;
+	bus->ops = &cns3xxx_pcie_ops;
+	bus->sysdata = &sd;
 
-	pci_bus_read_config_byte(&bus, devfn, PCI_PRIMARY_BUS, &tmp8);
-	pci_bus_read_config_byte(&bus, devfn, PCI_SECONDARY_BUS, &tmp8);
-	pci_bus_read_config_byte(&bus, devfn, PCI_SUBORDINATE_BUS, &tmp8);
+	pci_bus_write_config_byte(bus, devfn, PCI_PRIMARY_BUS, 0);
+	pci_bus_write_config_byte(bus, devfn, PCI_SECONDARY_BUS, 1);
+	pci_bus_write_config_byte(bus, devfn, PCI_SUBORDINATE_BUS, 1);
 
-	pci_bus_write_config_word(&bus, devfn, PCI_MEMORY_BASE, mem_base);
-	pci_bus_write_config_word(&bus, devfn, PCI_MEMORY_LIMIT, mem_limit);
-	pci_bus_write_config_word(&bus, devfn, PCI_IO_BASE_UPPER16, io_base);
-	pci_bus_write_config_word(&bus, devfn, PCI_IO_LIMIT_UPPER16, io_limit);
+	pci_bus_read_config_byte(bus, devfn, PCI_PRIMARY_BUS, &tmp8);
+	pci_bus_read_config_byte(bus, devfn, PCI_SECONDARY_BUS, &tmp8);
+	pci_bus_read_config_byte(bus, devfn, PCI_SUBORDINATE_BUS, &tmp8);
 
-	if (!cnspci->linked)
+	pci_bus_write_config_word(bus, devfn, PCI_MEMORY_BASE, mem_base);
+	pci_bus_write_config_word(bus, devfn, PCI_MEMORY_LIMIT, mem_limit);
+	pci_bus_write_config_word(bus, devfn, PCI_IO_BASE_UPPER16, io_base);
+	pci_bus_write_config_word(bus, devfn, PCI_IO_LIMIT_UPPER16, io_limit);
+
+	if (!cnspci->linked) {
+		kfree(bus);
 		return;
+	}
 
 	/* Set Device Max_Read_Request_Size to 128 byte */
 	devfn = PCI_DEVFN(1, 0);
-	pos = pci_bus_find_capability(&bus, devfn, PCI_CAP_ID_EXP);
-	pci_bus_read_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
+	pos = pci_bus_find_capability(bus, devfn, PCI_CAP_ID_EXP);
+	pci_bus_read_config_word(bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
 	dc &= ~(0x3 << 12);	/* Clear Device Control Register [14:12] */
-	pci_bus_write_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, dc);
-	pci_bus_read_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
+	pci_bus_write_config_word(bus, devfn, pos + PCI_EXP_DEVCTL, dc);
+	pci_bus_read_config_word(bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
 	if (!(dc & (0x3 << 12)))
 		pr_info("PCIe: Set Device Max_Read_Request_Size to 128 byte\n");
 
 	/* Disable PCIe0 Interrupt Mask INTA to INTD */
 	__raw_writel(~0x3FFF, MISC_PCIE_INT_MASK(port));
+
+	kfree(bus);
 }
 
 static int cns3xxx_pcie_abort_handler(unsigned long addr, unsigned int fsr,
-- 
2.1.0.rc1
