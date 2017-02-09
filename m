From: lkp@intel.com (kbuild test robot)
Date: Thu, 9 Feb 2017 16:37:05 +0800
Subject: [PATCH] arm64: use is_vmalloc_addr
In-Reply-To: <1486606807-32097-1-git-send-email-miles.chen@mediatek.com>
Message-ID: <201702091600.7Yg9Yj0D%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miles,

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on v4.10-rc7 next-20170208]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Miles-Chen/arm64-use-is_vmalloc_addr/20170209-103100
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   arch/arm64/mm/ioremap.c: In function '__iounmap':
>> arch/arm64/mm/ioremap.c:91:22: warning: passing argument 1 of 'is_vmalloc_addr' makes pointer from integer without a cast [-Wint-conversion]
     if (is_vmalloc_addr(addr))
                         ^~~~
   In file included from arch/arm64/mm/ioremap.c:24:0:
   include/linux/mm.h:472:20: note: expected 'const void *' but argument is of type 'long unsigned int'
    static inline bool is_vmalloc_addr(const void *x)
                       ^~~~~~~~~~~~~~~

vim +/is_vmalloc_addr +91 arch/arm64/mm/ioremap.c

    75	
    76	void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot)
    77	{
    78		return __ioremap_caller(phys_addr, size, prot,
    79					__builtin_return_address(0));
    80	}
    81	EXPORT_SYMBOL(__ioremap);
    82	
    83	void __iounmap(volatile void __iomem *io_addr)
    84	{
    85		unsigned long addr = (unsigned long)io_addr & PAGE_MASK;
    86	
    87		/*
    88		 * We could get an address outside vmalloc range in case
    89		 * of ioremap_cache() reusing a RAM mapping.
    90		 */
  > 91		if (is_vmalloc_addr(addr))
    92			vunmap((void *)addr);
    93	}
    94	EXPORT_SYMBOL(__iounmap);
    95	
    96	void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
    97	{
    98		/* For normal memory we already have a cacheable mapping. */
    99		if (pfn_valid(__phys_to_pfn(phys_addr)))

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33971 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170209/d29382e6/attachment-0001.gz>
