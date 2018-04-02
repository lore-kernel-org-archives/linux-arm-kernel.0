From: lkp@intel.com (kbuild test robot)
Date: Mon, 2 Apr 2018 15:50:44 +0800
Subject: [PATCH v5 1/5] mm: page_alloc: remain memblock_next_valid_pfn()
 on arm and arm64
In-Reply-To: <1522636236-12625-2-git-send-email-hejianet@gmail.com>
References: <1522636236-12625-2-git-send-email-hejianet@gmail.com>
Message-ID: <201804021305.pjbSxb3W%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jia,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16 next-20180329]
[cannot apply to arm64/for-next/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jia-He/optimize-memblock_next_valid_pfn-and-early_pfn_valid-on-arm-and-arm64/20180402-131223
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   mm/page_alloc.c: In function 'memmap_init_zone':
>> mm/page_alloc.c:5360:10: error: implicit declaration of function 'skip_to_last_invalid_pfn' [-Werror=implicit-function-declaration]
       pfn = skip_to_last_invalid_pfn(pfn);
             ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/skip_to_last_invalid_pfn +5360 mm/page_alloc.c

  5340	
  5341		if (highest_memmap_pfn < end_pfn - 1)
  5342			highest_memmap_pfn = end_pfn - 1;
  5343	
  5344		/*
  5345		 * Honor reservation requested by the driver for this ZONE_DEVICE
  5346		 * memory
  5347		 */
  5348		if (altmap && start_pfn == altmap->base_pfn)
  5349			start_pfn += altmap->reserve;
  5350	
  5351		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
  5352			/*
  5353			 * There can be holes in boot-time mem_map[]s handed to this
  5354			 * function.  They do not exist on hotplugged memory.
  5355			 */
  5356			if (context != MEMMAP_EARLY)
  5357				goto not_early;
  5358	
  5359			if (!early_pfn_valid(pfn)) {
> 5360				pfn = skip_to_last_invalid_pfn(pfn);
  5361				continue;
  5362			}
  5363			if (!early_pfn_in_nid(pfn, nid))
  5364				continue;
  5365			if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
  5366				break;
  5367	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6721 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180402/1a272b4d/attachment-0001.gz>
