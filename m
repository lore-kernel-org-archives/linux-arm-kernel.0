From: lkp@intel.com (kbuild test robot)
Date: Mon, 23 Nov 2015 19:02:46 +0800
Subject: [PATCH v3 4/6] PCI: qcom: Add Qualcomm PCIe controller driver
In-Reply-To: <edbe363a31ad2a6c2eddc5441c2de44475551dcd.1448270813.git.stanimir.varbanov@linaro.org>
Message-ID: <201511231928.HamSevrs%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stanimir,

[auto build test ERROR on: v4.4-rc2]
[also build test ERROR on: next-20151123]

url:    https://github.com/0day-ci/linux/commits/Stanimir-Varbanov/Qualcomm-PCIe-driver-and-designware-fixes/20151123-173312
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/pci/host/pcie-designware.c: In function 'dw_pcie_host_init':
>> drivers/pci/host/pcie-designware.c:559:7: error: implicit declaration of function 'pci_has_flag' [-Werror=implicit-function-declaration]
     if (!pci_has_flag(PCI_PROBE_ONLY)) {
          ^
>> drivers/pci/host/pcie-designware.c:559:20: error: 'PCI_PROBE_ONLY' undeclared (first use in this function)
     if (!pci_has_flag(PCI_PROBE_ONLY)) {
                       ^
   drivers/pci/host/pcie-designware.c:559:20: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors

vim +/pci_has_flag +559 drivers/pci/host/pcie-designware.c

cbce7900 Zhou Wang   2015-10-29  543  					    &dw_pcie_msi_chip);
0815f957 Yijing Wang 2014-11-11  544  		dw_pcie_msi_chip.dev = pp->dev;
cbce7900 Zhou Wang   2015-10-29  545  	} else
cbce7900 Zhou Wang   2015-10-29  546  		bus = pci_scan_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
cbce7900 Zhou Wang   2015-10-29  547  					pp, &res);
cbce7900 Zhou Wang   2015-10-29  548  	if (!bus)
cbce7900 Zhou Wang   2015-10-29  549  		return -ENOMEM;
cbce7900 Zhou Wang   2015-10-29  550  
cbce7900 Zhou Wang   2015-10-29  551  	if (pp->ops->scan_bus)
cbce7900 Zhou Wang   2015-10-29  552  		pp->ops->scan_bus(pp);
cbce7900 Zhou Wang   2015-10-29  553  
cbce7900 Zhou Wang   2015-10-29  554  #ifdef CONFIG_ARM
cbce7900 Zhou Wang   2015-10-29  555  	/* support old dtbs that incorrectly describe IRQs */
cbce7900 Zhou Wang   2015-10-29  556  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
0815f957 Yijing Wang 2014-11-11  557  #endif
0815f957 Yijing Wang 2014-11-11  558  
cbce7900 Zhou Wang   2015-10-29 @559  	if (!pci_has_flag(PCI_PROBE_ONLY)) {
cbce7900 Zhou Wang   2015-10-29  560  		pci_bus_size_bridges(bus);
cbce7900 Zhou Wang   2015-10-29  561  		pci_bus_assign_resources(bus);
4b1ced84 Jingoo Han  2013-07-31  562  
cbce7900 Zhou Wang   2015-10-29  563  		list_for_each_entry(child, &bus->children, node)
cbce7900 Zhou Wang   2015-10-29  564  			pcie_bus_configure_settings(child);
cbce7900 Zhou Wang   2015-10-29  565  	}
4b1ced84 Jingoo Han  2013-07-31  566  
cbce7900 Zhou Wang   2015-10-29  567  	pci_bus_add_devices(bus);

:::::: The code at line 559 was first introduced by commit
:::::: cbce7900598c26a12652f8ca9c41c5b29034c38d PCI: designware: Make driver arch-agnostic

:::::: TO: Zhou Wang <wangzhou1@hisilicon.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 52602 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151123/1fe50844/attachment-0001.obj>
