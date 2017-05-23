From: lkp@intel.com (kbuild test robot)
Date: Tue, 23 May 2017 18:04:42 +0800
Subject: [PATCH v3 3/6] mm/hugetlb: add size parameter to huge_pte_offset()
In-Reply-To: <20170522133604.11392-4-punit.agrawal@arm.com>
Message-ID: <201705231817.OSRI6iib%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Punit,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.12-rc2 next-20170523]
[cannot apply to mmotm/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Punit-Agrawal/Support-for-contiguous-pte-hugepages/20170523-142407
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_get_and_clear':
>> arch/arm64/mm/hugetlbpage.c:200:10: error: too few arguments to function 'huge_pte_offset'
      cpte = huge_pte_offset(mm, addr);
             ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c:135:8: note: declared here
    pte_t *huge_pte_offset(struct mm_struct *mm,
           ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_set_access_flags':
   arch/arm64/mm/hugetlbpage.c:238:10: error: too few arguments to function 'huge_pte_offset'
      cpte = huge_pte_offset(vma->vm_mm, addr);
             ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c:135:8: note: declared here
    pte_t *huge_pte_offset(struct mm_struct *mm,
           ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_set_wrprotect':
   arch/arm64/mm/hugetlbpage.c:263:10: error: too few arguments to function 'huge_pte_offset'
      cpte = huge_pte_offset(mm, addr);
             ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c:135:8: note: declared here
    pte_t *huge_pte_offset(struct mm_struct *mm,
           ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_clear_flush':
   arch/arm64/mm/hugetlbpage.c:280:10: error: too few arguments to function 'huge_pte_offset'
      cpte = huge_pte_offset(vma->vm_mm, addr);
             ^~~~~~~~~~~~~~~
   arch/arm64/mm/hugetlbpage.c:135:8: note: declared here
    pte_t *huge_pte_offset(struct mm_struct *mm,
           ^~~~~~~~~~~~~~~

vim +/huge_pte_offset +200 arch/arm64/mm/hugetlbpage.c

66b3923a David Woods 2015-12-17  194  	if (pte_cont(*ptep)) {
66b3923a David Woods 2015-12-17  195  		int ncontig, i;
66b3923a David Woods 2015-12-17  196  		size_t pgsize;
66b3923a David Woods 2015-12-17  197  		pte_t *cpte;
66b3923a David Woods 2015-12-17  198  		bool is_dirty = false;
66b3923a David Woods 2015-12-17  199  
66b3923a David Woods 2015-12-17 @200  		cpte = huge_pte_offset(mm, addr);
66b3923a David Woods 2015-12-17  201  		ncontig = find_num_contig(mm, addr, cpte, *cpte, &pgsize);
66b3923a David Woods 2015-12-17  202  		/* save the 1st pte to return */
66b3923a David Woods 2015-12-17  203  		pte = ptep_get_and_clear(mm, addr, cpte);

:::::: The code at line 200 was first introduced by commit
:::::: 66b3923a1a0f77a563b43f43f6ad091354abbfe9 arm64: hugetlb: add support for PTE contiguous bit

:::::: TO: David Woods <dwoods@ezchip.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 35202 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170523/dd2d84e0/attachment-0001.gz>
