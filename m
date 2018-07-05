From: lkp@intel.com (kbuild test robot)
Date: Thu, 5 Jul 2018 17:39:47 +0800
Subject: [PATCH v3 08/11] hugetlb: Introduce generic version of
 prepare_hugepage_range
In-Reply-To: <20180705051640.790-9-alex@ghiti.fr>
References: <20180705051640.790-9-alex@ghiti.fr>
Message-ID: <201807051714.BBlsWblH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.18-rc3 next-20180704]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexandre-Ghiti/hugetlb-Factorize-hugetlb-architecture-primitives/20180705-135909
config: powerpc-mpc8540_ads_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All warnings (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/setup-common.c:37:0:
   include/linux/hugetlb.h:191:65: error: expected identifier or '(' before '{' token
    #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) ({BUG(); 0; })
                                                                    ^
   include/asm-generic/hugetlb.h:44:20: note: in expansion of macro 'hugetlb_free_pgd_range'
    static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
                       ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/hugetlb.h:187:50: error: expected identifier or '(' before '-' token
    #define prepare_hugepage_range(file, addr, len) (-EINVAL)
                                                     ^
>> include/asm-generic/hugetlb.h:91:19: note: in expansion of macro 'prepare_hugepage_range'
    static inline int prepare_hugepage_range(struct file *file,
                      ^~~~~~~~~~~~~~~~~~~~~~

vim +/prepare_hugepage_range +91 include/asm-generic/hugetlb.h

    42	
    43	#ifndef __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
  > 44	static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
    45			unsigned long addr, unsigned long end,
    46			unsigned long floor, unsigned long ceiling)
    47	{
    48		free_pgd_range(tlb, addr, end, floor, ceiling);
    49	}
    50	#endif
    51	
    52	#ifndef __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
    53	static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
    54			pte_t *ptep, pte_t pte)
    55	{
    56		set_pte_at(mm, addr, ptep, pte);
    57	}
    58	#endif
    59	
    60	#ifndef __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
    61	static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
    62			unsigned long addr, pte_t *ptep)
    63	{
    64		return ptep_get_and_clear(mm, addr, ptep);
    65	}
    66	#endif
    67	
    68	#ifndef __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
    69	static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
    70			unsigned long addr, pte_t *ptep)
    71	{
    72		ptep_clear_flush(vma, addr, ptep);
    73	}
    74	#endif
    75	
    76	#ifndef __HAVE_ARCH_HUGE_PTE_NONE
    77	static inline int huge_pte_none(pte_t pte)
    78	{
    79		return pte_none(pte);
    80	}
    81	#endif
    82	
    83	#ifndef __HAVE_ARCH_HUGE_PTE_WRPROTECT
    84	static inline pte_t huge_pte_wrprotect(pte_t pte)
    85	{
    86		return pte_wrprotect(pte);
    87	}
    88	#endif
    89	
    90	#ifndef __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
  > 91	static inline int prepare_hugepage_range(struct file *file,
    92			unsigned long addr, unsigned long len)
    93	{
    94		struct hstate *h = hstate_file(file);
    95	
    96		if (len & ~huge_page_mask(h))
    97			return -EINVAL;
    98		if (addr & ~huge_page_mask(h))
    99			return -EINVAL;
   100	
   101		return 0;
   102	}
   103	#endif
   104	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 10925 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180705/42e7d2e8/attachment-0001.gz>
