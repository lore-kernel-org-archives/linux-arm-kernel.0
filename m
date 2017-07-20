From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 20 Jul 2017 12:03:59 +0100
Subject: [PATCH 1/4] arm64/numa: Drop duplicate message
In-Reply-To: <20170720110402.15313-1-punit.agrawal@arm.com>
References: <20170720110402.15313-1-punit.agrawal@arm.com>
Message-ID: <20170720110402.15313-2-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting linux on a system without CONFIG_NUMA enabled, the
following messages are printed during boot -

NUMA: Faking a node at [mem 0x0000000000000000-0x00000083ffffffff]
NUMA: Adding memblock [0x8000000000 - 0x8000e7ffff] on node 0
NUMA: Adding memblock [0x8000e80000 - 0x83f65cffff] on node 0
NUMA: Adding memblock [0x83f65d0000 - 0x83f665ffff] on node 0
NUMA: Adding memblock [0x83f6660000 - 0x83f676ffff] on node 0
NUMA: Adding memblock [0x83f6770000 - 0x83f678ffff] on node 0
NUMA: Adding memblock [0x83f6790000 - 0x83fb82ffff] on node 0
NUMA: Adding memblock [0x83fb830000 - 0x83fbc0ffff] on node 0
NUMA: Adding memblock [0x83fbc10000 - 0x83fbdfffff] on node 0
NUMA: Adding memblock [0x83fbe00000 - 0x83fbffffff] on node 0
NUMA: Adding memblock [0x83fc000000 - 0x83fffbffff] on node 0
NUMA: Adding memblock [0x83fffc0000 - 0x83fffdffff] on node 0
NUMA: Adding memblock [0x83fffe0000 - 0x83ffffffff] on node 0
NUMA: Initmem setup node 0 [mem 0x8000000000-0x83ffffffff]
NUMA: NODE_DATA [mem 0x83fffec500-0x83fffedfff]

The information is then duplicated by core kernel messages right after
the above output.

Early memory node ranges
  node   0: [mem 0x0000008000000000-0x0000008000e7ffff]
  node   0: [mem 0x0000008000e80000-0x00000083f65cffff]
  node   0: [mem 0x00000083f65d0000-0x00000083f665ffff]
  node   0: [mem 0x00000083f6660000-0x00000083f676ffff]
  node   0: [mem 0x00000083f6770000-0x00000083f678ffff]
  node   0: [mem 0x00000083f6790000-0x00000083fb82ffff]
  node   0: [mem 0x00000083fb830000-0x00000083fbc0ffff]
  node   0: [mem 0x00000083fbc10000-0x00000083fbdfffff]
  node   0: [mem 0x00000083fbe00000-0x00000083fbffffff]
  node   0: [mem 0x00000083fc000000-0x00000083fffbffff]
  node   0: [mem 0x00000083fffc0000-0x00000083fffdffff]
  node   0: [mem 0x00000083fffe0000-0x00000083ffffffff]
Initmem setup node 0 [mem 0x0000008000000000-0x00000083ffffffff]

Remove the duplication of memblock layout information printed during
boot by dropping the messages from arm64 numa initialisation.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/numa.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index b388a99fea7b..dad128ba98bf 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -208,8 +208,6 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
 	}
 
 	node_set(nid, numa_nodes_parsed);
-	pr_info("Adding memblock [0x%llx - 0x%llx] on node %d\n",
-			start, (end - 1), nid);
 	return ret;
 }
 
@@ -223,10 +221,7 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	void *nd;
 	int tnid;
 
-	if (start_pfn < end_pfn)
-		pr_info("Initmem setup node %d [mem %#010Lx-%#010Lx]\n", nid,
-			start_pfn << PAGE_SHIFT, (end_pfn << PAGE_SHIFT) - 1);
-	else
+	if (start_pfn >= end_pfn)
 		pr_info("Initmem setup node %d [<memory-less node>]\n", nid);
 
 	nd_pa = memblock_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
-- 
2.11.0
