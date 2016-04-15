From: lkp@intel.com (kbuild test robot)
Date: Sat, 16 Apr 2016 04:41:45 +0800
Subject: [PATCH V6 01/13] pci, acpi, x86, ia64: Move ACPI host bridge
 device companion assignment to core code.
In-Reply-To: <1460740008-19489-2-git-send-email-tn@semihalf.com>
Message-ID: <201604160430.P8zNe8Vl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

[auto build test ERROR on pci/next]
[also build test ERROR on v4.6-rc3 next-20160415]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Tomasz-Nowicki/Support-for-generic-ACPI-based-PCI-host-controller/20160416-011935
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: ia64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   drivers/pci/hotplug/sgi_hotplug.c: In function 'enable_slot':
>> drivers/pci/hotplug/sgi_hotplug.c:412:61: error: 'struct pci_controller' has no member named 'companion'
      phandle = acpi_device_handle(PCI_CONTROLLER(slot->pci_bus)->companion);
                                                                ^
   drivers/pci/hotplug/sgi_hotplug.c: In function 'disable_slot':
   drivers/pci/hotplug/sgi_hotplug.c:491:32: error: 'struct pci_controller' has no member named 'companion'
      PCI_CONTROLLER(slot->pci_bus)->companion) {
                                   ^
   drivers/pci/hotplug/sgi_hotplug.c:500:61: error: 'struct pci_controller' has no member named 'companion'
      phandle = acpi_device_handle(PCI_CONTROLLER(slot->pci_bus)->companion);
                                                                ^

vim +412 drivers/pci/hotplug/sgi_hotplug.c

3e643e77 John Keller       2007-01-30  406  		struct acpi_device *pdevice;
3e643e77 John Keller       2007-01-30  407  		acpi_handle phandle;
3e643e77 John Keller       2007-01-30  408  		acpi_handle chandle = NULL;
3e643e77 John Keller       2007-01-30  409  		acpi_handle rethandle;
3e643e77 John Keller       2007-01-30  410  		acpi_status ret;
3e643e77 John Keller       2007-01-30  411  
7b199811 Rafael J. Wysocki 2013-11-11 @412  		phandle = acpi_device_handle(PCI_CONTROLLER(slot->pci_bus)->companion);
3e643e77 John Keller       2007-01-30  413  
3e643e77 John Keller       2007-01-30  414  		if (acpi_bus_get_device(phandle, &pdevice)) {
227f0647 Ryan Desfosses    2014-04-18  415  			dev_dbg(&slot->pci_bus->self->dev, "no parent device, assuming NULL\n");

:::::: The code at line 412 was first introduced by commit
:::::: 7b1998116bbb2f3e5dd6cb9a8ee6db479b0b50a9 ACPI / driver core: Store an ACPI device pointer in struct acpi_dev_node

:::::: TO: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 43194 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160416/624e773d/attachment-0001.obj>
