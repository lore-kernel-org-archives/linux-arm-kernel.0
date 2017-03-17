From: lkp@intel.com (kbuild test robot)
Date: Fri, 17 Mar 2017 17:17:15 +0800
Subject: [PATCH] of: Mark property::value as const
In-Reply-To: <148951941955.30407.4217812594792852642@sboyd-linaro>
Message-ID: <201703171613.IWm6RSo1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc2 next-20170310]
[cannot apply to glikely/devicetree/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/of-Mark-property-value-as-const/20170317-143414
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/pci_32.c: In function 'pcibios_make_OF_bus_map':
>> arch/powerpc/kernel/pci_32.c:141:10: error: passing argument 1 of 'memcpy' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
      memcpy(map_prop->value, pci_to_OF_bus_map, pci_bus_count);
             ^~~~~~~~
   In file included from include/linux/string.h:18:0,
                    from include/uapi/linux/uuid.h:21,
                    from include/linux/uuid.h:19,
                    from include/linux/mod_devicetable.h:12,
                    from include/linux/pci.h:20,
                    from arch/powerpc/kernel/pci_32.c:6:
   arch/powerpc/include/asm/string.h:21:15: note: expected 'void *' but argument is of type 'const void *'
    extern void * memcpy(void *,const void *,__kernel_size_t);
                  ^~~~~~
   cc1: all warnings being treated as errors

vim +141 arch/powerpc/kernel/pci_32.c

e05b3b4a Paul Mackerras   2006-01-15  125  	 */
e05b3b4a Paul Mackerras   2006-01-15  126  	for (i=0; i<pci_bus_count; i++)
e05b3b4a Paul Mackerras   2006-01-15  127  		pci_to_OF_bus_map[i] = 0xff;
e05b3b4a Paul Mackerras   2006-01-15  128  
e05b3b4a Paul Mackerras   2006-01-15  129  	/* For each hose, we begin searching bridges */
a4c9e328 Kumar Gala       2007-06-27  130  	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
44ef3390 Stephen Rothwell 2007-12-10  131  		struct device_node* node = hose->dn;
44ef3390 Stephen Rothwell 2007-12-10  132  
e05b3b4a Paul Mackerras   2006-01-15  133  		if (!node)
e05b3b4a Paul Mackerras   2006-01-15  134  			continue;
e05b3b4a Paul Mackerras   2006-01-15  135  		make_one_node_map(node, hose->first_busno);
e05b3b4a Paul Mackerras   2006-01-15  136  	}
8c8dc322 Stephen Rothwell 2007-04-24  137  	dn = of_find_node_by_path("/");
8c8dc322 Stephen Rothwell 2007-04-24  138  	map_prop = of_find_property(dn, "pci-OF-bus-map", NULL);
a7f67bdf Jeremy Kerr      2006-07-12  139  	if (map_prop) {
a7f67bdf Jeremy Kerr      2006-07-12  140  		BUG_ON(pci_bus_count > map_prop->length);
a7f67bdf Jeremy Kerr      2006-07-12 @141  		memcpy(map_prop->value, pci_to_OF_bus_map, pci_bus_count);
a7f67bdf Jeremy Kerr      2006-07-12  142  	}
8c8dc322 Stephen Rothwell 2007-04-24  143  	of_node_put(dn);
e05b3b4a Paul Mackerras   2006-01-15  144  #ifdef DEBUG
e05b3b4a Paul Mackerras   2006-01-15  145  	printk("PCI->OF bus map:\n");
e05b3b4a Paul Mackerras   2006-01-15  146  	for (i=0; i<pci_bus_count; i++) {
e05b3b4a Paul Mackerras   2006-01-15  147  		if (pci_to_OF_bus_map[i] == 0xff)
e05b3b4a Paul Mackerras   2006-01-15  148  			continue;
e05b3b4a Paul Mackerras   2006-01-15  149  		printk("%d -> %d\n", i, pci_to_OF_bus_map[i]);

:::::: The code at line 141 was first introduced by commit
:::::: a7f67bdf2c9f24509b8e81e0f35573b611987c80 [POWERPC] Constify & voidify get_property()

:::::: TO: Jeremy Kerr <jk@ozlabs.org>
:::::: CC: Paul Mackerras <paulus@samba.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6114 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170317/1359e19c/attachment.gz>
