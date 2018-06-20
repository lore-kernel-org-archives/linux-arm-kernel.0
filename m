From: lkp@intel.com (kbuild test robot)
Date: Wed, 20 Jun 2018 13:17:34 +0800
Subject: [PATCH V2 5/5] PCI: Unify slot and bus reset API
In-Reply-To: <1529467995-28780-5-git-send-email-okaya@codeaurora.org>
References: <1529467995-28780-5-git-send-email-okaya@codeaurora.org>
Message-ID: <201806201307.4hu51q9Q%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

I love your patch! Yet something to improve:

[auto build test ERROR on pci/next]
[also build test ERROR on v4.18-rc1 next-20180619]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sinan-Kaya/PCI-handle-error-return-from-pci_reset_bridge_secondary_bus/20180620-121648
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: x86_64-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/infiniband//hw/hfi1/pcie.c: In function 'trigger_sbr':
>> drivers/infiniband//hw/hfi1/pcie.c:908:23: error: passing argument 1 of 'pci_reset_bus' from incompatible pointer type [-Werror=incompatible-pointer-types]
     return pci_reset_bus(dev->bus);
                          ^~~
   In file included from drivers/infiniband//hw/hfi1/pcie.c:48:0:
   include/linux/pci.h:1099:5: note: expected 'struct pci_dev *' but argument is of type 'struct pci_bus *'
    int pci_reset_bus(struct pci_dev *dev);
        ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/pci_reset_bus +908 drivers/infiniband//hw/hfi1/pcie.c

77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  873  
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  874  /*
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  875   * Trigger a secondary bus reset (SBR) on ourselves using our parent.
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  876   *
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  877   * Based on pci_parent_bus_reset() which is not exported by the
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  878   * kernel core.
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  879   */
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  880  static int trigger_sbr(struct hfi1_devdata *dd)
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  881  {
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  882  	struct pci_dev *dev = dd->pcidev;
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  883  	struct pci_dev *pdev;
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  884  
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  885  	/* need a parent */
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  886  	if (!dev->bus->self) {
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  887  		dd_dev_err(dd, "%s: no parent device\n", __func__);
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  888  		return -ENOTTY;
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  889  	}
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  890  
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  891  	/* should not be anyone else on the bus */
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  892  	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  893  		if (pdev != dev) {
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  894  			dd_dev_err(dd,
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  895  				   "%s: another device is on the same bus\n",
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  896  				   __func__);
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  897  			return -ENOTTY;
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  898  		}
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  899  
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  900  	/*
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  901  	 * A secondary bus reset (SBR) issues a hot reset to our device.
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  902  	 * The following routine does a 1s wait after the reset is dropped
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  903  	 * per PCI Trhfa (recovery time).  PCIe 3.0 section 6.6.1 -
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  904  	 * Conventional Reset, paragraph 3, line 35 also says that a 1s
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  905  	 * delay after a reset is required.  Per spec requirements,
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  906  	 * the link is either working or not after that point.
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  907  	 */
f001109e drivers/infiniband/hw/hfi1/pcie.c Sinan Kaya       2018-06-20 @908  	return pci_reset_bus(dev->bus);
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  909  }
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  910  

:::::: The code at line 908 was first introduced by commit
:::::: f001109e94b74baebb3621ce1c7ba114a858adb3 IB/hfi1: use pci_reset_bus() for initiating pci secondary bus reset

:::::: TO: Sinan Kaya <okaya@codeaurora.org>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63999 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180620/6bf47b7a/attachment-0001.gz>
