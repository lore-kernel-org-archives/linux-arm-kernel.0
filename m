From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 24 Jul 2014 21:00:10 +0800
Subject: [PATCH 04/19] ARM64 / ACPI: Introduce arch_fix_phys_package_id() for
 cpu topology
In-Reply-To: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1406206825-15590-5-git-send-email-hanjun.guo@linaro.org>
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
index 7ebcd31..2b216d4 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -23,11 +23,13 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
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
index 43514f9..c547885 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -281,3 +281,17 @@ void __init init_cpu_topology(void)
 	if (parse_dt_topology())
 		reset_cpu_topology();
 }
+
+/*
+ * Use the CPU slot number provided by ACPI to update the physical
+ * package id when cpuid_topo->cluster_id is not available, then we
+ * can get the right value in the "physical id" field of /proc/cpuinfo.
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
