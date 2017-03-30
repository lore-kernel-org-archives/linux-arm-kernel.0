From: lkp@intel.com (kbuild test robot)
Date: Thu, 30 Mar 2017 20:09:32 +0800
Subject: [PATCH v3 2/2] PCI: Add tango PCIe host bridge support
In-Reply-To: <65114e62-7458-b6f7-327c-f07a5096a452@sigmadesigns.com>
Message-ID: <201703302009.BkYunZzb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

[auto build test ERROR on v4.9-rc8]
[also build test ERROR on next-20170330]
[cannot apply to pci/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Marc-Gonzalez/Tango-PCIe-controller-support/20170330-154028
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/pci/host/pcie-tango.c:4:0:
>> include/linux/pci-ecam.h:29:19: error: field 'pci_ops' has incomplete type
     struct pci_ops   pci_ops;
                      ^~~~~~~
>> include/linux/pci-ecam.h:57:39: warning: 'struct pci_bus' declared inside parameter list will not be visible outside of this definition or declaration
    void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
                                          ^~~~~~~
>> drivers/pci/host/pcie-tango.c:198:39: warning: 'struct pci_bus' declared inside parameter list will not be visible outside of this definition or declaration
    static int smp8759_config_read(struct pci_bus *bus,
                                          ^~~~~~~
   drivers/pci/host/pcie-tango.c: In function 'smp8759_config_read':
>> drivers/pci/host/pcie-tango.c:202:37: error: dereferencing pointer to incomplete type 'struct pci_bus'
     struct pci_config_window *cfg = bus->sysdata;
                                        ^~
>> drivers/pci/host/pcie-tango.c:211:10: error: 'PCIBIOS_FUNC_NOT_SUPPORTED' undeclared (first use in this function)
      return PCIBIOS_FUNC_NOT_SUPPORTED; /* Error seems appropriate */
             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/host/pcie-tango.c:211:10: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/pci/host/pcie-tango.c:219:15: error: 'PCI_BASE_ADDRESS_0' undeclared (first use in this function)
     if (where == PCI_BASE_ADDRESS_0 && bus->number == 0) {
                  ^~~~~~~~~~~~~~~~~~
>> drivers/pci/host/pcie-tango.c:221:10: error: 'PCIBIOS_SUCCESSFUL' undeclared (first use in this function)
      return PCIBIOS_SUCCESSFUL; /* Should we return error or success? */
             ^~~~~~~~~~~~~~~~~~
>> drivers/pci/host/pcie-tango.c:233:8: error: implicit declaration of function 'pci_generic_config_read' [-Werror=implicit-function-declaration]
     ret = pci_generic_config_read(bus, devfn, where, size, val);
           ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/host/pcie-tango.c: At top level:
   drivers/pci/host/pcie-tango.c:239:40: warning: 'struct pci_bus' declared inside parameter list will not be visible outside of this definition or declaration
    static int smp8759_config_write(struct pci_bus *bus,
                                           ^~~~~~~
   drivers/pci/host/pcie-tango.c: In function 'smp8759_config_write':
   drivers/pci/host/pcie-tango.c:243:37: error: dereferencing pointer to incomplete type 'struct pci_bus'
     struct pci_config_window *cfg = bus->sysdata;
                                        ^~
>> drivers/pci/host/pcie-tango.c:247:8: error: implicit declaration of function 'pci_generic_config_write' [-Werror=implicit-function-declaration]
     ret = pci_generic_config_write(bus, devfn, where, size, val);
           ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/host/pcie-tango.c: At top level:
>> drivers/pci/host/pcie-tango.c:256:3: error: field name not in record or union initializer
      .map_bus = pci_ecam_map_bus,
      ^
   drivers/pci/host/pcie-tango.c:256:3: note: (near initialization for 'smp8759_ecam_ops.pci_ops')
   drivers/pci/host/pcie-tango.c:257:3: error: field name not in record or union initializer
      .read  = smp8759_config_read,
      ^
   drivers/pci/host/pcie-tango.c:257:3: note: (near initialization for 'smp8759_ecam_ops.pci_ops')
   drivers/pci/host/pcie-tango.c:258:3: error: field name not in record or union initializer
      .write  = smp8759_config_write,
      ^
   drivers/pci/host/pcie-tango.c:258:3: note: (near initialization for 'smp8759_ecam_ops.pci_ops')
   drivers/pci/host/pcie-tango.c: In function 'tango_fixup_class':
>> drivers/pci/host/pcie-tango.c:329:5: error: dereferencing pointer to incomplete type 'struct pci_dev'
     dev->class = PCI_CLASS_BRIDGE_PCI << 8;
        ^~
>> drivers/pci/host/pcie-tango.c:329:15: error: 'PCI_CLASS_BRIDGE_PCI' undeclared (first use in this function)
     dev->class = PCI_CLASS_BRIDGE_PCI << 8;
                  ^~~~~~~~~~~~~~~~~~~~
   drivers/pci/host/pcie-tango.c: At top level:
>> drivers/pci/host/pcie-tango.c:320:22: error: expected declaration specifiers or '...' before numeric constant
    #define VENDOR_SIGMA 0x1105
                         ^
>> drivers/pci/host/pcie-tango.c:331:25: note: in expansion of macro 'VENDOR_SIGMA'
    DECLARE_PCI_FIXUP_EARLY(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_class);
                            ^~~~~~~~~~~~
   In file included from include/linux/of.h:22:0,
                    from include/linux/irqdomain.h:34,
                    from drivers/pci/host/pcie-tango.c:3:
>> include/linux/mod_devicetable.h:16:20: error: expected declaration specifiers or '...' before '(' token
    #define PCI_ANY_ID (~0)
                       ^
>> drivers/pci/host/pcie-tango.c:331:39: note: in expansion of macro 'PCI_ANY_ID'
    DECLARE_PCI_FIXUP_EARLY(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_class);
                                          ^~~~~~~~~~
>> drivers/pci/host/pcie-tango.c:331:51: error: expected declaration specifiers or '...' before 'tango_fixup_class'
    DECLARE_PCI_FIXUP_EARLY(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_class);
                                                      ^~~~~~~~~~~~~~~~~
   drivers/pci/host/pcie-tango.c: In function 'tango_fixup_bar':
>> drivers/pci/host/pcie-tango.c:342:9: error: implicit declaration of function 'pci_write_config_dword' [-Werror=implicit-function-declaration]
            pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0x80000000);
            ^~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/host/pcie-tango.c:342:37: error: 'PCI_BASE_ADDRESS_0' undeclared (first use in this function)
            pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0x80000000);
                                        ^~~~~~~~~~~~~~~~~~
   drivers/pci/host/pcie-tango.c: At top level:
>> drivers/pci/host/pcie-tango.c:320:22: error: expected declaration specifiers or '...' before numeric constant
    #define VENDOR_SIGMA 0x1105
                         ^
   drivers/pci/host/pcie-tango.c:344:25: note: in expansion of macro 'VENDOR_SIGMA'
    DECLARE_PCI_FIXUP_FINAL(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_bar);
                            ^~~~~~~~~~~~
   In file included from include/linux/of.h:22:0,
                    from include/linux/irqdomain.h:34,
                    from drivers/pci/host/pcie-tango.c:3:
>> include/linux/mod_devicetable.h:16:20: error: expected declaration specifiers or '...' before '(' token
    #define PCI_ANY_ID (~0)
                       ^
   drivers/pci/host/pcie-tango.c:344:39: note: in expansion of macro 'PCI_ANY_ID'
    DECLARE_PCI_FIXUP_FINAL(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_bar);
                                          ^~~~~~~~~~
--
   In file included from drivers/pci//host/pcie-tango.c:4:0:
>> include/linux/pci-ecam.h:29:19: error: field 'pci_ops' has incomplete type
     struct pci_ops   pci_ops;
                      ^~~~~~~
>> include/linux/pci-ecam.h:57:39: warning: 'struct pci_bus' declared inside parameter list will not be visible outside of this definition or declaration
    void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
                                          ^~~~~~~
   drivers/pci//host/pcie-tango.c:198:39: warning: 'struct pci_bus' declared inside parameter list will not be visible outside of this definition or declaration
    static int smp8759_config_read(struct pci_bus *bus,
                                          ^~~~~~~
   drivers/pci//host/pcie-tango.c: In function 'smp8759_config_read':
   drivers/pci//host/pcie-tango.c:202:37: error: dereferencing pointer to incomplete type 'struct pci_bus'
     struct pci_config_window *cfg = bus->sysdata;
                                        ^~
   drivers/pci//host/pcie-tango.c:211:10: error: 'PCIBIOS_FUNC_NOT_SUPPORTED' undeclared (first use in this function)
      return PCIBIOS_FUNC_NOT_SUPPORTED; /* Error seems appropriate */
             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci//host/pcie-tango.c:211:10: note: each undeclared identifier is reported only once for each function it appears in
   drivers/pci//host/pcie-tango.c:219:15: error: 'PCI_BASE_ADDRESS_0' undeclared (first use in this function)
     if (where == PCI_BASE_ADDRESS_0 && bus->number == 0) {
                  ^~~~~~~~~~~~~~~~~~
   drivers/pci//host/pcie-tango.c:221:10: error: 'PCIBIOS_SUCCESSFUL' undeclared (first use in this function)
      return PCIBIOS_SUCCESSFUL; /* Should we return error or success? */
             ^~~~~~~~~~~~~~~~~~
   drivers/pci//host/pcie-tango.c:233:8: error: implicit declaration of function 'pci_generic_config_read' [-Werror=implicit-function-declaration]
     ret = pci_generic_config_read(bus, devfn, where, size, val);
           ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci//host/pcie-tango.c: At top level:
   drivers/pci//host/pcie-tango.c:239:40: warning: 'struct pci_bus' declared inside parameter list will not be visible outside of this definition or declaration
    static int smp8759_config_write(struct pci_bus *bus,
                                           ^~~~~~~
   drivers/pci//host/pcie-tango.c: In function 'smp8759_config_write':
   drivers/pci//host/pcie-tango.c:243:37: error: dereferencing pointer to incomplete type 'struct pci_bus'
     struct pci_config_window *cfg = bus->sysdata;
                                        ^~
   drivers/pci//host/pcie-tango.c:247:8: error: implicit declaration of function 'pci_generic_config_write' [-Werror=implicit-function-declaration]
     ret = pci_generic_config_write(bus, devfn, where, size, val);
           ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci//host/pcie-tango.c: At top level:
   drivers/pci//host/pcie-tango.c:256:3: error: field name not in record or union initializer
      .map_bus = pci_ecam_map_bus,
      ^
   drivers/pci//host/pcie-tango.c:256:3: note: (near initialization for 'smp8759_ecam_ops.pci_ops')
   drivers/pci//host/pcie-tango.c:257:3: error: field name not in record or union initializer
      .read  = smp8759_config_read,
      ^
   drivers/pci//host/pcie-tango.c:257:3: note: (near initialization for 'smp8759_ecam_ops.pci_ops')
   drivers/pci//host/pcie-tango.c:258:3: error: field name not in record or union initializer
      .write  = smp8759_config_write,
      ^
   drivers/pci//host/pcie-tango.c:258:3: note: (near initialization for 'smp8759_ecam_ops.pci_ops')
   drivers/pci//host/pcie-tango.c: In function 'tango_fixup_class':
   drivers/pci//host/pcie-tango.c:329:5: error: dereferencing pointer to incomplete type 'struct pci_dev'
     dev->class = PCI_CLASS_BRIDGE_PCI << 8;
        ^~
   drivers/pci//host/pcie-tango.c:329:15: error: 'PCI_CLASS_BRIDGE_PCI' undeclared (first use in this function)
     dev->class = PCI_CLASS_BRIDGE_PCI << 8;
                  ^~~~~~~~~~~~~~~~~~~~
   drivers/pci//host/pcie-tango.c: At top level:
   drivers/pci//host/pcie-tango.c:320:22: error: expected declaration specifiers or '...' before numeric constant
    #define VENDOR_SIGMA 0x1105
                         ^
   drivers/pci//host/pcie-tango.c:331:25: note: in expansion of macro 'VENDOR_SIGMA'
    DECLARE_PCI_FIXUP_EARLY(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_class);
                            ^~~~~~~~~~~~
   In file included from include/linux/of.h:22:0,
                    from include/linux/irqdomain.h:34,
                    from drivers/pci//host/pcie-tango.c:3:
>> include/linux/mod_devicetable.h:16:20: error: expected declaration specifiers or '...' before '(' token
    #define PCI_ANY_ID (~0)
                       ^
   drivers/pci//host/pcie-tango.c:331:39: note: in expansion of macro 'PCI_ANY_ID'
    DECLARE_PCI_FIXUP_EARLY(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_class);
                                          ^~~~~~~~~~
   drivers/pci//host/pcie-tango.c:331:51: error: expected declaration specifiers or '...' before 'tango_fixup_class'
    DECLARE_PCI_FIXUP_EARLY(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_class);
                                                      ^~~~~~~~~~~~~~~~~
   drivers/pci//host/pcie-tango.c: In function 'tango_fixup_bar':
   drivers/pci//host/pcie-tango.c:342:9: error: implicit declaration of function 'pci_write_config_dword' [-Werror=implicit-function-declaration]
            pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0x80000000);
            ^~~~~~~~~~~~~~~~~~~~~~
   drivers/pci//host/pcie-tango.c:342:37: error: 'PCI_BASE_ADDRESS_0' undeclared (first use in this function)
            pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0x80000000);
                                        ^~~~~~~~~~~~~~~~~~
   drivers/pci//host/pcie-tango.c: At top level:
   drivers/pci//host/pcie-tango.c:320:22: error: expected declaration specifiers or '...' before numeric constant
    #define VENDOR_SIGMA 0x1105
                         ^
   drivers/pci//host/pcie-tango.c:344:25: note: in expansion of macro 'VENDOR_SIGMA'
    DECLARE_PCI_FIXUP_FINAL(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_bar);
                            ^~~~~~~~~~~~
   In file included from include/linux/of.h:22:0,
                    from include/linux/irqdomain.h:34,
                    from drivers/pci//host/pcie-tango.c:3:
>> include/linux/mod_devicetable.h:16:20: error: expected declaration specifiers or '...' before '(' token
    #define PCI_ANY_ID (~0)
                       ^
   drivers/pci//host/pcie-tango.c:344:39: note: in expansion of macro 'PCI_ANY_ID'
    DECLARE_PCI_FIXUP_FINAL(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_bar);
                                          ^~~~~~~~~~
   drivers/pci//host/pcie-tango.c:344:51: error: expected declaration specifiers or '...' before 'tango_fixup_bar'
    DECLARE_PCI_FIXUP_FINAL(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_bar);
                                                      ^~~~~~~~~~~~~~~
   drivers/pci//host/pcie-tango.c:340:13: warning: 'tango_fixup_bar' defined but not used [-Wunused-function]
    static void tango_fixup_bar(struct pci_dev *dev)
                ^~~~~~~~~~~~~~~
   drivers/pci//host/pcie-tango.c:327:13: warning: 'tango_fixup_class' defined but not used [-Wunused-function]
    static void tango_fixup_class(struct pci_dev *dev)
                ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/pci_ops +29 include/linux/pci-ecam.h

35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  23   * struct to hold pci ops and bus shift of the config window
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  24   * for a PCI controller.
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  25   */
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  26  struct pci_config_window;
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  27  struct pci_ecam_ops {
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  28  	unsigned int			bus_shift;
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10 @29  	struct pci_ops			pci_ops;
5c3d14f7 include/linux/pci-ecam.h Jayachandran C 2016-06-10  30  	int				(*init)(struct pci_config_window *);
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  31  };
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  32  
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  33  /*
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  34   * struct to hold the mappings of a config space window. This
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  35   * is expected to be used as sysdata for PCI controllers that
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  36   * use ECAM.
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  37   */
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  38  struct pci_config_window {
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  39  	struct resource			res;
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  40  	struct resource			busr;
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  41  	void				*priv;
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  42  	struct pci_ecam_ops		*ops;
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  43  	union {
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  44  		void __iomem		*win;	/* 64-bit single mapping */
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  45  		void __iomem		**winp; /* 32-bit per-bus mapping */
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  46  	};
5c3d14f7 include/linux/pci-ecam.h Jayachandran C 2016-06-10  47  	struct device			*parent;/* ECAM res was from this dev */
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  48  };
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  49  
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  50  /* create and free pci_config_window */
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  51  struct pci_config_window *pci_ecam_create(struct device *dev,
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  52  		struct resource *cfgres, struct resource *busr,
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  53  		struct pci_ecam_ops *ops);
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  54  void pci_ecam_free(struct pci_config_window *cfg);
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  55  
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  56  /* map_bus when ->sysdata is an instance of pci_config_window */
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10 @57  void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  58  			       int where);
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  59  /* default ECAM ops */
35ff9477 drivers/pci/ecam.h       Jayachandran C 2016-05-10  60  extern struct pci_ecam_ops pci_generic_ecam_ops;

:::::: The code at line 29 was first introduced by commit
:::::: 35ff9477d880986441981010585399c1d7201fee PCI: Provide common functions for ECAM mapping

:::::: TO: Jayachandran C <jchandra@broadcom.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59492 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170330/adbb5d8f/attachment-0001.gz>
