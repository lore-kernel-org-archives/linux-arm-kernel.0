From: lkp@intel.com (kbuild test robot)
Date: Sat, 3 Jun 2017 06:00:22 +0800
Subject: [PATCH v2] mm: vmalloc: make vmalloc_to_page() deal with PMD/PUD
 mappings
In-Reply-To: <20170602155416.32706-1-ard.biesheuvel@linaro.org>
Message-ID: <201706030526.coRsJtv9%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

[auto build test ERROR on mmotm/master]
[also build test ERROR on v4.12-rc3 next-20170602]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/mm-vmalloc-make-vmalloc_to_page-deal-with-PMD-PUD-mappings/20170603-021745
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: frv-defconfig (attached as .config)
compiler: frv-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=frv 

All error/warnings (new ones prefixed by >>):

   In file included from arch/frv/include/asm/page.h:70:0,
                    from include/linux/vmalloc.h:8,
                    from mm/vmalloc.c:11:
   mm/vmalloc.c: In function 'vmalloc_to_page':
>> mm/vmalloc.c:295:19: error: incompatible types when initializing type 'long unsigned int' using type 'pud_t {aka struct <anonymous>}'
      return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
                      ^
   include/asm-generic/memory_model.h:32:41: note: in definition of macro '__pfn_to_page'
    #define __pfn_to_page(pfn) (mem_map + ((pfn) - ARCH_PFN_OFFSET))
                                            ^~~
>> arch/frv/include/asm/pgtable.h:367:36: note: in expansion of macro 'pmd_val'
    #define pmd_page(pmd) (pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
                                       ^~~~~~~
>> arch/frv/include/asm/pgtable.h:247:27: note: in expansion of macro 'pmd_page'
    #define pud_page(pud)    (pmd_page((pmd_t){ pud }))
                              ^~~~~~~~
   mm/vmalloc.c:295:10: note: in expansion of macro 'pud_page'
      return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
             ^~~~~~~~

vim +295 mm/vmalloc.c

   289			return NULL;
   290		pud = pud_offset(p4d, addr);
   291		if (pud_none(*pud))
   292			return NULL;
   293		if (pud_huge(*pud)) {
   294			VM_BUG_ON(!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP));
 > 295			return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
   296		}
   297		pmd = pmd_offset(pud, addr);
   298		if (pmd_none(*pmd))

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 8869 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170603/69cf0667/attachment.gz>
