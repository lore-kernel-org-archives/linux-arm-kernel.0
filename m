From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 May 2014 15:37:49 +0100
Subject: [PATCH 2/3] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <1399905470-26500-1-git-send-email-mark.rutland@arm.com>
References: <1399905470-26500-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1399905470-26500-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently reading /proc/cpuinfo will result in information being read
out of the MIDR_EL1 of the current CPU, and the information is not
associated with any particular logical CPU number.

This is problematic for systems with heterogeneous CPUs (i.e.
big.LITTLE) where fields will vary across CPUs, and the output will
differ depending on the executing CPU. Additionally the output is
different in format to the 32-bit ARM Linux port, where information is
printed out for each CPU.

This patch adds the necessary infrastructure to log the relevant
registers (currently just MPIDR_EL1) and print out the logged
information.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jacob Bramley <jacob.bramley@arm.com>
---
 arch/arm64/include/asm/cpu.h | 30 +++++++++++++++++++++++++++++
 arch/arm64/kernel/Makefile   |  2 +-
 arch/arm64/kernel/cpuinfo.c  | 30 +++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c    | 46 +++++++++++++++++++++++---------------------
 arch/arm64/kernel/smp.c      |  6 ++++++
 5 files changed, 91 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm64/include/asm/cpu.h
 create mode 100644 arch/arm64/kernel/cpuinfo.c

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
new file mode 100644
index 0000000..74bf9bb
--- /dev/null
+++ b/arch/arm64/include/asm/cpu.h
@@ -0,0 +1,30 @@
+/*
+ *  arch/arm/include/asm/cpu.h
+ *
+ *  Copyright (C) 2004-2014 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_ARM64_CPU_H
+#define __ASM_ARM64_CPU_H
+
+#include <linux/percpu.h>
+#include <linux/cpu.h>
+
+/*
+ * Records attributes of an individual CPU.
+ *
+ * This is used to cache data for /proc/cpuinfo.
+ */
+struct cpuinfo_arm64 {
+	struct cpu	cpu;
+	u32		reg_midr;
+};
+
+DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
+
+void cpuinfo_store_cpu(void);
+
+#endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7d811d9..0e0431f 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -9,7 +9,7 @@ AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
 			   entry-fpsimd.o process.o ptrace.o setup.o signal.o	\
 			   sys.o stacktrace.o time.o traps.o io.o vdso.o	\
-			   hyp-stub.o psci.o cpu_ops.o insn.o
+			   hyp-stub.o psci.o cpu_ops.o insn.o cpuinfo.o
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
new file mode 100644
index 0000000..b9e18c5
--- /dev/null
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -0,0 +1,30 @@
+/*
+ * Record CPU attributes for later retrieval
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <asm/cpu.h>
+
+#include <linux/smp.h>
+
+DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
+
+void cpuinfo_store_cpu(void)
+{
+	int cpu = smp_processor_id();
+	struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, cpu);
+
+	cpuinfo->reg_midr = read_cpuid_id();
+}
+
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 7450c58..b2c0554 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -44,6 +44,7 @@
 #include <linux/of_platform.h>
 
 #include <asm/fixmap.h>
+#include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/elf.h>
 #include <asm/cputable.h>
@@ -391,6 +392,7 @@ void __init setup_arch(char **cmdline_p)
 
 	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
 	cpu_read_bootcpu_ops();
+	cpuinfo_store_cpu();
 #ifdef CONFIG_SMP
 	smp_init_cpus();
 	smp_build_mpidr_hash();
@@ -412,14 +414,12 @@ static int __init arm64_device_init(void)
 }
 arch_initcall_sync(arm64_device_init);
 
-static DEFINE_PER_CPU(struct cpu, cpu_data);
-
 static int __init topology_init(void)
 {
 	int i;
 
 	for_each_possible_cpu(i) {
-		struct cpu *cpu = &per_cpu(cpu_data, i);
+		struct cpu *cpu = &per_cpu(cpu_data.cpu, i);
 		cpu->hotpluggable = 1;
 		register_cpu(cpu, i);
 	}
@@ -442,38 +442,40 @@ static const char *hwcap_str[] = {
 
 static int c_show(struct seq_file *m, void *v)
 {
-	int i;
+	int c;
 
-	seq_printf(m, "Processor\t: %s rev %d (%s)\n",
-		   cpu_name, read_cpuid_id() & 15, ELF_PLATFORM);
+	for_each_online_cpu(c) {
+		int i;
+		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, c);
+		u32 midr = cpuinfo->reg_midr;
 
-	for_each_online_cpu(i) {
 		/*
 		 * glibc reads /proc/cpuinfo to determine the number of
 		 * online processors, looking for lines beginning with
 		 * "processor".  Give glibc what it expects.
 		 */
 #ifdef CONFIG_SMP
-		seq_printf(m, "processor\t: %d\n", i);
+		seq_printf(m, "processor\t: %d\n", c);
 #endif
-	}
+		seq_printf(m, "Type\t\t: %s rev %d (%s)\n",
+			   cpu_name, MIDR_REVISION(midr), ELF_PLATFORM);
 
-	/* dump out the processor features */
-	seq_puts(m, "Features\t: ");
+		/* dump out the processor features */
+		seq_puts(m, "Features\t: ");
 
-	for (i = 0; hwcap_str[i]; i++)
-		if (elf_hwcap & (1 << i))
-			seq_printf(m, "%s ", hwcap_str[i]);
+		for (i = 0; hwcap_str[i]; i++)
+			if (elf_hwcap & (1 << i))
+				seq_printf(m, "%s ", hwcap_str[i]);
 
-	seq_printf(m, "\nCPU implementer\t: 0x%02x\n", read_cpuid_id() >> 24);
-	seq_printf(m, "CPU architecture: AArch64\n");
-	seq_printf(m, "CPU variant\t: 0x%x\n", (read_cpuid_id() >> 20) & 15);
-	seq_printf(m, "CPU part\t: 0x%03x\n", (read_cpuid_id() >> 4) & 0xfff);
-	seq_printf(m, "CPU revision\t: %d\n", read_cpuid_id() & 15);
+		seq_printf(m, "\nCPU implementer\t: 0x%02x\n",
+			   MIDR_IMPLEMENTOR(midr));
+		seq_printf(m, "CPU architecture: AArch64\n");
+		seq_printf(m, "CPU variant\t: 0x%x\n", MIDR_VARIANT(midr));
+		seq_printf(m, "CPU part\t: 0x%03x\n", MIDR_PARTNUM(midr));
+		seq_printf(m, "CPU revision\t: %d\n", MIDR_REVISION(midr));
 
-	seq_puts(m, "\n");
-
-	seq_printf(m, "Hardware\t: %s\n", machine_name);
+		seq_puts(m, "\n");
+	}
 
 	return 0;
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index f0a141d..f74866d 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -38,6 +38,7 @@
 
 #include <asm/atomic.h>
 #include <asm/cacheflush.h>
+#include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpu_ops.h>
 #include <asm/mmu_context.h>
@@ -160,6 +161,11 @@ asmlinkage void secondary_start_kernel(void)
 	smp_store_cpu_info(cpu);
 
 	/*
+	 * Log the CPU info before it is marked online and might get read.
+	 */
+	cpuinfo_store_cpu();
+
+	/*
 	 * OK, now it's safe to let the boot CPU continue.  Wait for
 	 * the CPU migration code to notice that the CPU is online
 	 * before we continue.
-- 
1.8.1.1
