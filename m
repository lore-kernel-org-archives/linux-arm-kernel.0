From: lkp@intel.com (kbuild test robot)
Date: Thu, 3 Aug 2017 12:46:13 +0800
Subject: [v4 13/15] mm: stop zeroing memory during allocation in vmemmap
In-Reply-To: <1501706304-869240-14-git-send-email-pasha.tatashin@oracle.com>
Message-ID: <201708031252.yCFUrZos%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

[auto build test ERROR on mmotm/master]
[also build test ERROR on v4.13-rc3]
[cannot apply to next-20170802]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pavel-Tatashin/complete-deferred-page-initialization/20170803-081025
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All error/warnings (new ones prefixed by >>):

   mm/sparse.c: In function 'sparse_mem_maps_populate_node':
>> mm/sparse.c:444:8: error: implicit declaration of function 'memblock_virt_alloc_try_nid_raw' [-Werror=implicit-function-declaration]
     map = memblock_virt_alloc_try_nid_raw(size * map_count,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> mm/sparse.c:444:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     map = memblock_virt_alloc_try_nid_raw(size * map_count,
         ^
   cc1: some warnings being treated as errors

vim +/memblock_virt_alloc_try_nid_raw +444 mm/sparse.c

   406	
   407	#ifndef CONFIG_SPARSEMEM_VMEMMAP
   408	struct page __init *sparse_mem_map_populate(unsigned long pnum, int nid)
   409	{
   410		struct page *map;
   411		unsigned long size;
   412	
   413		map = alloc_remap(nid, sizeof(struct page) * PAGES_PER_SECTION);
   414		if (map)
   415			return map;
   416	
   417		size = PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
   418		map = memblock_virt_alloc_try_nid(size,
   419						  PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
   420						  BOOTMEM_ALLOC_ACCESSIBLE, nid);
   421		return map;
   422	}
   423	void __init sparse_mem_maps_populate_node(struct page **map_map,
   424						  unsigned long pnum_begin,
   425						  unsigned long pnum_end,
   426						  unsigned long map_count, int nodeid)
   427	{
   428		void *map;
   429		unsigned long pnum;
   430		unsigned long size = sizeof(struct page) * PAGES_PER_SECTION;
   431	
   432		map = alloc_remap(nodeid, size * map_count);
   433		if (map) {
   434			for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
   435				if (!present_section_nr(pnum))
   436					continue;
   437				map_map[pnum] = map;
   438				map += size;
   439			}
   440			return;
   441		}
   442	
   443		size = PAGE_ALIGN(size);
 > 444		map = memblock_virt_alloc_try_nid_raw(size * map_count,
   445						      PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
   446						      BOOTMEM_ALLOC_ACCESSIBLE, nodeid);
   447		if (map) {
   448			for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
   449				if (!present_section_nr(pnum))
   450					continue;
   451				map_map[pnum] = map;
   452				map += size;
   453			}
   454			return;
   455		}
   456	
   457		/* fallback */
   458		for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
   459			struct mem_section *ms;
   460	
   461			if (!present_section_nr(pnum))
   462				continue;
   463			map_map[pnum] = sparse_mem_map_populate(pnum, nodeid);
   464			if (map_map[pnum])
   465				continue;
   466			ms = __nr_to_section(pnum);
   467			pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
   468			       __func__);
   469			ms->section_mem_map = 0;
   470		}
   471	}
   472	#endif /* !CONFIG_SPARSEMEM_VMEMMAP */
   473	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45971 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170803/f659ee9a/attachment-0001.gz>
