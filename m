From: lkp@intel.com (kbuild test robot)
Date: Thu, 3 Nov 2016 11:13:08 +0800
Subject: [PATCH 2/2] mm: hugetlb: support gigantic surplus pages
In-Reply-To: <1478141499-13825-3-git-send-email-shijie.huang@arm.com>
Message-ID: <201611031100.ggXBvpJr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Huang,

[auto build test ERROR on mmotm/master]
[also build test ERROR on v4.9-rc3 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Huang-Shijie/mm-hugetlb-rename-some-allocation-functions/20161103-105611
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: x86_64-randconfig-x011-201644 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   mm/hugetlb.c: In function '__alloc_huge_page':
>> mm/hugetlb.c:1623:10: error: implicit declaration of function 'alloc_gigantic_page' [-Werror=implicit-function-declaration]
      page = alloc_gigantic_page(nid, huge_page_order(h));
             ^~~~~~~~~~~~~~~~~~~
>> mm/hugetlb.c:1623:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      page = alloc_gigantic_page(nid, huge_page_order(h));
           ^
   cc1: some warnings being treated as errors

vim +/alloc_gigantic_page +1623 mm/hugetlb.c

  1617			h->nr_huge_pages++;
  1618			h->surplus_huge_pages++;
  1619		}
  1620		spin_unlock(&hugetlb_lock);
  1621	
  1622		if (hstate_is_gigantic(h))  {
> 1623			page = alloc_gigantic_page(nid, huge_page_order(h));
  1624			if (page)
  1625				prep_compound_gigantic_page(page, huge_page_order(h));
  1626		} else {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25105 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161103/516fb148/attachment-0001.gz>
