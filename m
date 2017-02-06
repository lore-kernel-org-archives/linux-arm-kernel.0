From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 02:48:45 +0800
Subject: [hisi:topic-lpc-4.10-libio 139/148] drivers/of/address.c:330:3:
 error: implicit declaration of function 'address_to_pio'
Message-ID: <201702070243.4D7HItWA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/hisilicon/linux-hisi topic-lpc-4.10-libio
head:   06443d85dc35b64a704f7be84cc538281a1598f4
commit: b7bc5eec71294f8df5db8a1e0be4c4eb09c007cd [139/148] libio: relocate pci io functions
config: x86_64-randconfig-i0-201706 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        git checkout b7bc5eec71294f8df5db8a1e0be4c4eb09c007cd
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the hisi/topic-lpc-4.10-libio HEAD 06443d85dc35b64a704f7be84cc538281a1598f4 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/of/address.c: In function 'of_pci_range_to_resource':
   drivers/of/address.c:327:3: error: implicit declaration of function 'register_io_range' [-Werror=implicit-function-declaration]
      err = register_io_range(&np->fwnode, range->cpu_addr, range->size);
      ^
>> drivers/of/address.c:330:3: error: implicit declaration of function 'address_to_pio' [-Werror=implicit-function-declaration]
      port = address_to_pio(range->cpu_addr);
      ^
   drivers/of/address.c: In function '__of_translate_address':
>> drivers/of/address.c:610:3: error: implicit declaration of function 'find_io_range_from_fwnode' [-Werror=implicit-function-declaration]
      if (find_io_range_from_fwnode(&dev->fwnode)) {
      ^
   drivers/of/address.c: In function 'of_translate_ioport':
>> drivers/of/address.c:726:3: error: implicit declaration of function 'io_translate' [-Werror=implicit-function-declaration]
      port = io_translate(&host->fwnode, taddr);
      ^
   cc1: some warnings being treated as errors

vim +/address_to_pio +330 drivers/of/address.c

   321		res->flags = range->flags;
   322		res->parent = res->child = res->sibling = NULL;
   323		res->name = np->full_name;
   324	
   325		if (res->flags & IORESOURCE_IO) {
   326			unsigned long port;
 > 327			err = register_io_range(&np->fwnode, range->cpu_addr, range->size);
   328			if (err)
   329				goto invalid_range;
 > 330			port = address_to_pio(range->cpu_addr);
   331			if (port == (unsigned long)-1) {
   332				err = -EINVAL;
   333				goto invalid_range;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26858 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/9f82d2a9/attachment-0001.gz>
