From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 14 Nov 2016 12:57:41 +0000
Subject: [PATCH 1/2] ARM: always store CPU ID early into percpu data
Message-ID: <E1c6GpR-0008DI-5B@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Always store the CPU ID into the percpu data so that it is available
early on.  This allows us to eliminate various is_smp() tests that
select between reading the hardware CPU ID directly and reading from
the percpu data.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/smp_plat.h | 5 +----
 arch/arm/kernel/setup.c         | 5 ++++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index f9080717fc88..43f246b73ce7 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -34,10 +34,7 @@ static inline bool is_smp(void)
  */
 static inline unsigned int smp_cpuid_part(int cpu)
 {
-	struct cpuinfo_arm *cpu_info = &per_cpu(cpu_data, cpu);
-
-	return is_smp() ? cpu_info->cpuid & ARM_CPU_PART_MASK :
-			  read_cpuid_part();
+	return per_cpu(cpu_data, cpu).cpuid;
 }
 
 /* all SMP configurations have the extended CPUID registers */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 34e3f3c45634..80f45b01fbaa 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -724,6 +724,9 @@ static void __init setup_processor(void)
 
 	cacheid_init();
 	cpu_init();
+
+	/* Always setup the boot CPU ID in the per-cpu data */
+	per_cpu(cpu_data, smp_processor_id()).cpuid = read_cpuid_id();
 }
 
 void __init dump_machine_table(void)
@@ -1217,7 +1220,7 @@ static int c_show(struct seq_file *m, void *v)
 		 * "processor".  Give glibc what it expects.
 		 */
 		seq_printf(m, "processor\t: %d\n", i);
-		cpuid = is_smp() ? per_cpu(cpu_data, i).cpuid : read_cpuid_id();
+		cpuid = per_cpu(cpu_data, i).cpuid;
 		seq_printf(m, "model name\t: %s rev %d (%s)\n",
 			   cpu_name, cpuid & 15, elf_platform);
 
-- 
2.7.4
