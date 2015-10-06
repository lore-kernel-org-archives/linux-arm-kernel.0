From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 6 Oct 2015 23:26:06 +0800
Subject: [arm-platforms:irq/gsi-irq-domain-v5 16/16]
 drivers/pci/msi.c:1323:38: warning: passing argument 1 of
 'pci_msi_create_irq_domain' from incompatible pointer type
Message-ID: <201510062305.0lgLckvO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/gsi-irq-domain-v5
head:   77d2d8815f4d2d622f69dd383deb60f62ca0de15
commit: 77d2d8815f4d2d622f69dd383deb60f62ca0de15 [16/16] irqdomain/msi: Use fwnode instead of of_node
config: i386-randconfig-x004-201540 (attached as .config)
reproduce:
        git checkout 77d2d8815f4d2d622f69dd383deb60f62ca0de15
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/pci/msi.c: In function 'pci_msi_create_default_irq_domain':
>> drivers/pci/msi.c:1323:38: warning: passing argument 1 of 'pci_msi_create_irq_domain' from incompatible pointer type [-Wincompatible-pointer-types]
      domain = pci_msi_create_irq_domain(node, info, parent);
                                         ^
   drivers/pci/msi.c:1259:20: note: expected 'struct fwnode_handle *' but argument is of type 'struct device_node *'
    struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
                       ^

vim +/pci_msi_create_irq_domain +1323 drivers/pci/msi.c

8e047ada Jiang Liu 2014-11-15  1307   * @info:	MSI domain info
8e047ada Jiang Liu 2014-11-15  1308   * @parent:	Parent irq domain
8e047ada Jiang Liu 2014-11-15  1309   *
8e047ada Jiang Liu 2014-11-15  1310   * Returns: A domain pointer or NULL in case of failure. If successful
8e047ada Jiang Liu 2014-11-15  1311   * the default PCI/MSI irqdomain pointer is updated.
8e047ada Jiang Liu 2014-11-15  1312   */
8e047ada Jiang Liu 2014-11-15  1313  struct irq_domain *pci_msi_create_default_irq_domain(struct device_node *node,
8e047ada Jiang Liu 2014-11-15  1314  		struct msi_domain_info *info, struct irq_domain *parent)
8e047ada Jiang Liu 2014-11-15  1315  {
8e047ada Jiang Liu 2014-11-15  1316  	struct irq_domain *domain;
8e047ada Jiang Liu 2014-11-15  1317  
8e047ada Jiang Liu 2014-11-15  1318  	mutex_lock(&pci_msi_domain_lock);
8e047ada Jiang Liu 2014-11-15  1319  	if (pci_msi_default_domain) {
8e047ada Jiang Liu 2014-11-15  1320  		pr_err("PCI: default irq domain for PCI MSI has already been created.\n");
8e047ada Jiang Liu 2014-11-15  1321  		domain = NULL;
8e047ada Jiang Liu 2014-11-15  1322  	} else {
8e047ada Jiang Liu 2014-11-15 @1323  		domain = pci_msi_create_irq_domain(node, info, parent);
8e047ada Jiang Liu 2014-11-15  1324  		pci_msi_default_domain = domain;
8e047ada Jiang Liu 2014-11-15  1325  	}
8e047ada Jiang Liu 2014-11-15  1326  	mutex_unlock(&pci_msi_domain_lock);
8e047ada Jiang Liu 2014-11-15  1327  
8e047ada Jiang Liu 2014-11-15  1328  	return domain;
8e047ada Jiang Liu 2014-11-15  1329  }
3878eaef Jiang Liu 2014-11-11  1330  #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */

:::::: The code at line 1323 was first introduced by commit
:::::: 8e047adae969701c6cec136484bb9de8572af934 PCI/MSI: Provide mechanism to alloc/free MSI/MSIX interrupt from irqdomain

:::::: TO: Jiang Liu <jiang.liu@linux.intel.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 20374 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/0cc8da78/attachment-0001.obj>
