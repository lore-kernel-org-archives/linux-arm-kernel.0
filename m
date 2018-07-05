From: lkp@intel.com (kbuild test robot)
Date: Thu, 5 Jul 2018 16:29:43 +0800
Subject: [PATCH v3 02/11] hugetlb: Introduce generic version of
 hugetlb_free_pgd_range
In-Reply-To: <20180705051640.790-3-alex@ghiti.fr>
References: <20180705051640.790-3-alex@ghiti.fr>
Message-ID: <201807051622.dY8S5PXo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.18-rc3 next-20180704]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexandre-Ghiti/hugetlb-Factorize-hugetlb-architecture-primitives/20180705-135909
config: powerpc-mpc8540_ads_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All error/warnings (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/setup-common.c:37:0:
>> include/linux/hugetlb.h:191:65: error: expected identifier or '(' before '{' token
    #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) ({BUG(); 0; })
                                                                    ^
>> include/asm-generic/hugetlb.h:44:20: note: in expansion of macro 'hugetlb_free_pgd_range'
    static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
                       ^~~~~~~~~~~~~~~~~~~~~~

vim +191 include/linux/hugetlb.h

^1da177e Linus Torvalds    2005-04-16  172  
87ffc118 Andrea Arcangeli  2017-02-22  173  #define follow_hugetlb_page(m,v,p,vs,a,b,i,w,n)	({ BUG(); 0; })
^1da177e Linus Torvalds    2005-04-16  174  #define follow_huge_addr(mm, addr, write)	ERR_PTR(-EINVAL)
^1da177e Linus Torvalds    2005-04-16  175  #define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
e1759c21 Alexey Dobriyan   2008-10-15  176  static inline void hugetlb_report_meminfo(struct seq_file *m)
e1759c21 Alexey Dobriyan   2008-10-15  177  {
e1759c21 Alexey Dobriyan   2008-10-15  178  }
^1da177e Linus Torvalds    2005-04-16  179  #define hugetlb_report_node_meminfo(n, buf)	0
949f7ec5 David Rientjes    2013-04-29  180  static inline void hugetlb_show_meminfo(void)
949f7ec5 David Rientjes    2013-04-29  181  {
949f7ec5 David Rientjes    2013-04-29  182  }
4dc71451 Aneesh Kumar K.V  2017-07-06  183  #define follow_huge_pd(vma, addr, hpd, flags, pdshift) NULL
e66f17ff Naoya Horiguchi   2015-02-11  184  #define follow_huge_pmd(mm, addr, pmd, flags)	NULL
e66f17ff Naoya Horiguchi   2015-02-11  185  #define follow_huge_pud(mm, addr, pud, flags)	NULL
faaa5b62 Anshuman Khandual 2017-07-06  186  #define follow_huge_pgd(mm, addr, pgd, flags)	NULL
a5516438 Andi Kleen        2008-07-23  187  #define prepare_hugepage_range(file, addr, len)	(-EINVAL)
^1da177e Linus Torvalds    2005-04-16  188  #define pmd_huge(x)	0
ceb86879 Andi Kleen        2008-07-23  189  #define pud_huge(x)	0
^1da177e Linus Torvalds    2005-04-16  190  #define is_hugepage_only_range(mm, addr, len)	0
9da61aef David Gibson      2006-03-22 @191  #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) ({BUG(); 0; })
788c7df4 Hugh Dickins      2009-06-23  192  #define hugetlb_fault(mm, vma, addr, flags)	({ BUG(); 0; })
8fb5debc Mike Kravetz      2017-02-22  193  #define hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
8fb5debc Mike Kravetz      2017-02-22  194  				src_addr, pagep)	({ BUG(); 0; })
7868a208 Punit Agrawal     2017-07-06  195  #define huge_pte_offset(mm, address, sz)	0
24669e58 Aneesh Kumar K.V  2012-07-31  196  

:::::: The code at line 191 was first introduced by commit
:::::: 9da61aef0fd5b17dd4bf4baf33db12c470def774 [PATCH] hugepage: Fix hugepage logic in free_pgtables()

:::::: TO: David Gibson <david@gibson.dropbear.id.au>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 10925 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180705/01a302a5/attachment-0001.gz>
