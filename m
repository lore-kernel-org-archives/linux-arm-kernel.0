From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Wed, 24 Aug 2016 15:44:39 +0800
Subject: [PATCH v7 00/14] fix some type infos and bugs for arm64/of numa
Message-ID: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v6 -> v7:
Fix a bug for this patch series when "numa=off" was set in bootargs, this
modification only impact patch 12.

Please refer https://lkml.org/lkml/2016/8/23/249 for more details.

@@ -119,13 +115,13 @@ static void __init setup_node_to_cpumask_map(void)
  */
 void numa_store_cpu_info(unsigned int cpu)
 {
-	map_cpu_to_node(cpu, numa_off ? 0 : cpu_to_node_map[cpu]);
+	map_cpu_to_node(cpu, cpu_to_node_map[cpu]);
 }

 void __init early_map_cpu_to_node(unsigned int cpu, int nid)
 {
 	/* fallback to node 0 */
-	if (nid < 0 || nid >= MAX_NUMNODES)
+	if (nid < 0 || nid >= MAX_NUMNODES || numa_off)
 		nid = 0;

v5 -> v6:
Move memblk nid check from arch/arm64/mm/numa.c into drivers/of/of_numa.c,
because this check is arch independent.

This modification only related to patch 3, but impacted the contents of patch 7 and 8,
other patches have no change.

v4 -> v5:
This version has no code changes, just add "Acked-by: Rob Herring <robh@kernel.org>"
into patches 1, 2, 4, 6, 7, 13, 14. Because these patches rely on some acpi numa
patches, and the latter had not been upstreamed in 4.7, but upstreamed in 4.8-rc1,
so I resend my patches again.

v3 -> v4:
1. Packed three patches of Kefeng Wang, patch6-8.
2. Add 6 new patches(9-15) to enhance the numa on arm64.

v2 -> v3:
1. Adjust patch2 and patch5 according to Matthias Brugger's advice, to make the
   patches looks more well. The final code have no change. 

v1 -> v2:
1. Base on https://lkml.org/lkml/2016/5/24/679
2. Rewrote of_numa_parse_memory_nodes according to Rob Herring's advice. So that it looks more clear.
3. Rewrote patch 5 because some scenes were not considered before.

Kefeng Wang (3):
  of_numa: Use of_get_next_parent to simplify code
  of_numa: Use pr_fmt()
  arm64: numa: Use pr_fmt()

Zhen Lei (11):
  of/numa: remove a duplicated pr_debug information
  of/numa: fix a memory@ node can only contains one memory block
  arm64/numa: add nid check for memory block
  of/numa: remove a duplicated warning
  arm64/numa: avoid inconsistent information to be printed
  arm64/numa: support HAVE_SETUP_PER_CPU_AREA
  arm64/numa: define numa_distance as array to simplify code
  arm64/numa: support HAVE_MEMORYLESS_NODES
  arm64/numa: remove the limitation that cpu0 must bind to node0
  of/numa: remove the constraint on the distances of node pairs
  Documentation: remove the constraint on the distances of node pairs

 Documentation/devicetree/bindings/numa.txt |   1 -
 arch/arm64/Kconfig                         |  12 ++
 arch/arm64/include/asm/numa.h              |   1 -
 arch/arm64/kernel/smp.c                    |   1 +
 arch/arm64/mm/numa.c                       | 226 ++++++++++++++++-------------
 drivers/of/of_numa.c                       |  88 ++++++-----
 6 files changed, 179 insertions(+), 150 deletions(-)

--
2.5.0
