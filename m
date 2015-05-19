From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 17:14:59 +0200
Subject: [PATCH] ARM: cns3xxx: pci: avoid potential stack overflow
Message-ID: <2273145.0Ls8cProhs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cns3xxx_pcie_hw_init function uses excessive kernel
stack space because of a hack that puts a fake struct
pci_sys_data and struct pci_bus on the stack in order to
call the generic pci_bus_read_config accessors, which causes
a warning in ARM allmodconfig builds:

arch/arm/mach-cns3xxx/pcie.c:266:1: warning: the frame size of 1080 bytes is larger than 1024 bytes

This rewrites the code in question to use a private
implementation of the config space access for the same
purpose, getting rid of the local variables and the
warning in the process. As part of this, we have to
use an open-coded version of pci_bus_find_capability(),
which unfortunately complicates the implementation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index c622c306c390..f411664639a2 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -106,6 +106,30 @@ static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	return ret;
 }
 
+static u32 cns3xxx_pci_raw_read_config(void __iomem *base, int where,
+				       int size)
+{
+	u32 mask = (0x1ull << (size * 8)) - 1;
+	int shift = (where % 4) * 8;
+
+	return (__raw_readl(base + (where & 0xffc)) >> shift) & mask;
+}
+
+static void cns3xxx_pci_raw_write_config(void __iomem *base, int where,
+					 int size, u32 val)
+{
+	u32 v;
+	u32 mask = (0x1ull << (size * 8)) - 1;
+	int shift = (where % 4) * 8;
+
+	v = __raw_readl(base + (where & 0xffc));
+
+	v &= ~(mask << shift);
+	v |= (val & mask) << shift;
+
+	__raw_writel(v, base + (where & 0xffc));
+}
+
 static int cns3xxx_pci_setup(int nr, struct pci_sys_data *sys)
 {
 	struct cns3xxx_pcie *cnspci = sysdata_to_cnspci(sys);
@@ -213,56 +237,46 @@ static void __init cns3xxx_pcie_check_link(struct cns3xxx_pcie *cnspci)
 
 static void __init cns3xxx_pcie_hw_init(struct cns3xxx_pcie *cnspci)
 {
-	int port = cnspci->port;
-	struct pci_sys_data sd = {
-		.private_data = cnspci,
-	};
-	struct pci_bus bus = {
-		.number = 0,
-		.ops = &cns3xxx_pcie_ops,
-		.sysdata = &sd,
-	};
+	void __iomem *regs = cnspci->host_regs;
 	u16 mem_base  = cnspci->res_mem.start >> 16;
 	u16 mem_limit = cnspci->res_mem.end   >> 16;
 	u16 io_base   = cnspci->res_io.start  >> 16;
 	u16 io_limit  = cnspci->res_io.end    >> 16;
-	u32 devfn = 0;
-	u8 tmp8;
 	u16 pos;
 	u16 dc;
 
-	pci_bus_write_config_byte(&bus, devfn, PCI_PRIMARY_BUS, 0);
-	pci_bus_write_config_byte(&bus, devfn, PCI_SECONDARY_BUS, 1);
-	pci_bus_write_config_byte(&bus, devfn, PCI_SUBORDINATE_BUS, 1);
+	cns3xxx_pci_raw_write_config(regs, PCI_PRIMARY_BUS, 1, 0);
+	cns3xxx_pci_raw_write_config(regs, PCI_SECONDARY_BUS, 1, 1);
+	cns3xxx_pci_raw_write_config(regs, PCI_SUBORDINATE_BUS, 1, 1);
 
-	pci_bus_read_config_byte(&bus, devfn, PCI_PRIMARY_BUS, &tmp8);
-	pci_bus_read_config_byte(&bus, devfn, PCI_SECONDARY_BUS, &tmp8);
-	pci_bus_read_config_byte(&bus, devfn, PCI_SUBORDINATE_BUS, &tmp8);
+	cns3xxx_pci_raw_read_config(regs, PCI_PRIMARY_BUS, 1);
+	cns3xxx_pci_raw_read_config(regs, PCI_SECONDARY_BUS, 1);
+	cns3xxx_pci_raw_read_config(regs, PCI_SUBORDINATE_BUS, 1);
 
-	pci_bus_write_config_word(&bus, devfn, PCI_MEMORY_BASE, mem_base);
-	pci_bus_write_config_word(&bus, devfn, PCI_MEMORY_LIMIT, mem_limit);
-	pci_bus_write_config_word(&bus, devfn, PCI_IO_BASE_UPPER16, io_base);
-	pci_bus_write_config_word(&bus, devfn, PCI_IO_LIMIT_UPPER16, io_limit);
+	cns3xxx_pci_raw_write_config(regs, PCI_MEMORY_BASE, 2, mem_base);
+	cns3xxx_pci_raw_write_config(regs, PCI_MEMORY_LIMIT, 2, mem_limit);
+	cns3xxx_pci_raw_write_config(regs, PCI_IO_BASE_UPPER16, 2, io_base);
+	cns3xxx_pci_raw_write_config(regs, PCI_IO_LIMIT_UPPER16, 2, io_limit);
 
 	if (!cnspci->linked)
 		return;
 
+	regs = cnspci->cfg0_regs + (PCI_DEVFN(1, 0) << 12);
+
 	/* Set Device Max_Read_Request_Size to 128 byte */
-	bus.number = 1; /* directly connected PCIe device */
-	devfn = PCI_DEVFN(0, 0);
-	pos = pci_bus_find_capability(&bus, devfn, PCI_CAP_ID_EXP);
-	pci_bus_read_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
-	if (dc & PCI_EXP_DEVCTL_READRQ) {
-		dc &= ~PCI_EXP_DEVCTL_READRQ;
-		pci_bus_write_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, dc);
-		pci_bus_read_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
-		if (dc & PCI_EXP_DEVCTL_READRQ)
-			pr_warn("PCIe: Unable to set device Max_Read_Request_Size\n");
-		else
-			pr_info("PCIe: Max_Read_Request_Size set to 128 bytes\n");
-	}
+	pos = cns3xxx_pci_raw_read_config(regs, PCI_CAPABILITY_LIST, 1);
+	while (cns3xxx_pci_raw_read_config(regs, pos, 1) != PCI_CAP_ID_EXP)
+		pos = cns3xxx_pci_raw_read_config(regs, pos + PCI_CAP_LIST_NEXT, 1);
+
+	dc = cns3xxx_pci_raw_read_config(regs, pos + PCI_EXP_DEVCTL, 2);
+	dc &= ~(0x3 << 12);	/* Clear Device Control Register [14:12] */
+	cns3xxx_pci_raw_write_config(regs, pos + PCI_EXP_DEVCTL, 2, dc);
+	dc = cns3xxx_pci_raw_read_config(regs, pos + PCI_EXP_DEVCTL, 2);
+	if (!(dc & (0x3 << 12)))
+		pr_info("PCIe: Set Device Max_Read_Request_Size to 128 byte\n");
+
 	/* Disable PCIe0 Interrupt Mask INTA to INTD */
-	__raw_writel(~0x3FFF, MISC_PCIE_INT_MASK(port));
+	__raw_writel(~0x3FFF, MISC_PCIE_INT_MASK(cnspci->port));
 }
 
 static int cns3xxx_pcie_abort_handler(unsigned long addr, unsigned int fsr,
