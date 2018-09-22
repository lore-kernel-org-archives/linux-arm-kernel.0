From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Sat, 22 Sep 2018 21:09:55 +0530
Subject: [PATCH 4/5] arm64/numa: Report correct memblock range for the dummy
 node
In-Reply-To: <1537630796-14756-1-git-send-email-anshuman.khandual@arm.com>
References: <1537630796-14756-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <1537630796-14756-5-git-send-email-anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dummy node ID is marked into all memory ranges on the system. So the
dummy node really extends the entire memblock.memory. Hence report correct
extent information for the dummy node using memblock range helper functions
instead of the range [0LLU, PFN_PHYS(max_pfn) - 1)].

Fixes: 1a2db30034 ("arm64, numa: Add NUMA support for arm64 platforms")
Acked-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 146c04c..54529b4 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -432,7 +432,7 @@ static int __init dummy_numa_init(void)
 	if (numa_off)
 		pr_info("NUMA disabled\n"); /* Forced off on command line. */
 	pr_info("Faking a node at [mem %#018Lx-%#018Lx]\n",
-		0LLU, PFN_PHYS(max_pfn) - 1);
+		memblock_start_of_DRAM(), memblock_end_of_DRAM() - 1);
 
 	for_each_memblock(memory, mblk) {
 		ret = numa_add_memblk(0, mblk->base, mblk->base + mblk->size);
-- 
2.7.4
