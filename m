From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 25 Apr 2014 21:20:13 +0800
Subject: [PATCH v3 part1 07/11] ARM64 / ACPI: Introduce
 arch_fix_phys_package_id() for cpu topology
In-Reply-To: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1398432017-8506-8-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_fix_phys_package_id() will be called in ACPI core to use
the slot number provided by ACPI to update the physical package
id, then we can get the right value in the "physical id" field
of /proc/cpuinfo.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/topology.h |    2 ++
 arch/arm64/kernel/topology.c      |   14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 0172e6d..0b0e24f 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -26,11 +26,13 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
 void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
+void arch_fix_phys_package_id(int num, u32 slot);
 
 #else
 
 static inline void init_cpu_topology(void) { }
 static inline void store_cpu_topology(unsigned int cpuid) { }
+static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 
 #endif
 
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 3e06b0b..51ea4a1 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -93,3 +93,17 @@ void __init init_cpu_topology(void)
 		cpumask_clear(&cpu_topo->thread_sibling);
 	}
 }
+
+/*
+ * Use the CPU slot number provided by ACPI to update the physical
+ * package id, then we can get the right value in the "physical id"
+ * field of /proc/cpuinfo.
+ */
+void arch_fix_phys_package_id(int num, u32 slot)
+{
+	struct cpu_topology *cpuid_topo = &cpu_topology[num];
+
+	if (cpuid_topo->cluster_id == -1)
+		cpuid_topo->cluster_id = slot;
+}
+EXPORT_SYMBOL_GPL(arch_fix_phys_package_id);
-- 
1.7.9.5
