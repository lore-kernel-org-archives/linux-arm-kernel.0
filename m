From: will.deacon@arm.com (Will Deacon)
Date: Tue,  9 Aug 2011 22:42:36 +0100
Subject: [RFC PATCH 2/8] ARM: smp: populate logical CPU mapping during boot
In-Reply-To: <1312926162-22469-1-git-send-email-will.deacon@arm.com>
References: <1312926162-22469-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312926162-22469-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow booting Linux on a CPU with physical ID != 0, we need to
provide a mapping from the logical CPU number to the physical CPU
number.

This patch adds such a mapping and populates it during boot.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/smp.h |    6 ++++++
 arch/arm/kernel/smp.c      |   15 +++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index e42d96a..674ebcd 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -66,6 +66,12 @@ extern void platform_secondary_init(unsigned int cpu);
 extern void platform_smp_prepare_cpus(unsigned int);
 
 /*
+ * Logical CPU mapping.
+ */
+extern int __cpu_logical_map[NR_CPUS];
+#define cpu_logical_map(cpu)	__cpu_logical_map[cpu]
+
+/*
  * Initial data for bringing up a secondary CPU.
  */
 struct secondary_data {
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index d88ff02..0016665 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -39,6 +39,7 @@
 #include <asm/tlbflush.h>
 #include <asm/ptrace.h>
 #include <asm/localtimer.h>
+#include <asm/smp_plat.h>
 
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
@@ -259,6 +260,20 @@ void __ref cpu_die(void)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+int __cpu_logical_map[NR_CPUS];
+
+void __init smp_setup_processor_id(void)
+{
+	int i;
+	u32 cpu = is_smp() ? read_cpuid_mpidr() & 0xff : 0;
+
+	cpu_logical_map(0) = cpu;
+	for (i = 1; i < NR_CPUS; ++i)
+		cpu_logical_map(i) = i == cpu ? 0 : i;
+
+	printk(KERN_INFO "Booting Linux on physical CPU %d\n", cpu);
+}
+
 /*
  * Called by both boot and secondaries to move global data into
  * per-processor storage.
-- 
1.7.0.4
