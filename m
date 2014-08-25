From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Aug 2014 13:30:22 +0200
Subject: [PATCH] ARM: cns3xxx: Don't allocate PCI addresses on stack
In-Reply-To: <2492333.HstnrugmgL@wuerfel>
References: <1408927894-30858-1-git-send-email-broonie@kernel.org>
 <2492333.HstnrugmgL@wuerfel>
Message-ID: <2791908.V6o8lplUAt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 August 2014 12:34:25 Arnd Bergmann wrote:
> On Sunday 24 August 2014 19:51:34 Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>
> > 
> > The cns3xxx PCIe code allocates a PCI bus structure on the stack, causing
> > warnings due to the excessibe size of the resulting stack frame:
> > 
> > arch/arm/mach-cns3xxx/pcie.c:311:1: warning: the frame size of 1072 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > 
> > Avoid this by dynamically allocating the structure, though I am not
> > convinced that we should be locally creating the struct pci_bus in the
> > first place.
> > 
> > Signed-off-by: Mark Brown <broonie@linaro.org>
> > 
> 
> We should certainly not make up a pci_bus here just for the purpose
> of calling a common code function that comes back through a callback
> to the locally defined cns3xxx_pci_read_config/cns3xxx_pci_write_config.
> 
> However, refactoring the code to do it right seems like actual work
> and I'm not sure we can find anybody to do it, so your hack seems
> like the best approximation.

I may have spoken too fast. Here is a patch that should deal with the
problem more cleanly, and also help prepare that code for a potential
move to the changed PCI probing infrastructure that is getting
done for arm64.

Completely untested.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 413134c54452..5b26b574bcbe 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -55,7 +55,7 @@ static struct cns3xxx_pcie *pbus_to_cnspci(struct pci_bus *bus)
 }
 
 static void __iomem *cns3xxx_pci_cfg_base(struct pci_bus *bus,
-				  unsigned int devfn, int where)
+					  unsigned int devfn)
 {
 	struct cns3xxx_pcie *cnspci = pbus_to_cnspci(bus);
 	int busno = bus->number;
@@ -86,61 +86,87 @@ static void __iomem *cns3xxx_pci_cfg_base(struct pci_bus *bus,
 	} else /* remote PCI bus */
 		base = cnspci->cfg1_regs;
 
-	offset = ((busno & 0xf) << 20) | (devfn << 12) | (where & 0xffc);
+	offset = ((busno & 0xf) << 20) | (devfn << 12);
 	return base + offset;
 }
 
-static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
-				   int where, int size, u32 *val)
+static u32 cns3xxx_pci_raw_read_config(void __iomem *base, int where,
+				       int size)
+{
+	u32 v;
+	u32 mask = (0x1ull << (size * 8)) - 1;
+	int shift = (where % 4) * 8;
+
+	v = __raw_readl(base + (where & 0xffc));
+
+	return (v >> shift) & mask;
+}
+
+static u32 cns3xxx_pci_fake_read_config(void __iomem *base, int where,
+				        int size)
 {
 	u32 v;
-	void __iomem *base;
 	u32 mask = (0x1ull << (size * 8)) - 1;
 	int shift = (where % 4) * 8;
 
-	base = cns3xxx_pci_cfg_base(bus, devfn, where);
+	v = __raw_readl(base + (where & 0xffc));
+
+	/*
+	 * RC's class is 0xb, but Linux PCI driver needs 0x604
+	 * for a PCIe bridge. So we must fixup the class code
+	 * to 0x604 here.
+	 */
+	v &= 0xff;
+	v |= 0x604 << 16;
+
+	return (v >> shift) & mask;
+}
+
+static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 *val)
+{
+	void __iomem *base;
+
+	base = cns3xxx_pci_cfg_base(bus, devfn);
 	if (!base) {
 		*val = 0xffffffff;
 		return PCIBIOS_SUCCESSFUL;
 	}
 
-	v = __raw_readl(base);
-
 	if (bus->number == 0 && devfn == 0 &&
-			(where & 0xffc) == PCI_CLASS_REVISION) {
-		/*
-		 * RC's class is 0xb, but Linux PCI driver needs 0x604
-		 * for a PCIe bridge. So we must fixup the class code
-		 * to 0x604 here.
-		 */
-		v &= 0xff;
-		v |= 0x604 << 16;
-	}
-
-	*val = (v >> shift) & mask;
+	    (where & 0xffc) == PCI_CLASS_REVISION)
+		*val = cns3xxx_pci_fake_read_config(base, where, size);
+	else
+		*val = cns3xxx_pci_raw_read_config(base, where, size);
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int cns3xxx_pci_write_config(struct pci_bus *bus, unsigned int devfn,
-				    int where, int size, u32 val)
+static void cns3xxx_pci_raw_write_config(void __iomem *base, int where,
+					 int size, u32 val)
 {
 	u32 v;
-	void __iomem *base;
 	u32 mask = (0x1ull << (size * 8)) - 1;
 	int shift = (where % 4) * 8;
 
-	base = cns3xxx_pci_cfg_base(bus, devfn, where);
-	if (!base)
-		return PCIBIOS_SUCCESSFUL;
-
-	v = __raw_readl(base);
+	v = __raw_readl(base + (where & 0xffc));
 
 	v &= ~(mask << shift);
 	v |= (val & mask) << shift;
 
-	__raw_writel(v, base);
+	__raw_writel(v, base + (where & 0xffc));
+}
+
+static int cns3xxx_pci_write_config(struct pci_bus *bus, unsigned int devfn,
+				    int where, int size, u32 val)
+{
+	void __iomem *base;
 
+	base = cns3xxx_pci_cfg_base(bus, devfn);
+	if (!base)
+		return PCIBIOS_SUCCESSFUL;
+
+	cns3xxx_pci_raw_write_config(base, where, size, val);
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -262,47 +288,42 @@ static void __init cns3xxx_pcie_check_link(struct cns3xxx_pcie *cnspci)
 
 static void __init cns3xxx_pcie_hw_init(struct cns3xxx_pcie *cnspci)
 {
+	void __iomem *regs = cnspci->host_regs;
 	int port = cnspci->hw_pci.domain;
-	struct pci_sys_data sd = {
-		.domain = port,
-	};
-	struct pci_bus bus = {
-		.number = 0,
-		.ops = &cns3xxx_pcie_ops,
-		.sysdata = &sd,
-	};
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
-	devfn = PCI_DEVFN(1, 0);
-	pos = pci_bus_find_capability(&bus, devfn, PCI_CAP_ID_EXP);
-	pci_bus_read_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
+	pos = cns3xxx_pci_raw_read_config(regs, PCI_CAPABILITY_LIST, 1);
+	while (cns3xxx_pci_raw_read_config(regs, pos, 1) != PCI_CAP_ID_EXP)
+		pos = cns3xxx_pci_raw_read_config(regs, pos + PCI_CAP_LIST_NEXT, 1);
+		
+	dc = cns3xxx_pci_raw_read_config(regs, pos + PCI_EXP_DEVCTL, 2);
 	dc &= ~(0x3 << 12);	/* Clear Device Control Register [14:12] */
-	pci_bus_write_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, dc);
-	pci_bus_read_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
+	cns3xxx_pci_raw_write_config(regs, pos + PCI_EXP_DEVCTL, 2, dc);
+	dc = cns3xxx_pci_raw_read_config(regs, pos + PCI_EXP_DEVCTL, 2);
 	if (!(dc & (0x3 << 12)))
 		pr_info("PCIe: Set Device Max_Read_Request_Size to 128 byte\n");
 
