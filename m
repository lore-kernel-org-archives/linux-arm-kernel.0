From: shuah@kernel.org (Shuah Khan (Samsung OSG))
Date: Fri, 24 Aug 2018 17:05:59 -0600
Subject: [PATCH] arm64: add NUMA emulation support
Message-ID: <20180824230559.32336-1-shuah@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NUMA emulation support to emulate NUMA on non-NUMA platforms. A new
CONFIG_NUMA_EMU option enables NUMA emulation and a new kernel command
line option "numa=fake=N" allows users to specify the configuration for
emulation.

When NUMA emulation is enabled, a flat (non-NUMA) machine will be split
into virtual NUMA nodes when booted with "numa=fake=N", where N is the
number of nodes, the system RAM will be split into N equal chunks and
assigned to each node.

Emulated nodes are bounded by MAX_NUMNODES and the number of memory block
count to avoid splitting memory blocks across NUMA nodes.

If NUMA emulation init fails, it will fall back to dummy NUMA init.

This is tested on Raspberry Pi3b+ with ltp NUMA test suite, numactl, and
numastat tools. In addition, tested in conjunction with cpuset cgroup to
verify cpuset.cpus and cpuset.mems assignments.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 arch/arm64/Kconfig            |   9 +++
 arch/arm64/include/asm/numa.h |   8 +++
 arch/arm64/mm/Makefile        |   1 +
 arch/arm64/mm/numa.c          |   4 ++
 arch/arm64/mm/numa_emu.c      | 109 ++++++++++++++++++++++++++++++++++
 5 files changed, 131 insertions(+)
 create mode 100644 arch/arm64/mm/numa_emu.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 29e75b47becd..6e74d9995d24 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -740,6 +740,15 @@ config NUMA
 	  local memory of the CPU and add some more
 	  NUMA awareness to the kernel.
 
+config NUMA_EMU
+	bool "NUMA emulation"
+	depends on NUMA
+	help
+	  Enable NUMA emulation. A flat machine will be split into virtual
+	  nodes when booted with "numa=fake=N", where N is the number of
+	  nodes, the system RAM will be split into N equal chunks, and
+	  assigned to each node.
+
 config NODES_SHIFT
 	int "Maximum NUMA Nodes (as a power of 2)"
 	range 1 10
diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
index 626ad01e83bf..16e8cc035872 100644
--- a/arch/arm64/include/asm/numa.h
+++ b/arch/arm64/include/asm/numa.h
@@ -29,6 +29,14 @@ static inline const struct cpumask *cpumask_of_node(int node)
 }
 #endif
 
+#ifdef CONFIG_NUMA_EMU
+void arm64_numa_emu_cmdline(char *str);
+extern int arm64_numa_emu_init(void);
+#else
+static inline void arm64_numa_emu_cmdline(char *str) {}
+static inline int arm64_numa_emu_init(void) { return -1; }
+#endif /* CONFIG_NUMA_EMU */
+
 void __init arm64_numa_init(void);
 int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init numa_set_distance(int from, int to, int distance);
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 849c1df3d214..2c8634daeffa 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ARM64_PTDUMP_CORE)	+= dump.o
 obj-$(CONFIG_ARM64_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
 obj-$(CONFIG_NUMA)		+= numa.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
+obj-$(CONFIG_NUMA_EMU)		+= numa_emu.o
 KASAN_SANITIZE_physaddr.o	+= n
 
 obj-$(CONFIG_KASAN)		+= kasan_init.o
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 146c04ceaa51..9232f18e3992 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -43,6 +43,8 @@ static __init int numa_parse_early_param(char *opt)
 		return -EINVAL;
 	if (!strncmp(opt, "off", 3))
 		numa_off = true;
+	if (!strncmp(opt, "fake=", 5))
+		arm64_numa_emu_cmdline(opt + 5);
 
 	return 0;
 }
@@ -460,6 +462,8 @@ void __init arm64_numa_init(void)
 			return;
 		if (acpi_disabled && !numa_init(of_numa_init))
 			return;
+		if (!numa_init(arm64_numa_emu_init))
+			return;
 	}
 
 	numa_init(dummy_numa_init);
diff --git a/arch/arm64/mm/numa_emu.c b/arch/arm64/mm/numa_emu.c
new file mode 100644
index 000000000000..97217adb029e
--- /dev/null
+++ b/arch/arm64/mm/numa_emu.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NUMA Emulation for non-NUMA platforms.
+ */
+
+#include <linux/numa.h>
+#include <linux/nodemask.h>
+#include <linux/pfn.h>
+#include <linux/bootmem.h>
+#include <linux/memblock.h>
+
+#include <asm/numa.h>
+
+static char *emu_cmdline __initdata;
+
+/*
+ * arm64_numa_emu_cmdline - parse early NUMA Emulation params.
+ */
+void __init arm64_numa_emu_cmdline(char *str)
+{
+	emu_cmdline = str;
+}
+
+/*
+ * arm64_numa_emu_init - Initialize NUMA Emulation
+ *
+ * Used when NUMA Emulation is enabled on a platform without underlying
+ * NUMA architecture.
+ */
+int __init arm64_numa_emu_init(void)
+{
+	u64 node_size;
+	int node_cnt = 0;
+	int mblk_cnt = 0;
+	int node = 0;
+	struct memblock_region *mblk;
+	bool split = false;
+	int ret;
+
+	pr_info("NUMA emulation init begin\n");
+
+	if (!emu_cmdline)
+		return -EINVAL;
+	/*
+	 * Split the system RAM into N equal chunks.
+	 */
+	ret = kstrtoint(emu_cmdline, 0, &node_cnt);
+	if (ret || node_cnt <= 0)
+		return -EINVAL;
+
+	if (node_cnt > MAX_NUMNODES)
+		node_cnt = MAX_NUMNODES;
+
+	node_size = PFN_PHYS(max_pfn) / node_cnt;
+	pr_info("NUMA emu: Node Size = %#018Lx Node = %d\n",
+		node_size, node_cnt);
+
+	for_each_memblock(memory, mblk)
+		mblk_cnt++;
+
+	/*
+	 * Size the node count to match the memory block count to avoid
+	 * splitting memory blocks across nodes. If there is only one
+	 * memory block split it.
+	 */
+	if (mblk_cnt <= node_cnt) {
+		pr_info("NUMA emu: Nodes (%d) >= Memblocks (%d)\n",
+			node_cnt, mblk_cnt);
+		if (mblk_cnt == 1) {
+			split = true;
+			pr_info("NUMA emu: Splitting single Memory Block\n");
+		} else {
+			node_cnt = mblk_cnt;
+			pr_info("NUMA emu: Adjust Nodes = Memory Blocks\n");
+		}
+	}
+
+	for_each_memblock(memory, mblk) {
+
+		if (split) {
+			for (node = 0; node < node_cnt; node++) {
+				u64 start, end;
+
+				start = mblk->base + node * node_size;
+				end = start + node_size;
+				pr_info("Adding an emulation node %d for [mem %#018Lx-%#018Lx]\n",
+					node, start, end);
+				ret = numa_add_memblk(node, start, end);
+				if (!ret)
+					continue;
+				pr_err("NUMA emulation init failed\n");
+				return ret;
+			}
+			break;
+		}
+		pr_info("Adding a emulation node %d for [mem %#018Lx-%#018Lx]\n",
+			node, mblk->base, mblk->base + mblk->size);
+		ret = numa_add_memblk(node, mblk->base,
+				      mblk->base + mblk->size);
+		if (!ret)
+			continue;
+		pr_err("NUMA emulation init failed\n");
+		return ret;
+	}
+	pr_info("NUMA: added %d emulation nodes of %#018Lx size each\n",
+		node_cnt, node_size);
+
+	return 0;
+}
-- 
2.17.1
