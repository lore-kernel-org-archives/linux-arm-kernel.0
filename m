From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 27 Jun 2014 19:12:06 -0600
Subject: [PATCH 1/2] arm64: add MIDR to per-CPU information
In-Reply-To: <20140628010440.9839.9366.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140628010440.9839.9366.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20140628011206.9839.2351.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save the MIDR of each CPU we bring online instead of assuming they're all
the same.

Based on e8d432c9cf0a ("ARM: kernel: add MIDR to per-CPU information
data").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm64/kernel/setup.c |   13 +++++++------
 arch/arm64/kernel/smp.c   |    5 +++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 46d1125571f6..37cc2bb9f3ae 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -45,6 +45,7 @@
 #include <linux/efi.h>
 
 #include <asm/fixmap.h>
+#include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/elf.h>
 #include <asm/cputable.h>
@@ -417,16 +418,16 @@ static int __init arm64_device_init(void)
 }
 arch_initcall_sync(arm64_device_init);
 
-static DEFINE_PER_CPU(struct cpu, cpu_data);
+DEFINE_PER_CPU(struct cpuinfo_arm, cpu_data);
 
 static int __init topology_init(void)
 {
-	int i;
+	int cpu;
 
-	for_each_possible_cpu(i) {
-		struct cpu *cpu = &per_cpu(cpu_data, i);
-		cpu->hotpluggable = 1;
-		register_cpu(cpu, i);
+	for_each_possible_cpu(cpu) {
+		struct cpuinfo_arm *cpuinfo = &per_cpu(cpu_data, cpu);
+		cpuinfo->cpu.hotpluggable = 1;
+		register_cpu(&cpuinfo->cpu, cpu);
 	}
 
 	return 0;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 40f38f46c8e0..c69963496dc6 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -39,6 +39,7 @@
 
 #include <asm/atomic.h>
 #include <asm/cacheflush.h>
+#include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpu_ops.h>
 #include <asm/mmu_context.h>
@@ -118,6 +119,10 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 
 static void smp_store_cpu_info(unsigned int cpuid)
 {
+	struct cpuinfo_arm *cpu_info = &per_cpu(cpu_data, cpuid);
+
+	cpu_info->cpuid = read_cpuid_id();
+
 	store_cpu_topology(cpuid);
 }
 
