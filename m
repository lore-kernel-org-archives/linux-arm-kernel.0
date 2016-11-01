From: lkp@intel.com (kbuild test robot)
Date: Tue, 1 Nov 2016 23:04:28 +0800
Subject: [PATCH/RESEND V4 2/3] ARM64 LPC: Add missing range exception for
 special ISA
In-Reply-To: <1478006926-240933-3-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <201611012314.dvKdVJNf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi zhichang.yuan,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.9-rc3 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/zhichang-yuan/ARM64-LPC-legacy-ISA-I-O-support/20161101-211425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: openrisc-or1ksim_defconfig (attached as .config)
compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All errors (new ones prefixed by >>):

   drivers/of/address.c: In function '__of_address_to_resource':
>> drivers/of/address.c:733:40: error: 'PCIBIOS_MIN_IO' undeclared (first use in this function)
   drivers/of/address.c:733:40: note: each undeclared identifier is reported only once for each function it appears in

vim +/PCIBIOS_MIN_IO +733 drivers/of/address.c

   727		if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
   728			return -EINVAL;
   729		taddr = of_translate_address(dev, addrp);
   730		if (taddr == OF_BAD_ADDR)
   731			return -EINVAL;
   732		memset(r, 0, sizeof(struct resource));
 > 733		if (flags & IORESOURCE_IO && taddr >= PCIBIOS_MIN_IO) {
   734			unsigned long port;
   735	
   736			port = pci_address_to_pio(taddr);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 7206 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161101/dc5720b1/attachment-0001.gz>
