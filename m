From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 21 Oct 2016 16:13:56 +0800
Subject: [PATCH v2 2/2] arm64/numa: fix incorrect log for memory-less node
In-Reply-To: <1477037636-10077-1-git-send-email-guohanjun@huawei.com>
References: <1477037636-10077-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1477037636-10077-2-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

When booting on NUMA system with memory-less node (no
memory dimm on this memory controller), the print
for setup_node_data() is incorrect:

NUMA: Initmem setup node 2 [mem 0x00000000-0xffffffffffffffff]

It can be fixed by printing [mem 0x00000000-0x00000000] when
end_pfn is 0, but print <memory-less node> will be more useful.

Fixes: 1a2db300348b ("arm64, numa: Add NUMA support for arm64 platforms.")
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
---
 arch/arm64/mm/numa.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 9a71d06..4b32168 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -223,8 +223,11 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	void *nd;
 	int tnid;
 
-	pr_info("Initmem setup node %d [mem %#010Lx-%#010Lx]\n",
-		nid, start_pfn << PAGE_SHIFT, (end_pfn << PAGE_SHIFT) - 1);
+	if (start_pfn < end_pfn)
+		pr_info("Initmem setup node %d [mem %#010Lx-%#010Lx]\n", nid,
+			start_pfn << PAGE_SHIFT, (end_pfn << PAGE_SHIFT) - 1);
+	else
+		pr_info("Initmem setup node %d [<memory-less node>]\n", nid);
 
 	nd_pa = memblock_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
 	nd = __va(nd_pa);
-- 
1.7.12.4
