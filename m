From: lkp@intel.com (kbuild test robot)
Date: Thu, 3 Aug 2017 12:29:45 +0800
Subject: [v4 04/15] mm: discard memblock data later
In-Reply-To: <1501706304-869240-5-git-send-email-pasha.tatashin@oracle.com>
Message-ID: <201708031251.T005mOYA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

[auto build test ERROR on mmotm/master]
[also build test ERROR on v4.13-rc3 next-20170802]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pavel-Tatashin/complete-deferred-page-initialization/20170803-081025
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: tile-allmodconfig (attached as .config)
compiler: tilegx-linux-gcc (GCC) 4.6.2
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All errors (new ones prefixed by >>):

   mm/page_alloc.c: In function 'page_alloc_init_late':
>> mm/page_alloc.c:1588:2: error: implicit declaration of function 'memblock_discard'
   cc1: some warnings being treated as errors

vim +/memblock_discard +1588 mm/page_alloc.c

  1567	
  1568	void __init page_alloc_init_late(void)
  1569	{
  1570		struct zone *zone;
  1571	
  1572	#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
  1573		int nid;
  1574	
  1575		/* There will be num_node_state(N_MEMORY) threads */
  1576		atomic_set(&pgdat_init_n_undone, num_node_state(N_MEMORY));
  1577		for_each_node_state(nid, N_MEMORY) {
  1578			kthread_run(deferred_init_memmap, NODE_DATA(nid), "pgdatinit%d", nid);
  1579		}
  1580	
  1581		/* Block until all are initialised */
  1582		wait_for_completion(&pgdat_init_all_done_comp);
  1583	
  1584		/* Reinit limits that are based on free pages after the kernel is up */
  1585		files_maxfiles_init();
  1586	#endif
  1587		/* Discard memblock private memory */
> 1588		memblock_discard();
  1589	
  1590		for_each_populated_zone(zone)
  1591			set_zone_contiguous(zone);
  1592	}
  1593	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49784 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170803/5078114a/attachment-0001.gz>
