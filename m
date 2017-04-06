From: lkp@intel.com (kbuild test robot)
Date: Thu, 6 Apr 2017 13:37:58 +0800
Subject: [PATCH v2 4/9] arm64: hugetlb: Override huge_pte_clear() to
 support contiguous hugepages
In-Reply-To: <20170405133722.6406-5-punit.agrawal@arm.com>
Message-ID: <201704061354.9WPpGlZW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Punit,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.11-rc5 next-20170405]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Punit-Agrawal/Support-swap-entries-for-contiguous-pte-hugepages/20170406-090327
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/mm/hugetlbpage.c: In function 'huge_pte_clear':
>> arch/arm64/mm/hugetlbpage.c:200:44: error: incompatible type for argument 4 of 'find_num_contig'
     ncontig = find_num_contig(mm, addr, ptep, &pgsize);
                                               ^
   arch/arm64/mm/hugetlbpage.c:44:12: note: expected 'pte_t {aka struct <anonymous>}' but argument is of type 'size_t * {aka long unsigned int *}'
    static int find_num_contig(struct mm_struct *mm, unsigned long addr,
               ^~~~~~~~~~~~~~~
>> arch/arm64/mm/hugetlbpage.c:200:12: error: too few arguments to function 'find_num_contig'
     ncontig = find_num_contig(mm, addr, ptep, &pgsize);
               ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c:44:12: note: declared here
    static int find_num_contig(struct mm_struct *mm, unsigned long addr,
               ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_get_and_clear':
   arch/arm64/mm/hugetlbpage.c:216:10: error: too few arguments to function 'huge_pte_offset'
      cpte = huge_pte_offset(mm, addr);
             ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c:135:8: note: declared here
    pte_t *huge_pte_offset(struct mm_struct *mm,
           ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_set_access_flags':
   arch/arm64/mm/hugetlbpage.c:254:10: error: too few arguments to function 'huge_pte_offset'
      cpte = huge_pte_offset(vma->vm_mm, addr);
             ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c:135:8: note: declared here
    pte_t *huge_pte_offset(struct mm_struct *mm,
           ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_set_wrprotect':
   arch/arm64/mm/hugetlbpage.c:279:10: error: too few arguments to function 'huge_pte_offset'
      cpte = huge_pte_offset(mm, addr);
             ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c:135:8: note: declared here
    pte_t *huge_pte_offset(struct mm_struct *mm,
           ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_clear_flush':
   arch/arm64/mm/hugetlbpage.c:296:10: error: too few arguments to function 'huge_pte_offset'
      cpte = huge_pte_offset(vma->vm_mm, addr);
             ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c:135:8: note: declared here
    pte_t *huge_pte_offset(struct mm_struct *mm,
           ^~~~~~~~~~~~~~~

vim +/find_num_contig +200 arch/arm64/mm/hugetlbpage.c

   194	
   195		if (sz == PUD_SIZE || sz == PMD_SIZE) {
   196			pte_clear(mm, addr, ptep);
   197			return;
   198		}
   199	
 > 200		ncontig = find_num_contig(mm, addr, ptep, &pgsize);
   201		for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
   202			pte_clear(mm, addr, ptep);
   203	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 54634 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/72a1d341/attachment-0001.gz>
