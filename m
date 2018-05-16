From: lkp@intel.com (kbuild test robot)
Date: Wed, 16 May 2018 19:00:53 +0800
Subject: [PATCH v2 1/3] x86/mm: disable ioremap free page handling on
 x86-PAE
In-Reply-To: <20180515213931.23885-2-toshi.kani@hpe.com>
References: <20180515213931.23885-2-toshi.kani@hpe.com>
Message-ID: <201805161819.uT7J37yy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Toshi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.17-rc5 next-20180515]
[cannot apply to tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Toshi-Kani/fix-free-pmd-pte-page-handlings-on-x86/20180516-183317
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: i386-randconfig-x013-201819 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the linux-review/Toshi-Kani/fix-free-pmd-pte-page-handlings-on-x86/20180516-183317 HEAD 93944422fcef9bfadf22e345c1d7a34723cc3203 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> arch/x86/mm/pgtable.c:757:5: error: conflicting types for 'pud_free_pmd_page'
    int pud_free_pmd_page(pud_t *pud, unsigned long addr)
        ^~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/pgtable.h:1301:0,
                    from include/linux/memremap.h:8,
                    from include/linux/mm.h:27,
                    from arch/x86/mm/pgtable.c:2:
   include/asm-generic/pgtable.h:1022:5: note: previous declaration of 'pud_free_pmd_page' was here
    int pud_free_pmd_page(pud_t *pud);
        ^~~~~~~~~~~~~~~~~
>> arch/x86/mm/pgtable.c:766:5: error: conflicting types for 'pmd_free_pte_page'
    int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
        ^~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/pgtable.h:1301:0,
                    from include/linux/memremap.h:8,
                    from include/linux/mm.h:27,
                    from arch/x86/mm/pgtable.c:2:
   include/asm-generic/pgtable.h:1023:5: note: previous declaration of 'pmd_free_pte_page' was here
    int pmd_free_pte_page(pmd_t *pmd);
        ^~~~~~~~~~~~~~~~~

vim +/pud_free_pmd_page +757 arch/x86/mm/pgtable.c

   756	
 > 757	int pud_free_pmd_page(pud_t *pud, unsigned long addr)
   758	{
   759		return pud_none(*pud);
   760	}
   761	
   762	/*
   763	 * Disable free page handling on x86-PAE. This assures that ioremap()
   764	 * does not update sync'd pmd entries. See vmalloc_sync_one().
   765	 */
 > 766	int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
   767	{
   768		return pmd_none(*pmd);
   769	}
   770	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34248 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180516/6de8a15a/attachment-0001.gz>
