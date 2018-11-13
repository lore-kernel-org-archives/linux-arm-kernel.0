From: lkp@intel.com (kbuild test robot)
Date: Wed, 14 Nov 2018 06:42:24 +0800
Subject: [arm-platforms:pci/dwc-mask 3/3]
 drivers/pci/controller/dwc/pcie-designware-host.c:200:53: error: 'data'
 undeclared; did you mean '_data'?
Message-ID: <201811140621.TXEiYKQ6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git pci/dwc-mask
head:   921b42033f8ed0ee5aed9d77ebe29c9efc70df0e
commit: 921b42033f8ed0ee5aed9d77ebe29c9efc70df0e [3/3] PCI: designware: Move interrupt acking into the proper callback
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 921b42033f8ed0ee5aed9d77ebe29c9efc70df0e
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware-host.c: In function 'dw_pci_bottom_ack':
>> drivers/pci/controller/dwc/pcie-designware-host.c:200:53: error: 'data' undeclared (first use in this function); did you mean '_data'?
     struct pcie_port *pp  = irq_data_get_irq_chip_data(data);
                                                        ^~~~
                                                        _data
   drivers/pci/controller/dwc/pcie-designware-host.c:200:53: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/spinlock.h:50:0,
                    from include/linux/irq.h:14,
                    from include/linux/irqchip/chained_irq.h:21,
                    from drivers/pci/controller/dwc/pcie-designware-host.c:11:
   drivers/pci/controller/dwc/pcie-designware-host.c:207:35: error: 'flags' undeclared (first use in this function); did you mean 'class'?
     raw_spin_lock_irqsave(&pp->lock, flags);
                                      ^
   include/linux/typecheck.h:11:9: note: in definition of macro 'typecheck'
     typeof(x) __dummy2; \
            ^
   drivers/pci/controller/dwc/pcie-designware-host.c:207:2: note: in expansion of macro 'raw_spin_lock_irqsave'
     raw_spin_lock_irqsave(&pp->lock, flags);
     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/spinlock.h:240:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags); \
      ^~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware-host.c:207:2: note: in expansion of macro 'raw_spin_lock_irqsave'
     raw_spin_lock_irqsave(&pp->lock, flags);
     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/spinlock.h:278:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags);  \
      ^~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware-host.c:214:2: note: in expansion of macro 'raw_spin_unlock_irqrestore'
     raw_spin_unlock_irqrestore(&pp->lock, flags);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~

vim +200 drivers/pci/controller/dwc/pcie-designware-host.c

   197	
   198	static void dw_pci_bottom_ack(struct irq_data *d)
   199	{
 > 200		struct pcie_port *pp  = irq_data_get_irq_chip_data(data);
   201		unsigned int res, bit, ctrl;
   202	
   203		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
   204		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
   205		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
   206	
   207		raw_spin_lock_irqsave(&pp->lock, flags);
   208	
   209		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
   210	
   211		if (pp->ops->msi_irq_ack)
   212			pp->ops->msi_irq_ack(d->hwirq, pp);
   213	
   214		raw_spin_unlock_irqrestore(&pp->lock, flags);
   215	}
   216	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 66605 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181114/d27dc003/attachment-0001.gz>
