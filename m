From: lkp@intel.com (kbuild test robot)
Date: Sat, 3 Jun 2017 06:31:53 +0800
Subject: [PATCH v2] mm: vmalloc: make vmalloc_to_page() deal with PMD/PUD
 mappings
In-Reply-To: <20170602155416.32706-1-ard.biesheuvel@linaro.org>
Message-ID: <201706030608.koMVDa7j%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

[auto build test ERROR on mmotm/master]
[also build test ERROR on v4.12-rc3 next-20170602]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/mm-vmalloc-make-vmalloc_to_page-deal-with-PMD-PUD-mappings/20170603-021745
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: parisc-allmodconfig (attached as .config)
compiler: hppa-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=parisc 

All error/warnings (new ones prefixed by >>):

   In file included from arch/parisc/include/asm/pgtable.h:4:0,
                    from include/linux/mm.h:70,
                    from mm/vmalloc.c:12:
   mm/vmalloc.c: In function 'vmalloc_to_page':
>> include/asm-generic/4level-fixup.h:26:25: error: implicit declaration of function 'pgd_page' [-Werror=implicit-function-declaration]
    #define pud_page(pud)   pgd_page(pud)
                            ^
>> mm/vmalloc.c:295:10: note: in expansion of macro 'pud_page'
      return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
             ^~~~~~~~
>> mm/vmalloc.c:295:25: warning: return makes pointer from integer without a cast [-Wint-conversion]
      return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
                             
   cc1: some warnings being treated as errors

vim +/pud_page +295 mm/vmalloc.c

   279		/*
   280		 * XXX we might need to change this if we add VIRTUAL_BUG_ON for
   281		 * architectures that do not vmalloc module space
   282		 */
   283		VIRTUAL_BUG_ON(!is_vmalloc_or_module_addr(vmalloc_addr));
   284	
   285		if (pgd_none(*pgd))
   286			return NULL;
   287		p4d = p4d_offset(pgd, addr);
   288		if (p4d_none(*p4d))
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
   299			return NULL;
   300		if (pmd_huge(*pmd)) {
   301			VM_BUG_ON(!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP));
   302			return pmd_page(*pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
   303		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 50008 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170603/92e31e12/attachment-0001.gz>
