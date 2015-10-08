From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Oct 2015 22:16:25 +0800
Subject: [PATCH v8 3/6] pci:host: Add Altera PCIe host controller driver
In-Reply-To: <1444297394-3122-4-git-send-email-lftan@altera.com>
Message-ID: <201510082217.oV6b4scl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ley,

[auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]

config: sparc-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc 

All errors (new ones prefixed by >>):

   drivers/pci/host/pcie-altera.c: In function 'tlp_cfg_dword_read':
   drivers/pci/host/pcie-altera.c:243:12: warning: large integer implicitly truncated to unsigned type [-Woverflow]
      *value = ~0UL; /* return 0xFFFFFFFF if error */
               ^
   drivers/pci/host/pcie-altera.c: In function 'altera_pcie_cfg_read':
   drivers/pci/host/pcie-altera.c:291:12: warning: large integer implicitly truncated to unsigned type [-Woverflow]
      *value = ~0UL;
               ^
   drivers/pci/host/pcie-altera.c: In function 'altera_pcie_parse_request_of_pci_ranges':
>> drivers/pci/host/pcie-altera.c:410:2: error: implicit declaration of function 'of_pci_get_host_bridge_resources' [-Werror=implicit-function-declaration]
     err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
     ^
   cc1: some warnings being treated as errors

vim +/of_pci_get_host_bridge_resources +410 drivers/pci/host/pcie-altera.c

   237		headers[2] = TLP_CFG_DW2(bus, devfn, where);
   238	
   239		tlp_write_packet(pcie, headers, 0, false);
   240	
   241		ret = tlp_read_packet(pcie, value);
   242		if (ret != PCIBIOS_SUCCESSFUL)
 > 243			*value = ~0UL;	/* return 0xFFFFFFFF if error */
   244	
   245		return ret;
   246	}
   247	
   248	static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
   249				       int where, u32 value)
   250	{
   251		u32 headers[TLP_HDR_SIZE];
   252		int ret;
   253	
   254		if (bus == pcie->root_bus_nr)
   255			headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR0);
   256		else
   257			headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR1);
   258	
   259		headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, devfn),
   260						TLP_WRITE_TAG);
   261		headers[2] = TLP_CFG_DW2(bus, devfn, where);
   262	
   263		/* check alignment to Qword */
   264		if ((where & 0x7) == 0)
   265			tlp_write_packet(pcie, headers, value, true);
   266		else
   267			tlp_write_packet(pcie, headers, value, false);
   268	
   269		ret = tlp_read_packet(pcie, NULL);
   270		if (ret != PCIBIOS_SUCCESSFUL)
   271			return ret;
   272	
   273		/*
   274		 * Monitoring changes to PCI_PRIMARY_BUS register on root port and update
   275		 * local copy of root bus number accordingly.
   276		 */
   277		if ((bus == pcie->root_bus_nr) && (where == PCI_PRIMARY_BUS))
   278			pcie->root_bus_nr = (u8)(value);
   279	
   280		return PCIBIOS_SUCCESSFUL;
   281	}
   282	
   283	static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
   284					int where, int size, u32 *value)
   285	{
   286		struct altera_pcie *pcie = bus->sysdata;
   287		int ret;
   288		u32 data;
   289	
   290		if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn))) {
   291			*value = ~0UL;
   292			return PCIBIOS_DEVICE_NOT_FOUND;
   293		}
   294	
   295		ret = tlp_cfg_dword_read(pcie, bus->number, devfn,
   296					 (where & ~DWORD_MASK), &data);
   297		if (ret != PCIBIOS_SUCCESSFUL)
   298			return ret;
   299	
   300		switch (size) {
   301		case 1:
   302			*value = (data >> (8 * (where & 0x3))) & 0xff;
   303			break;
   304		case 2:
   305			*value = (data >> (8 * (where & 0x2))) & 0xffff;
   306			break;
   307		default:
   308			*value = data;
   309			break;
   310		}
   311	
   312		return PCIBIOS_SUCCESSFUL;
   313	}
   314	
   315	static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
   316					 int where, int size, u32 value)
   317	{
   318		struct altera_pcie *pcie = bus->sysdata;
   319		u32 data32;
   320		u32 shift = 8 * (where & 3);
   321		int ret;
   322	
   323		if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
   324			return PCIBIOS_DEVICE_NOT_FOUND;
   325	
   326		/* write partial */
   327		if (size != sizeof(u32)) {
   328			ret = tlp_cfg_dword_read(pcie, bus->number, devfn,
   329						 where & ~DWORD_MASK, &data32);
   330			if (ret)
   331				return ret;
   332		}
   333	
   334		switch (size) {
   335		case 1:
   336			data32 = (data32 & ~(0xff << shift)) |
   337					((value & 0xff) << shift);
   338			break;
   339		case 2:
   340			data32 = (data32 & ~(0xffff << shift)) |
   341					((value & 0xffff) << shift);
   342			break;
   343		default:
   344			data32 = value;
   345			break;
   346		}
   347	
   348		return tlp_cfg_dword_write(pcie, bus->number, devfn,
   349			(where & ~DWORD_MASK), data32);
   350	}
   351	
   352	static struct pci_ops altera_pcie_ops = {
   353		.read = altera_pcie_cfg_read,
   354		.write = altera_pcie_cfg_write,
   355	};
   356	
   357	static int altera_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
   358					irq_hw_number_t hwirq)
   359	{
   360		irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
   361		irq_set_chip_data(irq, domain->host_data);
   362	
   363		return 0;
   364	}
   365	
   366	static const struct irq_domain_ops intx_domain_ops = {
   367		.map = altera_pcie_intx_map,
   368	};
   369	
   370	static void altera_pcie_isr(struct irq_desc *desc)
   371	{
   372		struct irq_chip *chip = irq_desc_get_chip(desc);
   373		struct altera_pcie *pcie;
   374		unsigned long status;
   375		u32 bit;
   376		u32 virq;
   377	
   378		chained_irq_enter(chip, desc);
   379		pcie = irq_desc_get_handler_data(desc);
   380	
   381		while ((status = cra_readl(pcie, P2A_INT_STATUS)
   382			& P2A_INT_STS_ALL) != 0) {
   383			for_each_set_bit(bit, &status, INTX_NUM) {
   384				/* clear interrupts */
   385				cra_writel(pcie, 1 << bit, P2A_INT_STATUS);
   386	
   387				virq = irq_find_mapping(pcie->irq_domain, bit + 1);
   388				if (virq)
   389					generic_handle_irq(virq);
   390				else
   391					dev_err(&pcie->pdev->dev, "unexpected IRQ\n");
   392			}
   393		}
   394	
   395		chained_irq_exit(chip, desc);
   396	}
   397	
   398	static void altera_pcie_release_of_pci_ranges(struct altera_pcie *pcie)
   399	{
   400		pci_free_resource_list(&pcie->resources);
   401	}
   402	
   403	static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
   404	{
   405		int err, res_valid = 0;
   406		struct device *dev = &pcie->pdev->dev;
   407		struct device_node *np = dev->of_node;
   408		struct resource_entry *win;
   409	
 > 410		err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
   411						       NULL);
   412		if (err)
   413			return err;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 43415 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151008/5af3e1de/attachment-0001.obj>
