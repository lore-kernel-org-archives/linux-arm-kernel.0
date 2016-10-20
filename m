From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 20 Oct 2016 11:52:56 +0800
Subject: [PATCH 2/2] arm64/numa: fix incorrect print of end_pfn
In-Reply-To: <1476935576-59941-1-git-send-email-guohanjun@huawei.com>
References: <1476935576-59941-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1476935576-59941-2-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

When booting on NUMA system with memory-less node (no
memory dimm on this memory controller), the print
for setup_node_data() is incorrect:

NUMA: Initmem setup node 2 [mem 0x00000000-0xffffffffffffffff]

It should be 0, not 0xffffffffffffffff as there is
no memory on that node.

Fixes: 1a2db300348b ("arm64, numa: Add NUMA support for arm64 platforms.")
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/numa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 34415fc..148e1fc 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -227,7 +227,8 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	int tnid;
 
 	pr_info("Initmem setup node %d [mem %#010Lx-%#010Lx]\n",
-		nid, start_pfn << PAGE_SHIFT, (end_pfn << PAGE_SHIFT) - 1);
+		nid, start_pfn << PAGE_SHIFT,
+		end_pfn ? (end_pfn << PAGE_SHIFT) - 1 : 0);
 
 	nd_pa = memblock_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
 	nd = __va(nd_pa);
-- 
1.7.12.4
