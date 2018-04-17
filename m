From: lkp@intel.com (kbuild test robot)
Date: Wed, 18 Apr 2018 03:14:05 +0800
Subject: [arm-platforms:irq/level-msi 8/9]
 drivers/irqchip/irq-gic-v3-mbi.c:60:23: error: 'pci_msi_domain_write_msg'
 undeclared here (not in a function); did you mean 'irq_domain_is_msi'?
Message-ID: <201804180303.F10GefxW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/level-msi
head:   38158ba494401627aff6018b4cd65d17d9a8d3e8
commit: 0f5775c792c5f600ddbd7e40a73b2444e6829482 [8/9] irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller
config: arm64-alldefconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 0f5775c792c5f600ddbd7e40a73b2444e6829482
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> drivers/irqchip/irq-gic-v3-mbi.c:60:23: error: 'pci_msi_domain_write_msg' undeclared here (not in a function); did you mean 'irq_domain_is_msi'?
     .irq_write_msi_msg = pci_msi_domain_write_msg,
                          ^~~~~~~~~~~~~~~~~~~~~~~~
                          irq_domain_is_msi
   drivers/irqchip/irq-gic-v3-mbi.c: In function 'mbi_allocate_domains':
   drivers/irqchip/irq-gic-v3-mbi.c:218:15: error: implicit declaration of function 'pci_msi_create_irq_domain'; did you mean 'msi_create_irq_domain'? [-Werror=implicit-function-declaration]
     pci_domain = pci_msi_create_irq_domain(parent->fwnode,
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
                  msi_create_irq_domain
   drivers/irqchip/irq-gic-v3-mbi.c:218:13: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     pci_domain = pci_msi_create_irq_domain(parent->fwnode,
                ^
   cc1: some warnings being treated as errors

vim +60 drivers/irqchip/irq-gic-v3-mbi.c

    51	
    52	/* PCI-specific irqchip */
    53	static struct irq_chip mbi_msi_irq_chip = {
    54		.name			= "MSI",
    55		.irq_mask		= irq_chip_mask_parent,
    56		.irq_unmask		= irq_chip_unmask_parent,
    57		.irq_eoi		= irq_chip_eoi_parent,
    58		.irq_set_type		= irq_chip_set_type_parent,
    59		.irq_compose_msi_msg	= mbi_compose_msi_msg,
  > 60		.irq_write_msi_msg	= pci_msi_domain_write_msg,
    61	};
    62	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 8591 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180418/f896013f/attachment.gz>
