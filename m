From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Sat, 28 May 2016 17:22:55 +0800
Subject: [PATCH v2 3/5] arm64/numa: add nid check for memory block
In-Reply-To: <1464427377-12712-1-git-send-email-thunder.leizhen@huawei.com>
References: <1464427377-12712-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1464427377-12712-4-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the same tactic to cpu and numa-distance nodes.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/numa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index c7fe3ec..2601660 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -141,6 +141,11 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
 {
 	int ret;

+	if (nid >= MAX_NUMNODES) {
+		pr_warn("NUMA: Node id %u exceeds maximum value\n", nid);
+		return -EINVAL;
+	}
+
 	ret = memblock_set_node(start, (end - start), &memblock.memory, nid);
 	if (ret < 0) {
 		pr_err("NUMA: memblock [0x%llx - 0x%llx] failed to add on node %d\n",
--
2.5.0
