From: lkp@intel.com (kbuild test robot)
Date: Tue, 12 Jan 2016 17:55:09 +0800
Subject: [PATCH 1/5] PCI: xilinx: Removing xilinx_pcie_parse_and_add_res
 function
In-Reply-To: <1452576399-1513-2-git-send-email-bharatku@xilinx.com>
Message-ID: <201601121728.WfQgEwJr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bharat,

[auto build test ERROR on pci/next]
[also build test ERROR on v4.4 next-20160111]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Bharat-Kumar-Gogada/PCI-xilinx-Removing-xilinx_pcie_parse_and_add_res-function/20160112-133224
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/Bharat-Kumar-Gogada/PCI-xilinx-Removing-xilinx_pcie_parse_and_add_res-function/20160112-133224 HEAD 8ae5c17c14eb5023b68a0c2bc9fabb3b24eab051 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> drivers/pci/host/pcie-xilinx.c:657:25: error: expected '=', ',', ';', 'asm' or '__attribute__' before '-' token
     * xilinx_pcie_parse_dt - Parse Device tree
                            ^
>> drivers/pci/host/pcie-xilinx.c:658:4: error: stray '@' in program
     * @port: PCIe port information
       ^
   drivers/pci/host/pcie-xilinx.c: In function 'xilinx_pcie_probe':
>> drivers/pci/host/pcie-xilinx.c:722:2: error: implicit declaration of function 'xilinx_pcie_parse_dt' [-Werror=implicit-function-declaration]
     err = xilinx_pcie_parse_dt(port);
     ^
   drivers/pci/host/pcie-xilinx.c: At top level:
   drivers/pci/host/pcie-xilinx.c:391:20: warning: 'xilinx_pcie_intr_handler' defined but not used [-Wunused-function]
    static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
                       ^
   cc1: some warnings being treated as errors

vim +657 drivers/pci/host/pcie-xilinx.c

8953aab1 Lorenzo Pieralisi   2015-07-29  651  	else
8953aab1 Lorenzo Pieralisi   2015-07-29  652  		bus = pci_scan_root_bus(port->dev, sys->busnr,
8953aab1 Lorenzo Pieralisi   2015-07-29  653  					&xilinx_pcie_ops, sys, &sys->resources);
8961def5 Srikanth Thokala    2014-08-20  654  	return bus;
8961def5 Srikanth Thokala    2014-08-20  655  }
8961def5 Srikanth Thokala    2014-08-20  656  
8961def5 Srikanth Thokala    2014-08-20 @657   * xilinx_pcie_parse_dt - Parse Device tree
8961def5 Srikanth Thokala    2014-08-20 @658   * @port: PCIe port information
8961def5 Srikanth Thokala    2014-08-20  659   *
8961def5 Srikanth Thokala    2014-08-20  660   * Return: '0' on success and error value on failure
8961def5 Srikanth Thokala    2014-08-20  661   */
8961def5 Srikanth Thokala    2014-08-20  662  static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
8961def5 Srikanth Thokala    2014-08-20  663  {
8961def5 Srikanth Thokala    2014-08-20  664  	struct device *dev = port->dev;
8961def5 Srikanth Thokala    2014-08-20  665  	struct device_node *node = dev->of_node;
8961def5 Srikanth Thokala    2014-08-20  666  	struct resource regs;
8961def5 Srikanth Thokala    2014-08-20  667  	const char *type;
8961def5 Srikanth Thokala    2014-08-20  668  	int err;
8961def5 Srikanth Thokala    2014-08-20  669  
8961def5 Srikanth Thokala    2014-08-20  670  	type = of_get_property(node, "device_type", NULL);
8961def5 Srikanth Thokala    2014-08-20  671  	if (!type || strcmp(type, "pci")) {
8961def5 Srikanth Thokala    2014-08-20  672  		dev_err(dev, "invalid \"device_type\" %s\n", type);
8961def5 Srikanth Thokala    2014-08-20  673  		return -EINVAL;
8961def5 Srikanth Thokala    2014-08-20  674  	}
8961def5 Srikanth Thokala    2014-08-20  675  
8961def5 Srikanth Thokala    2014-08-20  676  	err = of_address_to_resource(node, 0, &regs);
8961def5 Srikanth Thokala    2014-08-20  677  	if (err) {
8961def5 Srikanth Thokala    2014-08-20  678  		dev_err(dev, "missing \"reg\" property\n");
8961def5 Srikanth Thokala    2014-08-20  679  		return err;
8961def5 Srikanth Thokala    2014-08-20  680  	}
8961def5 Srikanth Thokala    2014-08-20  681  
8961def5 Srikanth Thokala    2014-08-20  682  	port->reg_base = devm_ioremap_resource(dev, &regs);
8961def5 Srikanth Thokala    2014-08-20  683  	if (IS_ERR(port->reg_base))
8961def5 Srikanth Thokala    2014-08-20  684  		return PTR_ERR(port->reg_base);
8961def5 Srikanth Thokala    2014-08-20  685  
8961def5 Srikanth Thokala    2014-08-20  686  	port->irq = irq_of_parse_and_map(node, 0);
8961def5 Srikanth Thokala    2014-08-20  687  	err = devm_request_irq(dev, port->irq, xilinx_pcie_intr_handler,
9dd875f8 Grygorii Strashko   2015-12-10  688  			       IRQF_SHARED | IRQF_NO_THREAD,
9dd875f8 Grygorii Strashko   2015-12-10  689  			       "xilinx-pcie", port);
8961def5 Srikanth Thokala    2014-08-20  690  	if (err) {
8961def5 Srikanth Thokala    2014-08-20  691  		dev_err(dev, "unable to request irq %d\n", port->irq);
8961def5 Srikanth Thokala    2014-08-20  692  		return err;
8961def5 Srikanth Thokala    2014-08-20  693  	}
8961def5 Srikanth Thokala    2014-08-20  694  
8961def5 Srikanth Thokala    2014-08-20  695  	return 0;
8961def5 Srikanth Thokala    2014-08-20  696  }
8961def5 Srikanth Thokala    2014-08-20  697  
8961def5 Srikanth Thokala    2014-08-20  698  /**
8961def5 Srikanth Thokala    2014-08-20  699   * xilinx_pcie_probe - Probe function
8961def5 Srikanth Thokala    2014-08-20  700   * @pdev: Platform device pointer
8961def5 Srikanth Thokala    2014-08-20  701   *
8961def5 Srikanth Thokala    2014-08-20  702   * Return: '0' on success and error value on failure
8961def5 Srikanth Thokala    2014-08-20  703   */
8961def5 Srikanth Thokala    2014-08-20  704  static int xilinx_pcie_probe(struct platform_device *pdev)
8961def5 Srikanth Thokala    2014-08-20  705  {
8961def5 Srikanth Thokala    2014-08-20  706  	struct xilinx_pcie_port *port;
8961def5 Srikanth Thokala    2014-08-20  707  	struct hw_pci hw;
8961def5 Srikanth Thokala    2014-08-20  708  	struct device *dev = &pdev->dev;
8961def5 Srikanth Thokala    2014-08-20  709  	int err;
aefcb31a Bharat Kumar Gogada 2016-01-12  710  	resource_size_t iobase = 0;
aefcb31a Bharat Kumar Gogada 2016-01-12  711  	LIST_HEAD(res);
8961def5 Srikanth Thokala    2014-08-20  712  
8961def5 Srikanth Thokala    2014-08-20  713  	if (!dev->of_node)
8961def5 Srikanth Thokala    2014-08-20  714  		return -ENODEV;
8961def5 Srikanth Thokala    2014-08-20  715  
8961def5 Srikanth Thokala    2014-08-20  716  	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
8961def5 Srikanth Thokala    2014-08-20  717  	if (!port)
8961def5 Srikanth Thokala    2014-08-20  718  		return -ENOMEM;
8961def5 Srikanth Thokala    2014-08-20  719  
8961def5 Srikanth Thokala    2014-08-20  720  	port->dev = dev;
8961def5 Srikanth Thokala    2014-08-20  721  
8961def5 Srikanth Thokala    2014-08-20 @722  	err = xilinx_pcie_parse_dt(port);
8961def5 Srikanth Thokala    2014-08-20  723  	if (err) {
8961def5 Srikanth Thokala    2014-08-20  724  		dev_err(dev, "Parsing DT failed\n");
8961def5 Srikanth Thokala    2014-08-20  725  		return err;

:::::: The code at line 657 was first introduced by commit
:::::: 8961def56845593f22ce85474e428f6e4892fdd3 PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver

:::::: TO: Srikanth Thokala <sthokal@xilinx.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53964 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160112/4d7ce5e2/attachment-0001.obj>
