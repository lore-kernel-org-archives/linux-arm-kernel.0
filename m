From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 14 Aug 2013 16:22:33 +1000
Subject: linux-next: manual merge of the mvebu tree with the pci tree
Message-ID: <20130814162233.9265a6c8feaaabd0b690985c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in
drivers/pci/host/pci-mvebu.c between commit f48fbf9c7e89 ("PCI: mvebu:
Convert to use devm_ioremap_resource") from the pci tree and commit
826727641b2a ("PCI: mvebu: move clock enable before register access")
from the mvebu tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/pci/host/pci-mvebu.c
index ce1543a,88c6790..0000000
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@@ -725,12 -741,71 +741,71 @@@ static void __iomem *mvebu_pcie_map_reg
  
  	ret = of_address_to_resource(np, 0, &regs);
  	if (ret)
 -		return NULL;
 +		return ERR_PTR(ret);
  
 -	return devm_request_and_ioremap(&pdev->dev, &regs);
 +	return devm_ioremap_resource(&pdev->dev, &regs);
  }
  
- static int __init mvebu_pcie_probe(struct platform_device *pdev)
+ #define DT_FLAGS_TO_TYPE(flags)       (((flags) >> 24) & 0x03)
+ #define    DT_TYPE_IO                 0x1
+ #define    DT_TYPE_MEM32              0x2
+ #define DT_CPUADDR_TO_TARGET(cpuaddr) (((cpuaddr) >> 56) & 0xFF)
+ #define DT_CPUADDR_TO_ATTR(cpuaddr)   (((cpuaddr) >> 48) & 0xFF)
+ 
+ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
+ 			      unsigned long type, int *tgt, int *attr)
+ {
+ 	const int na = 3, ns = 2;
+ 	const __be32 *range;
+ 	int rlen, nranges, rangesz, pna, i;
+ 
+ 	range = of_get_property(np, "ranges", &rlen);
+ 	if (!range)
+ 		return -EINVAL;
+ 
+ 	pna = of_n_addr_cells(np);
+ 	rangesz = pna + na + ns;
+ 	nranges = rlen / sizeof(__be32) / rangesz;
+ 
+ 	for (i = 0; i < nranges; i++) {
+ 		u32 flags = of_read_number(range, 1);
+ 		u32 slot = of_read_number(range, 2);
+ 		u64 cpuaddr = of_read_number(range + na, pna);
+ 		unsigned long rtype;
+ 
+ 		if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_IO)
+ 			rtype = IORESOURCE_IO;
+ 		else if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_MEM32)
+ 			rtype = IORESOURCE_MEM;
+ 
+ 		if (slot == PCI_SLOT(devfn) && type == rtype) {
+ 			*tgt = DT_CPUADDR_TO_TARGET(cpuaddr);
+ 			*attr = DT_CPUADDR_TO_ATTR(cpuaddr);
+ 			return 0;
+ 		}
+ 
+ 		range += rangesz;
+ 	}
+ 
+ 	return -ENOENT;
+ }
+ 
+ static void mvebu_pcie_msi_enable(struct mvebu_pcie *pcie)
+ {
+ 	struct device_node *msi_node;
+ 
+ 	msi_node = of_parse_phandle(pcie->pdev->dev.of_node,
+ 				    "msi-parent", 0);
+ 	if (!msi_node)
+ 		return;
+ 
+ 	pcie->msi = of_pci_find_msi_chip_by_node(msi_node);
+ 
+ 	if (pcie->msi)
+ 		pcie->msi->dev = &pcie->pdev->dev;
+ }
+ 
+ static int mvebu_pcie_probe(struct platform_device *pdev)
  {
  	struct mvebu_pcie *pcie;
  	struct device_node *np = pdev->dev.of_node;
@@@ -816,11 -888,62 +888,63 @@@
  		if (port->devfn < 0)
  			continue;
  
+ 		ret = mvebu_get_tgt_attr(np, port->devfn, IORESOURCE_MEM,
+ 					 &port->mem_target, &port->mem_attr);
+ 		if (ret < 0) {
+ 			dev_err(&pdev->dev, "PCIe%d.%d: cannot get tgt/attr for mem window\n",
+ 				port->port, port->lane);
+ 			continue;
+ 		}
+ 
+ 		ret = mvebu_get_tgt_attr(np, port->devfn, IORESOURCE_IO,
+ 					 &port->io_target, &port->io_attr);
+ 		if (ret < 0) {
+ 			dev_err(&pdev->dev, "PCIe%d.%d: cannot get tgt/attr for io window\n",
+ 				port->port, port->lane);
+ 			continue;
+ 		}
+ 
+ 		port->reset_gpio = of_get_named_gpio_flags(child,
+ 						   "reset-gpios", 0, &flags);
+ 		if (gpio_is_valid(port->reset_gpio)) {
+ 			u32 reset_udelay = 20000;
+ 
+ 			port->reset_active_low = flags & OF_GPIO_ACTIVE_LOW;
+ 			port->reset_name = kasprintf(GFP_KERNEL,
+ 				     "pcie%d.%d-reset", port->port, port->lane);
+ 			of_property_read_u32(child, "reset-delay-us",
+ 					     &reset_udelay);
+ 
+ 			ret = devm_gpio_request_one(&pdev->dev,
+ 			    port->reset_gpio, GPIOF_DIR_OUT, port->reset_name);
+ 			if (ret) {
+ 				if (ret == -EPROBE_DEFER)
+ 					return ret;
+ 				continue;
+ 			}
+ 
+ 			gpio_set_value(port->reset_gpio,
+ 				       (port->reset_active_low) ? 1 : 0);
+ 			udelay(reset_udelay);
+ 		}
+ 
+ 		port->clk = of_clk_get_by_name(child, NULL);
+ 		if (IS_ERR(port->clk)) {
+ 			dev_err(&pdev->dev, "PCIe%d.%d: cannot get clock\n",
+ 			       port->port, port->lane);
+ 			continue;
+ 		}
+ 
+ 		ret = clk_prepare_enable(port->clk);
+ 		if (ret)
+ 			continue;
+ 
  		port->base = mvebu_pcie_map_registers(pdev, child, port);
 -		if (!port->base) {
 +		if (IS_ERR(port->base)) {
  			dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
  				port->port, port->lane);
+ 			clk_disable_unprepare(port->clk);
 +			port->base = NULL;
  			continue;
  		}
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130814/daeb9b6e/attachment.sig>
