From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 16 Oct 2012 17:24:44 +0100
Subject: [RFC PATCH] ARM: kernel: update cpuinfo to print all online CPUs
 features
Message-ID: <1350404684-6883-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, reading /proc/cpuinfo provides userspace with CPU ID of
the CPU carrying out the read from the file. This is fine as long as all
CPUs in the system are the same. With the advent of big.LITTLE and
heterogenous ARM systems this approach provides user space with incorrect
bits of information since CPU ids in the system might differ from the one
provided by the CPU reading the file.

This patch updates the cpuinfo show function and some internal data
structures so that a read from /proc/cpuinfo prints HW information for
all online CPUs at once, mirroring x86 behaviour.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---

Posting it as a way to get advice on the best way to improve /proc/cpuinfo for
heterogenous multi-cluster systems and to provide proper information to
userspace without breaking existing semantics, no more than that.

Comments more than welcome.

Thanks,
Lorenzo

 arch/arm/include/asm/cpu.h |  1 +
 arch/arm/kernel/setup.c    | 66 +++++++++++++++++++++++-----------------------
 arch/arm/kernel/smp.c      |  1 +
 3 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/arch/arm/include/asm/cpu.h b/arch/arm/include/asm/cpu.h
index d797223..2744f06 100644
--- a/arch/arm/include/asm/cpu.h
+++ b/arch/arm/include/asm/cpu.h
@@ -15,6 +15,7 @@
 
 struct cpuinfo_arm {
 	struct cpu	cpu;
+	u32		cpuid;
 #ifdef CONFIG_SMP
 	unsigned int	loops_per_jiffy;
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 8707cff..bf7839d08 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1054,13 +1054,15 @@ static const char *hwcap_str[] = {
 
 static int c_show(struct seq_file *m, void *v)
 {
-	int i;
+	int i, j;
+	u32 cpuid;
 
-	seq_printf(m, "Processor\t: %s rev %d (%s)\n",
-		   cpu_name, read_cpuid_id() & 15, elf_platform);
+	for_each_online_cpu(i) {
+		cpuid = is_smp() ? per_cpu(cpu_data, i).cpuid : read_cpuid_id();
+		seq_printf(m, "Processor\t: %s rev %d (%s)\n",
+			   cpu_name, cpuid & 15, elf_platform);
 
 #if defined(CONFIG_SMP)
-	for_each_online_cpu(i) {
 		/*
 		 * glibc reads /proc/cpuinfo to determine the number of
 		 * online processors, looking for lines beginning with
@@ -1070,42 +1072,40 @@ static int c_show(struct seq_file *m, void *v)
 		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n\n",
 			   per_cpu(cpu_data, i).loops_per_jiffy / (500000UL/HZ),
 			   (per_cpu(cpu_data, i).loops_per_jiffy / (5000UL/HZ)) % 100);
-	}
-#else /* CONFIG_SMP */
-	seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
-		   loops_per_jiffy / (500000/HZ),
-		   (loops_per_jiffy / (5000/HZ)) % 100);
+#else
+		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
+			   loops_per_jiffy / (500000/HZ),
+			   (loops_per_jiffy / (5000/HZ)) % 100);
 #endif
+		/* dump out the processor features */
+		seq_puts(m, "Features\t: ");
 
-	/* dump out the processor features */
-	seq_puts(m, "Features\t: ");
+		for (j = 0; hwcap_str[j]; j++)
+			if (elf_hwcap & (1 << j))
+				seq_printf(m, "%s ", hwcap_str[j]);
 
-	for (i = 0; hwcap_str[i]; i++)
-		if (elf_hwcap & (1 << i))
-			seq_printf(m, "%s ", hwcap_str[i]);
+		seq_printf(m, "\nCPU implementer\t: 0x%02x\n", cpuid >> 24);
+		seq_printf(m, "CPU architecture: %s\n",
+			   proc_arch[cpu_architecture()]);
 
-	seq_printf(m, "\nCPU implementer\t: 0x%02x\n", read_cpuid_id() >> 24);
-	seq_printf(m, "CPU architecture: %s\n", proc_arch[cpu_architecture()]);
-
-	if ((read_cpuid_id() & 0x0008f000) == 0x00000000) {
-		/* pre-ARM7 */
-		seq_printf(m, "CPU part\t: %07x\n", read_cpuid_id() >> 4);
-	} else {
-		if ((read_cpuid_id() & 0x0008f000) == 0x00007000) {
-			/* ARM7 */
-			seq_printf(m, "CPU variant\t: 0x%02x\n",
-				   (read_cpuid_id() >> 16) & 127);
+		if ((cpuid & 0x0008f000) == 0x00000000) {
+			/* pre-ARM7 */
+			seq_printf(m, "CPU part\t: %07x\n", cpuid >> 4);
 		} else {
-			/* post-ARM7 */
-			seq_printf(m, "CPU variant\t: 0x%x\n",
-				   (read_cpuid_id() >> 20) & 15);
+			if ((cpuid & 0x0008f000) == 0x00007000) {
+				/* ARM7 */
+				seq_printf(m, "CPU variant\t: 0x%02x\n",
+					   (cpuid >> 16) & 127);
+			} else {
+				/* post-ARM7 */
+				seq_printf(m, "CPU variant\t: 0x%x\n",
+					   (cpuid >> 20) & 15);
+			}
+			seq_printf(m, "CPU part\t: 0x%03x\n",
+				   (cpuid >> 4) & 0xfff);
 		}
-		seq_printf(m, "CPU part\t: 0x%03x\n",
-			   (read_cpuid_id() >> 4) & 0xfff);
+		seq_printf(m, "CPU revision\t: %d\n\n", cpuid & 15);
 	}
-	seq_printf(m, "CPU revision\t: %d\n", read_cpuid_id() & 15);
-
-	seq_puts(m, "\n");
 
 	seq_printf(m, "Hardware\t: %s\n", machine_name);
 	seq_printf(m, "Revision\t: %04x\n", system_rev);
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index f0bcb1e..73f407e 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -211,6 +211,7 @@ static void __cpuinit smp_store_cpu_info(unsigned int cpuid)
 	struct cpuinfo_arm *cpu_info = &per_cpu(cpu_data, cpuid);
 
 	cpu_info->loops_per_jiffy = loops_per_jiffy;
+	cpu_info->cpuid = read_cpuid_id();
 
 	store_cpu_topology(cpuid);
 }
-- 
1.7.12
