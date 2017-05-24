From: lkp@intel.com (kbuild test robot)
Date: Thu, 25 May 2017 03:20:35 +0800
Subject: [PATCH v4 8/8] mm: rmap: Use correct helper when poisoning
 hugepages
In-Reply-To: <20170524115409.31309-9-punit.agrawal@arm.com>
Message-ID: <201705250342.fHpDVCsZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Punit,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.12-rc2 next-20170524]
[cannot apply to mmotm/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Punit-Agrawal/Support-for-contiguous-pte-hugepages/20170524-221905
config: x86_64-kexec (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   mm/rmap.c: In function 'try_to_unmap_one':
>> mm/rmap.c:1386:5: error: implicit declaration of function 'set_huge_swap_pte_at' [-Werror=implicit-function-declaration]
        set_huge_swap_pte_at(mm, address,
        ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/set_huge_swap_pte_at +1386 mm/rmap.c

  1380	
  1381			if (PageHWPoison(page) && !(flags & TTU_IGNORE_HWPOISON)) {
  1382				pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
  1383				if (PageHuge(page)) {
  1384					int nr = 1 << compound_order(page);
  1385					hugetlb_count_sub(nr, mm);
> 1386					set_huge_swap_pte_at(mm, address,
  1387							     pvmw.pte, pteval,
  1388							     vma_mmu_pagesize(vma));
  1389				} else {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25343 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170525/305fb753/attachment-0001.gz>
