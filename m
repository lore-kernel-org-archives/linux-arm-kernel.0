From: lkp@intel.com (kbuild test robot)
Date: Thu, 3 Aug 2017 12:29:28 +0800
Subject: [v4 14/15] mm: optimize early system hash allocations
In-Reply-To: <1501706304-869240-15-git-send-email-pasha.tatashin@oracle.com>
Message-ID: <201708031239.tNZVFTAD%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

[auto build test ERROR on mmotm/master]
[also build test ERROR on v4.13-rc3]
[cannot apply to next-20170802]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pavel-Tatashin/complete-deferred-page-initialization/20170803-081025
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: mips-allmodconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All error/warnings (new ones prefixed by >>):

   mm/page_alloc.c: In function 'alloc_large_system_hash':
>> mm/page_alloc.c:7369:13: error: implicit declaration of function 'memblock_virt_alloc_raw' [-Werror=implicit-function-declaration]
        table = memblock_virt_alloc_raw(size, 0);
                ^~~~~~~~~~~~~~~~~~~~~~~
>> mm/page_alloc.c:7369:11: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
        table = memblock_virt_alloc_raw(size, 0);
              ^
   cc1: some warnings being treated as errors

vim +/memblock_virt_alloc_raw +7369 mm/page_alloc.c

  7328	
  7329			/* limit to 1 bucket per 2^scale bytes of low memory */
  7330			if (scale > PAGE_SHIFT)
  7331				numentries >>= (scale - PAGE_SHIFT);
  7332			else
  7333				numentries <<= (PAGE_SHIFT - scale);
  7334	
  7335			/* Make sure we've got@least a 0-order allocation.. */
  7336			if (unlikely(flags & HASH_SMALL)) {
  7337				/* Makes no sense without HASH_EARLY */
  7338				WARN_ON(!(flags & HASH_EARLY));
  7339				if (!(numentries >> *_hash_shift)) {
  7340					numentries = 1UL << *_hash_shift;
  7341					BUG_ON(!numentries);
  7342				}
  7343			} else if (unlikely((numentries * bucketsize) < PAGE_SIZE))
  7344				numentries = PAGE_SIZE / bucketsize;
  7345		}
  7346		numentries = roundup_pow_of_two(numentries);
  7347	
  7348		/* limit allocation size to 1/16 total memory by default */
  7349		if (max == 0) {
  7350			max = ((unsigned long long)nr_all_pages << PAGE_SHIFT) >> 4;
  7351			do_div(max, bucketsize);
  7352		}
  7353		max = min(max, 0x80000000ULL);
  7354	
  7355		if (numentries < low_limit)
  7356			numentries = low_limit;
  7357		if (numentries > max)
  7358			numentries = max;
  7359	
  7360		log2qty = ilog2(numentries);
  7361	
  7362		gfp_flags = (flags & HASH_ZERO) ? GFP_ATOMIC | __GFP_ZERO : GFP_ATOMIC;
  7363		do {
  7364			size = bucketsize << log2qty;
  7365			if (flags & HASH_EARLY) {
  7366				if (flags & HASH_ZERO)
  7367					table = memblock_virt_alloc_nopanic(size, 0);
  7368				else
> 7369					table = memblock_virt_alloc_raw(size, 0);
  7370			} else if (hashdist) {
  7371				table = __vmalloc(size, gfp_flags, PAGE_KERNEL);
  7372			} else {
  7373				/*
  7374				 * If bucketsize is not a power-of-two, we may free
  7375				 * some pages at the end of hash table which
  7376				 * alloc_pages_exact() automatically does
  7377				 */
  7378				if (get_order(size) < MAX_ORDER) {
  7379					table = alloc_pages_exact(size, gfp_flags);
  7380					kmemleak_alloc(table, size, 1, gfp_flags);
  7381				}
  7382			}
  7383		} while (!table && size > PAGE_SIZE && --log2qty);
  7384	
  7385		if (!table)
  7386			panic("Failed to allocate %s hash table\n", tablename);
  7387	
  7388		pr_info("%s hash table entries: %ld (order: %d, %lu bytes)\n",
  7389			tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size);
  7390	
  7391		if (_hash_shift)
  7392			*_hash_shift = log2qty;
  7393		if (_hash_mask)
  7394			*_hash_mask = (1 << log2qty) - 1;
  7395	
  7396		return table;
  7397	}
  7398	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47112 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170803/603cce2a/attachment-0001.gz>
