From: lkp@intel.com (kbuild test robot)
Date: Sun, 11 Dec 2016 21:31:56 +0800
Subject: [PATCH 3/3] mm: make pagoff_t type 64-bit
In-Reply-To: <1481461003-14361-4-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <201612112116.8GzvAvNR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.9-rc8]
[cannot apply to mmotm/master next-20161209]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yury-Norov/mm-move-argument-checkers-of-mmap_pgoff-to-separated-routine/20161211-211314
config: i386-tinyconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   arch/x86/mm/pgtable.c: In function 'pgd_set_mm':
>> arch/x86/mm/pgtable.c:108:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     virt_to_page(pgd)->index = (pgoff_t)mm;
                                ^
   arch/x86/mm/pgtable.c: In function 'pgd_page_get_mm':
>> arch/x86/mm/pgtable.c:113:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     return (struct mm_struct *)page->index;
            ^
--
   mm/percpu.c: In function 'pcpu_get_page_chunk':
>> mm/percpu.c:240:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     return (struct pcpu_chunk *)page->index;
            ^

vim +108 arch/x86/mm/pgtable.c

68db065c Jeremy Fitzhardinge 2008-03-17  102  	(SHARED_KERNEL_PMD ? KERNEL_PGD_BOUNDARY : PTRS_PER_PGD)
4f76cd38 Jeremy Fitzhardinge 2008-03-17  103  
617d34d9 Jeremy Fitzhardinge 2010-09-21  104  
617d34d9 Jeremy Fitzhardinge 2010-09-21  105  static void pgd_set_mm(pgd_t *pgd, struct mm_struct *mm)
617d34d9 Jeremy Fitzhardinge 2010-09-21  106  {
617d34d9 Jeremy Fitzhardinge 2010-09-21  107  	BUILD_BUG_ON(sizeof(virt_to_page(pgd)->index) < sizeof(mm));
617d34d9 Jeremy Fitzhardinge 2010-09-21 @108  	virt_to_page(pgd)->index = (pgoff_t)mm;
617d34d9 Jeremy Fitzhardinge 2010-09-21  109  }
617d34d9 Jeremy Fitzhardinge 2010-09-21  110  
617d34d9 Jeremy Fitzhardinge 2010-09-21  111  struct mm_struct *pgd_page_get_mm(struct page *page)
617d34d9 Jeremy Fitzhardinge 2010-09-21  112  {
617d34d9 Jeremy Fitzhardinge 2010-09-21 @113  	return (struct mm_struct *)page->index;
617d34d9 Jeremy Fitzhardinge 2010-09-21  114  }
617d34d9 Jeremy Fitzhardinge 2010-09-21  115  
617d34d9 Jeremy Fitzhardinge 2010-09-21  116  static void pgd_ctor(struct mm_struct *mm, pgd_t *pgd)

:::::: The code at line 108 was first introduced by commit
:::::: 617d34d9e5d8326ec8f188c616aa06ac59d083fe x86, mm: Hold mm->page_table_lock while doing vmalloc_sync

:::::: TO: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
:::::: CC: H. Peter Anvin <hpa@linux.intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6363 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161211/a02f0aed/attachment.gz>
