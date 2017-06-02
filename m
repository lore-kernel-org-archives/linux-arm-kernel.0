From: lkp@intel.com (kbuild test robot)
Date: Sat, 3 Jun 2017 00:34:05 +0800
Subject: [PATCH] mm: vmalloc: make vmalloc_to_page() deal with PMD/PUD
 mappings
In-Reply-To: <20170602112720.28948-1-ard.biesheuvel@linaro.org>
Message-ID: <201706030004.lHWpPody%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

[auto build test ERROR on mmotm/master]
[also build test ERROR on v4.12-rc3 next-20170602]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/mm-vmalloc-make-vmalloc_to_page-deal-with-PMD-PUD-mappings/20170602-210236
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: sh-sh7785lcr_32bit_defconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All error/warnings (new ones prefixed by >>):

   mm/vmalloc.c: In function 'vmalloc_to_pud_page':
>> mm/vmalloc.c:277:10: error: implicit declaration of function 'pud_page' [-Werror=implicit-function-declaration]
      page = pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
             ^~~~~~~~
>> mm/vmalloc.c:277:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      page = pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
           ^
   cc1: some warnings being treated as errors

vim +/pud_page +277 mm/vmalloc.c

   271	{
   272		struct page *page = NULL;
   273	#ifdef CONFIG_HUGETLB_PAGE
   274		pte_t pte = huge_ptep_get((pte_t *)pud);
   275	
   276		if (pte_present(pte))
 > 277			page = pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
   278	#else
   279		VIRTUAL_BUG_ON(1);
   280	#endif

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 16941 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170603/c4e81de6/attachment-0001.gz>
