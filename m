From: lkp@intel.com (kbuild test robot)
Date: Thu, 6 Apr 2017 09:25:32 +0800
Subject: [PATCH v2 6/9] mm: rmap: Use correct helper when poisoning
 hugepages
In-Reply-To: <20170405133722.6406-7-punit.agrawal@arm.com>
Message-ID: <201704060916.o3JFLNRt%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Punit,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.11-rc5 next-20170405]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Punit-Agrawal/Support-swap-entries-for-contiguous-pte-hugepages/20170406-090327
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: i386-tinyconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   mm/rmap.c: In function 'try_to_unmap_one':
>> mm/rmap.c:1393:5: error: implicit declaration of function 'set_huge_swap_pte_at' [-Werror=implicit-function-declaration]
        set_huge_swap_pte_at(mm, address,
        ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/set_huge_swap_pte_at +1393 mm/rmap.c

  1387	
  1388			if (PageHWPoison(page) && !(flags & TTU_IGNORE_HWPOISON)) {
  1389				pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
  1390				if (PageHuge(page)) {
  1391					int nr = 1 << compound_order(page);
  1392					hugetlb_count_sub(nr, mm);
> 1393					set_huge_swap_pte_at(mm, address,
  1394							     pvmw.pte, pteval,
  1395							     vma_mmu_pagesize(vma));
  1396				} else {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6518 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/f26f6f20/attachment.gz>
