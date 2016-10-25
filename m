From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 25 Oct 2016 10:59:16 +0800
Subject: [PATCH 0/2] to support memblock near alloc and memoryless on arm64
Message-ID: <1477364358-10620-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If HAVE_MEMORYLESS_NODES is selected, and some memoryless numa nodes are
actually exist. The percpu variable areas and numa control blocks of that
memoryless numa nodes need to be allocated from the nearest available
node to improve performance.

In the beginning, I added a new function:
phys_addr_t __init memblock_alloc_near_nid(phys_addr_t size, phys_addr_t align, int nid);

But it can not replace memblock_virt_alloc_try_nid, because the latter can specify a min_addr,
it usually be assigned as __pa(MAX_DMA_ADDRESS), to prevent memory be allocated from DMA area.
It's bad to add another function, because the code will be duplicated in these two functions.

So I make memblock_alloc_near_nid to be called in the subfunctions of memblock_alloc_try_nid
and memblock_virt_alloc_try_nid. Add a macro node_distance_ready to distinguish different
situations:
1) By default, the value of node_distance_ready is zero, memblock_*_try_nid work as normal as before.
2) ARCH platforms set the value of node_distance_ready to be true when numa node distances are ready, (please refer patch 2)
   memblock_*_try_nid allocate memory from the nearest node relative to the specified node.

Zhen Lei (2):
  mm/memblock: prepare a capability to support memblock near alloc
  arm64/numa: support HAVE_MEMORYLESS_NODES

 arch/arm64/Kconfig            |  4 +++
 arch/arm64/include/asm/numa.h |  3 ++
 arch/arm64/mm/numa.c          |  6 +++-
 mm/memblock.c                 | 76 ++++++++++++++++++++++++++++++++++++-------
 4 files changed, 77 insertions(+), 12 deletions(-)

-- 
2.5.0
