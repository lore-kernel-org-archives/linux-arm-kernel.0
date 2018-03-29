From: lkp@intel.com (kbuild test robot)
Date: Thu, 29 Mar 2018 19:53:32 +0800
Subject: [PATCH v7 1/4] ioremap: Update pgtable free interfaces with addr
In-Reply-To: <1522240282-12104-2-git-send-email-cpandya@codeaurora.org>
References: <1522240282-12104-2-git-send-email-cpandya@codeaurora.org>
Message-ID: <201803291957.TombWSzK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chintan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v4.16-rc7]
[also build test ERROR on next-20180328]
[cannot apply to arm64/for-next/core tip/x86/core asm-generic/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chintan-Pandya/ioremap-Update-pgtable-free-interfaces-with-addr/20180329-133736
config: x86_64-rhel (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   arch/x86/mm/pgtable.c: In function 'pud_free_pmd_page':
>> arch/x86/mm/pgtable.c:725:8: error: too few arguments to function 'pmd_free_pte_page'
      if (!pmd_free_pte_page(&pmd[i]), addr + (i * PMD_SIZE))
           ^~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/pgtable.h:1292:0,
                    from include/linux/memremap.h:8,
                    from include/linux/mm.h:27,
                    from arch/x86/mm/pgtable.c:2:
   include/asm-generic/pgtable.h:987:5: note: declared here
    int pmd_free_pte_page(pmd_t *pmd, unsigned long addr);
        ^~~~~~~~~~~~~~~~~
   arch/x86/mm/pgtable.c:725:34: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      if (!pmd_free_pte_page(&pmd[i]), addr + (i * PMD_SIZE))
                                     ^

vim +/pmd_free_pte_page +725 arch/x86/mm/pgtable.c

   705	
   706	/**
   707	 * pud_free_pmd_page - Clear pud entry and free pmd page.
   708	 * @pud: Pointer to a PUD.
   709	 * @addr: Virtual address associated with pud.
   710	 *
   711	 * Context: The pud range has been unmaped and TLB purged.
   712	 * Return: 1 if clearing the entry succeeded. 0 otherwise.
   713	 */
   714	int pud_free_pmd_page(pud_t *pud, unsigned long addr)
   715	{
   716		pmd_t *pmd;
   717		int i;
   718	
   719		if (pud_none(*pud))
   720			return 1;
   721	
   722		pmd = (pmd_t *)pud_page_vaddr(*pud);
   723	
   724		for (i = 0; i < PTRS_PER_PMD; i++)
 > 725			if (!pmd_free_pte_page(&pmd[i]), addr + (i * PMD_SIZE))
   726				return 0;
   727	
   728		pud_clear(pud);
   729		free_page((unsigned long)pmd);
   730	
   731		return 1;
   732	}
   733	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 40695 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180329/3dd9824d/attachment-0001.gz>
