From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 1 Sep 2016 14:55:03 +0800
Subject: [PATCH v8 12/16] arm64/numa: remove some useless code
In-Reply-To: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
References: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1472712907-12700-13-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the deleted code is executed, only the bit of cpu0 was set on
cpu_possible_mask. So that, only set_cpu_numa_node(0, NUMA_NO_NODE); will
be executed. And map_cpu_to_node(0, 0) will soon be called. So these code
can be safely removed.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/numa.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 891bdaa..72f4539 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -95,7 +95,6 @@ void numa_clear_node(unsigned int cpu)
  */
 static void __init setup_node_to_cpumask_map(void)
 {
-	unsigned int cpu;
 	int node;

 	/* setup nr_node_ids if not done yet */
@@ -108,9 +107,6 @@ static void __init setup_node_to_cpumask_map(void)
 		cpumask_clear(node_to_cpumask_map[node]);
 	}

-	for_each_possible_cpu(cpu)
-		set_cpu_numa_node(cpu, NUMA_NO_NODE);
-
 	/* cpumask_of_node() will now work */
 	pr_debug("Node to cpumask map for %d nodes\n", nr_node_ids);
 }
--
2.5.0
