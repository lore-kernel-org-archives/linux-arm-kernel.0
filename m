From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 1 Sep 2016 14:55:04 +0800
Subject: [PATCH v8 13/16] arm64/numa: remove the limitation that cpu0 must
 bind to node0
In-Reply-To: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
References: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1472712907-12700-14-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Remove the old binding code.
2. Read the nid of cpu0 from dts.
3. Fallback the nid of cpu0 to 0 when numa=off is set in bootargs.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/kernel/smp.c |  1 +
 arch/arm64/mm/numa.c    | 16 ++++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d93d433..4879085 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -619,6 +619,7 @@ static void __init of_parse_and_init_cpus(void)
 			}

 			bootcpu_valid = true;
+			early_map_cpu_to_node(0, of_node_to_nid(dn));

 			/*
 			 * cpu_logical_map has already been
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 72f4539..ef7e336 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -116,16 +116,24 @@ static void __init setup_node_to_cpumask_map(void)
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

 	cpu_to_node_map[cpu] = nid;
+
+	/*
+	 * We should set the numa node of cpu0 as soon as possible, because it
+	 * has already been set up online before. cpu_to_node(0) will soon be
+	 * called.
+	 */
+	if (!cpu)
+		set_cpu_numa_node(cpu, nid);
 }

 #ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
@@ -394,10 +402,6 @@ static int __init numa_init(int (*init_func)(void))

 	setup_node_to_cpumask_map();

-	/* init boot processor */
-	cpu_to_node_map[0] = 0;
-	map_cpu_to_node(0, 0);
-
 	return 0;
 }

--
2.5.0
