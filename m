From: ahs3@redhat.com (Al Stone)
Date: Tue, 26 Sep 2017 16:23:22 -0600
Subject: [PATCH 1/3] arm64: cpuinfo: add MPIDR value to /proc/cpuinfo
In-Reply-To: <20170926222324.17409-1-ahs3@redhat.com>
References: <20170926222324.17409-1-ahs3@redhat.com>
Message-ID: <20170926222324.17409-2-ahs3@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When displaying cpuinfo on an arm64 system, include the MPIDR register
value which can be used to understand the CPU topology on a platform.
This can serve as a cross-check to the information provided in sysfs,
and has been useful in understanding CPU and NUMA allocation issues.

Signed-off-by: Al Stone <ahs3@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cpu.h | 1 +
 arch/arm64/kernel/cpuinfo.c  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 889226b4c6e1..ac40894df247 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -32,6 +32,7 @@ struct cpuinfo_arm64 {
 	u32		reg_midr;
 	u32		reg_revidr;
 
+	u64		reg_id_aa64mpidr;
 	u64		reg_id_aa64dfr0;
 	u64		reg_id_aa64dfr1;
 	u64		reg_id_aa64isar0;
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 4a6f875ac854..e505007138eb 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -120,6 +120,7 @@ static int c_show(struct seq_file *m, void *v)
 	for_each_online_cpu(i) {
 		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
 		u32 midr = cpuinfo->reg_midr;
+		u64 mpidr = cpuinfo->reg_id_aa64mpidr;
 
 		/*
 		 * glibc reads /proc/cpuinfo to determine the number of
@@ -159,6 +160,12 @@ static int c_show(struct seq_file *m, void *v)
 		}
 		seq_puts(m, "\n");
 
+		seq_printf(m, "CPU MPIDR\t: 0x%016llx ", mpidr);
+		seq_printf(m, "(Aff3 %d Aff2 %d Aff1 %d Aff0 %d)\n",
+			   (u8) MPIDR_AFFINITY_LEVEL(mpidr, 3),
+			   (u8) MPIDR_AFFINITY_LEVEL(mpidr, 2),
+			   (u8) MPIDR_AFFINITY_LEVEL(mpidr, 1),
+			   (u8) MPIDR_AFFINITY_LEVEL(mpidr, 0));
 		seq_printf(m, "CPU implementer\t: 0x%02x\n",
 			   MIDR_IMPLEMENTOR(midr));
 		seq_printf(m, "CPU architecture: 8\n");
@@ -372,6 +379,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_midr = read_cpuid_id();
 	info->reg_revidr = read_cpuid(REVIDR_EL1);
 
+	info->reg_id_aa64mpidr = read_cpuid_mpidr();
 	info->reg_id_aa64dfr0 = read_cpuid(ID_AA64DFR0_EL1);
 	info->reg_id_aa64dfr1 = read_cpuid(ID_AA64DFR1_EL1);
 	info->reg_id_aa64isar0 = read_cpuid(ID_AA64ISAR0_EL1);
-- 
2.13.5
