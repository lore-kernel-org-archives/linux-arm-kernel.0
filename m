From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Mar 2018 19:50:21 +0800
Subject: [PATCH v5 1/4] ioremap: Update pgtable free interfaces with addr
In-Reply-To: <1522157100-16879-2-git-send-email-cpandya@codeaurora.org>
References: <1522157100-16879-2-git-send-email-cpandya@codeaurora.org>
Message-ID: <201803281954.xld7X6dW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chintan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v4.16-rc7]
[also build test ERROR on next-20180328]
[cannot apply to arm64/for-next/core tip/x86/core asm-generic/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chintan-Pandya/Fix-issues-with-huge-mapping-in-ioremap-for-ARM64/20180328-192254
config: i386-randconfig-x014-201812 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   arch/x86/mm/pgtable.c: In function 'pud_free_pmd_page':
>> arch/x86/mm/pgtable.c:725:8: error: too few arguments to function 'pmd_free_pte_page'
      if (!pmd_free_pte_page(&pmd[i]))
           ^~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/pgtable.h:1292:0,
                    from include/linux/memremap.h:8,
                    from include/linux/mm.h:27,
                    from arch/x86/mm/pgtable.c:2:
   include/asm-generic/pgtable.h:987:5: note: declared here
    int pmd_free_pte_page(pmd_t *pmd, unsigned long addr);
        ^~~~~~~~~~~~~~~~~

vim +/pmd_free_pte_page +725 arch/x86/mm/pgtable.c

b6bdb751 Toshi Kani     2018-03-22  705  
b6bdb751 Toshi Kani     2018-03-22  706  /**
b6bdb751 Toshi Kani     2018-03-22  707   * pud_free_pmd_page - Clear pud entry and free pmd page.
b6bdb751 Toshi Kani     2018-03-22  708   * @pud: Pointer to a PUD.
5b7ee34c Chintan Pandya 2018-03-27  709   * @addr: Virtual address associated with pud.
b6bdb751 Toshi Kani     2018-03-22  710   *
b6bdb751 Toshi Kani     2018-03-22  711   * Context: The pud range has been unmaped and TLB purged.
b6bdb751 Toshi Kani     2018-03-22  712   * Return: 1 if clearing the entry succeeded. 0 otherwise.
b6bdb751 Toshi Kani     2018-03-22  713   */
5b7ee34c Chintan Pandya 2018-03-27  714  int pud_free_pmd_page(pud_t *pud, unsigned long addr)
b6bdb751 Toshi Kani     2018-03-22  715  {
28ee90fe Toshi Kani     2018-03-22  716  	pmd_t *pmd;
28ee90fe Toshi Kani     2018-03-22  717  	int i;
28ee90fe Toshi Kani     2018-03-22  718  
28ee90fe Toshi Kani     2018-03-22  719  	if (pud_none(*pud))
28ee90fe Toshi Kani     2018-03-22  720  		return 1;
28ee90fe Toshi Kani     2018-03-22  721  
28ee90fe Toshi Kani     2018-03-22  722  	pmd = (pmd_t *)pud_page_vaddr(*pud);
28ee90fe Toshi Kani     2018-03-22  723  
28ee90fe Toshi Kani     2018-03-22  724  	for (i = 0; i < PTRS_PER_PMD; i++)
28ee90fe Toshi Kani     2018-03-22 @725  		if (!pmd_free_pte_page(&pmd[i]))
28ee90fe Toshi Kani     2018-03-22  726  			return 0;
28ee90fe Toshi Kani     2018-03-22  727  
28ee90fe Toshi Kani     2018-03-22  728  	pud_clear(pud);
28ee90fe Toshi Kani     2018-03-22  729  	free_page((unsigned long)pmd);
28ee90fe Toshi Kani     2018-03-22  730  
28ee90fe Toshi Kani     2018-03-22  731  	return 1;
b6bdb751 Toshi Kani     2018-03-22  732  }
b6bdb751 Toshi Kani     2018-03-22  733  

:::::: The code at line 725 was first introduced by commit
:::::: 28ee90fe6048fa7b7ceaeb8831c0e4e454a4cf89 x86/mm: implement free pmd/pte page interfaces

:::::: TO: Toshi Kani <toshi.kani@hpe.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27074 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180328/b87477fe/attachment-0001.gz>
