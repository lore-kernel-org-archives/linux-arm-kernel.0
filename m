From: lkp@intel.com (kbuild test robot)
Date: Tue, 28 Jun 2016 18:14:31 +0800
Subject: [PATCH v4 2/3] mm: memblock Add some new functions to address
 the mem limit issue
In-Reply-To: <1467107137-29631-2-git-send-email-dennis.chen@arm.com>
Message-ID: <201606281837.baLUZlDs%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on v4.7-rc5 next-20160627]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dennis-Chen/mm-memblock-enhence-the-memblock-debugfs-output/20160628-174951
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: i386-randconfig-i0-201626 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   mm/memblock.c: In function 'memblock_enforce_memory_limit':
>> mm/memblock.c:1489:26: warning: unused variable 'r' [-Wunused-variable]
     struct memblock_region *r;
                             ^

vim +/r +1489 mm/memblock.c

  1473		 * of those regions, max_addr will keep original value ULLONG_MAX
  1474		 */
  1475		for_each_memblock(memory, r) {
  1476			if (limit <= r->size) {
  1477				max_addr = r->base + limit;
  1478				break;
  1479			}
  1480			limit -= r->size;
  1481		}
  1482	
  1483		return max_addr;
  1484	}
  1485	
  1486	void __init memblock_enforce_memory_limit(phys_addr_t limit)
  1487	{
  1488		phys_addr_t max_addr = (phys_addr_t)ULLONG_MAX;
> 1489		struct memblock_region *r;
  1490	
  1491		if (!limit)
  1492			return;
  1493	
  1494		max_addr = __find_max_addr(limit);
  1495	
  1496		/* @limit exceeds the total size of the memory, do nothing */
  1497		if (max_addr == (phys_addr_t)ULLONG_MAX)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24789 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160628/ba739723/attachment-0001.obj>
