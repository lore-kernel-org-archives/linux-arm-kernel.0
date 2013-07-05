From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  5 Jul 2013 18:39:21 -0300
Subject: [PATCH v6 10/21] pci: mvebu: Adapt to the new device tree layout
In-Reply-To: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1373060372-32357-11-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The new device tree layout encodes the window's target ID and attribute
in the PCIe controller node's ranges property. This allows to parse
such entries to obtain such information and use the recently introduced
MBus API to create the windows, instead of using the current name based
scheme.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-mvebu.c | 152 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 120 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 13a633b..a146f44 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -123,6 +123,10 @@ struct mvebu_pcie_port {
 	u32 port;
 	u32 lane;
 	int devfn;
+	unsigned int mem_target;
+	unsigned int mem_attr;
+	unsigned int io_target;
+	unsigned int io_attr;
 	struct clk *clk;
 	struct mvebu_sw_pci_bridge bridge;
 	struct device_node *dn;
@@ -307,10 +311,9 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 			    (port->bridge.iolimitupper << 16)) -
 			    iobase);
 
-	mvebu_mbus_add_window_remap_flags(port->name, port->iowin_base,
-					  port->iowin_size,
-					  iobase,
-					  MVEBU_MBUS_PCI_IO);
+	mvebu_mbus_add_window_remap_by_id(port->io_target, port->io_attr,
+					  port->iowin_base, port->iowin_size,
+					  iobase);
 
 	pci_ioremap_io(iobase, port->iowin_base);
 }
@@ -342,10 +345,8 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 		(((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
 		port->memwin_base;
 
-	mvebu_mbus_add_window_remap_flags(port->name, port->memwin_base,
-					  port->memwin_size,
-					  MVEBU_MBUS_NO_REMAP,
-					  MVEBU_MBUS_PCI_MEM);
+	mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
+				    port->memwin_base, port->memwin_size);
 }
 
 /*
@@ -755,12 +756,104 @@ mvebu_pcie_map_registers(struct platform_device *pdev,
 	return devm_request_and_ioremap(&pdev->dev, &regs);
 }
 
+#define DT_FLAGS_TO_TYPE(flags)       (((flags) >> 24) & 0x03)
+#define    DT_TYPE_IO                 0x1
+#define    DT_TYPE_MEM32              0x2
+#define DT_FLAGS_TO_DEVFN(flags)      (((flags) >> 8) & 0xFF)
+#define DT_CPUADDR_TO_ADDR(cpuaddr)   ((cpuaddr) & 0xFFFFFFFF)
+#define DT_CPUADDR_TO_TARGET(cpuaddr) (((cpuaddr) >> 56) & 0xFF)
+#define DT_CPUADDR_TO_ATTR(cpuaddr)   (((cpuaddr) >> 48) & 0xFF)
+
+static int mvebu_get_resources(struct device_node *np, struct resource *mem,
+			       struct resource *io, struct resource *realio)
+{
+	const int na = 3, ns = 2;
+	const __be32 *range;
+	int rlen, nranges, rangesz, pna, i;
+
+	range = of_get_property(np, "ranges", &rlen);
+	if (!range)
+		return -EINVAL;
+
+	pna = of_n_addr_cells(np);
+	rangesz = pna + na + ns;
+	nranges = rlen / sizeof(__be32) / rangesz;
+
+	for (i = 0; i < nranges; i++) {
+		u32 flags = of_read_number(range, 1);
+		u64 pciaddr = of_read_number(range + 1, ns);
+		u64 cpuaddr = of_read_number(range + na, pna);
+		u64 size    = of_read_number(range + na + pna, ns);
+
+		/* I/O */
+		if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_IO &&
+		    DT_FLAGS_TO_DEVFN(flags) != 0) {
+			io->start = cpuaddr & 0xFFFFFFFF;
+			io->end   = io->start + size;
+			io->flags = IORESOURCE_IO;
+			realio->start = max_t(resource_size_t,
+					      PCIBIOS_MIN_IO,
+					      pciaddr);
+			realio->end = min_t(resource_size_t,
+					    IO_SPACE_LIMIT,
+					    pciaddr + size);
+			realio->flags = io->flags;
+		}
+		/* MEM */
+		else if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_MEM32 &&
+			 DT_FLAGS_TO_DEVFN(flags) != 0) {
+			mem->start = cpuaddr & 0xFFFFFFFF;
+			mem->end   = mem->start + size;
+			mem->flags = IORESOURCE_MEM;
+		}
+
+		range += rangesz;
+	}
+
+	return 0;
+}
+
+static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
+			      unsigned long type, int *tgt, int *attr)
+{
+	const int na = 3, ns = 2;
+	const __be32 *range;
+	int rlen, nranges, rangesz, pna, i;
+
+	range = of_get_property(np, "ranges", &rlen);
+	if (!range)
+		return -EINVAL;
+
+	pna = of_n_addr_cells(np);
+	rangesz = pna + na + ns;
+	nranges = rlen / sizeof(__be32) / rangesz;
+
+	for (i = 0; i < nranges; i++) {
+		u32 flags = of_read_number(range, 1);
+		u64 cpuaddr = of_read_number(range + na, pna);
+		unsigned long rtype;
+
+		if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_IO)
+			rtype = IORESOURCE_IO;
+		else if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_MEM32)
+			rtype = IORESOURCE_MEM;
+
+		if (DT_FLAGS_TO_DEVFN(flags) == devfn && type == rtype) {
+			*tgt = DT_CPUADDR_TO_TARGET(cpuaddr);
+			*attr = DT_CPUADDR_TO_ATTR(cpuaddr);
+			return 0;
+		}
+
+		range += rangesz;
+	}
+
+	return -ENOENT;
+}
+
 static int __init mvebu_pcie_probe(struct platform_device *pdev)
 {
 	struct mvebu_pcie *pcie;
 	struct device_node *np = pdev->dev.of_node;
-	struct of_pci_range range;
-	struct of_pci_range_parser parser;
 	struct device_node *child;
 	int i, ret;
 
@@ -771,28 +864,7 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
 
 	pcie->pdev = pdev;
 
-	if (of_pci_range_parser_init(&parser, np))
-		return -EINVAL;
-
-	/* Get the I/O and memory ranges from DT */
-	for_each_of_pci_range(&parser, &range) {
-		unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
-		if (restype == IORESOURCE_IO) {
-			of_pci_range_to_resource(&range, np, &pcie->io);
-			of_pci_range_to_resource(&range, np, &pcie->realio);
-			pcie->io.name = "I/O";
-			pcie->realio.start = max_t(resource_size_t,
-						   PCIBIOS_MIN_IO,
-						   range.pci_addr);
-			pcie->realio.end = min_t(resource_size_t,
-						 IO_SPACE_LIMIT,
-						 range.pci_addr + range.size);
-		}
-		if (restype == IORESOURCE_MEM) {
-			of_pci_range_to_resource(&range, np, &pcie->mem);
-			pcie->mem.name = "MEM";
-		}
-	}
+	mvebu_get_resources(np, &pcie->mem, &pcie->io, &pcie->realio);
 
 	/* Get the bus range */
 	ret = of_pci_parse_bus_range(np, &pcie->busn);
@@ -841,6 +913,22 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
 		if (port->devfn < 0)
 			continue;
 
+		ret = mvebu_get_tgt_attr(np, port->devfn, IORESOURCE_MEM,
+					 &port->mem_target, &port->mem_attr);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "PCIe%d.%d: cannot get tgt/attr for mem window\n",
+				port->port, port->lane);
+			continue;
+		}
+
+		ret = mvebu_get_tgt_attr(np, port->devfn, IORESOURCE_IO,
+					 &port->io_target, &port->io_attr);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "PCIe%d.%d: cannot get tgt/attr for io window\n",
+				port->port, port->lane);
+			continue;
+		}
+
 		port->base = mvebu_pcie_map_registers(pdev, child, port);
 		if (!port->base) {
 			dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
-- 
1.8.1.5
