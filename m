From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 25 Oct 2016 10:59:18 +0800
Subject: [PATCH 2/2] arm64/numa: support HAVE_MEMORYLESS_NODES
In-Reply-To: <1477364358-10620-1-git-send-email-thunder.leizhen@huawei.com>
References: <1477364358-10620-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1477364358-10620-3-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some numa nodes may have no memory. For example:
1) a node has no memory bank plugged.
2) a node has no memory bank slots.

To ensure percpu variable areas and numa control blocks of the
memoryless numa nodes to be allocated from the nearest available node to
improve performance, defined node_distance_ready. And make its value to be
true immediately after node distances have been initialized.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/Kconfig            | 4 ++++
 arch/arm64/include/asm/numa.h | 3 +++
 arch/arm64/mm/numa.c          | 6 +++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 30398db..648dd13 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -609,6 +609,10 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
 	def_bool y
 	depends on NUMA

+config HAVE_MEMORYLESS_NODES
+	def_bool y
+	depends on NUMA
+
 source kernel/Kconfig.preempt
 source kernel/Kconfig.hz

diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
index 600887e..9d068bf 100644
--- a/arch/arm64/include/asm/numa.h
+++ b/arch/arm64/include/asm/numa.h
@@ -13,6 +13,9 @@
 int __node_distance(int from, int to);
 #define node_distance(a, b) __node_distance(a, b)

+extern int __initdata arch_node_distance_ready;
+#define node_distance_ready()	arch_node_distance_ready
+
 extern nodemask_t numa_nodes_parsed __initdata;

 /* Mappings between node number and cpus on that node. */
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 9a71d06..5db9765 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -36,6 +36,7 @@ static int cpu_to_node_map[NR_CPUS] = { [0 ... NR_CPUS-1] = NUMA_NO_NODE };
 static int numa_distance_cnt;
 static u8 *numa_distance;
 static bool numa_off;
+int __initdata arch_node_distance_ready;

 static __init int numa_parse_early_param(char *opt)
 {
@@ -395,9 +396,12 @@ static int __init numa_init(int (*init_func)(void))
 		return -EINVAL;
 	}

+	arch_node_distance_ready = 1;
 	ret = numa_register_nodes();
-	if (ret < 0)
+	if (ret < 0) {
+		arch_node_distance_ready = 0;
 		return ret;
+	}

 	setup_node_to_cpumask_map();

--
2.5.0
