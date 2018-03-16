From: lkp@intel.com (kbuild test robot)
Date: Fri, 16 Mar 2018 22:50:42 +0800
Subject: [PATCH v1 3/4] arm64: Fix the page leak in pud/pmd_set_huge
In-Reply-To: <1521017305-28518-4-git-send-email-cpandya@codeaurora.org>
References: <1521017305-28518-4-git-send-email-cpandya@codeaurora.org>
Message-ID: <201803162229.qR3oMfXU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chintan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc5]
[cannot apply to next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chintan-Pandya/Fix-issues-with-huge-mapping-in-ioremap/20180316-132223
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/page.h:27:0,
                    from include/linux/shm.h:6,
                    from include/linux/sched.h:16,
                    from include/linux/sched/task_stack.h:9,
                    from include/linux/elfcore.h:7,
                    from include/linux/crash_core.h:6,
                    from include/linux/kexec.h:18,
                    from arch/arm64/mm/mmu.c:26:
   arch/arm64/mm/mmu.c: In function 'pud_set_huge':
>> arch/arm64/mm/mmu.c:943:15: error: 'pud' undeclared (first use in this function); did you mean 'pudp'?
     if (pud_val(*pud) && !pud_huge(*pud))
                  ^
   arch/arm64/include/asm/pgtable-types.h:50:22: note: in definition of macro 'pgd_val'
    #define pgd_val(x) ((x).pgd)
                         ^
>> arch/arm64/mm/mmu.c:943:6: note: in expansion of macro 'pud_val'
     if (pud_val(*pud) && !pud_huge(*pud))
         ^~~~~~~
   arch/arm64/mm/mmu.c:943:15: note: each undeclared identifier is reported only once for each function it appears in
     if (pud_val(*pud) && !pud_huge(*pud))
                  ^
   arch/arm64/include/asm/pgtable-types.h:50:22: note: in definition of macro 'pgd_val'
    #define pgd_val(x) ((x).pgd)
                         ^
>> arch/arm64/mm/mmu.c:943:6: note: in expansion of macro 'pud_val'
     if (pud_val(*pud) && !pud_huge(*pud))
         ^~~~~~~
   arch/arm64/mm/mmu.c: In function 'pmd_set_huge':
>> arch/arm64/mm/mmu.c:960:15: error: 'pmd' undeclared (first use in this function); did you mean 'pmdp'?
     if (pmd_val(*pmd) && !pmd_huge(*pmd))
                  ^
   arch/arm64/include/asm/pgtable-types.h:39:22: note: in definition of macro 'pmd_val'
    #define pmd_val(x) ((x).pmd)
                         ^

vim +943 arch/arm64/mm/mmu.c

   932	
   933	int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
   934	{
   935		pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
   936						pgprot_val(mk_sect_prot(prot)));
   937	
   938		/* ioremap_page_range doesn't honour BBM */
   939		if (pud_present(READ_ONCE(*pudp)))
   940			return 0;
   941	
   942		BUG_ON(phys & ~PUD_MASK);
 > 943		if (pud_val(*pud) && !pud_huge(*pud))
   944			free_page((unsigned long)__va(pud_val(*pud)));
   945	
   946		set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
   947		return 1;
   948	}
   949	
   950	int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
   951	{
   952		pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
   953						pgprot_val(mk_sect_prot(prot)));
   954	
   955		/* ioremap_page_range doesn't honour BBM */
   956		if (pmd_present(READ_ONCE(*pmdp)))
   957			return 0;
   958	
   959		BUG_ON(phys & ~PMD_MASK);
 > 960		if (pmd_val(*pmd) && !pmd_huge(*pmd))
   961			free_page((unsigned long)__va(pmd_val(*pmd)));
   962	
   963		set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
   964		return 1;
   965	}
   966	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59091 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180316/a45a1c0d/attachment-0001.gz>
